//
//  LoginRequestModal.m
//  GreySi
//
//  Created by Dipen Sekhsaria on 01/09/16.
//  Copyright © 2016 GreyScissors. All rights reserved.
//

#import "LoginRequestModal.h"

@implementation LoginRequestModal

@synthesize email,password;

- (NSMutableDictionary *)createRequestDictionary {
    
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    
    [dict setObject:email forKey:registerEmailKey];
    [dict setObject:password forKey:registerPasswordKey];
    [dict setObject:@"1234567890" forKey:registerGCMIdKey];
    [dict setObject:@"2" forKey:registerDeviceTypeKey];
    [dict setObject:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"] forKey:registerVersionCodeKey];
    
    return dict;
}

@end
