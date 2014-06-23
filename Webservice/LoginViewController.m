//
//  LoginViewController.m
//  Webservice
//
//  Created by Hanguang on 14-5-25.
//  Copyright (c) 2014年 com.kangge. All rights reserved.
//

#import "LoginViewController.h"
#import "userInfo.h"
#import "ViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    // 生成触摸识别
    UITapGestureRecognizer *tapScreen = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tapScreen];
}
#pragma mark - 键盘事件
// 当触摸屏幕时 判断是否有输入框，如果是，谁是firstresponder 然后resign
- (void)dismissKeyboard
{
    NSArray *subviews = [self.view subviews];
    for (id objInput in subviews){
        if ([objInput isKindOfClass:[UITextField class]]) {
            UITextField *currentTextField = objInput;
            if ([currentTextField isFirstResponder]) {
                [currentTextField resignFirstResponder];
            }
        }
    }
}

#pragma mark - 按钮事件
- (IBAction)loginBt:(id)sender {
    // 初始化AFNetworking
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    // 抓取用户名和密码框的内容
    NSString *name = _userNameTxtField.text;
    NSString *password = _passwordTxtField.text;
    
    // 传递json格式参数
    NSDictionary *parameters = @{@"mobile": name,
                                 @"pass": password};
    
    // 用manager post到网站
    [manager POST:@"http://kongqueling.tupai.cc/api/dologin?" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        
        // 如果成功，加载界面viewcontroller
        ViewController *mainViewController = [[ViewController alloc] init];
        [self presentViewController:mainViewController animated:YES completion:nil];
        
        // 生成NSDATA使用jsonkit转换传递过来的数据
        mainViewController.jsonDic = responseObject;
        
      
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    // 储存uid方便以后调用
    NSUUID *uuid = [[NSUUID alloc] init];
    NSString *uuidKey = [uuid UUIDString];
    [[userInfo sharedObject] saveUid:uuidKey];
    
    NSLog(@"strUid is %@, standardUserDefault is %@",[userInfo sharedObject].strUid,
          [[NSUserDefaults standardUserDefaults] objectForKey:KUid]);
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
