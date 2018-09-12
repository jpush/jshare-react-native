/*
 *	| |    | |  \ \  / /  | |    | |   / _______|
 *	| |____| |   \ \/ /   | |____| |  / /
 *	| |____| |    \  /    | |____| |  | |   _____
 * 	| |    | |    /  \    | |    | |  | |  |____ |
 *  | |    | |   / /\ \   | |    | |  \ \______| |
 *  | |    | |  /_/  \_\  | |    | |   \_________|
 *
 * Copyright (c) 2011 ~ 2017 Shenzhen HXHG. All rights reserved.
 */



#define JSHARE_VERSION_NUMBER 1.6.0

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, JSHAREPlatform) {
    JSHAREPlatformWechatSession = 1,
    JSHAREPlatformWechatTimeLine = 2,
    JSHAREPlatformWechatFavourite = 3,
    
    JSHAREPlatformQQ = 4,
    JSHAREPlatformQzone = 5,
    
    JSHAREPlatformSinaWeibo = 6,
    JSHAREPlatformSinaWeiboContact = 7,
    
    JSHAREPlatformFacebook = 8,
    JSHAREPlatformFacebookMessenger = 9,
    

    JSHAREPlatformTwitter = 10,

    JSHAREPlatformJChatPro = 11,
};

typedef NS_ENUM(NSUInteger,JSHAREState){
    JSHAREStateSuccess = 1,
    JSHAREStateFail = 2,
    JSHAREStateCancel = 3,
    JSHAREStateUnknown = 4,
};

typedef NS_ENUM(NSUInteger,JSHAREMediaType){
    JSHAREText = 1,
    JSHAREImage = 2,
    JSHARELink = 3,
    JSHAREAudio = 4,
    JSHAREVideo = 5,
    JSHAREApp = 6,
    JSHAREFile = 7,
    JSHAREEmoticon = 8,
    JSHARGraphic = 9,  //图文类型，仅用于JChatPro
    JSHAREUndefined = 100,
};

@class JSHARESocialUserInfo;
typedef void(^JSHAREStateHandler)(JSHAREState state,NSError *error);
typedef void(^JSHARECompletionHandler)(JSHAREState state,NSError *error, id responseObject);
typedef void(^JSHARESocialHandler)(JSHARESocialUserInfo *userInfo,NSError *error);

@interface JSHARELaunchConfig : NSObject

/**
 appKey 一个 JIGUANG 应用必须的,唯一的标识. 请参考 JIGUANG 相关说明文档来获取这个标识。
 */
@property (nonatomic, copy) NSString *appKey;

/**
 channel 发布渠道. 可选。
 */
@property (nonatomic, copy) NSString *channel;

/**
 advertisingIdentifier 广告标识符（IDFA). 可选，IDFA能帮助您更准确的统计。
 */
@property (nonatomic, copy) NSString *advertisingId;

/**
 isProduction 是否生产环境. 如果为开发状态,设置为NO; 如果为生产状态,应改为 YES.默认为NO。
 */
@property (nonatomic, assign) BOOL isProduction;

/**
 设置微信的应用标识。
 */
@property (nonatomic, copy) NSString *WeChatAppId;

/**
 设置微信的应用密匙。
 */
@property (nonatomic, copy) NSString *WeChatAppSecret;

/**
 设置QQ应用标识。
 */
@property (nonatomic, copy) NSString *QQAppId;

/**
 设置QQ应用Key。
 */
@property (nonatomic, copy) NSString *QQAppKey;

/**
 设置新浪微博应用标识。
 */
@property (nonatomic, copy) NSString *SinaWeiboAppKey;

/**
 设置新浪微博应用密匙。
 */
@property (nonatomic, copy) NSString *SinaWeiboAppSecret;

/**
 设置新浪微博应用回调地址。
 */
@property (nonatomic, copy) NSString *SinaRedirectUri;


/**
 设置Facebook应用标识
 */
@property (nonatomic,copy) NSString *FacebookAppID;

/**
 设置Facebook应用名称
 */
@property (nonatomic,copy) NSString *FacebookDisplayName;

/**
 不存在新浪客户端的情况下，是否支持新浪网页版分享，默认不支持值为NO，若需支持将此值设置为YES，具体参考官方文档。
 */
@property (nonatomic, assign) BOOL isSupportWebSina;

/**
 *  Twitter consumer key
 */
@property (nonatomic, copy) NSString *TwitterConsumerKey;
/**
 *  Twitter consumer secret
 */
@property (nonatomic, copy) NSString *TwitterConsumerSecret;
/**
 *  JChatPro Auth
 */
@property (nonatomic, copy) NSString *JChatProAuth;

@end

@interface JSHAREMessage : NSObject

/**
 标题：长度每个平台的限制而不同。
 微信好友：最大 512 字符。
 微信朋友圈：最大 512 字符。
 微信收藏：最大 512 字符。
 QQ：最大 128 字符。
 QQ空间：最大 128 字符。
 新浪微博：分享链接类型，最大 1 K字符。
 JChatPro:消息标题。
 */
@property (nonatomic,strong) NSString *title;

/**
 文本：文本内容，长度每个平台的限制而不同。
 在分享非文本类型时，此字段作为分享内容的描述使用。
 
 微信好友：分享文本类型时，最大 10 K字符。分享非文本类型，最大 1 K字符。
 微信朋友圈：分享文本类型时，最大 10 K字符。分享非文本类型，最大 1 K字符。
 微信收藏：分享文本类型时，最大 10 K字符。分享非文本类型，最大 1 K字符。
 QQ：分享文本类型时，最大 1536 字符。分享非文本类型，最大 512 字符。
 QQ空间：分享文本类型时，最大 128 字符。分享非文本类型，最大 512 字符。
 新浪微博：最大 140 汉字。
 Twitter:最大 140 汉字
 JChatPro:消息内容。不超过4k字节
 */
@property (nonatomic,strong) NSString *text;

/**
 链接：根据媒体类型填入链接，长度每个平台的限制不同。分享非文本及非图片类型时，必要！
 微信好友：最大 10 K字符。
 微信朋友圈：最大 10 K字符。
 微信收藏：最大 10 K字符。
 QQ：最大 512 字符。
 QQ空间：最大 512 字符。
 新浪微博：最大 512 字符。
 Twitter:以Twitter返回结果为准。分享链接时必要,其它情况可选。
 */
@property (nonatomic,strong) NSString *url;


/**
 本地视频AssetURL:分享本地视频到 QQ 空间的必填参数，可传ALAsset的ALAssetPropertyAssetURL，或者PHAsset的localIdentifier。分享到视频类型至 facebook 、facebookMessenger 只能识别 ALAsset 的ALAssetPropertyAssetURL。
 */
@property (nonatomic,strong) NSString *videoAssetURL;

/**
 缩略图：大小限制根据平台不同而不同。
 微信好友：最大 32 K。
 微信朋友圈：最大 32 K。
 微信收藏：最大 32 K。
 QQ：最大 1 M。
 QQ空间：最大 1 M。
 新浪微博：最大 32 K。
 */
@property (nonatomic,strong) NSData *thumbnail;

/**
 JChatPro 网络缩略图地址
 */
@property (nonatomic,copy) NSString *thumbUrl;

/**
 图片：分享JSHAREImage类型，大小限制根据平台不同而不同，当分享JSHARELink类型时没有提供缩略图时，若此参数不为空，JSHARE将会裁剪此参数提供的图片去适配缩略图。
 微信好友：最大 10 M。
 微信朋友圈：最大 10 M。
 微信收藏：最大 10 M。
 QQ：最大 5 M。
 QQ空间：最大 5 M。
 新浪微博：最大 10 M。
 Twitter:最大 5 M。
 JChatPro :分享单张图片。暂无限制
 */
@property (nonatomic,strong) NSData *image;

/**
 图片数组：分享到 QQ 空间 或 Facebook/Messenger 或 Twitter支持多张图片。图片数组的元素需要为 NSData 类型。
         1.QQ 空间图片数量限制为20张。若只分享单张图片使用 image 字段即可。
         2.Facebook/Messenger 图片数量限制为6张。如果分享单张图片，图片大小建议不要超过12M；如果分享多张图片，图片大小建议不要超过700K，否则可能出现重启手机或者不能分享。
         3、Twitter 图片数量限制为4张。单张图片大小不超过5mb。
         4、JChatPro图片限制为9张。若分享单张图片使用image字段即可。
 */
@property (nonatomic,strong) NSArray<NSData *> *images;

/**
 分享的媒体类型。必要！
 */
@property (nonatomic,assign) JSHAREMediaType mediaType;

/**
 分享的目标平台。必要！
 */
@property (nonatomic,assign) JSHAREPlatform platform;

/**
 分享JSHAREAudio类型至微信平台或QQ平台时，音乐数据url地址。
 微信好友：最大 10 K字符。
 微信朋友圈：最大 10 K字符。
 微信收藏：最大 10 K字符。
 QQ：最大 512 字符。
 QQ空间：最大 512 字符。
 新浪微博：最大 512 字符。
 */
@property (nonatomic,strong) NSString *mediaDataUrl;

/**
 微信 分享JSHAREApp类型至微信平台时，第三方程序自定义的简单数据。
 JChatPro 点击消息跳转到第三方应用时带的extra信息
 */
@property (nonatomic,strong) NSString *extInfo;

/**
 分享JSHAREFile类型或者JSHAREApp类型至微信平台时，对应的File数据以及App数据，最大 10 M。
 */
@property (nonatomic,strong) NSData *fileData;

/**
 分享JSHAREFile类型至微信平台时，对应的文件后缀名，分享文件必填，否则会导致分享到微信平台出现不一致的文件类型,最大 64 字符。
 */
@property (nonatomic,strong) NSString *fileExt;

/**
 分享JSHAREEmoticon类型至微信平台时，对应的表情数据，最大 10 M。
 */
@property (nonatomic,strong) NSData *emoticonData;

/**
 分享至新浪微博平台时，分享参数的一个标识符，默认为 “objectId”。最大 255 字符。
 */
@property (nonatomic,strong) NSString *sinaObjectID;

/**
 分享的视频，目前支持平台有Twitter
 上传至Twitter视频有几个要求：
    - 持续时间应该在0.5秒到30秒之间
    - 文件大小不应超过15 mb
    - 尺寸应该在32x32和1280x1024之间
    - 长宽比应在1：3和3：1之间
    - 帧率应该是40fps或更少
 */
@property (nonatomic,strong) NSData *videoData;

/*
 JChatPro 当应用内的分享消息被点击时，如果启动的客户端不存在时，回调的url。开发者可以通过这个配置实现本地应用不存在时跳转到他们的官网之类的操作
 */
@property (nonatomic,strong) NSString *callbackUrl ;

/**
 JChatPro 点击消息时跳转第三方android客户端的包名
 */
@property (nonatomic,strong) NSString *pkgName;

/**
 JChatPro 点击消息时跳转第三方android客户端的类名
 */
@property (nonatomic,strong) NSString *className;

/**
 JChatPro  第三方客户端应用名称
 */
@property (nonatomic, copy) NSString *appName;

/**
 JChatPro  点击消息跳转第三方iOS客户端的Scheme
 */
@property (nonatomic, copy) NSString *fromScheme __attribute__((deprecated("已废弃,设置无效")));

/**
 JChatPro  图片网络地址
 */
@property (nonatomic, copy) NSString *imageURL;

/**
 返回一个 JShareMessage 实例
 
 @return 返回一个 JShareMessage 实例
 */
+ (JSHAREMessage *)message;
@end


@interface JSHAREService : NSObject

/**
 启动SDK,必要!
 
 @param config SDK启动参数模型，不可为nil。
 */
+ (void)setupWithConfig:(JSHARELaunchConfig *)config;


/**
 处理平台回调,必要！
 
 @param url 回调的url，在 Appdelegate 的 application:handleOpenURL: 中调用。不调用此接口 JSHARE 将无法提供分享回调。
 @return 处理结果 YES为处理成功，NO为不处理。
 */
+ (BOOL)handleOpenUrl:(NSURL *)url;

/**
 分享
 
 @param message  分享参数
 @param handler  分享之后的回调
 */
+ (void)share:(JSHAREMessage *)message
      handler:(JSHAREStateHandler)handler;

/**
 分享 仅支持JChatPro
 @param message  分享参数
 @param handler  分享之后的回调
 */
+ (void)share:(JSHAREMessage *)message
      completionHandler:(JSHARECompletionHandler)handler;



/**
 获取社交平台用户信息

 @param platform 社交平台参数，JSHAREPlatformWechatSession表示微信平台，JSHAREPlatformQQ表示 QQ 平台，JSHAREPlatformSinaWeibo，表示新浪微博平台。
 @param handler 获取社交平台用户信息的回调
 */
+ (void)getSocialUserInfo:(JSHAREPlatform)platform
                  handler:(JSHARESocialHandler)handler;


/**
 检查用户授权之后信息是否过期。

 @param platform 社交平台。
 @return 结果，YES 表示该社交平台已授权。NO 表示未授权或授权信息已过期。
 */
+ (BOOL)isPlatformAuth:(JSHAREPlatform)platform;


/**
 删除用户授权本地数据

 @param platfrom 社交平台。
 @return 取消结果，YES 表示已取消。
 */
+ (BOOL)cancelAuthWithPlatform:(JSHAREPlatform)platfrom;


/**
 检查不存在新浪客户端情况下的网页端是否登陆
 
 @return 返回结果
 */
+ (BOOL)isSinaWeiboWebLogined;


/**
 登出新浪网页端最新帐号
 
 @return 返回结果
 */
+ (BOOL)sinaWeiboWebLogOut;


/**
 检查是否安装微信客户端
 
 @return 返回结果
 */
+ (BOOL)isWeChatInstalled;

/**
 检查是否存在QQ客户端
 
 @return 返回结果
 */
+ (BOOL)isQQInstalled;


/**
 检查是否存在 facebook 客户端

 @return 返回结果
 */
+ (BOOL)isFacebookInstalled;


/**
 检查是否存在 facebookMessenger 客户端

 @return 返回结果
 */
+ (BOOL)isFacebookMessengerInstalled;

/**
 检查是否存在新浪微博客户端
 
 @return 返回结果
 */
+ (BOOL)isSinaWeiBoInstalled;

/**
 检查是否存在Twitter客户端
 
 @return 返回结果
 */
+ (BOOL)isTwitterInstalled;

/**
 检查是否存在JChatPro客户端
 
 @return 返回结果
 */
+ (BOOL)isJChatProInstalled;



/**
 @abstract 设置是否打印sdk产生的Debug级log信息, 默认为NO(不打印log)
 
 SDK 默认开启的日志级别为: Info. 只显示必要的信息, 不打印调试日志.
 
 请在SDK启动后调用本接口，调用本接口可打开日志级别为: Debug, 打印调试日志.
 请在发布产品时改为NO，避免产生不必要的IO
 
 此接口必须在"setupWithConfig:"之后调用才会生效.
 @param enable 是否打印
 */
+ (void)setDebug:(BOOL)enable;


@end


/**
 社交平台授权信息。
 */
@interface JSHARESocial : NSObject

/**
 对应新浪微博平台的uid，以及QQ与微信平台可能会存在的unionid，Twitter平台对应的userID
 */
@property (nonatomic, copy) NSString  *uid;

/**
 对应QQ与微信平台授权提供的openId。
 */
@property (nonatomic, copy) NSString  *openid;

/**
 accessToken 用户允许授权获取的 accessToken
 */
@property (nonatomic, copy) NSString  *accessToken;

/**
 accessToken有效期的时间戳，单位为秒。
 Twitter平台为空
 */
@property (nonatomic, assign) long expiration;

/**
 refreshToken 用来刷新 accessToken 的有效期。
 Twitter平台为空
 */
@property (nonatomic, copy) NSString  *refreshToken;


/**
 对应的社交平台。
 */
@property (nonatomic, assign) JSHAREPlatform platform;

/**
 社交平台提供的授权原始数据。
 */
@property (nonatomic,strong) NSDictionary *oauthOriginalResponse;

@end


@interface JSHARESocialUserInfo : JSHARESocial

/**
 社交平台的用户昵称。
 */
@property (nonatomic, copy) NSString  *name;

/**
 社交平台的用户头像链接。
 */
@property (nonatomic, copy) NSString  *iconurl;

/**
 社交平台的用户性别，数值1表示男，数值2表示女。
 Twitter平台为空
 */
@property (nonatomic, assign) NSInteger gender;

/**
 社交平台提供的用户信息原始数据。
 */
@property (nonatomic, strong) NSDictionary *userOriginalResponse;

@end

