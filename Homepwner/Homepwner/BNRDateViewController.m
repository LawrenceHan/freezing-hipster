//
//  BNRDateViewController.m
//  Homepwner
//
//  Created by Hanguang on 14-5-30.
//  Copyright (c) 2014年 Big Nerd Ranch. All rights reserved.
//

#import "BNRDateViewController.h"
#import "BNRItem.h"

@interface BNRDateViewController ()
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

@end

@implementation BNRDateViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // 把传递过来的BNRItem的date显示在datePicker上
    BNRItem *item = self.item;
    _datePicker.date = item.dateCreated;
    NSLog(@"self item date %@",self.item.dateCreated);
    NSLog(@"datepicker %@", _datePicker.date);
}

// 离开界面时 把设置的datePicker日期传递回去
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    BNRItem *item = self.item;
    item.dateCreated = _datePicker.date;
    NSLog(@"self item date %@",self.item.dateCreated);
    NSLog(@"datepicker %@", _datePicker.date);
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"Date Record";
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
