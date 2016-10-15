//
//  MindTickleAuth.h
//  Auth
//
//  Created by hridayesh gupta on 14/10/16.
//  Copyright © 2016 MindTickle. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MindTickleAuth : NSObject

+ (void) initWithDomain:(NSString*) domain;
+ (void) initWithDomain:(NSString*) domain accessToken:(NSString*) accessToken;
+ (void) setAccessToken:(NSString*) accessToken;

+ (void) initWithDomain:(NSString*) domain secretKey:(NSString*) secretKey;
+ (void) initWithDomain:(NSString*) domain secretKey:(NSString*) secretKey email:(NSString*) email;
+ (void) setEmail:(NSString*) email;

+ (BOOL) openMindTickle;

@end
