#import "RNCookieManagerIOS.h"
#if __has_include("RCTConvert.h")
#import "RCTConvert.h"
#else
#import <React/RCTConvert.h>
#endif

@implementation RNCookieManagerIOS

- (NSError *) errorFromException: (NSException *) exception
{
    NSDictionary *exceptionInfo = @{
                                    @"name": exception.name,
                                    @"reason": exception.reason,
                                    @"callStackReturnAddresses": exception.callStackReturnAddresses,
                                    @"callStackSymbols": exception.callStackSymbols,
                                    @"userInfo": exception.userInfo
                                    };
    
    return [[NSError alloc] initWithDomain: @"RNCookieManager"
                                      code: 0
                                  userInfo: exceptionInfo];
}

RCT_EXPORT_MODULE()

RCT_EXPORT_METHOD(set:(NSDictionary *)props
    resolver:(RCTPromiseResolveBlock)resolve
    rejecter:(RCTPromiseRejectBlock)reject) {
    
    @try {
        NSString *name = [RCTConvert NSString:props[@"name"]];
        NSString *value = [RCTConvert NSString:props[@"value"]];
        NSString *domain = [RCTConvert NSString:props[@"domain"]];
        NSString *origin = [RCTConvert NSString:props[@"origin"]];
        NSString *path = [RCTConvert NSString:props[@"path"]];
        NSString *version = [RCTConvert NSString:props[@"version"]];
        NSDate *expiration = [RCTConvert NSDate:props[@"expiration"]];

        NSMutableDictionary *cookieProperties = [NSMutableDictionary dictionary];
        [cookieProperties setObject:name forKey:NSHTTPCookieName];
        [cookieProperties setObject:value forKey:NSHTTPCookieValue];
        [cookieProperties setObject:domain forKey:NSHTTPCookieDomain];
        [cookieProperties setObject:origin forKey:NSHTTPCookieOriginURL];
        [cookieProperties setObject:path forKey:NSHTTPCookiePath];
        [cookieProperties setObject:version forKey:NSHTTPCookieVersion];
        [cookieProperties setObject:expiration forKey:NSHTTPCookieExpires];

        NSLog(@"SETTING COOKIE");
        NSLog(@"%@", cookieProperties);

        NSHTTPCookie *cookie = [NSHTTPCookie cookieWithProperties:cookieProperties];
        [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie];

        resolve(nil);
    }
    @catch (NSException * e) {
        reject(@"Could not set cookie", [self errorFromException:e]);
    }
    
}

RCT_EXPORT_METHOD(setFromResponse:(NSURL *)url
    value:(NSDictionary *)value
    resolver:(RCTPromiseResolveBlock)resolve
    rejecter:(RCTPromiseRejectBlock)reject) {
           
    @try {
        NSArray *cookies = [NSHTTPCookie cookiesWithResponseHeaderFields:value forURL:url];
        [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookies:cookies forURL:url mainDocumentURL:NULL];
        resolve(nil);
    }
    @catch (NSException * e) {
        reject(@"Could not set cookie via setFromResponse", [self errorFromException:e]);
    }
}

RCT_EXPORT_METHOD(getFromResponse:(NSURL *)url
    resolver:(RCTPromiseResolveBlock)resolve
    rejecter:(RCTPromiseRejectBlock)reject) {
    @try {
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [NSURLConnection sendAsynchronousRequest:request  queue:[[NSOperationQueue alloc] init]
                            completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {

            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
            NSArray *cookies = [NSHTTPCookie cookiesWithResponseHeaderFields:httpResponse.allHeaderFields forURL:response.URL];
            NSMutableDictionary *dics = [NSMutableDictionary dictionary];

            for (int i = 0; i < cookies.count; i++) {
                NSHTTPCookie *cookie = [cookies objectAtIndex:i];
                [dics setObject:cookie.value forKey:cookie.name];
                NSLog(@"cookie: name=%@, value=%@", cookie.name, cookie.value);
                [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie];
            }
            resolve(dics);
        }];
    }
    @catch (NSException * e) {
        reject(@"Could not get cookie via getFromResponse", [self errorFromException:e]);
    }
}

RCT_EXPORT_METHOD(get:(NSURL *) url
    resolver:(RCTPromiseResolveBlock)resolve
    rejecter:(RCTPromiseRejectBlock)reject) {
    @try {
        NSMutableDictionary *cookies = [NSMutableDictionary dictionary];
        for (NSHTTPCookie *c in [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookiesForURL:url]) {
            [cookies setObject:c.value forKey:c.name];
        }
        resolve(cookies);
    }
    @catch (NSException * e) {
        reject(@"Could not get cookie", [self errorFromException:e]);
    }
}

RCT_EXPORT_METHOD(clearAll:(RCTPromiseResolveBlock)resolve
    rejecter:(RCTPromiseRejectBlock)reject) {
    @try {
        NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
        for (NSHTTPCookie *c in cookieStorage.cookies) {
            [cookieStorage deleteCookie:c];
        }
        resolve(nil);
    }
    @catch (NSException * e) {
        reject(@"Could not clearAll cookies", [self errorFromException:e]);
    }
}

RCT_EXPORT_METHOD(clearByName:(NSString *) name
    resolver:(RCTPromiseResolveBlock)resolve
    rejecter:(RCTPromiseRejectBlock)reject) {
    @try {
        NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
        for (NSHTTPCookie *c in cookieStorage.cookies) {
        if ([[c name] isEqualToString:name]) {
            [cookieStorage deleteCookie:c];
        }
        }
        resolve(nil);
    }
    @catch (NSException * e) {
        reject(@"Could not clearByName cookie", [self errorFromException:e]);
    }
}

// TODO: return a better formatted list of cookies per domain
RCT_EXPORT_METHOD(getAll:(RCTPromiseResolveBlock)resolve
    rejecter:(RCTPromiseRejectBlock)reject) {
    @try {
        NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
        NSMutableDictionary *cookies = [NSMutableDictionary dictionary];
        for (NSHTTPCookie *c in cookieStorage.cookies) {
            NSMutableDictionary *d = [NSMutableDictionary dictionary];
            [d setObject:c.value forKey:@"value"];
            [d setObject:c.name forKey:@"name"];
            [d setObject:c.domain forKey:@"domain"];
            [d setObject:c.path forKey:@"path"];
            [cookies setObject:d forKey:c.name];
        }
        resolve(cookies);
     }
    @catch (NSException * e) {
        reject(@"Could not getAll cookies", [self errorFromException:e]);
    }
}

@end
