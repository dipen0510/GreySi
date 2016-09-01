//
//  SignUpResponseModal.m
//  GreySi
//
//  Created by Dipen Sekhsaria on 01/09/16.
//  Copyright © 2016 GreyScissors. All rights reserved.
//

#import "SignUpResponseModal.h"

@implementation SignUpResponseModal

- (id)initWithDictionary:(NSDictionary *)dictionary {
    self = [self init];
    if (self == nil) return nil;
    
    _available = dictionary[registerAvailableKey];
    _device_Type = dictionary[registerDeviceTypeKey];
    _email = dictionary[registerEmailKey];
    _fB = dictionary[registerFBKey];
    _flag = dictionary[registerFlagKey];
    _gcm_id = dictionary[registerGCMIdKey];
    _long_description = dictionary[registerLongDescriptionKey];
    _name = dictionary[registerNameKey];
    _pic_Name = dictionary[registerPicNameKey];
    _profile_pi = dictionary[registerProfilePiKey];
    _short_description = dictionary[registerShortDescriptionKey];
    _twitter = dictionary[registerTwitterKey];
    _user_id = dictionary[registerUserIdKey];
    _version_Code = dictionary[registerVersionCodeKey];
    _website = dictionary[registerWebsiteKey];

    
    return self;
}

@end
