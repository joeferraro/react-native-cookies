// RNCookieManagerIOS.h
#if __has_include("RCTBridgeModule.h")
#import "RCTBridgeModule.h"
#else
#import <React/RCTBridgeModule.h>
#endif

#import <WebKit/WebKit.h>

@interface RNCookieManagerIOS : NSObject <RCTBridgeModule>

@property (nonatomic, strong) NSDateFormatter *formatter;

@end
