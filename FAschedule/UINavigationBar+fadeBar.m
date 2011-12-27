//
//  UINavigationBar+fadeBar.m
//  FAschedule
//
//  Created by Reed Rosenbluth on 8/26/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "UINavigationBar+fadeBar.h"

@implementation UINavigationBar (fadeBar)

- (void)setTintColor:(UIColor *)tintColor animated:(BOOL)animated {
    if (animated && self.tintColor != tintColor) {
        CATransition *transition = [CATransition animation];
        transition.duration = 0.3;
        transition.timingFunction = [CAMediaTimingFunction
                                     functionWithName:kCAMediaTimingFunctionEaseIn];
        [self.layer addAnimation:transition forKey:nil];
    }
    
    [self setTintColor:tintColor];
}

@end
