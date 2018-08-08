## iOS Configuration Part

### 在 Appdelegate.m 中插入代码

加入头文件 `RCTJShareModule.h`

```objective-c
#import <RCTJShareModule.h>
```

添加 `handleOpenURL`

```objective-c
// work in iOS(8.0)
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
  [JSHAREService handleOpenUrl:url];
  return YES;
}
// work in iOS(9_0)
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
  [JSHAREService handleOpenUrl:url];
  return YES;
}
// work in iOS(9_0,++)
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
  [JSHAREService handleOpenUrl:url];
  return YES;
}
```

### 添加搜索路径

TARGET -> Build Settings -> Header Search Paths 添加搜索路径

```
$(SRCROOT)/../node_modules/jshare-react-native/ios/RCTJShareModule
```

### 添加 RCTJShareConfig.plist 文件到 XCode 中

> 1.3.0 及以后版将不再 setup 中传入相关配置参数，将使用 [RCTJShareConfig.plist](../RCTJShareConfig.plist) 文件进行传递参数。

将 [RCTJShareConfig.plist](../RCTJShareConfig.plist) 文件添加到 XCode 工程中，并替换自己的 value。具体可以参考 [demo](../example/ios/RCTJShareConfig.plist) 。


- 参数说明：
  - `appKey`: String              // appKey 一个 JIGUANG 应用必须的,唯一的标识. 请参考 JIGUANG 相关说明文档来获取这个标识。
  - `channel`: String             // channel 发布渠道. 可选。
  - `advertisingId`: String       // advertisingIdentifier 广告标识符（IDFA). 可选，IDFA能帮助您更准确的统计。
  - `isProduction`: Boolean       // isProduction 是否生产环境. 如果为开发状态,设置为NO; 如果为生产状态,应改为 YES.默认为NO。
  - `wechatAppId`: String         // 微信的应用标识。
  - `wechatAppSecret`: String     // 微信的应用密匙。
  - `qqAppId`: String             // QQ 的应用密匙。
  - `qqAppKey`: String            // QQ 应用Key。
  - `sinaWeiboAppKey`: String     // 新浪微博应用标识。
  - `sinaWeiboAppSecret`: String  // 新浪微博应用密匙。
  - `sinaRedirectUri`: String     // 新浪微博应用回调地址。
  - `isSupportWebSina`: Boolean   // 不存在新浪客户端的情况下，是否支持新浪网页版分享，默认不支持值为NO，若需支持将此值设置为YES，具体参考官方文档。
  - `facebookAppId`: string       // facebook 注册的应用 id（必须使用自己的，测试时需要添加自己的用户才能正常分享）。
  - `facebookDisplayName`: string // facebook 注册的应用名，必须要匹配，否则会分享失败。

  ​

### 配置 Info.plist

在 info.plist 文件中添加如下键值对

```xml
<key>LSApplicationQueriesSchemes</key>
<array>
    <!-- 微信 URL Scheme 白名单-->
    <string>wechat</string>
    <string>weixin</string>

    <!-- 新浪微博 URL Scheme 白名单-->
    <string>sinaweibohd</string>
    <string>sinaweibo</string>
    <string>sinaweibosso</string>
    <string>weibosdk</string>
    <string>weibosdk2.5</string>

    <!-- QQ、Qzone URL Scheme 白名单-->
    <string>mqqapi</string>
    <string>mqq</string>
    <string>mqqOpensdkSSoLogin</string>
    <string>mqqconnect</string>
    <string>mqqopensdkdataline</string>
    <string>mqqopensdkgrouptribeshare</string>
    <string>mqqopensdkfriend</string>
    <string>mqqopensdkapi</string>
    <string>mqqopensdkapiV2</string>
    <string>mqqopensdkapiV3</string>
    <string>mqqopensdkapiV4</string>
    <string>mqzoneopensdk</string>
    <string>wtloginmqq</string>
    <string>wtloginmqq2</string>
    <string>mqqwpa</string>
    <string>mqzone</string>
    <string>mqzonev2</string>
    <string>mqzoneshare</string>
    <string>wtloginqzone</string>
    <string>mqzonewx</string>
    <string>mqzoneopensdkapiV2</string>
    <string>mqzoneopensdkapi19</string>
    <string>mqzoneopensdkapi</string>
    <string>mqqbrowser</string>
    <string>mttbrowser</string>

    <!-- Facebook URL Scheme 白名单-->
    <string>fbapi</string>
    <string>fb-messenger-api</string>
    <string>fbauth2</string>
    <string>fbshareextension</string>
</array>
```

### 添加 URL Types
#### 各个平台的 URL Schemes 格式说明：

| 平台   | 格式                               | 举例                                       |
| ---- | -------------------------------- | ---------------------------------------- |
| 微信   | 微信 appKey                        | wxa2ea563906227379                       |
| QQ   | 需添加：“tencent” + 腾讯 QQ 互联应用 appID | 如 appID 为:1105864531<br> URL Schemes 值为:tencent1105864531 |
| 新浪微博 | “wb”+新浪 appKey                   | 如 appKey 为:727232518<br>URL Schemes 值为: wb727232518 |

#### URL Types 设置<br>
Xcode 工程目录中的 [TARGETS] -> [Info] 中设置：
![](https://docs.jiguang.cn/jshare/client/image/urlType.png)

### HTTPS 设置
 > Apple 将从2017年开始执行 ATS(App Transport Security)，所有进行审核的应用中网络请求全部支持 HTTPS，届时以下配置将会失效，请提前做好准备。

  目前 JSHARE 支持不存在新浪微博客户端情况下的网页分享，但是由于新浪微博的 api 尚未针对 https 做优化所以需要针对新浪的做对应的 https 设置。在 JSHARE 中是默认关闭新浪微博的网页端分享的，如需使用这个功能则需要在 JSHARELaunchConfig 类的实例中将 **isSupportWebSina** 属性设置为 YES。

  以iOS10 SDK 编译的工程会默认以 SSL 安全协议进行网络传输，即 HTTPS，如果依然使用 HTTP 协议请求网络会报系统异常并中断请求。目前可用如下这种方式保持用 HTTP 进行网络连接：

在 info.plist 中加入安全域名白名单(右键 info.plist 用 source code 打开)

```
<key>NSAppTransportSecurity</key>
<dict>
    <!-- 配置允许 http 的任意网络 End-->
   <key>NSExceptionDomains</key>
   <dict>
       <!-- 集成新浪微博对应的 HTTP 白名单-->
       <key>sina.com.cn</key>
       <dict>
           <key>NSIncludesSubdomains</key>
           <true/>
           <key>NSThirdPartyExceptionAllowsInsecureHTTPLoads</key>
           <true/>
           <key>NSThirdPartyExceptionRequiresForwardSecrecy</key>
           <false/>
       </dict>
       <key>sinaimg.cn</key>
       <dict>
           <key>NSIncludesSubdomains</key>
           <true/>
           <key>NSThirdPartyExceptionAllowsInsecureHTTPLoads</key>
           <true/>
           <key>NSThirdPartyExceptionRequiresForwardSecrecy</key>
           <false/>
       </dict>
       <key>sinajs.cn</key>
       <dict>
           <key>NSIncludesSubdomains</key>
           <true/>
           <key>NSThirdPartyExceptionAllowsInsecureHTTPLoads</key>
           <true/>
           <key>NSThirdPartyExceptionRequiresForwardSecrecy</key>
           <false/>
       </dict>
       <key>sina.cn</key>
       <dict>
           <!-- 适配 iOS10 -->
           <key>NSExceptionMinimumTLSVersion</key>
           <string>TLSv1.0</string>
           <key>NSIncludesSubdomains</key>
           <true/>
           <key>NSThirdPartyExceptionRequiresForwardSecrecy</key>
           <false/>
       </dict>
       <key>weibo.cn</key>
       <dict>
           <!-- 适配 iOS10 -->
           <key>NSExceptionMinimumTLSVersion</key>
           <string>TLSv1.0</string>
           <key>NSIncludesSubdomains</key>
           <true/>
           <key>NSThirdPartyExceptionRequiresForwardSecrecy</key>
           <false/>
       </dict>
       <key>weibo.com</key>
       <dict>
           <!-- 适配 iOS10 -->
           <key>NSExceptionMinimumTLSVersion</key>
           <string>TLSv1.0</string>
           <key>NSIncludesSubdomains</key>
           <true/>
           <key>NSThirdPartyExceptionAllowsInsecureHTTPLoads</key>
           <true/>
           <key>NSThirdPartyExceptionRequiresForwardSecrecy</key>
           <false/>
       </dict>
       <!-- 新浪微博-->
   </dict>
</dict>
```