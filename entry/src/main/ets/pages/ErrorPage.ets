

@Component
export struct ErrorPage{

  private onRefresh?: () => void

  build() {
    Column(){
      Image($r("app.media.net_error"))
        .height(216)
        .width(216)
      Text('网络异常')
        .margin({
          top:8
        })
      Button(`刷新`)
        .width(136)
        .fontColor(Color.Black)
        .margin({
          top:30
        })
        .backgroundColor(Color.White)
        .border({
          width:0.5,
          color:"#595959"
        })
        .onClick(this.onRefresh)
    }
    .margin({
      top:`20%`
    })
    .height(`100%`)
  }
}