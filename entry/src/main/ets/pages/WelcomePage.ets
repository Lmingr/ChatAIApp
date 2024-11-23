

@Entry
@Component

struct  WelcomePage{

  build() {

    Column(){
      Text(`Welcome to ChatAI`)
        .fontColor(`#17C3CE`)
        .fontSize(40)
        .width(`50%`)

      Image($r("app.media.Group_AI"))
        .width(200)

      Button(`Start Chatting`)
        .backgroundColor(`#17C3CE` )
        .width(`80%`)
    }
    .justifyContent(FlexAlign.SpaceBetween)
    .height(`100%`)
    .width(`100%`)

  }
}