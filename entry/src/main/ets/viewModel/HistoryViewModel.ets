
import { UserMessage } from "../bean/UserMessage";
import { ApiPath } from "../http/ApiPath";
import { BaseResponse } from "../http/BaseResponse";
import { Logger } from "../utils/Logger";
import { BaseViewModel } from "./BaseViewModel";


export  class  HistoryViewModel extends  BaseViewModel{


  userMessageBean:UserMessage[]=[]

  async foundMessageList(username:string):Promise<UserMessage[]>
  {
   await this.get<BaseResponse<UserMessage[]>>(ApiPath.foundList,username).then((res)=>{
          if(res) {
            Logger.info("res的值是多少呀222222"+res.data.length)
            this.userMessageBean=res.data
          }
     });

    return  this.userMessageBean;
  }
}

export const historyViewModel=new HistoryViewModel()