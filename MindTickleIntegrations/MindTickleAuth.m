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

@interface MindTickleAuth()

@property (nonatomic) NSString* domain;
@property (nonatomic) NSString* secretKey;
@property (nonatomic) NSString* email;

@end

@implementation MindTickleAuth

- (instancetype)initWithDomain:(NSString *)domain email:(NSString *)email {
    self = [super init];
    if(self) {
        _domain = domain;
        _secretKey = nil;
        _email = email;
    }
    return self;
}

- (instancetype)initWithDomain:(NSString *)domain secretKey:(NSString *)secretKey email:(NSString *)email {
    self = [super init];
    if(self) {
        _domain = domain;
        _secretKey = secretKey;
        _email = email;
    }
    return self;
}

- (NSString*)generate {
    return [JWTBuilder encodePayload:@{@"identifier":@{@"email":self.email}, @"domain":self.domain}].secret(self.secretKey).algorithm([JWTAlgorithmFactory algorithmByName:@"HS512"]).encode;
}

- (void) openMindTickle {
    NSString* token = [self generate];
    //set branch key
    Branch* br = [Branch getInstance:@"key_live_lptauUbo5oklZUvxxuWgEgplAEjG82fa"];
    
    BranchUniversalObject *branchUniversalObject = [[BranchUniversalObject alloc] initWithCanonicalIdentifier:@"mindtickle"];
    
    branchUniversalObject.title = @"MindTickle";
    branchUniversalObject.contentDescription = [NSString stringWithFormat:@"Sales enablement done right!"];
    [branchUniversalObject addMetadataKey:@"access_token" value:token];
    [branchUniversalObject addMetadataKey:@"domain" value:self.domain];
    
    BranchLinkProperties *linkProperties = [[BranchLinkProperties alloc] init];
    
    [branchUniversalObject getShortUrlWithLinkProperties:linkProperties andCallback:^(NSString *urlString, NSError *error) {
        if (!error && urlString) {
            NSLog(@"url is %@", urlString);
            NSURL* url = [NSURL URLWithString:urlString];
            if([[UIApplication sharedApplication] canOpenURL:url]) {
                [[UIApplication sharedApplication] openURL:url];
            }
            else {
                NSLog(@"can not open MindTickle App from url %@", urlString);
            }
        }
    }];
}

@end
