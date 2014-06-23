//
//  userInfo.h
//  Webservice
//
//  Created by Hanguang on 14-5-25.
//  Copyright (c) 2014年 com.kangge. All rights reserved.
//

#import <Foundation/Foundation.h>
#define KUid @"uid"
#define KNickName @"nickname"
#define KUserName @"username"
#define KPassword @"password"
#define KUserType @"usertype"
#define KBDUid @"bduid"
#define KBDChannelId @"bdchannelid"
#define KDictUserInfo @"userdicttype"
#define KPriceInfo @"priceinfo"
#define KAlbumId @"aid"
#define KShareInfo @"shareinfo"
#define KMsgNum @"msgNum"
#define KLocation @"cllocation"
#define KCity @"city"

@interface userInfo : NSObject


@property(nonatomic, strong) NSString *strUid;
@property(nonatomic, strong) NSString *strUserName;
@property(nonatomic, strong) NSString *strPassword;
@property(nonatomic, strong) NSString *strNickName;
@property(nonatomic, strong) NSString *strAlbumId;
@property(nonatomic, strong) NSString *strUserType;
@property(nonatomic, strong) NSString *strBDUid;
@property(nonatomic, strong) NSString *strBDChannelId;
@property(nonatomic, strong) NSArray *arrPriceInfo;
@property(nonatomic, strong) NSDictionary *dictUserInfo;
@property(nonatomic, strong) NSDictionary *dictShareInfo;
@property(nonatomic, strong) NSString *strCity;

+ (userInfo *) sharedObject;

- (void) saveUid: (NSString *)strUid;


@end
