import { router } from "@kit.ArkUI"
import { Logger } from "../utils/Logger"


@Preview
@Component
export struct MessagePage{

  build() {
    Column(){
      Text('Welcome to\n' +
        'Chatbot AI')
        .fontSize(30)
        .fontColor($r("app.color.primaryColor"))

      Image($r("app.media.BigAI"))
        .width('50%')

      Text('小喵是一款人工智能聊天机器人，它可以快速准确地回答大家在日常生活中的疑问')
        .width('80%')
        .fontSize(13)
        .padding(25)
        .border({
          radius:20
        })
        .fontColor($r("app.color.date_Color"))
        .backgroundColor($r("app.color.message_Color"))

      Column(){
        Button(`开始聊天`)
          .onClick(()=>{
            router.pushUrl({url:'pages/ChatToAIPage',params:{isNewChat:true}})
          })
          .width('80%')
          .backgroundColor($r("app.color.primaryColor"))
        Button(`历史聊天`)
          .margin({
            top:20
          })
          .width('80%')
          .backgroundColor($r("app.color.primaryColor"))
          .onClick(()=>{
            router.pushUrl({url:'pages/HistoryPage'})
          })
      }
      Text()

    }
    .justifyContent(FlexAlign.SpaceEvenly)
    .alignItems(HorizontalAlign.Center)
    .height(`100%`)
    .width(`100%`)
  }

}

