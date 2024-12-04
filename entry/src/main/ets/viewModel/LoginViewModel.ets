import { BaseReq } from '../bean/LoginReq';
import { UserInfo } from '../bean/UserInfo';
import { ApiPath } from '../http/ApiPath';
import { BaseResponse } from '../http/BaseResponse';
import { showToast } from '../utils/ComponentUtils';
import { Logger } from '../utils/Logger';
import { BaseViewModel } from './BaseViewModel';


export class LoginViewModel extends BaseViewModel{


  async  Login(username: string, password: string,callback:(isSuccess:boolean)=>void){
    const  baseReq=new BaseReq()
    baseReq.username=username
    baseReq.password=password
    this.post<BaseResponse<UserInfo>>(ApiPath.login,baseReq).then( async response=>{
      if(response && response.state=='200'){
        Logger.info("LoginViewModel -》》登录成功1111！！！"+response.state)
        Logger.info("res 返回数据 phone-》"+response.data?.phone)
        callback(true)
      }else{
        showToast("登录失败")
        callback(false)
      }

    }).catch((err:string) => {
      Logger.error("LoginViewModel -》》"+err)
      showToast("登录失败"+err)
      callback(false)
    })
  }

}

export  const  loginViewModel =new LoginViewModel()

