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

      Image($r("app.media.Group_AI"))
        .width('50%')

      Column(){
        Button(`新建聊天`)
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

