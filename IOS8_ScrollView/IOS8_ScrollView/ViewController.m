//
//  ViewController.m
//  IOS8_ScrollView
//
//  Created by Hanguang on 9/29/14.
//  Copyright (c) 2014 Hanguang. All rights reserved.
//

#import "ViewController.h"
#import "OverlayScrollView.h"

@interface ViewController ()
@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) UIVisualEffectView *visualEffectView;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    CGRect bounds = self.view.bounds;
    UIView *backgroundView = [[UIView alloc] initWithFrame:bounds];
    backgroundView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backgroundView];
    [self addButtonsInView:backgroundView];
    
    _scrollView = [[OverlayScrollView alloc] initWithFrame:bounds];
    [self.view addSubview:_scrollView];
    
    _visualEffectView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleDark]];
    _visualEffectView.frame = CGRectMake(0, 0, bounds.size.width, 650.0);
    [_scrollView addSubview:_visualEffectView];
    [self addButtonsInView:_visualEffectView];
    
    _scrollView.contentSize = CGSizeMake(bounds.size.width, bounds.size.height + _visualEffectView.frame.size.height);
    _scrollView.contentOffset = CGPointMake(0, _visualEffectView.frame.size.height);
    _scrollView.bounces = NO;
    [self.view addGestureRecognizer:_scrollView.panGestureRecognizer];

    
}

- (void)addButtonsInView:(UIView *)view {
    
    for (int i = 0; i < 20; i++) {
        UIButton *label = [UIButton buttonWithType:UIButtonTypeSystem];
        [label setTitle:@"123" forState:UIControlStateNormal];
        //label.text = @"123";
        // Configure the label's colors and text
        label.backgroundColor = [self randomColor];
        
        [label sizeToFit];
        // Get a random x value that fits the hypnosis view's width
        int width = (int)(view.bounds.size.width - label.bounds.size.width);
        int x = arc4random() % width;
        
        // Get a random y value that fits the hypnosis view's height
        int height = (int)(view.bounds.size.height - label.bounds.size.height);
        int y = arc4random() % height;
        
        // Update the label's frame;
        CGRect frame = label.frame;
        frame.origin = CGPointMake(x, y);
        label.frame = frame;
        
        // Add the label to the hierarchy
        [view addSubview:label];
        
    }
}

- (UIColor *)randomColor {
    float red = (arc4random() % 100) / 100.0;
    float green = (arc4random() % 100) / 100.0;
    float blue = (arc4random() % 100) /100.0;
    
    UIColor *randomColor = [[UIColor alloc] initWithRed:red green:green blue:blue alpha:1.0];
    return randomColor;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
