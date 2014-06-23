//
//  ViewController.m
//  Webservice
//
//  Created by Hanguang on 14-5-25.
//  Copyright (c) 2014年 com.kangge. All rights reserved.
//

#import "ViewController.h"
#import "userInfo.h"
#import "LoginViewController.h"

@interface ViewController ()

@property UITableView *tableView;

@end

@implementation ViewController

// 初始化表格
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    
    //    // 第一步 初始化url
    //    NSURL *testUrl = [[NSURL alloc]
    //                      initWithString:@"http://www.youai000.com/app/public/product.json"];
    //    // 第二步 加载url到 request
    //    NSMutableURLRequest *requestTest = [[NSMutableURLRequest alloc]
    //                                        initWithURL:testUrl
    //                                        cachePolicy:NSURLRequestReloadIgnoringCacheData
    //                                        timeoutInterval:10];
    //
    //    // 第三步 设置requestTest 属性
    //    [requestTest setHTTPMethod:@"GET"];
    //
    //    // 第四步 初始化connection ulr=testurl request = request
    //    NSURLConnection *testConnection = [[NSURLConnection alloc] initWithRequest:requestTest delegate:self];
    //
    //    // 如果链接为真，则分配一个NSMutableDate
    //    if (testConnection) {
    //        _jsonData = [[NSMutableData alloc] init];
    //
    //    }
    //    else {
    //        NSLog(@"hahah");
    //    }
    
    
    //初始化tableview
    CGRect tabRect = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    _tableView = [[UITableView alloc] initWithFrame:tabRect style:UITableViewStyleGrouped];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    
    [self.view addSubview:_tableView];
    
    
}


// 准备数据
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    // 如果用户信息不存在，升起登陆界面
    if ([[userInfo sharedObject].strUid length] == 0){
        LoginViewController *lvc = [[LoginViewController alloc] init];
        [self presentViewController:lvc animated:YES completion:nil];
    }
    // 如果用户有信息，则通过信息读取
    else {
        // 初始化AFNetworking
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        
        // 传递json格式参数
        NSDictionary *parameters = @{@"mobile": @"15618989616",
                                     @"pass": @"111111"};
        
        // 用manager post到网站
        [manager POST:@"http://kongqueling.tupai.cc/api/dologin?"
           parameters:parameters
              success:^(AFHTTPRequestOperation *operation, id responseObject) {
                  NSLog(@"JSON: loaded");//responseObject);
                  
                  // 生成NSDATA使用jsonkit转换传递过来的数据
                  self.jsonDic = responseObject;
                  
                  [_tableView reloadData];
              } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                  NSLog(@"Error: %@", error);
              }];
    }
    
}

//// 接收数据拼装到 _testData
//- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
//{
//    [_testData appendData:data];
//    
//}
//
//// 测试是否接收到response并打印到NSLog
//- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
//    NSLog(@"1 and response is %@",response);
//}
//
//// 链接执行完成后转换json格式从_testdata并转入 _jsonArray
//- (void)connectionDidFinishLoading:(NSURLConnection *)connection
//{
//    NSString *result = [[NSString alloc] initWithData:_testData encoding:NSUTF8StringEncoding];
//    NSLog(@"array is %@", result);
//    _jsonArray = [_testData objectFromJSONData];
//    [_tableView reloadData];
//    
//}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // 经过调查发现，_userInfoDic里有四个对象 code priceInfo share userInfo
    // 怀疑priceInfo是数组，尝试用NSArray解
    NSArray *priceInfoArray = [_jsonDic objectForKey:KPriceInfo];
    NSLog(@"priceInfoArray is %@", priceInfoArray);
    NSDictionary *priceDic = priceInfoArray[indexPath.row];
    
    // 生成 share dic
    NSDictionary *shareDic = [_jsonDic objectForKey:KShareInfo];
    NSLog(@"shareDic is %@", shareDic);
    
    // 生成 userinfo dic
    NSDictionary *userInfoDic= [_jsonDic objectForKey:@"userinfo"];
    NSLog(@"userInfoDic is %@", userInfoDic);
    

    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];

    }
    // 标题
    cell.textLabel.text = [userInfoDic objectForKey:KNickName];
    // 子标题
    //NSString *heigh = [NSString stringWithFormat:@"%@",[userInfoDic objectForKey:@"Heigh"]];
    // 生成子标题string
    NSString *subTitle = [NSString stringWithFormat:@"年龄:%@ 物品价格:%@ 城市:%@",
                          [userInfoDic objectForKey:@"age"],
                          [priceDic objectForKey:@"price"],
                          [userInfoDic objectForKey:@"city"]];
    
    cell.detailTextLabel.text = subTitle;
    
    
    //生成图片网址拼接string
//    NSString *imgDir =[NSString stringWithFormat:@"http://www.youai000.com/app/public/%@list.jpg",[_jsonDic objectForKey:@"Dir"]];
//    NSURL *imgUrl = [[NSURL alloc] initWithString:imgDir];
//    // 添加头像
//    [cell.imageView setImageWithURL:imgUrl placeholderImage:nil];
    
    
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *priceInfoArray = [_jsonDic objectForKey:KPriceInfo];
    return [priceInfoArray count];
    NSLog(@"jsonArry count %i", [priceInfoArray count]);
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loginBt:(id)sender {
}
@end
