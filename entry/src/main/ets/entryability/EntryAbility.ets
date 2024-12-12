import { AbilityConstant, UIAbility, Want } from '@kit.AbilityKit';
import { hilog } from '@kit.PerformanceAnalysisKit';
import { KeyboardAvoidMode, window } from '@kit.ArkUI';
import { BusinessError } from '@kit.BasicServicesKit';

export default class EntryAbility extends UIAbility {
  onCreate(want: Want, launchParam: AbilityConstant.LaunchParam): void {
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onCreate');
  }

  onDestroy(): void {
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onDestroy');
  }

  onWindowStageCreate(windowStage: window.WindowStage): void {
    // Main window is created, set main page for this ability
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageCreate');

    windowStage.loadContent('pages/SplashPage', (err) => {
      if (err.code) {
        hilog.error(0x0000, 'testTag', 'Failed to load the content. Cause: %{public}s', JSON.stringify(err) ?? '');
        return;
      }

      hilog.info(0x0000, 'testTag', 'Succeeded in loading the content.');

      windowStage.getMainWindowSync()
        .getUIContext()
        .setKeyboardAvoidMode(KeyboardAvoidMode.RESIZE)
    });

    //获取主窗口
    let windowClass: window.Window = windowStage.getMainWindowSync()

    //1.设置窗口全屏
    let isLayoutFullScreen = true
    windowClass.setWindowLayoutFullScreen(isLayoutFullScreen).then(() => {
      console.info('Succeeded in setting the window layout to full-screen mode.');
    } )
      .catch((err: BusinessError) => {
        console.error('Failed to set the window layout to full-screen mode. Cause:' + JSON.stringify(err));
      })

    //<editor-fold desc="状态栏高度. 获取举例: statusBar: number = AppStorage.get<number>('statusBar') as number; ">
    const avoidAreaStatusBar = windowClass.getWindowAvoidArea(window.AvoidAreaType.TYPE_SYSTEM);
    // 获取状态栏的高度    (补充说明,beta2尝试过用avoidAreaStatusBar.bottomRect.height获取导航栏高度,发现获取结果为0)
    const statusBar = px2vp(avoidAreaStatusBar.topRect.height);
    AppStorage.setOrCreate('statusBar', statusBar);
    //</editor-fold>

    //<editor-fold desc="底部手势横条的高度. 获取举例: bottomRectHeight: number = AppStorage.get<number>('bottomRectHeight') as number; ">
    //2、获取布局避让遮挡区域
    const avoidArea = windowClass.getWindowAvoidArea(window.AvoidAreaType.TYPE_NAVIGATION_INDICATOR)
    // 获取到导航条区域的高度
    const bottomRectHeight = px2vp(avoidArea.bottomRect.height)
    AppStorage.setOrCreate('bottomRectHeight', bottomRectHeight)
    //</editor-fold>

    /** 固定状态栏文字颜色为黑色. 避免深色模式时,状态栏文字显示白色 */
    windowClass.setWindowSystemBarProperties({
      statusBarContentColor: '#000000'
    })

  }

  onWindowStageDestroy(): void {
    // Main window is destroyed, release UI related resources
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageDestroy');
  }

  onForeground(): void {
    // Ability has brought to foreground
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onForeground');
  }

  onBackground(): void {
    // Ability has back to background
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onBackground');
  }
}
