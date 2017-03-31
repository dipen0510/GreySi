//
//  LoginRequestModal.m
//  GreySi
//
//  Created by Dipen Sekhsaria on 01/09/16.
//  Copyright © 2016 GreyScissors. All rights reserved.
//

#import "LoginRequestModal.h"
#import <OneSignal/OneSignal.h>

@implementation LoginRequestModal

@synthesize email,password;

- (NSMutableDictionary *)createRequestDictionary {
    
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    
    [dict setObject:email forKey:registerEmailKey];
    [dict setObject:password forKey:registerPasswordKey];
    
    [OneSignal IdsAvailable:^(NSString* userId, NSString* pushToken) {
        NSLog(@"UserId:%@", userId);
        if (userId != nil) {
//            NSLog(@"pushToken:%@", pushToken);
            [dict setObject:userId forKey:registerGCMIdKey];
        }
        else {
            [dict setObject:@"1234567890" forKey:registerGCMIdKey];
        }
    }];
    
    
    //    if ([[NSUserDefaults standardUserDefaults] valueForKey:@"kDeviceToken"]) {
    //        [dict setObject:[[NSUserDefaults standardUserDefaults] valueForKey:@"kDeviceToken"] forKey:registerGCMIdKey];
    //    }
    //    else {
    //        [dict setObject:@"1234567890" forKey:registerGCMIdKey];
    //    }
    
    [dict setObject:@"2" forKey:registerDeviceTypeKey];
    [dict setObject:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"] forKey:registerVersionCodeKey];
    
    return dict;
}

@end
