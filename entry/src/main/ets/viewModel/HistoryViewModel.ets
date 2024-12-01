import { MessageBean } from "../bean/MessageBean";
import { UserInfo } from "../bean/UserInfo";
import { ApiPath } from "../http/ApiPath";
import { BaseResponse } from "../http/BaseResponse";
import { BaseViewModel } from "./BaseViewModel";


export  class  HistoryViewModel extends  BaseViewModel{


  messageBean:MessageBean[]=[]

  async found(username:string):Promise<MessageBean[]>
  {
   await this.get<BaseResponse<UserInfo>>(ApiPath.found,username).then((res)=>{
          if(res) {
           this.messageBean=res.data.message
          }
     });

    return  this.messageBean;
  }
}

export const historyViewModel=new HistoryViewModel()