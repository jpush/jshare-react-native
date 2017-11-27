//
//  RCTJShareModule.m
//  jshare
//
//  Created by oshumini on 2017/7/18.
//  Copyright © 2017年 Facebook. All rights reserved.
//

#import "RCTJShareModule.h"

#if __has_include(<React/RCTBridge.h>)
#import <React/RCTEventDispatcher.h>
#import <React/RCTRootView.h>
#import <React/RCTBridge.h>
#elif __has_include("RCTBridge.h")
#import "RCTEventDispatcher.h"
#import "RCTRootView.h"
#import "RCTBridge.h"
#elif __has_include("React/RCTBridge.h")
#import "React/RCTEventDispatcher.h"
#import "React/RCTRootView.h"
#import "React/RCTBridge.h"
#endif

@implementation RCTJShareModule

RCT_EXPORT_MODULE();

//@synthesize bridge = _bridge;

+ (id)allocWithZone:(NSZone *)zone {
  static RCTJShareModule *sharedInstance = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    sharedInstance = [super allocWithZone:zone];
  });
  return sharedInstance;
}

- (id)init {
  self = [super init];
  return self;
}



//
///**
// 启动SDK,必要!
// 
// @param config SDK启动参数模型，不可为nil。
// */
//+ (void)setupWithConfig:(JSHARELaunchConfig *)config;
//
//


//JSHARELaunchConfig *config = [[JSHARELaunchConfig alloc] init];
//config.appKey = @"a1703c14b186a68a66ef86c1";
//config.SinaWeiboAppKey = @"374535501";
//config.SinaWeiboAppSecret = @"baccd12c166f1df96736b51ffbf600a2";
//config.SinaRedirectUri = @"https://www.jiguang.cn";
//config.QQAppId = @"1105864531";
//config.QQAppKey = @"glFYjkHQGSOCJHMC";
//config.WeChatAppId = @"wxc40e16f3ba6ebabc";
//config.WeChatAppSecret = @"dcad950cd0633a27e353477c4ec12e7a";
//config.isSupportWebSina = YES;
//[JSHAREService setupWithConfig:config];
//[JSHAREService setDebug:YES];

- (JSHAREPlatform)getPlatformFromDic:(NSDictionary *)param {
  JSHAREPlatform platform = 0;
  
  if (param[@"platform"]) {
    if ([param[@"platform"] isEqualToString:@"wechat_session"]) {
      platform = JSHAREPlatformWechatSession;
    }
    
    if ([param[@"platform"] isEqualToString:@"wechat_timeLine"]) {
      platform = JSHAREPlatformWechatTimeLine;
    }
    
    if ([param[@"platform"] isEqualToString:@"wechat_favourite"]) {
      platform = JSHAREPlatformWechatFavourite;
    }
    
    if ([param[@"platform"] isEqualToString:@"qq"]) {
      platform = JSHAREPlatformQQ;
    }
    
    if ([param[@"platform"] isEqualToString:@"qzone"]) {
      platform = JSHAREPlatformQzone;
    }
    
    if ([param[@"platform"] isEqualToString:@"sina_weibo"]) {
      platform = JSHAREPlatformSinaWeibo;
    }
    
    if ([param[@"platform"] isEqualToString:@"sina_weibo_contact"]) {
      platform = JSHAREPlatformSinaWeiboContact;
    }
  }
  
  return platform;

}

RCT_EXPORT_METHOD(setup:(NSDictionary *)param){
  JSHARELaunchConfig *config = [[JSHARELaunchConfig alloc] init];
  if (param[@"appKey"]) {
    config.appKey = param[@"appKey"];
  }
  
  if (param[@"channel"]) {
    config.channel = param[@"channel"];
  }
  
  if (param[@"advertisingId"]) {
    config.advertisingId = param[@"advertisingId"];
  }
  
  if (param[@"isProduction"]) {
    config.isProduction = param[@"isProduction"];
  }
  
  if (param[@"wechatAppId"]) {
    config.WeChatAppId = param[@"wechatAppId"];
  }
  
  if (param[@"wechatAppSecret"]) {
    config.WeChatAppSecret = param[@"wechatAppSecret"];
  }
  
  if (param[@"qqAppId"]) {
    config.QQAppId = param[@"qqAppId"];
  }
  
  if (param[@"qqAppKey"]) {
    config.QQAppKey = param[@"qqAppKey"];
  }
  
  if (param[@"sinaWeiboAppKey"]) {
    config.SinaWeiboAppKey = param[@"sinaWeiboAppKey"];
  }
  
  if (param[@"sinaWeiboAppSecret"]) {
    config.SinaWeiboAppSecret = param[@"sinaWeiboAppSecret"];
  }
  
  if (param[@"sinaRedirectUri"]) {
    config.SinaRedirectUri = param[@"sinaRedirectUri"];
  }
  
  if (param[@"isSupportWebSina"]) {
    NSNumber *isSupportWebSina = param[@"isSupportWebSina"];
    config.isSupportWebSina = [isSupportWebSina boolValue];
  }
  
  [JSHAREService setupWithConfig:config];
}


RCT_EXPORT_METHOD(getSocialUserInfo:(NSDictionary *)param
                  success:(RCTResponseSenderBlock) successCallBack
                  fail:(RCTResponseSenderBlock) failCallBack) {

  JSHAREPlatform platform = [self getPlatformFromDic:param];
  
  if (platform == 0) {
    failCallBack(@[@{@"code": @(1), @"description": @"platform 参数错误"}]);
    return;
  }
  
  [JSHAREService getSocialUserInfo:platform handler:^(JSHARESocialUserInfo *userInfo, NSError *error) {
    NSMutableDictionary *userDic = @{}.mutableCopy;
    if (error) {
      NSString *descript = [error description];
      failCallBack(@[@{@"code": @(1), @"description": [error description]}]);
      return;
    }
    
    userDic[@"name"] = userInfo.name;
    userDic[@"iconUrl"] = userInfo.iconurl;
    if (userInfo.gender == 1) {
      userDic[@"gender"] = @"male";
    } else {
      userDic[@"gender"] = @"female";
    }
    userDic[@"response"] = userInfo.userOriginalResponse;
    successCallBack(@[[NSDictionary dictionaryWithDictionary: userDic]]);
  }];
}

RCT_EXPORT_METHOD(isPlatformAuth:(NSDictionary *)param
                  success:(RCTResponseSenderBlock) successCallBack) {
  JSHAREPlatform platform = [self getPlatformFromDic:param];
  
  if (platform == 0) {
    return;
  }
  
    BOOL result = [JSHAREService isPlatformAuth:platform];
    successCallBack(@[@(result)]);
}

RCT_EXPORT_METHOD(cancelAuthWithPlatform:(NSDictionary *)param
                  success:(RCTResponseSenderBlock) successCallBack) {
  
  JSHAREPlatform platform = [self getPlatformFromDic:param];
  
  if (platform == 0) {
    successCallBack(@[@{@"code": @(1), @"description": @"platform 参数错误"}]);
    return;
  }
  
  BOOL result = [JSHAREService cancelAuthWithPlatform:platform];
  successCallBack(@[@(result)]);
}

RCT_EXPORT_METHOD(isSinaWeiboWebLogined:(RCTResponseSenderBlock)successCallBack) {
  BOOL result = [JSHAREService isSinaWeiboWebLogined];
  successCallBack(@[@(result)]);
}

RCT_EXPORT_METHOD(sinaWeiboWebLogOut:(RCTResponseSenderBlock) successCallBack) {
  BOOL result = [JSHAREService sinaWeiboWebLogOut];
  successCallBack(@[@(result)]);
}

RCT_EXPORT_METHOD(isWeChatInstalled:(RCTResponseSenderBlock) successCallBack) {
  BOOL result = [JSHAREService isWeChatInstalled];
  successCallBack(@[@(result)]);
}

RCT_EXPORT_METHOD(isQQInstalled:(RCTResponseSenderBlock) successCallBack) {
  BOOL result = [JSHAREService isQQInstalled];
  successCallBack(@[@(result)]);
}


RCT_EXPORT_METHOD(isSinaWeiBoInstalled:(RCTResponseSenderBlock) successCallBack) {
  BOOL result = [JSHAREService isSinaWeiBoInstalled];
  successCallBack(@[@(result)]);
}


RCT_EXPORT_METHOD(setDebug:(NSDictionary *)param) {
  NSNumber *enable = false;
  if (param[@"enable"]) {
    enable = param[@"enable"];
  }
  [JSHAREService setDebug:[enable boolValue]];
}

RCT_EXPORT_METHOD(share:(NSDictionary *)param
                  success:(RCTResponseSenderBlock) successCallBack
                  fail:(RCTResponseSenderBlock) failCallBack) {

  if (param[@"type"] == nil) {
    failCallBack(@[@{@"code": @(1), @"description": @"parame error"}]);
    return;
  }
  
  JSHAREMessage *message = [JSHAREMessage message];
  JSHAREPlatform platform = [self getPlatformFromString: param[@"platform"]];
  
  if (platform) {
    message.platform = platform;
  } else {
    failCallBack(@[@{@"code":@(1), @"description": @"parame error: platform error"}]);
    return;
  }
  
  if ([param[@"type"] isEqualToString: @"text"]) {
    if (param[@"text"]) {
      message.text = param[@"text"];
    }
    message.mediaType = JSHAREText;

  }
  
  if ([param[@"type"] isEqualToString: @"image"]) {
    if (param[@"imagePath"]) {
      message.image = [NSData dataWithContentsOfFile:param[@"imagePath"]];
    }
    
    if (param[@"text"]) {
      message.text = param[@"text"];
    }
    
    if (param[@"imageArray"]) {
      NSArray *imageArr = param[@"imageArray"];
      NSMutableArray *imageDataArr = @[].mutableCopy;
      for (NSString *path in imageArr) {
        NSData *data = [NSData dataWithContentsOfFile: path];
        [imageDataArr addObject:data];
      }
      message.images = imageDataArr;
      
    }
    message.mediaType =JSHAREImage;
  }
  
  if ([param[@"type"] isEqualToString: @"video"]) {
    if (param[@"title"]) {
      message.title = param[@"title"];
    }
    
    if (param[@"url"]) {
      message.mediaDataUrl = param[@"url"];
    }
    
    if (param[@"text"]) {
      message.text = param[@"text"];
    }
    
    if (param[@"imagePath"]) {
      message.thumbnail = [NSData dataWithContentsOfFile:param[@"imagePath"]];
    }
    
    message.mediaType = JSHAREVideo;
  }
  
  if ([param[@"type"] isEqualToString: @"audio"]) {
    if (param[@"title"]) {
      message.title = param[@"title"];
    }
    
    if (param[@"text"]) {
      message.text = param[@"text"];
    }
    
    if (param[@"url"]) {
      message.mediaDataUrl = param[@"url"];
    }
    
    if (param[@"imagePath"]) {
      message.thumbnail = [NSData dataWithContentsOfFile:param[@"imagePath"]];
    }
    
    if (param[@"musicUrl"]) {
      message.mediaDataUrl = param[@"musicUrl"];
    }
    
    message.mediaType = JSHAREAudio;
  }
  
  if ([param[@"type"] isEqualToString: @"file"]) {
    message.mediaType = JSHAREFile;
    if (param[@"path"]) {
      message.fileData = [NSData dataWithContentsOfFile:param[@"path"]];
    }
    
    if (param[@"title"]) {
      message.title = param[@"title"];
    }
    
    if (param[@"fileExt"]) {
      message.fileExt = param[@"fileExt"];
    }
    
  }
  
  if ([param[@"type"] isEqualToString: @"emoticon"]) {
    if (param[@"imagePath"]) {
      message.emoticonData = [NSData dataWithContentsOfFile:param[@"imagePath"]];
    }
    
    message.mediaType = JSHAREEmoticon;
  }
  
  if ([param[@"type"] isEqualToString: @"app"]) {
    if (param[@"title"]) {
      message.title = param[@"title"];
    }
    
    if (param[@"text"]) {
      message.text = param[@"text"];
    }
    
    if (param[@"url"]) {
      message.url = param[@"url"];
    }
    
    if (param[@"extInfo"]) {
      message.extInfo = param[@"extInfo"];
    }
    
    if (param[@"path"]) {
      message.fileData = [NSData dataWithContentsOfFile:param[@"path"]];
    }
    message.mediaType = JSHAREApp;
  }
  
  if ([param[@"type"] isEqualToString: @"link"]) {
    
    if (param[@"title"]) {
      message.title = param[@"title"];
    }
    
    if (param[@"text"]) {
      message.text = param[@"text"];
    }
    
    if (param[@"url"]) {
      message.url = param[@"url"];
    }
    
    if (param[@"imagePath"]) {
      message.thumbnail = [NSData dataWithContentsOfFile:param[@"imagePath"]];
    }
    message.mediaType = JSHARELink;
  }
  
  [JSHAREService share:message handler:^(JSHAREState state, NSError *error) {
    if (error) {
      failCallBack(@[@{@"code":@(error.code), @"description": [error description]}]);
      return;
    }
    NSString *stateString = [self stateToString:state];
    successCallBack(@[@{@"state": stateString}]);
  }];
}

- (NSUInteger)getPlatformFromString:(NSString *)platformStr {
  if ([platformStr isEqualToString:@"wechat_session"]) {
    return JSHAREPlatformWechatSession;
  }
  
  if ([platformStr isEqualToString:@"wechat_timeLine"]) {
    return JSHAREPlatformWechatTimeLine;
  }
  
  if ([platformStr isEqualToString:@"wechat_favourite"]) {
    return JSHAREPlatformWechatFavourite;
  }
  
  if ([platformStr isEqualToString:@"qq"]) {
    return JSHAREPlatformQQ;
  }
  
  if ([platformStr isEqualToString:@"qzone"]) {
    return JSHAREPlatformQzone;
  }
  
  if ([platformStr isEqualToString:@"sina_weibo"]) {
    return JSHAREPlatformSinaWeibo;
  }
  
  if ([platformStr isEqualToString:@"sina_weibo_contact"]) {
    return JSHAREPlatformSinaWeiboContact;
  }
  
  return 0;
}

- (NSString *)stateToString:(JSHAREState)state {
  NSString *stateString = @"unknow";
  switch (state) {
    case JSHAREStateSuccess:
      stateString = @"success";
      break;
      
    case JSHAREStateFail:
      stateString = @"fail";
      break;
      
    case JSHAREStateCancel:
      stateString = @"cancel";
      break;
      
    case JSHAREStateUnknown:
      stateString = @"unknown";
      break;
  }
  return stateString;
}
@end
