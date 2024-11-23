import { http } from '@kit.NetworkKit';
import { XFResultBean } from '../bean/XFResultBean';
import { Logger } from '../utils/Logger';

export  class  HttpXfUtils{

  private  async  createHttpRequestOptions(method:http.RequestMethod,extraData?:object) {
    let options: http.HttpRequestOptions = {
      method: method,
      // 可选，默认为60s
      readTimeout: 60000,
      connectTimeout: 60000,
      usingCache: true, // 可选，默认为true
      priority: 1, // 可选，默认为1
      expectDataType: http.HttpDataType.STRING, // 可选，指定返回数据的类型
      usingProtocol: http.HttpProtocol.HTTP1_1, // 可选，默认值由系统自动指定。
      usingProxy: false,// 可选，默认为false
      header: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer IPxuQTpHIsGkvvMFATor:GoxkegkltWpglbfwExDS'
      }
    }
    if(method==http.RequestMethod.POST){
      options.extraData=extraData
      Logger.info(`POST请求,extraData:->${JSON.stringify(extraData)}`)
    }
    return options;
  }

  async post<T extends XFResultBean>(url:string,extraData?:object){
    let httpRequest=http.createHttp()
    let options = await this.createHttpRequestOptions(http.RequestMethod.POST,extraData)
    return await this.HandleResponse<T>(url,httpRequest,options)
  }

  private  async  HandleResponse<T extends XFResultBean>(url:string,httpRequest:http.HttpRequest,options:http.HttpRequestOptions): Promise<void | T>{
    try {
      Logger.info(`发起post 请求路径为${url}`)
      const response= await httpRequest.request(url,options)
      Logger.info(`发起post 请求路径为 response${response}`)
      let res:T
      res=JSON.parse(response.result as string) as T
      Logger.info(`发起post 请求路径为 res`)
      Logger.info(`发起post 请求路径为 res.message:${res.message}`)
      Logger.info(`发起post 请求路径为 res.choices[0].delta.role${res.choices[0].message.content}`)
      return res
    }catch (err) {
      /** 网络请求出现异常(断网,超时,解析出错等) */
      Logger.info("HttpXfUtils--> response error = " + JSON.stringify(err))
      if (err && err.code && err.message) {
        //如果有err且有err.code,err.message,处理错误信息
        //  this.handleError(err.code)
      }
      /** 返回undefined,用于if判断异常情况 */
      return undefined
    } finally {
      httpRequest.destroy()
    }
  }

}


export  const  httpXfUtils=new HttpXfUtils()

