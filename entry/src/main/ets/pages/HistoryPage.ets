import { router } from "@kit.ArkUI"
import { MessageBean } from "../bean/MessageBean"
import { UserMessage } from "../bean/UserMessage"
import { showToast } from "../utils/ComponentUtils"
import { Logger } from "../utils/Logger"
import { MessageComponent } from "../view/MesssageComponent"
import { historyViewModel } from "../viewModel/HistoryViewModel"


@Entry
@Component
export  struct HistoryPage{

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
    historyViewModel.deleteMessage(mid).then(()=>{
      showToast("删除成功")
    })
  }


  @Builder itemDelete(){
    Row(){
      Button(`删除`)
      Button(`删除`)
    }
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
            end:{
            builder: this.itemDelete,
            onAction: ()=>{
              animateTo({ duration: 1000 }, async () => {
                let index=  this.messageList.indexOf(item)
                await this.deleteMessage(item.mid)
                this.messageList.splice(index, 1)
              })
            }},
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
}