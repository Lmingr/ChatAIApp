import { router } from '@kit.ArkUI'
import { showToast } from '../utils/ComponentUtils'
import { registerViewModel } from '../viewModel/RegisterViewModel'


@Entry
@Component
struct  RegisterPage{

  @State   account: string=""
  @State   password: string=""
  statusBar: number = AppStorage.get<number>('statusBar') as number

  build() {
    Column(){
      Row(){
        Image($r("app.media.Button_Back"))
          .width(24)
          .height(24)
          .objectFit(ImageFit.Fill)
          .onClick(()=>{
            router.back()
          })
      }
      .justifyContent(FlexAlign.Start)
      .width(`100%`)

      Row(){
        Text('你好')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
        Image($r("app.media.emoji"))
          .width(22)
          .height(22)
      }
      .margin({
        top:30
      })
      .width(`100%`)
      .justifyContent(FlexAlign.Start)

      Text(`请输入需要注册的账号和密码`)
        .margin(10)
        .fontSize(12)
        .width(`100%`)
        .padding({right:'30%'})
        .textAlign(TextAlign.Start)

      this.LoginView()

      Blank()
    }
    .margin({
      top:this.statusBar
    })
    .padding({left:20,right:20})
    .justifyContent(FlexAlign.Start)
    .width(`100%`)
    .height(`100%`)
  }

  @Builder LoginView(){
    Column(){
        Text('账号')
          .fontSize(14)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Black)
          .width(`100%`)
      Row(){
        TextInput({placeholder:"account",text:this.account})
          .showUnderline(true)
          .underlineColor('#17C3CE')
          .onChange((text)=>{
            this.account=text
          })
        Image($r("app.media.account"))
          .width(24)
          .height(24)
          .margin({
            left:-26
          })
      }
      .width(`100%`)

      Text('密码')
        .fontSize(14)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.Black)
        .width(`100%`)
        .margin({top:10})
      Row(){
        TextInput({placeholder:"password",text:this.password})
          .showUnderline(true)
          .underlineColor('#17C3CE')
          .onChange((text)=>{
            this.password=text
          })
        Image($r("app.media.eye_light"))
          .width(24)
          .height(24)
          .margin({
            left:-26
          })
      }
      .width(`100%`)

      Row(){
        Checkbox()
          .unselectedColor('#17C3CE')
          .selectedColor('#17C3CE')
          .shape(CheckBoxShape.ROUNDED_SQUARE)
          .width(16)
          .height(16)
          .select(true)
        Text(`我同意app的相关隐私政策和隐私协议`)
          .width('80%')
          .fontSize(14)
          .fontWeight(FontWeight.Bold)
          .fontSize(14)
      }
      .margin({
        top:30
      })
      .width('100%')

      Button('注册')
        .width(`70%`)
        .margin({
          top:40
        })
        .backgroundColor('#17C3CE')
        .onClick(()=>{
          registerViewModel.register(this.account,this.password,(isSuccess)=>{
            if(isSuccess){
              showToast('注册成功！跳转导登录页')
              router.back({url:'pages/LoginPage'})
            }else{
              showToast('注册失败！')
            }
          })
        })
    }
    .margin({top:'30%'})
    .justifyContent(FlexAlign.Start)
    .width('100%')
  }
}

@Extend(TextInput) function textInputStyle() {
  .height(40)
  .backgroundColor(Color.Transparent)
  .borderWidth({ bottom:1,top:0,left:0,right:0})
  .borderRadius(0)
  .width(`80%`)

}