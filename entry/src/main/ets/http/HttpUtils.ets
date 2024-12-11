import { connection, http } from '@kit.NetworkKit'
import { Logger } from '../utils/Logger'
import { ApiPath } from './ApiPath'
import { BaseResponse } from './BaseResponse'
import { showToast } from '../utils/ComponentUtils'



export  class  HttpUtils{

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
        'Content-Type': 'application/json'
      }
    }
    /**
     * post请求添加extraData，额外的参数
     */http://114.132.225.103:8090/users/login
    if(method==http.RequestMethod.POST){
      options.extraData=extraData
      Logger.info(`POST请求,extraData:->${JSON.stringify(extraData)}`)
    }
    return options;
  }

  async post<T extends BaseResponse<object>>(url:string,extraData?:object){
    let httpRequest=http.createHttp()
    let options = await this.createHttpRequestOptions(http.RequestMethod.POST,extraData)
    return await this.HandleResponse<T>(url,httpRequest,options)
  }

  async get<T extends BaseResponse<object>>(url:string,param:number|string){
    let httpRequest=http.createHttp()
    let options = await this.createHttpRequestOptions(http.RequestMethod.GET)
    return await this.HandleResponse<T>(url+`${param}`,httpRequest,options)
  }


  private  async  HandleResponse<T extends BaseResponse<object>>(url:string,httpRequest:http.HttpRequest,options:http.HttpRequestOptions): Promise<void | T>{
    try {
      Logger.info(`发起post 请求路径为${url}`)
      const response= await httpRequest.request(url,options)
      let res:T
      res=JSON.parse(response.result as string) as T
      return res
    }catch (err) {
      /** 网络请求出现异常(断网,超时,解析出错等) */
      Logger.info("HttpUtils.ets--> convertResponse response error = " + JSON.stringify(err))
      if (err && err.code && err.message) {
        //如果有err且有err.code,err.message,处理错误信息
      }
      /** 返回undefined,用于if判断异常情况 */
      return undefined
    } finally {
      httpRequest.destroy()
    }

  }
  //处理错误
  handleError(code: number) {
    let msg = ''
    //参考官方文档,http错误码 https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/errorcode-net-http-V5#section2300005-%E4%BB%A3%E7%90%86%E6%9C%8D%E5%8A%A1%E5%99%A8%E5%9F%9F%E5%90%8D%E8%A7%A3%E6%9E%90%E5%A4%B1%E8%B4%A5
    switch (code) {
      case 2300001:
        msg = '不支持的协议';
        break;
      case 2300003:
        msg = 'URL格式错误';
        break;
      case 2300005:
        msg = '代理服务器域名解析失败';
        break;
      case 2300006:
        //可能原因: 1.传入的服务器的URL不正确。 2.网络不通畅。
        msg = '域名解析失败';
        if (!connection.hasDefaultNetSync()) {
          //如果没有网络
          msg = '网络异常，请检查网络后重试'
        }
        break;
      case 2300007:
        msg = '无法连接到服务器';
        if (!connection.hasDefaultNetSync()) {
          //如果没有网络
          msg = '网络异常，请检查网络后重试'
        }
        break;
      case 2300008:
        msg = '服务器返回非法数据';
        break;
      case 2300009:
        msg = '拒绝对远程资源的访问';
        break;
      case 2300016:
        msg = 'HTT2帧层错误';
        break;
      case 2300018:
        msg = '服务器返回数据不完整';
        break;
      case 2300027:
        msg = '内存不足';
        break;
      case 2300028:
        msg = '操作超时';
        break;
      case 2300047:
        msg = '重定向次数达到最大值';
        break;
      case 2300052:
        msg = '服务器没有返回内容';
        break;
      case 2300055:
        msg = '发送网络数据失败';
        break;
      case 2300056:
        msg = '接收网络数据失败';
        break;
      case 2300058:
        msg = '本地SSL证书错误';
        break;
      case 2300060:
        msg = '远程服务器SSL证书或SSH秘钥不正确';
        break;
      case 2300061:
        msg = '无法识别或错误的HTTP编码格式';
        break;
      case 2300070:
        msg = '服务器磁盘空间不足';
        break;
      case 2300077:
        msg = 'SSL CA证书不存在或没有访问权限';
        break;
      case 2300094:
        msg = '身份校验失败';
        break;
      case 2300998:
        msg = '不允许访问域名';
        break;
      case 2300999:
        msg = '未知错误';
        break;
      default:
        msg = '未知错误';
    }
    showToast(msg)
  }
}



export const httpUtils = new HttpUtils();