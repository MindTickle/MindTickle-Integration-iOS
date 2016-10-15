//
//  MindTickleAuth.m
//  Auth
//
//  Created by hridayesh gupta on 14/10/16.
//  Copyright © 2016 MindTickle. All rights reserved.
//

#import "MindTickleAuth.h"
#import <JWT/JWT.h>
#import <JWT/JWTAlgorithmFactory.h>
#import "BranchUniversalObject.h"
#import "BranchLinkProperties.h"

static NSString* __domain;
static NSString* __jwtToken;
static NSString* __secretKey;
static NSString* __accessToken;
static NSURL* __link;
static BOOL __branchError = NO;
static BOOL __openPending = NO;

@interface MindTickleAuth()

@end

@implementation MindTickleAuth

//secure methods
+ (void) initWithDomain:(NSString *)domain {
    __domain = domain;
}
+ (void) initWithDomain:(NSString *)domain accessToken:(NSString *)accessToken {
    __domain = domain;
    __accessToken = accessToken;
    [MindTickleAuth onAccessToken];
}
+ (void) setAccessToken:(NSString *)accessToken {
    __accessToken = accessToken;
    [MindTickleAuth onAccessToken];
}

//unsecure methods. keeping secret key in client code is not safe
+ (void) initWithDomain:(NSString *)domain secretKey:(NSString *)secretKey {
    __domain = domain;
    __secretKey = secretKey;
}
+ (void) initWithDomain:(NSString *)domain secretKey:(NSString *)secretKey email:(NSString *)email {
    __domain = domain;
    __secretKey = secretKey;
    __accessToken = [MindTickleAuth generateTokenForEmail:email];
    [MindTickleAuth onAccessToken];
}
+ (void) setEmail:(NSString *)email {
    __accessToken = [MindTickleAuth generateTokenForEmail:email];
    [MindTickleAuth onAccessToken];
}

+ (NSString*)generateTokenForEmail:(NSString*) email {
    return [JWTBuilder encodePayload:@{@"identifier":@{@"email":email}, @"domain":__domain}].secret(__secretKey).algorithm([JWTAlgorithmFactory algorithmByName:@"HS512"]).encode;
}

+ (void) onAccessToken {
    __openPending = NO;
    
    [Branch getInstance:@"key_live_lptauUbo5oklZUvxxuWgEgplAEjG82fa"];
    
    BranchUniversalObject *branchUniversalObject = [[BranchUniversalObject alloc] initWithCanonicalIdentifier:@"mindtickle"];
    
    branchUniversalObject.title = @"MindTickle";
    branchUniversalObject.contentDescription = [NSString stringWithFormat:@"Sales enablement done right!"];
    [branchUniversalObject addMetadataKey:@"access_token" value:__accessToken];
    [branchUniversalObject addMetadataKey:@"domain" value:__domain];
    
    BranchLinkProperties *linkProperties = [[BranchLinkProperties alloc] init];
    
    [branchUniversalObject getShortUrlWithLinkProperties:linkProperties andCallback:^(NSString *urlString, NSError *error) {
        if (!error && urlString) {
            NSLog(@"url is %@", urlString);
            NSURL* url = [NSURL URLWithString:urlString];
            __link = url;
            
            if(__openPending) {
                if([[UIApplication sharedApplication] canOpenURL:__link]) {
                    [[UIApplication sharedApplication] openURL:__link];
                }
                else {
                    NSLog(@"can not open MindTickle App from url %@", __link);
                }
                __openPending = NO;
            }
        }
        else {
            __branchError = YES;
        }
    }];
}
+ (BOOL) openMindTickle {
    if(__domain == nil || __accessToken == nil) {
        NSLog(@"unsufficiet parameters to open MindTickle");
        return NO;
    }
    if(__link == nil) {
        __openPending = YES;
        return YES;
    }
    if([[UIApplication sharedApplication] canOpenURL:__link]) {
        [[UIApplication sharedApplication] openURL:__link];
        return YES;
    }
    else {
        NSLog(@"can not open MindTickle App from url %@", __link);
        return NO;
    }
    
}

@end
