import { XFResultBean } from '../bean/XFResultBean'
import { BaseResponse } from '../http/BaseResponse'
import { httpUtils } from '../http/HttpUtils'
import { httpXfUtils } from '../http/HttpXfUtils'

export  class  BaseViewModel{

  /**
   * T是数据响应
   * @param url
   * @param extraData
   * @returns
   */
  async post<T extends BaseResponse<object>>(url:string,extraData?:object){
    return await httpUtils.post<T>(url,extraData)
  }


  async postXF<T  extends XFResultBean>(url:string,extraData?:object){
    return await httpXfUtils.post<T>(url,extraData)
  }
}