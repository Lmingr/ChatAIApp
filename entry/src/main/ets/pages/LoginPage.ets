
import { ApiPath } from '../http/ApiPath'
import { router } from '@kit.ArkUI'

import { Logger } from '../utils/Logger'
import { buffer, util } from '@kit.ArkTS'
import { http } from '@kit.NetworkKit'
import { loginViewModel } from '../viewModel/LoginViewModel'
import { showToast } from '../utils/ComponentUtils'


@Entry
@Component
struct LoginPage{

  @State  account: string="luomingr"
  @State  password: string="1231231"
  @State  checkBoolean:boolean=true
  @State  res :string=""


  build() {
    Column() {
      Row(){
        Text('Welcome ')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
        Image($r("app.media.emoji"))
          .width(22)
          .height(22)
      }
      .width(`100%`)
      .justifyContent(FlexAlign.Start)

      Text(`Please enter your account and password to sign in`)
        .margin(10)
        .fontSize(12)
        .width(`100%`)
        .textAlign(TextAlign.Start)

      Text('Account')
        .margin({
          top:'30%'
        })
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.Black)
        .width(`100%`)
        .textAlign(TextAlign.Start)

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

      Text('Password')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.Black)
        .margin({
          top:20
        })
        .width(`100%`)
        .textAlign(TextAlign.Start)

      Row(){
        TextInput({placeholder:"password",text:this.password})
          .showUnderline(true)
          .underlineColor('#17C3CE')
          .onChange((text)=>{
           this.password=text
          })
        Image($r("app.media.Eye_light"))
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
        Text(`remenber me`)
          .fontSize(14)
      }
      .margin({
        top:30
      })
      .width('100%')

      Button(`Sign in`)
        .backgroundColor('#17C3CE')
        .margin({
          top:20
        })
        .width(`90%`)
        .onClick(()=>{
          if(this.checkBoolean){
            loginViewModel.Login(this.account,this.password,(isSuccess)=>{
              if(isSuccess){
                showToast("登录成功")
                AppStorage.setOrCreate('username', this.account)
                router.pushUrl({url:'pages/MainPage'})
              }else{
                showToast("登录失败")
              }
            })
          }else{
            showToast("请先勾选协议")
          }
        })

      Text(){
        Span('Don’t have an account?')
          .fontSize(14)
          .fontColor(Color.Black)
        Span('Sign up')
          .fontSize(14)
          .fontColor($r("app.color.primaryColor"))
          .onClick(()=>{
            router.pushUrl({url:'pages/RegisterPage'})
          })
      }
      .margin({
        top:30
      })

    }
    .width('100%')
    .height('100%')
    .padding({
      top:20,
      left:20,
      right:20
    })

  }
}
