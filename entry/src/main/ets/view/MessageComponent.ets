import { MessageBean } from '../bean/MessageBean'
import { MessageInfoModel } from '../bean/MessageInfoModel'
import { XFRequestBean } from '../bean/XFRequestBean'

@Preview
@Component
struct  MessageComponent{

  @Prop
  messageBean:MessageBean

  @Prop isSendMessage:boolean

  //判断是不是user发的消息
  @State
  isOwnMessage:boolean = this.messageBean?.role=="user"
   //AI答复的需要有次序效果
  @State answer:string=""
  //AI答复的次序位置
  @State pos:number=0

  @State intervalID:number=0


  aboutToAppear(): void {
    this.answer = '';
    this.pos = 0;
    clearInterval(this.intervalID);
    setTimeout(() => {
      this.intervalID = setInterval(() => {
        if (this.pos < this.messageBean?.content.length) {
          this.answer = this.answer.concat(this.messageBean?.content.charAt(this.pos))
          this.pos += 1;
        } else {
          clearInterval(this.intervalID);
        }
      }, 30)
    })
  }

  build() {
    Row(){
      Image(this.isOwnMessage?$r("app.media.touxiang_1"):$r("app.media.vector_ai"))
        .width(33)
        .height(33)
        .objectFit(ImageFit.Contain)
        .borderRadius(this.isOwnMessage?20:0)


      Column({space:5}){
        Text(this.messageBean.role)
          .margin({ left:6, right:5 })
          .fontWeight(FontWeight.Bold)
        Text(!this.isOwnMessage&&this.isSendMessage?this.answer:this.messageBean.content)
          .backgroundColor(this.isOwnMessage?$r("app.color.primaryColor"):'#F8FAFC')
          .fontColor(this.isOwnMessage?$r("app.color.start_window_background"):'#475569')
          .padding(10)
          .margin({ left:5, right:5 })
          .borderRadius(8)
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)
    }
    .alignItems(VerticalAlign.Top)
    .direction(Direction.Ltr)
    .padding({ left:15, right:15})
  }
}

export  default MessageComponent