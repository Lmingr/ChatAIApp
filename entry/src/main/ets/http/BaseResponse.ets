import { HeaderBean } from './HeaderBean'

/**
 * 请求的返回数据
 */
export  class BaseResponse<T>{

  //请求头
  // header :HeaderBean
  state:string;
  message:string;
  data:T

  // constructor(header:HeaderBean, data: T) {
  //   this.header = header
  //   this.data = data
  // }

  constructor(state: string, message: string, data: T) {
    this.state = state;
    this.message = message;
    this.data = data;
  }
}