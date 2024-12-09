import { UserInfo } from "../bean/UserInfo"
import { showToast } from "../utils/ComponentUtils"

@Preview
@Component
export  struct MinePage{

  statusBar: number = AppStorage.get<number>('statusBar') as number

  userInfo=AppStorage.get<UserInfo>('userInfo') as UserInfo

  build() {
    //头部的组件
    Column(){
      Row(){
        Text()
          .width(20)
        Text("我的")
          .fontWeight(FontWeight.Bold)
          .fontSize(20)
          .alignSelf(ItemAlign.Center)
        Image($r("app.media.shape_mine"))
          .height(20)
          .width(20)
      }
      .padding({
        left:20,
        right:20
      })
      .justifyContent(FlexAlign.SpaceBetween)
      .height(30)
      .width(`100%`)

      Image($r("app.media.big_back"))
        .height(200)
        .border({
          radius:10
        })
        .padding({
          top:10,
          left:20,
          right:20
        })
        .width(`100%`)

      Row(){
        Image($r("app.media.touxiang_1"))
          .width(70)
          .height(70)
          .border({
            radius:40
          })
        Button('编辑信息')
          .backgroundColor($r("app.color.primaryColor"))
          .fontSize(14)
          .onClick(()=>{
            showToast("还没搞呢")
          })
          .height(25)
      }
      .padding({
        left:40,
        right:40
      })
      .margin({
        top:-35
      })
      .width(`100%`)
      .alignItems(VerticalAlign.Bottom)
      .justifyContent(FlexAlign.SpaceBetween)

      Column({space:20}){
        Text(this.userInfo.username)
          .fontSize(20)
          .fontColor("#ff0a0a0a")
        Text(`长路漫漫其修远兮，吾将上下而求索`)
          .fontSize(14)
          .fontColor("#ffa4a4a4")
      }
      .width('80%')
      .alignItems(HorizontalAlign.Start)
      .justifyContent(FlexAlign.Start)
      .margin({
        top:25,
        left:20,
        right:20
      })



    }
    .margin({
      top:this.statusBar
    })
    .height(`100%`)
    .width(`100%`)
  }
}
