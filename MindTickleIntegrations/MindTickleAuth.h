//
//  MindTickleAuth.h
//  Auth
//
//  Created by hridayesh gupta on 14/10/16.
//  Copyright © 2016 MindTickle. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MindTickleAuth : NSObject

- (instancetype)initWithDomain:(NSString *)domain email:(NSString*) email;
- (instancetype) initWithDomain:(NSString*) accessKey secretKey:(NSString*) secretKey email:(NSString*) email;

- (void) openMindTickle;

@end
