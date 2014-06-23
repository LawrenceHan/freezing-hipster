//
//  BNRDetailViewController.h
//  Homepwner
//
//  Created by Hanguang on 14-5-27.
//  Copyright (c) 2014年 Big Nerd Ranch. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BNRItem;

@interface BNRDetailViewController : UIViewController
@property (nonatomic, strong)BNRItem *item;
@property (nonatomic, copy) void (^dismissBlock)(void);

- (instancetype)initForNewItem:(BOOL)isNew;

@end
