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

#define JShareConfig_FileName @"RCTJShareConfig"
@implementation RCTJShareModule

RCT_EXPORT_MODULE();

+ (id)allocWithZone:(NSZone *)zone {
  static RCTJShareModule *sharedInstance = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    sharedInstance = [super allocWithZone:zone];
  });
  return sharedInstance;
}

+ (BOOL)requiresMainQueueSetup
{
  return NO;
}

- (id)init {
  self = [super init];
  return self;
}

- (JSHAREPlatform)getAuthorizePlatformFromDic:(NSDictionary *)param {
  JSHAREPlatform platform = 0;
  if (param[@"platform"]) {
    if ([param[@"platform"] isEqualToString:@"wechat"]) {
      platform = JSHAREPlatformWechatSession;
    }
    
    if ([param[@"platform"] isEqualToString:@"qq"]) {
      platform = JSHAREPlatformQQ;
    }
    
    if ([param[@"platform"] isEqualToString:@"weibo"]) {
      platform = JSHAREPlatformSinaWeibo;
    }
    
    if ([param[@"platform"] isEqualToString:@"facebook"]) {
      platform = JSHAREPlatformFacebook;
    }
      
      if ([param[@"platform"] isEqualToString:@"twitter"]) {
          platform = JSHAREPlatformTwitter;
      }
      
      if ([param[@"platform"] isEqualToString:@"jchat_pro"]) {
          platform = JSHAREPlatformJChatPro;
      }
  }
  
  return platform;
}

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
    
    if ([param[@"platform"] isEqualToString:@"facebook"]) {
      platform = JSHAREPlatformFacebook;
    }
    
    if ([param[@"platform"] isEqualToString:@"facebook_messenger"]) {
      platform = JSHAREPlatformFacebookMessenger;
    }
      
    if ([param[@"platform"] isEqualToString:@"twitter"]) {
      platform = JSHAREPlatformTwitter;
    }
      
    if ([param[@"platform"] isEqualToString:@"jchat_pro"]) {
      platform = JSHAREPlatformJChatPro;
    }
  }

  return platform;
}

RCT_EXPORT_METHOD(setup){
  
  NSString *plistPath = [[NSBundle mainBundle] pathForResource:JShareConfig_FileName ofType:@"plist"];
  if (plistPath == nil) {
    NSLog(@"error: RCTJShareConfig.plist not found");
    return;
  }
  
  NSMutableDictionary *param = [[NSMutableDictionary alloc] initWithContentsOfFile: plistPath];
  
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
  
  if (param[@"facebookAppId"]) {
    config.FacebookAppID = param[@"facebookAppId"];
  }
  
  if (param[@"facebookDisplayName"]) {
    config.FacebookDisplayName = param[@"facebookDisplayName"];
  }
  
  if (param[@"isSupportWebSina"]) {
    NSNumber *isSupportWebSina = param[@"isSupportWebSina"];
    config.isSupportWebSina = [isSupportWebSina boolValue];
  }
    
  if (param[@"twitterConsumerKey"]) {
    config.TwitterConsumerKey = param[@"twitterConsumerKey"];
  }

  if (param[@"twitterConsumerSecret"]) {
    config.TwitterConsumerSecret = param[@"twitterConsumerSecret"];
  }

  if (param[@"jchatProAuth"]) {
    config.JChatProAuth = param[@"jchatProAuth"];
  }
  
  [JSHAREService setupWithConfig:config];
}

RCT_EXPORT_METHOD(authorize:(NSDictionary *)param
                  success:(RCTResponseSenderBlock) successCallBack
                  fail:(RCTResponseSenderBlock) failCallBack) {
  JSHAREPlatform platform = [self getAuthorizePlatformFromDic:param];
  
  if (platform == 0) {
    failCallBack(@[@{@"code": @(1), @"description": @"platform 参数错误"}]);
    return;
  }
  
    dispatch_async(dispatch_get_main_queue(), ^{
        [JSHAREService getSocialUserInfo:platform handler:^(JSHARESocialUserInfo *userInfo, NSError *error) {
            NSMutableDictionary *userDic = [NSMutableDictionary new];
            if (error) {
                failCallBack(@[@{@"code": @(error.code), @"description": [error userInfo] ?: @""}]);
                return;
            }
            
            userDic[@"token"] = userInfo.accessToken;
            userDic[@"expiration"] = @(userInfo.expiration);
            userDic[@"refreshToken"] = userInfo.refreshToken;
            userDic[@"openId"] = userInfo.openid;
            
            userDic[@"originData"] = userInfo.userOriginalResponse;
            if ([self dictionaryToJson: userInfo.userOriginalResponse]) {
                userDic[@"originData"] = [self dictionaryToJson: userInfo.userOriginalResponse];
            }
            successCallBack(@[[NSDictionary dictionaryWithDictionary: userDic]]);
        }];
    });
//  ;
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
    NSMutableDictionary *userDic = [NSMutableDictionary new];
    if (error) {
      failCallBack(@[@{@"code": @(error.code), @"description": [error userInfo] ?: @""}]);
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
    userDic[@"openId"] = userInfo.openid;
    userDic[@"access_token"] = userInfo.accessToken;
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
  successCallBack(@[@(result ? 0 : 1)]);
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

RCT_EXPORT_METHOD(isFacebookInstalled:(RCTResponseSenderBlock) successCallBack) {
  BOOL result = [JSHAREService isFacebookInstalled];
  successCallBack(@[@(result)]);
}

RCT_EXPORT_METHOD(isSinaWeiBoInstalled:(RCTResponseSenderBlock) successCallBack) {
  BOOL result = [JSHAREService isSinaWeiBoInstalled];
  successCallBack(@[@(result)]);
}

RCT_EXPORT_METHOD(isTwitterInstalled:(RCTResponseSenderBlock) successCallBack) {
    BOOL result = [JSHAREService isTwitterInstalled];
    successCallBack(@[@(result)]);
}

RCT_EXPORT_METHOD(isJChatProInstalled:(RCTResponseSenderBlock) successCallBack) {
    BOOL result = [JSHAREService isJChatProInstalled];
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
    
    if (param[@"imageUrl"]) {
      NSString *imageURL = param[@"imageUrl"];
      NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageURL]];
      message.image = imageData;
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
    
    if (param[@"videoAssetURL"]) {
      message.videoAssetURL = param[@"videoAssetURL"];
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

    if (param[@"imageUrl"]) {
      NSString *imageURL = param[@"imageUrl"];
      NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageURL]];
      message.thumbnail = imageData;
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
    
    if (param[@"imageUrl"]) {
      NSString *imageURL = param[@"imageUrl"];
      NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageURL]];
      message.thumbnail = imageData;
    }
    
    message.mediaType = JSHARELink;
  }

  dispatch_async(dispatch_get_main_queue(), ^{
    [JSHAREService share:message handler:^(JSHAREState state, NSError *error) {
      if (error) {
        switch (message.platform) {
          case JSHAREPlatformQQ:{
            if (state == JSHAREStateCancel) {
              NSString *stateString = [self stateToString:state];
              successCallBack(@[@{@"state": stateString}]);
              return;
            }
            break;
          }
          case JSHAREPlatformQzone: {
            if (state == JSHAREStateCancel) {
              NSString *stateString = [self stateToString:state];
              successCallBack(@[@{@"state": stateString}]);
              return;
            }
            break;
          }
          default:
            break;
        }
        failCallBack(@[@{@"code":@(error.code), @"description": [error userInfo] ?: @""}]);
        return;
      }
      NSString *stateString = [self stateToString:state];
      successCallBack(@[@{@"state": stateString}]);
    }];
  });
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
  
  if ([platformStr isEqualToString:@"facebook"]) {
    return JSHAREPlatformFacebook;
  }
  
  if ([platformStr isEqualToString:@"facebook_messenger"]) {
    return JSHAREPlatformFacebookMessenger;
  }

  if ([platformStr isEqualToString:@"sina_weibo_contact"]) {
    return JSHAREPlatformSinaWeiboContact;
  }
    
  if ([platformStr isEqualToString:@"twitter"]) {
    return JSHAREPlatformTwitter;
  }
    
  if ([platformStr isEqualToString:@"jchat_pro"]) {
    return JSHAREPlatformJChatPro;
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

- (NSString *)dictionaryToJson:(NSDictionary *)dic {
  if (!dic) {
    return nil;
  }
  
  NSError *error;
  NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic
                                                     options:NSJSONWritingPrettyPrinted
                                                       error:&error];
  if (!jsonData) {
    return nil;
  } else {
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
  }
}
@end
