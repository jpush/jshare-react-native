//
//  EventEmiter.m
//  jshare
//
//  Created by oshumini on 2017/7/28.
//  Copyright © 2017年 Facebook. All rights reserved.
//

#import "EventEmiter.h"
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

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

@implementation EventEmiter

RCT_EXPORT_MODULE();

@synthesize bridge = _bridge;

+ (id)allocWithZone:(NSZone *)zone {
  static EventEmiter *emiter = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    emiter = [super allocWithZone:zone];
  });
  return emiter;
}

- (id)init {
  self = [super init];
  NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"wechat@3x" ofType:@"png"];
  NSString *videoPath = [[NSBundle mainBundle] pathForResource:@"jiguang" ofType:@"mp4"];
  
  NSString *emotionPath = [[NSBundle mainBundle] pathForResource:@"res6" ofType:@"gif"];
  
  dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    [self.bridge.eventDispatcher sendAppEventWithName:@"finishGetResource" body:@{@"imagePath": imagePath,
                                                                                  @"videoPath": videoPath,
                                                                                  @"emotionPath": emotionPath}];
    NSLog(@"++++++++++++++++++");
  });
  return self;
  

}
@end
