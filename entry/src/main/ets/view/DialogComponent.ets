import { promptAction } from "@kit.ArkUI";

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

      Button('CONFIRM')
        .fontSize(16)
        .fontColor('#0A59F7')
        .backgroundColor(Color.White)
        .onClick(() => {
          let dialogId = AppStorage.get<number>('dialogId');
          promptAction.closeCustomDialog(dialogId)
        })
        .width('100%')
        .margin({
          top: 8,
          bottom: 16
        })
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