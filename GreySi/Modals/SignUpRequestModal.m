//
//  SignUpRequestModal.m
//  GreySi
//
//  Created by Dipen Sekhsaria on 30/08/16.
//  Copyright © 2016 GreyScissors. All rights reserved.
//

#import "SignUpRequestModal.h"
#import <OneSignal/OneSignal.h>

@implementation SignUpRequestModal

@synthesize name,email,password,profilePic,flag;

- (NSMutableDictionary *)createRequestDictionary {
    
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    
    [dict setObject:name forKey:registerNameKey];
    [dict setObject:email forKey:registerEmailKey];
    [dict setObject:password forKey:registerPasswordKey];
    [dict setObject:flag forKey:registerFlagKey];
    [dict setObject:profilePic forKey:registerProfilePiKey];
    [dict setObject:[[SharedClass sharedInstance] getCurrentUTCFormatDate] forKey:registerPicNameKey];
    
    
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
    
    [dict setObject:@"1234" forKey:@"QB_ID"];
    
    return dict;
}


@end
