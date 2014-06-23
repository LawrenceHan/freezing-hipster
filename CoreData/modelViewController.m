//
//  modelViewController.m
//  CoreData
//
//  Created by Hanguang on 14-6-8.
//  Copyright (c) 2014年 Big Nerd Ranch. All rights reserved.
//

#import "modelViewController.h"
#import "AFNetworking.h"
#import "BNRAppDelegate.h"
#import "User.h"
#import "ZipArchive.h"

@interface modelViewController () <NSFetchedResultsControllerDelegate>
@property (nonatomic, strong)NSArray *jsonArray;
@property (nonatomic, strong)NSArray *userInfo;
@property (nonatomic, strong)NSMutableArray *userInfoArray;
@property (nonatomic, strong)UITableView *tableview;
@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, strong)UILabel *label;

@end

@implementation modelViewController

#pragma mark - fetchedRequest
- (NSFetchedResultsController *)fetchedResultsController
{
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSManagedObjectContext *managedObjectContext = ((BNRAppDelegate *)[UIApplication sharedApplication].delegate).managedObjectContext;
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"User" inManagedObjectContext:managedObjectContext];
    
    [fetchRequest setEntity:entity];
    
    NSSortDescriptor *sort = [[NSSortDescriptor alloc] initWithKey:@"nickname" ascending:NO];
    
    [fetchRequest setSortDescriptors:[NSArray arrayWithObjects:sort, nil]];
    
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc]
                                                             initWithFetchRequest:fetchRequest
                                                             managedObjectContext:managedObjectContext
                                                             sectionNameKeyPath:nil
                                                             cacheName:@"Root"];
    self.fetchedResultsController = aFetchedResultsController;
    _fetchedResultsController.delegate = self;
    
    return _fetchedResultsController;
}

#pragma mark - 初始化当前modelViewController的view - tableview
// 准备tableview
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        CGRect tabframe = CGRectMake(0, 20, self.view.bounds.size.width, self.view.bounds.size.height);
        _jsonArray = [[NSArray alloc] init];
        _tableview = [[UITableView alloc] initWithFrame:tabframe];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _label = [[UILabel alloc] initWithFrame:self.view.bounds];
        
        
        [self.view addSubview:_tableview];
    }
    return self;
}
#pragma mark - View 生命周期 准备数据 有打NSLog
- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"viewdidload");
    NSString *homePath = NSHomeDirectory();
    // Do any additional setup after loading the view.
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_async(group, queue, ^{
        NSURL * url = [NSURL
                       URLWithString:@"http://www.youai000.com/app/public/103/10010/videos.zip"];
        NSData * data = [[NSData alloc]initWithContentsOfURL:url];
        NSString *path = [homePath stringByAppendingPathComponent:[url lastPathComponent]];
        [data writeToFile:path atomically:YES];
    
        NSLog(@"Thread 1 finished");
    });
    dispatch_group_async(group, queue, ^{
        NSURL * url = [NSURL
                       URLWithString:@"http://www.youai000.com/app/public/103/10009/videos.zip"];
        NSData * data = [[NSData alloc]initWithContentsOfURL:url];
        NSString *path = [homePath stringByAppendingPathComponent:[url lastPathComponent]];
        [data writeToFile:path atomically:YES];
    
        NSLog(@"Thread 2 finished");
    });

    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSLog(@"Back to main Thread");
        if (_label.text) {
            _label.text = @"kangge lower";
        }
        NSLog(@"label color: %@",_label.textColor);
        
        
    });  
//    dispatch_release(group);
    
    //[NSThread detachNewThreadSelector:@selector(downloadVideos)
    //                         toTarget:self withObject:nil];
    

}
//- (void)downloadVideos
//{
//    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
//    AFURLSessionManager *videoDownloader = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
//    
//    NSURL *URL = [NSURL URLWithString:@"http://www.youai000.com/app/public/103/10009/videos.zip"];
//    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
//    
//    NSURLSessionDownloadTask *downloadTask = [videoDownloader downloadTaskWithRequest:request progress:nil destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
//        NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
//        return [documentsDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]];
//    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
//        NSLog(@"File downloaded to: %@ %@", filePath,[filePath path]);
//        NSString *zipFile = [filePath path];
//        NSString *unZipTo = [zipFile stringByReplacingOccurrencesOfString:@".zip" withString:@""];
//        NSLog(@"unzipto %@",[zipFile substringToIndex:[zipFile length] - 4]);
//        
//        ZipArchive* zip = [[ZipArchive alloc] init];
//        
//        if ([zip UnzipOpenFile:zipFile]) {
//            BOOL result = [zip UnzipFileTo:unZipTo overWrite:YES];
//            if (NO == result) {
//                // code
//            }
//            [zip UnzipCloseFile];
//        }
//    }];
//    [downloadTask resume];
// 
//}

// 准备数据
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSLog(@"viewwillappear");
    
    // 查询当前网络状态
    BOOL netStatus;
    netStatus = ((BNRAppDelegate *)[UIApplication sharedApplication].delegate).netOK;
    if (netStatus) {
        // 如果有网络
        // 初始化AFNetworking
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        
        // 用manager post到网站
        [manager GET:@"http://www.youai000.com/app/public/product.json" parameters:nil
             // 如果链接有效则执行下面block
             success:^(AFHTTPRequestOperation *operation, id responseObject) {
                 NSLog(@"JSON: loaded");//,responseObject);
                 // 生成报错对象
                 NSError *error;
                 
                 // 初始化array 使用jsonkit转换传递过来的数据
                 _jsonArray = responseObject;
                 
                 // 生成MOcontext
                 NSManagedObjectContext *context = ((BNRAppDelegate *)[UIApplication sharedApplication].delegate).managedObjectContext;
                 
                 // for循环开始
                 for (int i=0; i < [_jsonArray count]; i++) {
                     NSDictionary *userInfoDic = _jsonArray[i];
                     
                     // 生成数据表查询
                     NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"User"];
                     // 生成查询条件，查用户唯一id
                     fetchRequest.predicate = [NSPredicate predicateWithFormat:@"userid = %@",[userInfoDic objectForKey:@"ID"]];
                     
                     
                     
                     // 查询当前context
                     _userInfo = [context executeFetchRequest:fetchRequest error:&error];
                     // 如果当前本地数据为空，则调用userInfoDic导入数据，如果有
                     // 则更新
                     if ([_userInfo count] > 0) {
                         User *upUser = [_userInfo objectAtIndex:0];
                         upUser.age = [userInfoDic objectForKey:@"age"];
                         upUser.nickname = [userInfoDic objectForKey:@"NickName"];
                         upUser.height = [userInfoDic objectForKey:@"Heigh"];
                         upUser.weight = [userInfoDic objectForKey:@"Weight"];
                         upUser.measure = [userInfoDic objectForKey:@"Measure"];
                         NSLog(@"user is %@", upUser);
                         [context save:&error];
                     }
                     else {
                         // 生成用户数据模型 MO
                         User *addUser = [NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:context];
                         addUser.userid = [userInfoDic objectForKey:@"ID"];
                         addUser.age = [userInfoDic objectForKey:@"age"];
                         addUser.nickname = [userInfoDic objectForKey:@"NickName"];
                         addUser.height = [userInfoDic objectForKey:@"Heigh"];
                         addUser.weight = [userInfoDic objectForKey:@"Weight"];
                         addUser.measure = [userInfoDic objectForKey:@"Measure"];
                         NSLog(@"user is %@", addUser);
                         [context save:&error];
                        
                     }
                 }
                 // for循环结束
                 
                
                // 生成本地查询request查询本地coredata
                 
                // NSFetchRequest *afetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"User"];

                 // 查询fetchRequest.predicate留空为查所有数据
                 
                 
                 
                 // 查询当前context所有对象并保存到NSMutableArray
//                 _userInfoArray = [NSMutableArray arrayWithArray:[context executeFetchRequest:afetchRequest error:&error]];
//                 [_tableview reloadData];
                 
             }
         
             // 如果链接无效则打印报错信息block
             failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                 NSLog(@"Error: %@", error);
             }];
    }
    // 如果没有网络，读取本地文件
    else {
        // 生成本地查询request查询本地coredata
        NSFetchRequest *afetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"User"];
        
        // 生成报错对象
        NSError *error;
        // 查询fetchRequest.predicate留空为查所有数据
        
        // 生成MOcontext
        NSManagedObjectContext *acontext = ((BNRAppDelegate *)[UIApplication sharedApplication].delegate).managedObjectContext;
        
        // 查询当前context所有对象并保存到NSMutableArray
        _userInfoArray = [NSMutableArray arrayWithArray:[acontext executeFetchRequest:afetchRequest error:&error]];
        
        [_tableview reloadData];
        
        //            NSArray *theModelsArray = [((AppDelegate *)[UIApplication sharedApplication].delegate).managedObjectContext executeFetchRequest:fetchRequest error:&error];
    }
    

}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    NSLog(@"viewdidappear");

}

#pragma mark - tableview 当前表格有多少行 回调
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // 查询当前网络状态
//    BOOL netStatus;
//    netStatus = ((BNRAppDelegate *)[UIApplication sharedApplication].delegate).netOK;
//    if (netStatus) {
//        return [_jsonArray count];
//    }
//    else
//        return [_userInfoArray count];
    return [_userInfoArray count];
    
//    id  sectionInfo =
//    [[_fetchedResultsController sections] objectAtIndex:section];
//    return [sectionInfo numberOfObjects];
//    int a = [[self.fetchedResultsController sections] count];
//    return a;
}
#pragma mark - tableview datasource 数据源
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    //User *user = [self.fetchedResultsController objectAtIndexPath:indexPath];
    User *user = _userInfoArray[indexPath.row];
    
    cell.textLabel.text = user.nickname;
    NSString *detail = [NSString stringWithFormat:@"年龄:%@ 身高:%@ 体重:%@ 三围:%@", user.age, user.height, user.weight, user.measure];
    cell.detailTextLabel.text = detail;
    
    return cell;
}

#pragma mark - tableview 编辑状态回调
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
   forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // If the table view is asking to commit a delete command...
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        User *user = _userInfoArray[indexPath.row];
        
        NSManagedObjectContext *acontext = ((BNRAppDelegate *)[UIApplication sharedApplication].delegate).managedObjectContext;
        [acontext deleteObject:user];
        
        [_userInfoArray removeObjectAtIndex:indexPath.row];
        
        // Also remove that row from the table view with an animation
        [tableView deleteRowsAtIndexPaths:@[indexPath]
                         withRowAnimation:UITableViewRowAnimationFade];
        if (![acontext save:nil]) {
            /*
             Replace this implementation with code to handle the error appropriately.
             
             abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
             */
            abort();
        }

        
    }
}

#pragma mark - Others
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
