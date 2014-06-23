//
//  ViewController.h
//  Webservice
//
//  Created by Hanguang on 14-5-25.
//  Copyright (c) 2014年 com.kangge. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSONKit.h"
#import "UIImageView+WebCache.h"
#import "AFNetworking.h"

@interface ViewController : UIViewController <NSURLConnectionDataDelegate,NSURLConnectionDelegate, UITableViewDataSource, UITableViewDelegate>
@property NSMutableData *jsonData;
@property NSArray *jsonArray;
@property NSDictionary *jsonDic;

@end
