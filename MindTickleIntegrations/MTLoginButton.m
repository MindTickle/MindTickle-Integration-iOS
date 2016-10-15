//
//  MTLoginButton.m
//  MindTickleIntegrations
//
//  Created by hridayesh gupta on 14/10/16.
//  Copyright © 2016 MindTickle. All rights reserved.
//

#import "MTLoginButton.h"
#import "MindTickleAuth.h"

@implementation MTLoginButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (id)buttonWithFrame:(CGRect)frame {
    NSLog(@"button with frame");
    return [[self alloc] initWithFrame:frame];
}

- (id) initWithCoder:(NSCoder *)aDecoder {
    NSLog(@"init with coder");
    if (self = [super initWithCoder:aDecoder]) {
        [self addTarget:self action:@selector(onTap) forControlEvents:UIControlEventTouchUpInside];
        UIImage * buttonImage = [UIImage imageNamed:@"mindtickle_logo"];
        [self setBackgroundImage:buttonImage forState:UIControlStateNormal];
        [self setTitle:@"" forState:UIControlStateNormal];
    }
    return self;
}
- (id)initWithFrame:(CGRect)frame {
    NSLog(@"init with frame");
    if (self = [super initWithFrame:frame]) {
        [self addTarget:self action:@selector(onTap) forControlEvents:UIControlEventTouchUpInside];
        UIImage * buttonImage = [UIImage imageNamed:@"mindtickle_logo"];
        [self setBackgroundImage:buttonImage forState:UIControlStateNormal];
        [self setTitle:@"" forState:UIControlStateNormal];
    }
    return self;
}
- (void) onTap {
    [MindTickleAuth openMindTickle];
}
@end
