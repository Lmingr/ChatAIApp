import { router } from "@kit.ArkUI"
import { MessageBean } from "../bean/MessageBean"
import { UserMessage } from "../bean/UserMessage"
import { showToast } from "../utils/ComponentUtils"
import { Logger } from "../utils/Logger"
import { MessageComponent } from "../view/MesssageComponent"
import { historyViewModel } from "../viewModel/HistoryViewModel"


@Preview
@Component
export  struct HistoryPage{

  statusBar: number = AppStorage.get<number>('statusBar') as number

  private scroller: Scroller = new Scroller()

  @State
  messageList:UserMessage[]=[]

  aboutToAppear(){
     historyViewModel.foundMessageList("luomingr").then((res)=>{
        this.messageList=res
     })
  }

  build() {
    Column(){
      Stack({alignContent:Alignment.BottomEnd}){//开始居左
        Text(`Saved Chat`)
          .fontColor(Color.Black)
          .fontSize(20)
          .width('100%')
          .textAlign(TextAlign.Center)
        Image($r("app.media.search"))
          .width(18)
          .height(18)
          .zIndex(2)
          .onClick(()=>{
            router.back()
          })
      }
      .padding({
        left:10,
        right:10,
        bottom:10
      })
      .border({
        color:Color.Black,
        width:{bottom:1}
      })
      .height(`10%`)
      .width(`100%`)

      List({space:20,scroller:this.scroller}){
        ForEach(this.messageList, (item:UserMessage)=>{
          ListItem(){
            MessageComponent({userMessage:item})
          }
          .onClick(()=>{
            router.pushUrl({url:'pages/ChatToAIPage',params:{mid:item.mid,isNew:false}})
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