import { promptAction } from "@kit.ArkUI";

@Preview
@Component
export struct  DialogComponent{

  @Prop message: string = '';

  build() {
    Column() {
      Row() {
        Text('Title')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)

      Text(this.message)
        .fontSize(14)

      Row(){
        Button('确认')
          .fontSize(16)
          .fontColor('#0A59F7')
          .backgroundColor(Color.White)
          .onClick(() => {
          })
          .width('100%')
          .margin({
            top: 8,
            bottom: 16
          })

        Button('取消')
          .fontSize(16)
          .fontColor('#0A59F7')
          .backgroundColor(Color.White)
          .onClick(() => {
          })
          .width('100%')
          .margin({
            top: 8,
            bottom: 16
          })
      }
      .justifyContent(FlexAlign.SpaceBetween)

    }
    .padding({
      left: 24,
      right: 24
    })
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .backgroundColor(Color.White)
    .borderRadius(32)
    .margin({ left: 16, right: 16 })
  }
}