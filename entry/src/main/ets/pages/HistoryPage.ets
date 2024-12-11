import { promptAction, router } from "@kit.ArkUI"
import { UserMessage } from "../bean/UserMessage"
import { showToast } from "../utils/ComponentUtils"
import { Logger } from "../utils/Logger"
import { DialogComponent } from "../view/DialogComponent"
import { MessageComponent } from "../view/MesssageComponent"
import { historyViewModel } from "../viewModel/HistoryViewModel"


@Entry
@Component
export  struct HistoryPage{

  @State customDialogComponentId: number = 0

  statusBar: number = AppStorage.get<number>('statusBar') as number

  username =AppStorage.get('username') as string

  private scroller: Scroller = new Scroller()

  @State messageList:UserMessage[]=[]

  aboutToAppear(): void {
    historyViewModel.foundMessageList(this.username).then((res)=>{
      this.messageList=res
    })
  }



  async  deleteMessage(mid:number){
    Logger.info("删除"+mid)
    historyViewModel.deleteMessage(mid).then(()=>{
      showToast("删除成功")
    })
  }


  @Builder itemDelete(item:UserMessage){
    Row(){
      Button(`删除`)
        .backgroundColor($r("app.color.primaryColor"))
        .onClick(()=>{
          promptAction.openCustomDialog({
            builder:()=>{
             this.customDialogComponent(item)
            },
            autoCancel:true,
            width:"70%"
          }).then((dialogId: number)=>{
            this.customDialogComponentId=dialogId
          })
        })
    }
    .padding(10)
    .justifyContent(FlexAlign.SpaceEvenly)
  }

  build() {
    Column(){
      Row(){//开始居左
        Image($r("app.media.Button_Back"))
          .width(18)
          .height(18)
          .zIndex(2)
          .onClick(()=>{
            router.back()
          })
        Text(`Saved Chat`)
          .fontColor(Color.Black)
          .fontSize(20)
          .textAlign(TextAlign.Center)
        Image($r("app.media.search"))
          .width(18)
          .height(18)
          .zIndex(2)
          .onClick(()=>{
            showToast("此功能还未开发")
          })
      }
      .justifyContent(FlexAlign.SpaceBetween)
      .padding({
        left:10,
        right:10
      })
      .border({
        color:Color.Black,
        width:{bottom:1}
      })
      .height(`6%`)
      .width(`100%`)

      List({space:20,scroller:this.scroller}){
        ForEach(this.messageList, (item:UserMessage)=>{
          ListItem(){
            MessageComponent({userMessage:item})
          }
          .swipeAction({
            end:{ builder: this.itemDelete(item)},
            edgeEffect:SwipeEdgeEffect.None
          })
          .onClick(()=>{
            router.pushUrl({url:'pages/ChatToAIPage',params:{mid:item.mid,isNewChat:false}})
            showToast("点击了"+item.mid)
          })
        })
      }
      .scrollSnapAlign(ScrollSnapAlign.END)
      .layoutWeight(1)
      .padding({
        left:20,
        right:20,
        top:20,
        bottom:10
      })
    }
    .padding({top:this.statusBar})
    .height(`100%`)
    .justifyContent(FlexAlign.SpaceBetween)
  }


  @Builder
  customDialogComponent(item:UserMessage) {
    Column({space:10}) {
      Row() {
        Text('删除')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
        Image($r("app.media.alert"))
          .width(20)
          .margin({
            left:5
          })
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)
      Text("确认要删除该聊天话题吗？")
        .fontSize(14)
        .fontColor($r("app.color.dialog_Color"))
      Row(){
        Button('确认')
          .fontSize(16)
          .backgroundColor($r("app.color.primaryColor"))
          .onClick(async () => {
            await this.deleteMessage(item.mid)
            let index=  this.messageList.indexOf(item)
            this.messageList.splice(index, 1)
            promptAction.closeCustomDialog(this.customDialogComponentId)
          })
        Button('取消')
          .fontSize(16)
          .backgroundColor($r("app.color.primaryColor"))
          .onClick(() => {
            promptAction.closeCustomDialog(this.customDialogComponentId)
          })
      }
      .margin({
        top:15,
        bottom:10
      })
      .width("80%")
      .justifyContent(FlexAlign.SpaceEvenly)

    }
    .width(`100%`)
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .borderRadius(32)
  }

}