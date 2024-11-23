import { MessagesBean, XFRequestBean } from "../bean/XFRequestBean";
import { XFResultBean } from "../bean/XFResultBean";
import { ApiPath } from "../http/ApiPath";
import { showToast } from "../utils/ComponentUtils";
import { BaseViewModel } from "./BaseViewModel";


export class  ChatMessageViewModel extends  BaseViewModel{

  // 普通请求
  async    postXf(question:string,user:string): Promise<string>{
    const xfRequestBean = new XFRequestBean();
    const messages = new MessagesBean()
    messages.role = "user"
    messages.content = question

    xfRequestBean.user = user
    xfRequestBean.model = "lite"
    xfRequestBean.messages = [messages]
    xfRequestBean.stream = false
    const res=await this.postXF<XFResultBean>(ApiPath.xfUrl, xfRequestBean)
     if(res){
       return  res.choices[0].message?.content
     }
     else {
       showToast("消息返回异常")
       return ""
     }

  }


  // //流式请求
  // async postXfStream(callback:(data:string)=>void){
  //   //流式请求
  //   let httpRequest=http.createHttp()
  //   // 用于订阅HTTP响应头事件
  //   httpRequest.on('headersReceive', (header: object) => {
  //     console.info('header: ' + JSON.stringify(header));
  //   });
  //
  //   // 用于订阅HTTP流式响应数据接收事件
  //   let resData:XFResultStreamBean
  //   let res1 :string=""
  //   httpRequest.on('dataReceive', (dataInfo: ArrayBuffer) => {
  //     //1、先把数据段dataInfo的字符串提取出来
  //     Logger.info("dataInfo.byteLength"+dataInfo.byteLength)
  //     if(dataInfo.byteLength>0){
  //       const result=this.uInt8ArrayToString(new Uint8Array(dataInfo))
  //       let jsonString = result.substring(result.indexOf('{'), result.lastIndexOf('}') + 1);
  //       Logger.info("jsonString"+jsonString)
  //       resData=JSON.parse(jsonString) as XFResultStreamBean
  //       const resNew=res1+resData.choices[0].delta.content
  //       res1=resNew
  //       callback(res1)
  //     }
  //     else {
  //       Logger.info("dataInfo已无数据")
  //     }
  //   });
  //   const  xfRequestBean=new XFRequestBean();
  //   const messages=new MessagesBean()
  //   messages.role="user"
  //   messages.content="你知道大平洋多大吗"
  //
  //   xfRequestBean.user="lmr"
  //   xfRequestBean.model="lite"
  //   xfRequestBean.messages=[messages]
  //   xfRequestBean.stream=true
  //
  //   httpXfUtilsStream.post<XFResultStreamBean>(httpRequest,ApiPath.xfUrl,xfRequestBean).then(res=>{
  //   })
  // }
  //
  // uInt8ArrayToString(src: Uint8Array, encoding: buffer.BufferEncoding = 'utf-8'): string {
  //   let textDecoder = util.TextDecoder.create(encoding, { ignoreBOM: true })
  //   let result = textDecoder.decodeToString(src, { stream: true })
  //   return result;
  // }

}

export const  chatMessageViewModel=new ChatMessageViewModel()