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
    return [JWTBuilder encodePayload:@{@"identifier":@{@"email":self.email}, @"domain":self.domain}].secret(self.secretKey).algorithm([JWTAlgorithmFactory algorithmByName:@"RS512"]).encode;
}

- (void) openMindTickle {
    //set branch key
    Branch* br = [Branch getInstance:@"key_live_lptauUbo5oklZUvxxuWgEgplAEjG82fa"];
    
    BranchUniversalObject *branchUniversalObject = [[BranchUniversalObject alloc] initWithCanonicalIdentifier:@"mindtickle"];
    
    branchUniversalObject.title = @"MindTickle";
    branchUniversalObject.contentDescription = [NSString stringWithFormat:@"Sales enablement done right!"];
    [branchUniversalObject addMetadataKey:@"token" value:[self generate]];
    
    BranchLinkProperties *linkProperties = [[BranchLinkProperties alloc] init];
    
    [branchUniversalObject getShortUrlWithLinkProperties:linkProperties andCallback:^(NSString *url, NSError *error) {
        if (!error && url) {
            [[UIApplication sharedApplication] openURL:url];
        }
    }];
}

@end
