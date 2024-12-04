import { MessageBean } from "./MessageBean"


export class  UserMessage{

  mid:number=1
  username:string=""
  messageTopic: string=""
  messageContent: string=""
  messageDate: Date=new Date
  messageList: MessageBean[]=[]

}