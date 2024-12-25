import { Logger } from '../utils/Logger'
import { router } from '@kit.ArkUI'
import web_webview from '@ohos.web.webview';
import { call } from '@kit.TelephonyKit';
import { common, Want } from '@kit.AbilityKit';

/**
 * @see RouterPath.WebPage
 */
@Entry
@Component
struct WebPage {
  /** 标题 */
  @State title: string = ''
  /** h5的url链接 */
  @State url: string = "http://114.132.225.103/"
  /* 注入的js协议名 */
  JSProxyName: string = 'HarmonyOS'
  @State webFrom: string = ""
  @State error_net: number = 0
  /** 控制器 */
  controller: WebviewController = new web_webview.WebviewController()
  statusBar: number = AppStorage.get<number>('statusBar') as number;
  /** 底部安全区域的高度 */
  bottomRectHeight: number = AppStorage.get<number>('bottomRectHeight') as number;
  @State bgColor: ResourceColor = Color.White

  aboutToAppear() {
    /** 获取路由参数对象 */
    let params = router.getParams() as object
    if (params && params['url']) {
      /** 如果有params且params有url, 赋值成员变量url */
      this.url = params['url'] as string
      Logger.info(`WebPage aboutToAppear url:${this.url}`)
    }
    if (params && params['JSProxyName']) {
      /** 如果有params且params有JSProxyName, 赋值成员变量JSProxyName */
      this.JSProxyName = params['JSProxyName'] as string
      Logger.info(`WebPage aboutToAppear JSProxyName:${this.JSProxyName}`)
    }
  }

  /** 刷新函数 */
  private onRefresh = () => {
    try {
      //刷新链接
      this.controller.refresh()
      this.error_net = 0
      Logger.info(`WebPage.ets--> onRefresh,url: -> ${this.url}`)
    } catch (error) {
      Logger.error(`WebPage.ets--> onRefresh,error: ${JSON.stringify(error)}`);
    }
  }

  build() {
    Column(){
      Row(){
        Image($r("app.media.Button_Back"))
          .width(24)
          .height(24)
          .objectFit(ImageFit.Fill)
          .onClick(()=>{
            router.back()
          })
      }
      .padding({left:20})
      .justifyContent(FlexAlign.Start)
      .width(`100%`)

      Web({
        src: this.url,
        controller: this.controller
      })
        .onProgressChange((event) => {
          /** 网页加载进度变化时触发该回调 */
          Logger.info("webPage" + event?.newProgress)
        })
        .onOverrideUrlLoading((webResourceRequest) => {
          //return true 终止加载url, return false 继续加载url
          const url = webResourceRequest.getRequestUrl()
          if (url.startsWith('http') || url.startsWith('https')) {
            //如果是http或https开头
            return false
          }
          try {
            if (url.startsWith('tel:')) {
              //如果是电话号码,跳转到系统拨号页面
              call.makeCall(url.substring(4))
              return true
            }

            let context = getContext(this) as common.UIAbilityContext;
            let wantInfo: Want = { action: 'ohos.want.action.viewData', uri: url }
            Logger.info(`WebPage.ets--> onOverrideUrlLoading,wantInfo.uri: -> ${url}`)
            context.startAbility(wantInfo)
            return true
          } catch (err) {
            Logger.error(`WebPage.ets--> onOverrideUrlLoading,err -> ${JSON.stringify(err)}`)
            return false
          }
        })
        .onErrorReceive((event) => {
          /** 网页加载遇到错误时触发该回调 */
          if (event && event.error && event.request && event.request.isMainFrame()) {
            /** 如果是在主框架上(不在iframe或其他子资源上),处理错误 */
            Logger.info(`WebPage.ets--> onErrorReceive -> getErrorInfo:${event.error.getErrorInfo()},getErrorCode:${event.error.getErrorCode()}`)
            //看官方文档,出现错误时,getErrorCode为负数
            this.error_net = event.error.getErrorCode()
          }
        })
        .onTitleReceive((event) => { // 当标题变化时触发

        })
        .onPageEnd((event) => {
          /** 网页加载完成时触发该回调，且只在主frame触发 */
          Logger.info('WebPage.ets--> onPageEnd: 加载结束' + event?.url);
        })
        .javaScriptAccess(true)/** 设置是否允许执行JavaScript脚本，默认允许执行 */
        .domStorageAccess(true)//设置是否开启文档对象模型存储接口（DOM Storage API）权限，默认未开启
        .fileAccess(true)//允许访问文件
        .mixedMode(MixedMode.All)//设置是否允许加载超文本传输协议（HTTP）和超文本传输安全协议（HTTPS）混合内容，默认不允许加载HTTP和HTTPS混合内容
        .darkMode(WebDarkMode.Off)//禁用深色模式
        .databaseAccess(true)//设置是否开启数据库存储API权限，默认不开启。
        .multiWindowAccess(true)//设置是否开启多窗口权限，默认不开启.  截取所有的a标签带 target=”_blank”执行跳转新的页面
        .allowWindowOpenMethod(true)//设置网页是否可以通过JavaScript自动打开新窗口。
        .onWindowNew((event) => {
          //将新窗口对应WebviewController返回给Web内核。
          //如果不需要打开新窗口请调用event.handler.setWebController接口设置成null。
          //若不调用event.handler.setWebController接口，会造成render进程阻塞。
          event.handler.setWebController(null);
          //跳转到系统浏览器,用于点击前端的超链接跳转到系统浏览器下载文件
          let context = getContext(this) as common.UIAbilityContext;
          let wantInfo: Want = {
            action: 'ohos.want.action.viewData',
            entities: ['entity.system.browsable'],
            uri: event.targetUrl
          }
          Logger.info(`WebPage.ets--> onWindowNew,uri: -> ${event.targetUrl}`)
          context.startAbility(wantInfo)
        })
        .onConsole((event) => { // h5中所有的console.log打印的内容会在这个方法中被日志输出
          Logger.info("WebPage.ets--> onConsole,message:" + event?.message.getMessage())
          return false
        })
        .margin({ bottom: this.statusBar+20})//状态栏高度+AppBar高度+底部手势横条的高度
        .visibility(this.error_net >= 0 ? Visibility.Visible : Visibility.None)
    }
    .margin({
      top:this.statusBar
    })
    .height
    (`100%`)

  }

  /** 重写物理返回键 */
  onBackPress(): boolean | void {
    /** 当前页面是否可前进或者后退给定的step步(-1),正数代表前进，负数代表后退 */
    if (this.controller.accessStep(-1)) {
      /** 可以返回,执行返回上一个历史页 */
      this.controller.backward(); //
      /** true消费事件 */
      return true;
    } else {
      /** false不消费事件.再执行系统默认返回逻辑，返回上一个page页 */
      return false;
    }
  }

}



