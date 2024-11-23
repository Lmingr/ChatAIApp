


@Component
export struct  MessageLoadingComponent{

  @State  rotateAngle:number=0

  build() {
    Row(){
      Image($r("app.media.vector_ai"))
        .width(33)
        .height(33)
        .objectFit(ImageFit.Contain)

      Column({space:5}){
        Text("ChatAI")
          .fontWeight(FontWeight.Bold)
          .margin({ left:6, right:5 })
        this.loadingComponent()
      }
      .alignItems(HorizontalAlign.Start)
    }
    .alignItems(VerticalAlign.Top)
    .direction(Direction.Ltr)
    .padding({ left:15, right:15})
  }

    @Builder  loadingComponent(){
      Row(){
        Image($r('app.media.loading_answer'))
          .height(18)
          .objectFit(ImageFit.Fill)
          .rotate({ x: 0, y: 0, z: 1, angle: this.rotateAngle })
          .onAppear(() => {
            animateTo({
              duration: 1200,
              curve: Curve.Linear,
              iterations: -1, // 设置-1表示动画无限循环
            }, () => {
              this.rotateAngle = 360
            })
          })
        Text('正在生成中...')
          .fontSize(16)
          .fontColor($r("app.color.font_Color"))
          .margin({ left:5, right:5 })
      }
      .padding(10)
      .margin({ left:5, right:5 })
      .borderRadius(8)
    }


}