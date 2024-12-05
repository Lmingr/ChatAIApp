import { BaseReq } from '../bean/LoginReq'
import { hilog } from '@kit.PerformanceAnalysisKit'
import { httpUtils } from '../http/HttpUtils'
import { ApiPath } from '../http/ApiPath'
import { BaseResponse } from '../http/BaseResponse'
import { UserInfo } from '../bean/UserInfo'
import { Logger } from '../utils/Logger'
import { BaseViewModel } from './BaseViewModel'


export  class  RegisterViewModel extends BaseViewModel{

  async  register(username:string,password:string,callback:(isSuccess:boolean)=>void) {
    const baseReq = new BaseReq()
    baseReq.username = username
    baseReq.password = password
    this.post<BaseResponse<UserInfo>>(ApiPath.register, baseReq)
      .then( async res => {
        Logger.info('注册结果' + JSON.stringify(res))
        if (res && res.state == '200') {
          Logger.info('注册成功' )
          callback(true)
        } else {
          Logger.info('注册失败')
          callback(false)
        }
      }).catch((err: string) => {
        Logger.info('注册失败' + err)
        callback(false)
      })
  }
}

export  const  registerViewModel = new  RegisterViewModel()
