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
    return [[self alloc] initWithFrame:frame];
}

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addTarget:self action:@selector(onTap) forControlEvents:UIControlEventTouchUpInside];
        UIImage * buttonImage = [UIImage imageNamed:@"logo"];
        [self setImage:buttonImage forState:UIControlStateNormal];
    }
    return self;
}
- (void) onTap {
    [MindTickleAuth openMindTickle];
}
@end
