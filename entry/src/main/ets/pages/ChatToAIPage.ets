import { MessageInfoModel } from '../bean/MessageInfoModel'
import { promptAction, router } from '@kit.ArkUI'
import MessageComponent from '../view/MessageComponent'
import { MessageLoadingComponent } from '../view/MessageLoadingComponent'
import { BottomComponent } from '../view/BottomComponent'
import { Logger } from '../utils/Logger'
import { chatMessageViewModel } from '../viewModel/ChatMessageViewModel'
import { MessageBean } from '../bean/MessageBean'
import { UserMessage } from '../bean/UserMessage'
import { DialogComponent } from '../view/DialogComponent'
import { MessageUpdateBean } from '../bean/MessageUpdateBean'
import { showToast } from '../utils/ComponentUtils'


@Entry
@Component
struct  ChatToAIPage{

  @State resData:string=""
  statusBar: number = AppStorage.get<number>('statusBar') as number
  username =AppStorage.get('username') as string
  private scroller: Scroller = new Scroller()

  @State loading:boolean=false
  @State messageList:MessageBean[]=[]
  @State mid:number=0


  @State isSendMessage:boolean=false

  @State isNewChat:boolean=false


  aboutToAppear(): void {
    let  params=router.getParams() as  Record<string, number|boolean>;
    this.isNewChat=params[`isNewChat`] as boolean
    if(!this.isNewChat)
    {
       this.mid=params[`mid`] as number
       Logger.info("mid:"+this.mid)
       chatMessageViewModel.foundMessage(this.mid).then((res)=>{
        this.messageList=res.messageList
      })
    }
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
      .height(`6%`)
      .width('100%')

      List({space:20,scroller:this.scroller}){
        ForEach(this.messageList, (item:MessageBean)=>{
          ListItem(){
            MessageComponent({messageBean:item,isSendMessage:this.isSendMessage})
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
          this.isSendMessage = true
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

    // messageInfoModel.receiveUser="AI"
    // messageInfoModel.headImage=$r("app.media.touxiang_1")
    // this.messageList.push(messageInfoModel)
    await this.messagePush("user",content)
    Logger.info(" this.loading11111111"+ this.loading)
    this.loading=true
    this.getResponseMessage(content,"user")
  }

  //封装AI问答
  async   getResponseMessage(question:string,user:string){
    const  result= await chatMessageViewModel.postXf(question,user)
    this.loading=false
    this.messagePush("AI",result)
    // let messageInfo=new MessageInfoModel()
    // messageInfo.messageContent=result
    // messageInfo.sendUser="AI"
    // messageInfo.receiveUser=user
    // messageInfo.headImage=$r("app.media.ai_tou_xiang")
    // this.messageList.push(messageInfo)

  }

  async  messagePush(role:string,content:string){
    let messageBean=new MessageBean()
    messageBean.role=role
    messageBean.content=content;
    this.messageList.push(messageBean)
    this.scroller.scrollEdge(Edge.Bottom)
  }



  // async messagePush(result:string,senUser:string,user:string,image:ResourceStr) :Promise<void>
  // {
  //   Logger.info(" this.loading"+ this.loading)
  //   let messageInfo=new MessageInfoModel()
  //   messageInfo.messageContent=result
  //   messageInfo.sendUser=senUser
  //   messageInfo.receiveUser=user
  //   messageInfo.headImage=image
  //   this.messageList.push(messageInfo)
  //   this.scroller.scrollEdge(Edge.Bottom)
  // }


  aboutToDisappear(): void {
    if(this.isNewChat&&this.messageList.length>1){
      //需要满足信息的前两个内容是作为标题和内容的
        let  userMessage=new UserMessage()
         userMessage.username=this.username
         Logger.info("这里什么时候才会反应")
         userMessage.messageTopic=  this.messageList[0].content
         userMessage.messageContent=  this.messageList[1].content
         userMessage.messageList=this.messageList
         chatMessageViewModel.insertMessage(userMessage)
         showToast("新建成功啦")
    }
    else if(this.isSendMessage){
      //在页面消息的时候做更新操作,这里是修改
      let messageUpdateBean=new MessageUpdateBean()
      messageUpdateBean.mid=this.mid
      messageUpdateBean.messageList=this.messageList
      chatMessageViewModel.updateMessage(messageUpdateBean)
      showToast("修改成功")
      Logger.info(" aboutToDisappear()这里是页面不显示的时候")
    }
   else{
     showToast("啥都没变过啦")
   }
  }

}