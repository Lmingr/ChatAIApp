import { MessageInfoModel } from '../bean/MessageInfoModel'
import { router } from '@kit.ArkUI'
import MessageComponent from '../view/MessageComponent'
import { MessageLoadingComponent } from '../view/MessageLoadingComponent'
import { BottomComponent } from '../view/BottomComponent'
import { Logger } from '../utils/Logger'
import { chatMessageViewModel } from '../viewModel/ChatMessageViewModel'


@Entry
@Component
struct  ChatToAIPage{

  @State resData:string=""
  statusBar: number = AppStorage.get<number>('statusBar') as number


  private scroller: Scroller = new Scroller()

  @State loading:boolean=false

  @State
  messageList:MessageInfoModel[]=[]

  aboutToAppear(): void {
   Logger.info(" aboutToAppear()这里是页面显示的时候")
  }


  build() {
    Column(){
      Stack({alignContent:Alignment.BottomStart}){//开始居左
        Image($r("app.media.Button_Back"))
          .width(18)
          .height(18)
          .zIndex(2)
          .onClick(()=>{
            router.back()
          })
        Text(`ChatAI`)
          .fontColor(Color.Black)
          .fontSize(20)
          .width('100%')
          .textAlign(TextAlign.Center)
      }
      .padding({
        left:10,
        right:10,
        bottom:10
      })
      .border({
        color:Color.Black,
        width:{bottom:1}
      })
      .height(`10%`)
      .width('100%')

      List({space:20,scroller:this.scroller}){
        ForEach(this.messageList, (item:MessageInfoModel)=>{
          ListItem(){
            MessageComponent({messageInfo:item})
          }
        })
        MessageLoadingComponent()
          .visibility(this.loading?Visibility.Visible:Visibility.None)
      }
      .scrollSnapAlign(ScrollSnapAlign.END)
      .layoutWeight(1)
      .padding({top:20,bottom:10})

      BottomComponent({
        sendMessage: (content:string) => {
          this.sendMessage(content)
        }
      })
    }
    .padding({top:this.statusBar})
    .height(`100%`)
    .justifyContent(FlexAlign.SpaceBetween)
  }

  //把消息存到消息队列中
  async  sendMessage(content:string):Promise<void>{
    //这里是每次使用者调用的时候

    // let messageInfoModel=new MessageInfoModel()
    // messageInfoModel.messageContent=content
    // messageInfoModel.sendUser="lmr"
    // messageInfoModel.receiveUser="AI"
    // messageInfoModel.headImage=$r("app.media.touxiang_1")
    // this.messageList.push(messageInfoModel)
    await this.messagePush(content,"lmr","AI",$r("app.media.touxiang_1"))
    Logger.info(" this.loading11111111"+ this.loading)
    this.loading=true
    this.getResponseMessage(content,"lmr")
  }

  //封装AI问答
  async   getResponseMessage(question:string,user:string){
    const  result= await chatMessageViewModel.postXf(question,user)
    this.loading=false

    this.messagePush(result,"ChatAI",user,$r("app.media.vector_ai"))
    // let messageInfo=new MessageInfoModel()
    // messageInfo.messageContent=result
    // messageInfo.sendUser="AI"
    // messageInfo.receiveUser=user
    // messageInfo.headImage=$r("app.media.ai_tou_xiang")
    // this.messageList.push(messageInfo)

  }


  async messagePush(result:string,senUser:string,user:string,image:ResourceStr) :Promise<void>
  {
    Logger.info(" this.loading"+ this.loading)
    let messageInfo=new MessageInfoModel()
    messageInfo.messageContent=result
    messageInfo.sendUser=senUser
    messageInfo.receiveUser=user
    messageInfo.headImage=image
    this.messageList.push(messageInfo)
    this.scroller.scrollEdge(Edge.Bottom)
  }

  aboutToDisappear(): void {
    Logger.info(" aboutToDisappear()这里是页面不显示的时候")
  }

}