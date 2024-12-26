import { router } from '@kit.ArkUI'
import { InputBean } from '../bean/InputBean'
import { showToast } from '../utils/ComponentUtils'
import { registerViewModel } from '../viewModel/RegisterViewModel'


@Entry
@Component
struct  RegisterPage{

  @State   account: string=""
  @State   password: string=""

  @State checkBool:boolean=false

  statusBar: number = AppStorage.get<number>('statusBar') as number

  @State userNameError:string=""
  @State passwordError:string=""

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
          .select(this.checkBool)
          .onChange((value)=>{
            this.checkBool=value
          })


        Text(){
          Span('我已阅读并同意')
            .fontSize(14)
            .fontColor(Color.Black)
          Span('《隐私政策》')
            .fontSize(14)
            .fontColor($r("app.color.primaryColor"))
            .onClick(()=>{
              router.pushUrl({url:'pages/WebPage'})
            })
        }
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

            if(this.checkBool){

              if(this.account==""){
                this.userNameError=InputBean.userNameNoNull
              }

              if(this.password==""){
                this.passwordError=InputBean.passWordNoNull
              }

              if(isSuccess){
                showToast('注册成功！跳转导登录页')
                router.back({url:'pages/LoginPage'})
              }else{
                showToast('注册失败！')
              }
            }else{
              showToast('请先阅读并勾选同意隐私政策')
            }

          })
        })
    }
    .margin({top:'10%'})
    .justifyContent(FlexAlign.Start)
    .width('100%')
  }
}