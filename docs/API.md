# API List

JShare plugin's APIs list.

## Usage

```javascript
// xxx means function name, some have callbacks.
JShareModule.xxx();
```

- **setup(param)**
  ```javascript
  /**
    * iOS Only
    * @param {Object} config = {
    * appKey: String              // appKey 一个 JIGUANG 应用必须的,唯一的标识. 请参考 JIGUANG 相关说明文档来获取这个标识。
    * channel: String             // channel 发布渠道. 可选。
    * advertisingId: String       // advertisingIdentifier 广告标识符（IDFA). 可选，IDFA能帮助您更准确的统计。
    * isProduction: Boolean       // isProduction 是否生产环境. 如果为开发状态,设置为NO; 如果为生产状态,应改为 YES.默认为NO。
    * wechatAppId: String         // 微信的应用标识。
    * wechatAppSecret: String     // 微信的应用密匙。
    * qqAppId: String             // QQ 的应用密匙。
    * qqAppKey: String            // QQ 应用Key。
    * sinaWeiboAppKey: String     // 新浪微博应用标识。
    * sinaWeiboAppSecret: String  // 新浪微博应用密匙。
    * sinaRedirectUri: String     // 新浪微博应用回调地址。
    * isSupportWebSina: Boolean   // 不存在新浪客户端的情况下，是否支持新浪网页版分享，默认不支持值为NO，若需支持将此值设置为YES，具体参考官方文档。
    * facebookAppId: string       // facebook 注册的应用 id（必须使用自己的，测试时需要添加自己的用户才能正常分享）。
    * facebookDisplayName: string // facebook 注册的应用名，必须要匹配，否则会分享失败。
    * }
    */
  ```

- **getPlatformList(cb)**

  ```javascript
  /**
   * 获取SDK所有能用的平台名称，如要使用某个平台，必须在JGShareSDK.xml中配置。
   * Android only
   * @param {Function} callback 返回值 list 是一个数组
   */
  ```

  usage:
  ```javascript
  JShareModule.getPlatformList((list) => {
    console.log(list);
  });
  ```

- **share(message, successCallback, failCallback)**

  ```javascript
  /**
   * 分享
   * @param {object} message = {
   * 
   * platformString 必填，用于分享置不同的平台 //可以是 'wechat_session' / 'wechat_timeLine' / 'wechat_favourite' / 'qq' / 'qzone' / 'sina_weibo' / 'sina_weibo_contact' 
   * type 必填
   * 
   * {
   *  type: 'text'
   *  platform: platformString  // 分享到指定平台
   *  text: String
   *  imagePath: // 选填，新浪微博本地图片地址，其他平台没有这个字段(iOS 不支持这个字段)
   * }
   * 
   * {
   *  type: 'image'
   *  platform: platformString  // 分享到指定平台
   *  imagePath: String   // 本地图片路径 imagePath, imageUrl imageArray 必须三选一
   *  text: String  // 选填
   *  imageUrl: String // 网络图片地址，必须以 http 或 https 开头，imagePath, imageUrl imageArray 必须三选一 (iOS 不支持这个字段)
   *  imageArray: [String]  // (选填: 分享到 Qzone 才提供这个字段) 如果需要分享多张图片需要这个参数，数组中问题图片路径 imagePath, imageUrl imageArray 必须三选一
   * }
   * 
   * {
   *  type: 'video'
   *  platform: platformString  // 分享到指定平台
   *  title: String // 选填
   *  url: String // 视频跳转页面 url
   *  text: String  // 选填
   *  imagePath: String // 选填，缩略图，本地图片路径

   *  videoAssetURL: string // videoAssetURL：系统相册视频文件的 url，，facebook 只支持使用 videoAssetURL 来发送本地视频（不支持 url）。
   *  videoUrl: String  // QQ 空间本地视频 (iOS 不支持这个字段)
   * }
   * 
   * {
   *  type: 'audio'
   *  platform: platformString  // 分享到指定平台
   *  musicUrl: String //必填 点击直接播放的 url
   *  url: String //选填，点击跳转的 url
   *  imagePath: String   //选填，缩略图，本地图片路径，imagePath，imageUrl 必须二选一
   *  imageUrl: String // 选填，网络图片路径，imagePath， imageUrl 必须二选一
   *  title: String // 选填 
   *  text: String  // 选填
   * }
   * 
   * {
   *  type: 'file'
   *  platform: platformString  // 分享到指定平台
   *  path: String // 必填，文件路径
   *  fileExt: String // 必填，文件类型后缀
   *  tile: String
   * }
   * 
   * {
   * type: 'emoticon'
   * platform: platformString  // 分享到指定平台
   * imagePath: String // 必填，本地图片路径
   * }
   * 
   * {
   * type: 'app' // wechat_favourite 不支持
   * platform: platformString  // 分享到指定平台
   * url: String // 点击跳转 url
   * extInfo: String // 选填 第三方应用自定义数据
   * path: String // 选填 对应 app 数据文件
   * title: String // 选填
   * text: String // 选填
   * }
   * 
   * {
   * type: 'link'
   * platform: platformString  // 分享到指定平台
   * url: String // 必填，网页 url
   * imagePath: String // 选填，本地图片路径 imagePath，imageUrl 必须二选一 
   * imageUrl: String // 选填，网络图片地址 imagePath imageUrl 必须二选一 (iOS 不支持)
   * title: String // 选填
   * text: String // 选填
   * }
   * 
   * {
   * type: 'undefined'
   * platform: platformString  // 分享到指定平台
   * }
   * 
   * @param {Function} success = function (state) {} ## 
   * state = {state: String} state = 'success' / 'fail' / 'cancel' / 'unknow'
     *
   * @param {Function} fail = function (error) {} ## 
   * error = {code: number, descript: String}
   */
  ```

  usage:

  ```javascript
  var message = {
        platform: "wechat_session",
        type: "image",
        text: "JShare test text",
        imagePath: "/storage/emulated/0/DCIM/Camera/xx.jpg"
      };
  JShareModule.share(message, (map) => {
    console.log("share succeed, map: " + map);
  }, (map) => {
    console.log("share failed, map: " + map);
  })
  ```




- **getSocialUserInfo(param, successCallback, failCallback)**

  ```javascript
  /**
   * 获取社交平台用户信息
   * @param {Object} param = {
   *  platform: String //可以是 'wechat_session' / 'wechat_timeLine' / 'wechat_favourite' / 'qq' / 'qzone' / 'sina_weibo' / 'sina_weibo_contact' / 'facebook'
   * }
   * @param {Function} success function (userInfo) {} 
   * userInfo = {
   *  name: String        
   *  iconUrl: String   // 社交平台头像链接
   *  gender: String    // 'female' /  'male'
   *  response: Object  // 社交平台上的原始数据
   * }
   *
   * @param {Function} fail = function (error) {} ## 
   * error = {code: number, descript: String}
   */
  ```

  usage:

  ```javascript
  var param = {
    platform: "wechat_session"
  };
  JShareModule.getSocialUserInfo(param, (map) => {
    console.log(map);
    }, (errorCode) => {
    console.log("errorCode: " + errorCode);
  });
  ```

- **isPlatformAuth(param, callback)**

  ```javascript
  /**
   * 判断某平台是否支持授权
   * 
   * @param {Object} param = {
   *  platform: String //可以是 'wechat_session' / 'wechat_timeLine' / 'wechat_favourite' / 'qq' / 'qzone' / 'sina_weibo' / 'sina_weibo_contact' 
   * }
   * @param {Function} callback = (Boolean) => {} 
   */
  ```

  usage:

  ```javascript
  var param = {
  platform: "wechat_session"
  };
  JShareModule.isPlatformAuth(param, (result) => {
  console.log(param.platform + "is Auth: " + result);
  });
  ```

- **isClientValid(param, callback)**
  ```javascript
  /**
   * 判断该平台的分享是否有效
   * Android only
   * @param {Object} param = {
   *  platform: String //可以是 'wechat_session' / 'wechat_timeLine' / 'wechat_favourite' / 'qq' / 'qzone' / 'sina_weibo' / 'sina_weibo_contact' 
   * }
   * @param {Function} callback = (Boolean) => {} 
   */
  ```

  usage:

  ```javascript
  var param = {
    platform: "wechat_session"
  };
  JShareModule.isClientValid(param, (result) => {
    console.log(param.platform + "is valid: " + result);
  });
  ```

- **authorize(param, successCallback, failCallback) Android Only**

  ```javascript
  /**
   * 授权接口 Android Only
   * @param {Object} param = {
   *  platform: String //可以是 'wechat_session' / 'wechat_timeLine' / 'wechat_favourite' / 'qq' / 'qzone' / 'sina_weibo' / 'sina_weibo_contact' 
   * }
   * @param {Function} success 
   * @param {Function} fail 
   */
  ```

  usage:

  ```javascript
  var param = {
    platform: "wechat_session"
  };
  JShareModule.authorize(param, (map) => {
    console.log("Authorize succeed " + map);
  }, (errorCode) => {
    console.log("Authorize failed, errorCode : " + errorCode);
  });
  ```

- **isAuthorize(param, callback)**
  ```javascript
  /**
   *  判断是否授权接口
   * @param {Object} param = {
   *  platform: String //可以是 'wechat_session' / 'wechat_timeLine' / 'wechat_favourite' /    'qq' / 'qzone' / 'sina_weibo' / 'sina_weibo_contact' 
   * }  
   * @param {Function} callback = (Boolean) => {} 
   */
  ```

  usage:

  ```javascript
  var param = {  
    platform: "wechat_session"
  };
  JShareModule.isAuthorize(param, (result) => {        		
     console.log("param is Authorize: " + result);
  });
  ```

- **cancelAuthWithPlatform(param, callback)**

  ```javascript
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
   * @param {Function} callback = (Int) => {}
   * @code 返回码，0 表示成功删除
   */
  ```

  usage:

  ```javascript
  var param = {
    platform: "wechat_session"
  };
  JShareModule.cancelAuthWithPlatform(param, (code) => {
    if (code === 0) {
      console.log("remove authorize succeed");
    } else {
      console.log("remove authorize failed, errorCode: " + code);
    }
  });
  ```


- **isSinaWeiboWebLogined(param, callback)**

  ```javascript
  /**
   * 检查不存在新浪客户端情况下的网页端是否登陆
   * 
   * iOS Only
   * @param {Function} success = (Boolean) => {} 
   */
  ```

  usage:

  ```javascript
  JShareModule.isSinaWeiboWebLogined((isLogin) => {
    if (isLogin === true) {
      console.log("sina weibo is login");
    } else {
      console.log("sina weibo is not login");
    }
  });
  ```

- **sinaWeiboWebLogOut(param, callback)**

  ```javascript
  /**
   * 登出新浪网页端最新帐号
   * 
   * iOS Only
   * @param {Function} success = (Boolean) => {} 
   */
  ```

  usage:

  ```javascript
  JShareModule.sinaWeiboWebLogOut((success) => {
    if (success === true) {
      console.log("sina weibo logout success");
    } else {
      console.log("sina weibo logout fail");
    }
  });
  ```

- **isWeChatInstalled(param, callback)**

  ```javascript
  /**
   * 检查是否安装微信客户端
   * 
   * iOS Only
   * @param {Function} success = (Boolean) => {} 
   */
  ```

  usage:

  ```javascript
  JShareModule.isWeChatInstalled((isInstalled) => {
    if (isInstalled === true) {
      console.log("wechat is intalled");
    } else {
      console.log("wechat is not installed");
    }
  });
  ```

- **isQQInstalled(param, callback)**

  ```javascript
  /**
   * 检查是否存在QQ客户端
   * 
   * iOS Only
   * @param {Function} success = (Boolean) => {} 
   */
  ```

  usage:

  ```javascript
  JShareModule.isQQInstalled((isInstalled) => {
    if (isInstalled === true) {
      console.log("QQ is intalled");
    } else {
      console.log("QQ is not installed");
    }
  });
  ```

- **isSinaWeiBoInstalled(param, callback)**

  ```javascript
  /**
   * 检查是否存在新浪微博客户端
   * 
   * iOS Only
   * @param {Function} success = (Boolean) => {} 
   */
  ```

  usage:

  ```javascript
  JShareModule.isSinaWeiBoInstalled((isInstalled) => {
    if (isInstalled === true) {
      console.log("sina weibo is intalled");
    } else {
      console.log("sina weibo is not installed");
    }
  });
  ```

- **setDebug(param, callback)，Android 建议在 MainApplication 中调用，[参考 demo](./../example/android/app/src/main/java/cn/jiguang/share/demo/MainApplication.java)** 

  ```javascript
  /**
   * 
   * @param {Object} param = {
   *  enable: Boolean
   * }
   */
  ```

  usage:

  ```javascript
  JShareModule.setDebug({enable: true});
  ```
