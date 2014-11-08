//
//  OverlayScrollView.m
//  IOS8_ScrollView
//
//  Created by Hanguang on 9/29/14.
//  Copyright (c) 2014 Hanguang. All rights reserved.
//

#import "OverlayScrollView.h"

@implementation OverlayScrollView

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView *hitView = [super hitTest:point withEvent:event];
    if (hitView == self) {
        return nil;
    }
    
    return hitView;
}

@end
