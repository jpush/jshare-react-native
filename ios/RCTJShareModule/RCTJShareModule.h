//
//  RCTJShareModule.h
//  jshare
//
//  Created by oshumini on 2017/7/18.
//  Copyright © 2017年 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>

#if __has_include(<React/RCTBridgeModule.h>)
#import <React/RCTBridgeModule.h>
#elif __has_include("RCTBridgeModule.h")
#import "RCTBridgeModule.h"
#elif __has_include("React/RCTBridgeModule.h")
#import "React/RCTBridgeModule.h"
#endif

#import "JSHAREService.h"

@interface RCTJShareModule : NSObject <RCTBridgeModule>

@end
