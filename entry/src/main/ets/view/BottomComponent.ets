import { Logger } from "../utils/Logger"

@Component
export struct  BottomComponent{

  @State content:string=""

  @Link isGenerate:boolean

  //定义发送消息的方法
  sendMessage:(content:string)=>void = () => {}

  build() {
    Row({space:5}){
      TextInput({placeholder:this.isGenerate?"正在生成中...":"Ask me anything",text:$$this.content})
        .height(40)
        .borderRadius(15)
        .backgroundColor('#FAFAFA')
        .layoutWeight(1)
        .id("input")
        .shadow(ShadowStyle.OUTER_FLOATING_SM)

      Image(this.isGenerate?$r("app.media.button_no_send"):$r("app.media.Button_Send"))
        .width(60)
        .height(60)
        .enabled(this.isGenerate?false:true)
        .onClick(()=>{
          if(this.content){
            Logger.info("这里有运行吗"+this.content)
            this.sendMessage(this.content)
            this.content=""
            focusControl.requestFocus('input')
          }
        })
    }
    .height(60)
    .padding({left:10,right:10})
    .margin({bottom:10})
    .width(`100%`)
  }
}