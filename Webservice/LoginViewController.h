//
//  LoginViewController.h
//  Webservice
//
//  Created by Hanguang on 14-5-25.
//  Copyright (c) 2014年 com.kangge. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFNetworking.h"

@interface LoginViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *userNameTxtField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTxtField;
- (IBAction)loginBt:(id)sender;

@end
