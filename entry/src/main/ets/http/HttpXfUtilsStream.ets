import { http } from '@kit.NetworkKit';

import { XFResultBean } from '../bean/XFResultBean';
import {  XFResultStreamBean } from '../bean/XFResultStreamBean';
import { Logger } from '../utils/Logger';
import { buffer, util } from '@kit.ArkTS';
import { DataReceiveInfo } from '../bean/Data';


/**
 * HTTP流式响应数据接收
 */
export  class  HttpXfUtilsStream{


  private  async  createHttpRequestOptions(extraData?:object) {
    let options: http.HttpRequestOptions = {
      method: http.RequestMethod.POST,
      // 可选，默认为60s
      readTimeout: 60000,
      connectTimeout: 60000,
      extraData:extraData,
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
    return options;
  }


  async post<T extends XFResultStreamBean>(httpRequest:http.HttpRequest,url:string,extraData?:object){

    // let httpRequest=http.createHttp()
    // 用于订阅HTTP响应头事件
    // httpRequest.on('headersReceive', (header: object) => {
    //   console.info('header: ' + JSON.stringify(header));
    // });
    //
    // // 用于订阅HTTP流式响应数据接收事件
    //
    // let resData:T
    // let res :string=""
    // httpRequest.on('dataReceive', (dataInfo: ArrayBuffer) => {
    //   //1、先把数据段dataInfo的字符串提取出来
    //   const result=this.uInt8ArrayToString(new Uint8Array(dataInfo))
    //   let jsonString = result.substring(result.indexOf('{'), result.lastIndexOf('}') + 1);
    //   resData=JSON.parse(jsonString) as T
    //   const resNew=res+resData.choices[0].delta.content
    //   res=resNew
    //   Logger.info("str:"+res)
    //   // const newRes = new ArrayBuffer(res.byteLength + dataInfo.byteLength);
    //   // const resView = new Uint8Array(newRes)
    //   // resView.set(new Uint8Array(res))
    //   // resView.set(new Uint8Array(dataInfo), res.byteLength)
    //   // res = newRes
    //   // 将接收到的数据转换为字符串，然后从字符串中
    //   // 提取JSON字符串，并将其转换为对象。
    //   // return res
    // });

    // 用于订阅HTTP流式响应数据接收完毕事件
    httpRequest.on('dataEnd', () => {
      Logger.info('No more data in response, data receive end');
    });

    httpRequest.on('dataReceiveProgress', (data: DataReceiveInfo) => {
      Logger.info("dataReceiveProgress receiveSize:" + data.receiveSize + ", totalSize:" + data.totalSize);
    });

    let options = await this.createHttpRequestOptions(extraData)
    return await this.HandleResponse<T>(url,httpRequest,options)
  }

  private  async  HandleResponse<T extends XFResultStreamBean>(url:string,httpRequest:http.HttpRequest,options:http.HttpRequestOptions): Promise<void | T>{
    try {
      await httpRequest.requestInStream(url,options).then((response)=>{
        Logger.info("requestInStream OK!");
        Logger.info('ResponseCode :' + JSON.stringify(response));
        // 取消订阅HTTP响应头事件
        httpRequest.off('headersReceive');
        // 取消订阅HTTP流式响应数据接收事件
        httpRequest.off('dataReceive');
        // 取消订阅HTTP流式响应数据接收进度事件
        httpRequest.off('dataReceiveProgress');
        // 取消订阅HTTP流式响应数据接收完毕事件
        httpRequest.off('dataEnd');
      })

    }catch (err) {
      /** 网络请求出现异常(断网,超时,解析出错等) */
      Logger.info("HttpXfUtils--> response error = " + JSON.stringify(err))
      if (err && err.code && err.message) {
        //如果有err且有err.code,err.message,处理错误信息
        // this.handleError(err.code)
      }
      /** 返回undefined,用于if判断异常情况 */
      return undefined
    } finally {
      httpRequest.destroy()
    }
  }

   uInt8ArrayToString(src: Uint8Array, encoding: buffer.BufferEncoding = 'utf-8'): string {
    let textDecoder = util.TextDecoder.create(encoding, { ignoreBOM: true })
    let result = textDecoder.decodeToString(src, { stream: true })
    return result;
  }

}



export  const  httpXfUtilsStream=new HttpXfUtilsStream()

