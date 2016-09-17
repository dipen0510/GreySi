//
//  AdSIngleModal.h
//  GreySi
//
//  Created by Dipen Sekhsaria on 17/09/16.
//  Copyright © 2016 GreyScissors. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AdSIngleModal : NSObject

@property (nonatomic, strong) NSString* budget;
@property (nonatomic, strong) NSString* city;
@property (nonatomic, strong) NSString* date;
@property (nonatomic, strong) NSString* desc;
@property (nonatomic, strong) NSString* hairdresser_id;
@property (nonatomic, strong) NSString* place;
@property (nonatomic, strong) NSString* post_Date;
@property (nonatomic, strong) NSString* project_id;
@property (nonatomic, strong) NSString* status;
@property (nonatomic, strong) NSString* time;
@property (nonatomic, strong) NSString* treatment;
@property (nonatomic, strong) NSString* user_id;
@property (nonatomic, strong) NSString* no_of_bids;


- (id)initWithDictionary:(NSDictionary *)dictionary;

@end
