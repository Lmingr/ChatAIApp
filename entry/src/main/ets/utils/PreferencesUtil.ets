import { ValueType } from '@kit.ArkData';
import dataPreferences from '@ohos.data.preferences';
import { BusinessError } from '@kit.BasicServicesKit';


const PREFERENCES_NAME: string = 'ChatAiAPP';

/* 首选项工具类 */
export class PreferencesUtil {

  private static preferenceName: string = PREFERENCES_NAME;
  private static groupId: string = "";
  private static preference: dataPreferences.Preferences | null = null;

  /*支持自定义sp文件名*/
  static setPreferenceName(name: string): void {
    PreferencesUtil.preferenceName = name;
  }

  /* 设置组ID */
  static setGroupId(groupId: string): void {
    PreferencesUtil.groupId = groupId;
  }

  /* 获取首选项实例 */
  static getPreference(): dataPreferences.Preferences {
      let options: dataPreferences.Options = { name: PreferencesUtil.preferenceName };
      if (PreferencesUtil.groupId) {
        options.dataGroupId = PreferencesUtil.groupId;
      }
      PreferencesUtil.preference = dataPreferences.getPreferencesSync(getContext(PreferencesUtil), options);
      return PreferencesUtil.preference;
  }

  /* 初始化首选项 */
  static init(name?: string, groupId?: string): void {
    if (name) PreferencesUtil.setPreferenceName(name);
    if (groupId) PreferencesUtil.setGroupId(groupId);
    PreferencesUtil.getPreference(); // 创建首选项实例
  }

  /* 保存数据到首选项 */
  static putValue(key: string, value: ValueType, override: boolean = true): void {
    const pref = PreferencesUtil.getPreference();
    if (pref.hasSync(key) && !override) return; // 如果键存在且不允许覆盖，则退出
    pref.putSync(key, value);
    pref.flush((err: BusinessError) => {
      if (err) {
        console.error(`Failed to flush. Code:${err.code}, message:${err.message}`);
      } else {
        console.info('Succeeded in flushing.');
      }
    });
  }

  /* 获取数据到首选项 */
  static getValue(key: string, defaultValue: ValueType = ''): dataPreferences.ValueType {
    const pref = PreferencesUtil.getPreference();
    return pref.getSync(key, defaultValue);
  }

  /* 从首选项按key移除数据 */
  static removeValue(key: string): void {
    const pref = PreferencesUtil.getPreference();
    pref.deleteSync(key);
    pref.flush((err: BusinessError) => {
      if (err) {
        console.error(`Failed to flush. Code:${err.code}, message:${err.message}`);
      } else {
        console.info('Succeeded in flushing.');
      }
    });
  }

  /* 清除所有数据 */
  static clearAll(): void {
    const pref = PreferencesUtil.getPreference();
    pref.clearSync();
    pref.flush((err: BusinessError) => {
      if (err) {
        console.error(`Failed to flush. Code:${err.code}, message:${err.message}`);
      } else {
        console.info('Succeeded in flushing.');
      }
    });
  }

}

export default PreferencesUtil;
