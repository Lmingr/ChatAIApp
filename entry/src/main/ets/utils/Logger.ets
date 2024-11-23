import { hilog } from '@kit.PerformanceAnalysisKit';

export  class Logger{

  private static domain: number = 0xFF00;
  private static prefix: string = "ChatAIApplication";
  private static isPrint: boolean = true;


  private static format: string = '%{public}s';
  static debug = (...args: string[]) => {
    if (!this.isPrint) {
      return
    }
    hilog.debug(this.domain, this.prefix, this.format, args);
  }
  static info = (...args: string[]) => {
    if (!this.isPrint) {
      return
    }
    hilog.info(this.domain, this.prefix, this.format, args);
  }
  static warn = (...args: string[]) => {
    if (!this.isPrint) {
      return
    }
    hilog.warn(this.domain, this.prefix, this.format, args);
  }
  static error = (...args: string[]) => {
    if (!this.isPrint) {
      return
    }
    hilog.error(this.domain, this.prefix, this.format, args);
  }



}