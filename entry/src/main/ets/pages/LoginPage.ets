
import { ApiPath } from '../http/ApiPath'
import { router } from '@kit.ArkUI'

import { Logger } from '../utils/Logger'
import { buffer, util } from '@kit.ArkTS'
import { http } from '@kit.NetworkKit'
import { loginViewModel } from '../viewModel/LoginViewModel'
import { showToast } from '../utils/ComponentUtils'
import { InputBean } from '../bean/InputBean'
import { PreferencesUtil } from '../utils/PreferencesUtil'


@Entry
@Component
struct LoginPage{

  @State  account: string=""
  @State  password: string=""
  @State  checkBoolean:boolean=true
  @State  res :string=""

  statusBar: number = AppStorage.get<number>('statusBar') as number

  @State userNameError:string=""
  @State passwordError:string=""

  aboutToAppear(): void {
    if(PreferencesUtil.getPreference()){
      this.account=PreferencesUtil.getValue("username").toString()
      this.password=PreferencesUtil.getValue("password").toString()
    }
  }


  build() {
    Column() {
      Row(){
        Text('欢迎 ')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
        Image($r("app.media.emoji"))
          .width(22)
          .height(22)
      }
      .width(`100%`)
      .justifyContent(FlexAlign.Start)

      Text(`请输入您的账号和密码`)
        .margin(10)
        .fontSize(12)
        .width(`100%`)
        .textAlign(TextAlign.Start)

      Text('账号')
        .margin({
          top:'30%'
        })
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.Black)
        .width(`100%`)
        .textAlign(TextAlign.Start)


      TextInput({placeholder:"account",text:this.account})
        .backgroundColor(Color.Transparent)
        .placeholderColor($r("app.color.content_Color"))
        .maxLength(12)
        .type(InputType.USER_NAME)
        .showError(this.userNameError)
        .border({
          width:{bottom:1},
          color:'#17C3CE',
          radius:0
        })
        .padding({
          left:-2
        })
        .onChange((text)=>{
          this.account=text
        })
        .width(`100%`)

      Text('密码')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.Black)
        .margin({
          top:20
        })
        .width(`100%`)
        .textAlign(TextAlign.Start)


      TextInput({placeholder:"password",text:this.password})
        .type(InputType.Password)
        .maxLength(10)
        .showError(this.passwordError)
        .placeholderColor($r("app.color.content_Color"))
        .backgroundColor(Color.Transparent)
        .padding({
          left:-2
        })
        .border({
          width:{bottom:1},
          color:'#17C3CE',
          radius:0
        })
        .passwordIcon({onIconSrc:$r("app.media.eye_light_click"),offIconSrc:$r("app.media.eye_light")})
        .onChange((text)=>{
          this.password=text
        })
        .width(`100%`)

      Row(){
        Checkbox()
          .unselectedColor('#17C3CE')
          .selectedColor('#17C3CE')
          .shape(CheckBoxShape.ROUNDED_SQUARE)
          .width(16)
          .height(16)
          .select(true)
          .onChange((value:boolean)=>{
           this.checkBoolean=value
          })
        Text(`记住账号`)
          .fontSize(14)
      }
      .margin({
        top:30
      })
      .width('100%')

      Button(`登录`)
        .backgroundColor('#17C3CE')
        .margin({
          top:20
        })
        .width(`90%`)
        .onClick(()=>{

          if(this.account==""){
            this.userNameError=InputBean.userNameNoNull
          }

          if(this.password==""){
            this.passwordError=InputBean.passWordNoNull
          }
          loginViewModel.Login(this.account,this.password,(isSuccess)=>{
            if(isSuccess){
              showToast("登录成功")
              if(this.checkBoolean){
                PreferencesUtil.putValue("username",this.account)
                PreferencesUtil.putValue("password",this.password)
              }
              AppStorage.setOrCreate('username', this.account)
              router.pushUrl({url:'pages/MainPage'})
            }else{
              showToast("登录失败")
            }
          })
        })

      Text(){
        Span('没有账号？那就先')
          .fontSize(14)
          .fontColor(Color.Black)
        Span('注册')
          .fontSize(14)
          .fontColor($r("app.color.primaryColor"))
          .onClick(()=>{
            router.pushUrl({url:'pages/RegisterPage'})
          })
        Span('一下吧')
          .fontSize(14)
          .fontColor(Color.Black)
      }
      .margin({
        top:30
      })

    }
    .margin({
      top:this.statusBar
    })
    .width('100%')
    .height('100%')
    .padding({
      top:20,
      left:20,
      right:20
    })

  }


}
