//
//  AdSIngleModal.m
//  GreySi
//
//  Created by Dipen Sekhsaria on 17/09/16.
//  Copyright © 2016 GreyScissors. All rights reserved.
//

#import "AdSIngleModal.h"

@implementation AdSIngleModal

- (id)initWithDictionary:(NSDictionary *)dictionary {
    self = [self init];
    if (self == nil) return nil;
    
    _aD_ID = dictionary[@"AD_ID"];
    _address = dictionary[@"Address"];
    _average_Rating = dictionary[@"Average_Rating"];
    _budget = dictionary[@"Budget"];
    _lat = dictionary[@"Lat"];
    _longi = dictionary[@"Longi"];
    _name = dictionary[@"Name"];
    _post_date = dictionary[@"Post_date"];
    _profile_pi = dictionary[@"Profile_pi"];
    _short_description = dictionary[@"Short_description"];
    _status = dictionary[@"Status"];
    _treatment = dictionary[@"Treatment"];
    _user_id = dictionary[@"User_id"];
    _hours = dictionary[@"hours"];
    
    return self;
}

@end
