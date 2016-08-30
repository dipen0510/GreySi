//
//  SignUpRequestModal.m
//  GreySi
//
//  Created by Dipen Sekhsaria on 30/08/16.
//  Copyright © 2016 GreyScissors. All rights reserved.
//

#import "SignUpRequestModal.h"

@implementation SignUpRequestModal

@synthesize name,email,password,profilePic,flag;

- (NSMutableDictionary *)createRequestDictionary {
    
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    
    [dict setObject:name forKey:registerNameKey];
    [dict setObject:email forKey:registerEmailKey];
    [dict setObject:password forKey:registerPasswordKey];
    [dict setObject:flag forKey:registerFlagKey];
    [dict setObject:profilePic forKey:registerProfilePiKey];
    [dict setObject:@"Dummy123" forKey:registerPicNameKey];
    [dict setObject:@"1234567890" forKey:registerGCMIdKey];
    [dict setObject:@"2" forKey:registerDeviceTypeKey];
    [dict setObject:@"1.0" forKey:registerVersionCodeKey];
    
    return dict;
}


@end
