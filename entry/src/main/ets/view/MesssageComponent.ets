import { MessageBean } from "../bean/MessageBean"


@Preview
@Component
export struct  MessageComponent{


  @Prop messageBean:MessageBean

  build() {

    Stack(){
      Column(){
        Text(this.messageBean.topic)
          .fontSize(18)
          .maxLines(1)
          .textOverflow({overflow:TextOverflow.Ellipsis})
        Text(this.messageBean.content)
          .fontColor($r("app.color.content_Color"))
          .fontSize(14)
          .maxLines(2)
          .textOverflow({overflow:TextOverflow.Ellipsis})
          .margin({
            top:5
          })
        Text(`15 May 2023`)
          .fontSize(12)
          .textAlign(TextAlign.End)
          .width(`100%`)
          .fontColor($r("app.color.date_Color"))
          .margin({
            top:7,
            right:3
          })
      }
      .alignItems(HorizontalAlign.Start)
      .width(`100%`)
      .height(`100%`)

      Image($r("app.media.right"))
        .height(20)

    }
    .border({
      radius:15
    })
    .backgroundColor($r("app.color.back_Color"))
    .padding({
      top:15,
      left:20,
      right:20,
      bottom:8
    })
    .height(90)
    .alignContent(Alignment.End)
  }

}