//
//  MindTickleAuth.m
//  Auth
//
//  Created by hridayesh gupta on 14/10/16.
//  Copyright © 2016 MindTickle. All rights reserved.
//

#import "MindTickleAuth.h"

@interface MindTickleAuth()

@property (nonatomic) NSString* accessKey;
@property (nonatomic) NSString* secretKey;

@end

@implementation MindTickleAuth

- (instancetype)initWithAccessKey:(NSString *)accessKey secretKey:(NSString *)secretKey {
    self = [super init];
    if(self) {
        _accessKey = accessKey;
        _secretKey = secretKey;
    }
    return self;
}

- (NSString*)generateTokenFor:(NSDictionary *)userObject {
    return [NSString stringWithFormat:@"%@ - %@", self.accessKey, self.secretKey];
}

@end
