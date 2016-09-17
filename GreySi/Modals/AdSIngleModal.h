//
//  AdSIngleModal.h
//  GreySi
//
//  Created by Dipen Sekhsaria on 17/09/16.
//  Copyright © 2016 GreyScissors. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AdSIngleModal : NSObject

@property (nonatomic, strong) NSString* aD_ID;
@property (nonatomic, strong) NSString* address;
@property (nonatomic, strong) NSString* average_Rating;
@property (nonatomic, strong) NSString* budget;
@property (nonatomic, strong) NSString* lat;
@property (nonatomic, strong) NSString* longi;
@property (nonatomic, strong) NSString* name;
@property (nonatomic, strong) NSString* post_date;
@property (nonatomic, strong) NSString* profile_pi;
@property (nonatomic, strong) NSString* short_description;
@property (nonatomic, strong) NSString* status;
@property (nonatomic, strong) NSString* treatment;
@property (nonatomic, strong) NSString* user_id;
@property (nonatomic, strong) NSString* hours;


- (id)initWithDictionary:(NSDictionary *)dictionary;

@end
