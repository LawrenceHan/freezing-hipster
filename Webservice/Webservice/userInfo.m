//
//  userInfo.m
//  Webservice
//
//  Created by Hanguang on 14-5-25.
//  Copyright (c) 2014年 com.kangge. All rights reserved.
//

#import "userInfo.h"

@implementation userInfo
static userInfo *sharedUserInfo = nil;

- (void) saveUid: (NSString *)strUid{
    self.strUid = strUid;
    
    [[NSUserDefaults standardUserDefaults] setObject: strUid  forKey:KUid];
	[[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSString *)strUid{
    return [[NSUserDefaults standardUserDefaults] objectForKey:KUid];
}

+ (userInfo *)sharedObject {
    // double check will improve performance
    if (nil == sharedUserInfo) {
        @synchronized(self) {
            if (sharedUserInfo == nil) {
                sharedUserInfo = [[self alloc] init]; //assignment not done here
            }
        }
    }
    
	return sharedUserInfo;
}

@end
