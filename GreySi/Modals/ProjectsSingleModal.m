//
//  ProjectsSingleModal.m
//  GreySi
//
//  Created by Dipen Sekhsaria on 03/09/16.
//  Copyright © 2016 GreyScissors. All rights reserved.
//

#import "ProjectsSingleModal.h"

@implementation ProjectsSingleModal

- (id)initWithDictionary:(NSDictionary *)dictionary {
    self = [self init];
    if (self == nil) return nil;
    
        _budget = dictionary[@"Budget"];
        _city = dictionary[@"City"];
        _date = dictionary[@"Date"];
        _desc = dictionary[@"Description"];
        _hairdresser_id = dictionary[@"Hairdresser_id"];
        _name = dictionary[@"Name"];
        _place = dictionary[@"Place"];
        _post_Date = dictionary[@"Post_Date"];
        _profile_pic = dictionary[@"Profile_pi"];
        _project_id = dictionary[@"Project_id"];
        _status = dictionary[@"Status"];
        _time = dictionary[@"Time"];
        _treatment = dictionary[@"Treatment"];
        _user_id = dictionary[@"User_id"];
        _no_of_bids = dictionary[@"no_of_bids"];
        
    
    return self;
}

@end
