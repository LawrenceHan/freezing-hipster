//
//  ViewController.m
//  TextKitTest
//
//  Created by Hanguang on 3/9/15.
//  Copyright (c) 2015 Hanguang. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *textLabel;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *mainView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.textLabel.text = @"日落时分，沏上一杯山茶，听一曲意境空远的《禅》，心神随此天籁，沉溺于玄妙的幻境里。仿佛我就是那穿梭于葳蕤山林中的一只飞鸟，时而盘旋穿梭，时而引吭高歌；仿佛我就是那潺潺流泻于山涧的一汪清泉，涟漪轻盈，浩淼长流；仿佛我就是那竦峙在天地间的一座山峦，伟岸高耸，从容绵延。我不相信佛，只是喜欢玄冥空灵的梵音经贝，与慈悲淡然的佛境禅心，在清欢中，从容幽静，自在安然。一直向往走进青的山，碧的水，体悟山水的绚丽多姿，领略草木的兴衰荣枯，倾听黄天厚土之声，探寻宇宙自然的妙趣。走进了山水，也就走出了喧嚣，给身心以清凉，给精神以沉淀，给灵魂以升华。";
    
}

- (CGSize)labelSize:(UILabel *)label withText:(NSString *)text {
    CGSize size = [text boundingRectWithSize:CGSizeMake(label.frame.size.width, 0)
                                     options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                  attributes:@{NSFontAttributeName:label.font}
                                     context:nil].size;
    return size;
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    CGRect frame = self.textLabel.frame;
    CGSize size = [self labelSize:_textLabel withText:_textLabel.text];
    self.scrollView.contentSize = CGSizeMake(size.width, size.height + frame.origin.y);
    self.mainView.frame = CGRectMake(self.scrollView.frame.origin.x, self.scrollView.frame.origin.y, self.scrollView.contentSize.width, self.scrollView.contentSize.height);
    [self.view layoutIfNeeded];
    [self.textLabel setFrame:CGRectMake(frame.origin.x, frame.origin.y, size.width, size.height)];
    
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
