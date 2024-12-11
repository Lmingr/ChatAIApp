
import { UserMessage } from "../bean/UserMessage";
import { ApiPath } from "../http/ApiPath";
import { BaseResponse } from "../http/BaseResponse";
import { showToast } from "../utils/ComponentUtils";
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

  async  deleteMessage(mid:number){
    Logger.info("hhh")
    await this.get(ApiPath.deleteMessage,mid)
    showToast("删除 成功了")
  }


}

export const historyViewModel=new HistoryViewModel()