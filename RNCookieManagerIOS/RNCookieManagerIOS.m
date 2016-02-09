#import "RNCookieManagerIOS.h"
#import "RCTConvert.h"

@implementation RNCookieManagerIOS

RCT_EXPORT_MODULE()

RCT_EXPORT_METHOD(set:(NSDictionary *)props callback:(RCTResponseSenderBlock)callback) {
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

    callback(@[[NSNull null], @"success"]);
}

RCT_EXPORT_METHOD(setFromResponse:(NSURL *)url value:(NSDictionary *)value callback:(RCTResponseSenderBlock)callback) {
  NSArray *cookies = [NSHTTPCookie cookiesWithResponseHeaderFields:value forURL:url];
  [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookies:cookies forURL:url mainDocumentURL:NULL];
    callback(@[[NSNull null], @"success"]);
}


RCT_EXPORT_METHOD(get:(NSURL *)url callback:(RCTResponseSenderBlock)callback) {
  NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookiesForURL:url];
    NSDictionary *headers = [NSHTTPCookie requestHeaderFieldsWithCookies:cookies];
    if ([headers objectForKey:@"Cookie"] == nil) {
        callback(@[[NSNull null], @"success"]);
    } else {
        callback(@[headers[@"Cookie"], @"success"]);
    }
}

RCT_EXPORT_METHOD(clearAll:(RCTResponseSenderBlock)callback) {
    NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (NSHTTPCookie *c in cookieStorage.cookies) {
        [cookieStorage deleteCookie:c];
    }
    callback(@[[NSNull null], @"success"]);
}

// TODO: return a better formatted list of cookies per domain
RCT_EXPORT_METHOD(getAll:(RCTResponseSenderBlock)callback) {
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
    callback(@[cookies, @"success"]);
}

@end
