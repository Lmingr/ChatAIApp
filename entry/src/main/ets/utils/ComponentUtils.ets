/**
 * duration 显示时间3S
 * @param msg
 */
import { promptAction } from '@kit.ArkUI';

export function showToast(msg: string | Resource) {
  promptAction.showToast({
    message: msg,
    duration: 3000,
    bottom:"center",
  });
}