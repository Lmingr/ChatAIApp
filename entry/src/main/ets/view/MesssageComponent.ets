import { MessageBean } from "../bean/MessageBean"
import { UserMessage } from "../bean/UserMessage"


@Preview
@Component
export struct  MessageComponent{

   @Prop userMessage:UserMessage

  build() {

    Stack(){
      Column(){
        Text(this.userMessage.messageTopic)
          .fontSize(18)
          .maxLines(1)
          .margin({
            right:20
          })
          .textOverflow({overflow:TextOverflow.Ellipsis})
        Text(this.userMessage.messageContent)
          .fontColor($r("app.color.content_Color"))
          .fontSize(14)
          .maxLines(2)
          .textOverflow({overflow:TextOverflow.Ellipsis})
          .margin({
            right:40
          })
        Text(this.userMessage.messageDate.toString())
          .fontSize(12)
          .textAlign(TextAlign.End)
          .width(`100%`)
          .fontColor($r("app.color.date_Color"))
          .margin({
            right:3
          })
      }
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(HorizontalAlign.Start)
      .width(`100%`)
      .height(`100%`)

      Image($r("app.media.right"))
        .height(20)

    }
    .alignContent(Alignment.End)
    .border({
      radius:15
    })
    .backgroundColor($r("app.color.message_Color"))
    .padding({
      top:15,
      left:20,
      right:20,
      bottom:8
    })
    .height(95)
  }

}