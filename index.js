import {
	NativeModules,
	Platform,
	DeviceEventEmitter
} from 'react-native';

const JShareModule = NativeModules.JShareModule;

export default class JShare {
    /**
     * 
     * @param {Object} config = {
     *  appKey: String              // appKey 一个 JIGUANG 应用必须的,唯一的标识. 请参考 JIGUANG 相关说明文档来获取这个标识。
     *  channel: String             // channel 发布渠道. 可选。
     *  advertisingId: String       // advertisingIdentifier 广告标识符（IDFA). 可选，IDFA能帮助您更准确的统计。
     *  isProduction: Boolean       // isProduction 是否生产环境. 如果为开发状态,设置为NO; 如果为生产状态,应改为 YES.默认为NO。
     *  wechatAppId: String         // 微信的应用标识。
     *  wechatAppSecret: String     // 微信的应用密匙。
     *  qqAppId: String             // QQ 的应用密匙。
     *  qqAppKey: String            // QQ 应用Key。
     *  sinaWeiboAppKey: String     // 新浪微博应用标识。
     *  sinaWeiboAppSecret: String  // 新浪微博应用密匙。
     *  sinaRedirectUri: String     // 新浪微博应用回调地址。
     *  isSupportWebSina: Boolean   // 不存在新浪客户端的情况下，是否支持新浪网页版分享，默认不支持值为NO，若需支持将此值设置为YES，具体参考官方文档。
     * }
     */
    static setup(config) {
        JShareModule.setup(parma)
    }
    
    /**
     * 初始化插件
     * 
     * @param {object} Message = {
     * 
     * platformString 用于分享置不同的平台 //可以是 'wechat_session' / 'wechat_timeLine' / 'wechat_favourite' / 'qq' / 'qzone' / 'sina_weibo' / 'sina_weibo_contact' 
     * 
     * 
     * {
     *  type: 'text'
     *  platform: platformString  // 
     *  text: String
     * }
     * 
     * {
     *  type: 'image'
     *  platform: platformString  // 
     *  path: String  
     *  imagePaths: [String]  // (选填: 分享到 Qzone 才提供这个字段) 如果需要分享多张图片需要这个参数，数组中问题图片路径
     * }
     * 
     * {
     *  type: 'video'
     *  platform: platformString  // 
     *  title: String
     *  url: String
     *  text: String
     *  
     *  videoUrl: String  //
     * !! iOS 相册视频，可传ALAsset的ALAssetPropertyAssetURL，或者PHAsset的localIdentifier。
     * 
     * }
     * 
     * {
     *  type: 'audio'
     *  platform: platformString  // 
     *  url: String
     *  path: String
     *  title: String
     *  text: String
     * }
     * 
     * {
     *  type: 'file'
     *  platform: platformString  // 
     *  path: String
     *  tile: String
     *  fileExt: String
     * }
     * 
     * {
     *  type: 'emoticon'
     *  platform: platformString  // 
     *  url: String
     *  path: String
     * }
     * 
     * {
     *  type: 'app'
     *  platform: platformString  // 
     *  url: String
     *  extInfo: String
     *  path: String
     *  title: String
     *  text: String
     * }
     * 
     * {
     *  type: 'link'
     *  platform: platformString  // 
     *  url: String
     *  title: String
     *  text: String
     * }
     * 
     * {
     *  type: 'undefined'
     *  platform: platformString  // 
     * }
     * 
     * @param {*} success = function (state) {} ## state = {state: String} state 可以是 ‘success’ / 'fail' / 'cancel' / 'unknow'
     * @param {*} fail = function (error) {} ## error = {code: number, descript: String}
     */
    static share(alias, success, fail) {
		JShareModule.share(alias, success, fail)
    }
    
    /**
     * 
     * @param {*} param = {
     *  platform: String //可以是 'wechat_session' / 'wechat_timeLine' / 'wechat_favourite' / 'qq' / 'qzone' / 'sina_weibo' / 'sina_weibo_contact' 
     * }
     * @param {*} success function (userInfo) {} 
     * userInfo = {
     *  name: String        
     *  iconUrl: String   // 社交平台头像链接
     *  gender: String    // 'female' /  'male'
     *  response: Object  // 社交平台上的原始数据
     * }
     * @param {*} fail = function (error) {} ## error = {code: number, descript: String}
     */
    static getSoicalUserInfo(param, success, fail) {
		JShareModule.getSoicalUserInfo(param, success, fail)
    }
    
    /**
     * 获取社交平台用户信息
     * 
     * @param {*} param = {
     *  platform: String //可以是 'wechat_session' / 'wechat_timeLine' / 'wechat_favourite' / 'qq' / 'qzone' / 'sina_weibo' / 'sina_weibo_contact' 
     * }
     * @param {*} success 
     * @param {*} fail 
     */
    static isPlatformAuth(param, success) {
		JShareModule.isPlatformAuth(param, success)
    }

    /**
     * 删除用户授权本地数据
     * 
     * @param {Object} param = {
     *  platform: String //可以是 'wechat_session' / 
     *                           'wechat_timeLine' / 
     *                           'wechat_favourite' / 
     *                           'qq' / 
     *                           'qzone' /
     *                           'sina_weibo' /
     *                           'sina_weibo_contact' 
     * }
     * @param {function} success function (result) {}
     * @param {function} fail 
     */
    static cancelAuthWithPlatform(param, success) {
		JPushModule.cancelAuthWithPlatform(param, success)
    }

    /**
     * 检查不存在新浪客户端情况下的网页端是否登陆
     * 
     * @param {function} success 
     */
    static isSinaWeiboWebLogined(success) {
		JPushModule.isSinaWeiboWebLogined(success)
    }

    /**
     * 登出新浪网页端最新帐号
     * 
     * @param {function} success 
     */
    static sinaWeiboWebLogOut(success) {
		JShareModule.sinaWeiboWebLogOut(success)
    }

    /**
     * 检查是否安装微信客户端
     * 
     * @param {function} success 
     */
    static isWeChatInstalled(success) {
		JShareModule.isWeChatInstalled(success)
    }

    /**
     * 检查是否存在QQ客户端
     * 
     * @param {function} success 
     */
    static isQQInstalled(success) {
		JShareModule.isQQInstalled(success)
    }

    /**
     * 检查是否存在新浪微博客户端
     * 
     * @param {function} success 
     */
    static isSinaWeiBoInstalled(success) {
		JShareModule.isSinaWeiBoInstalled(success)
    }
    /**
     * 
     * @param {Object} param = {
     *  enable: Boolean
     * }
     */
    static setDebug(param) {
        JShareModule.setDebug(param)
    }

}
