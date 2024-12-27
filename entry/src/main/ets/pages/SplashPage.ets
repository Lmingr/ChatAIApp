import { Logger } from '../utils/Logger'
import { router } from '@kit.ArkUI'

@Entry
@Component
struct  SplashPage{
  //处理跳转到登录页
  async aboutToAppear(){
    Logger.info("这里能走吗")
    //这里定时3s进入登录页
    setTimeout(async ()=>{
      router.replaceUrl({url: 'pages/LoginPage'})
    }, 2000)
  }

  build() {
    Column(){
      Text()
      Column() {
        Image($r("app.media.refresh_group"))
          .height('150')
          .width('150')
        Text("小喵大平台")
          .fontSize(20)
          .margin({
            top: 10
          })
          .fontColor($r("app.color.primaryColor"))
      }
      Text('本款app主要用于AI日常问答，解决生活中的困惑')
        .fontSize(14)
        .fontColor($r("app.color.start_window_background"))
        .align(Alignment.Bottom)
        .margin({
          bottom:20
        })
    }
    .justifyContent(FlexAlign.SpaceBetween)
    .height('100%')
    .width('100%')
    .backgroundColor($r("app.color.primaryColor"))
  }
}