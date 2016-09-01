//
//  SignUpResponseModal.h
//  GreySi
//
//  Created by Dipen Sekhsaria on 01/09/16.
//  Copyright © 2016 GreyScissors. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SignUpResponseModal : NSObject

@property (nonatomic, strong) NSString* available;
@property (nonatomic, strong) NSString* device_Type;
@property (nonatomic, strong) NSString* email;
@property (nonatomic, strong) NSString* fB;
@property (nonatomic, strong) NSString* flag;
@property (nonatomic, strong) NSString* gcm_id;
@property (nonatomic, strong) NSString* long_description;
@property (nonatomic, strong) NSString* name;
@property (nonatomic, strong) NSString* pic_Name;
@property (nonatomic, strong) NSString* profile_pi;
@property (nonatomic, strong) NSString* short_description;
@property (nonatomic, strong) NSString* twitter;
@property (nonatomic, strong) NSString* user_id;
@property (nonatomic, strong) NSString* version_Code;
@property (nonatomic, strong) NSString* website;

- (id)initWithDictionary:(NSDictionary *)dictionary;

@end
