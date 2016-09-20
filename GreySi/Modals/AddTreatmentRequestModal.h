//
//  AddTreatmentRequestModal.h
//  GreySi
//
//  Created by Dipen Sekhsaria on 20/09/16.
//  Copyright © 2016 GreyScissors. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AddTreatmentRequestModal : NSObject

@property (nonatomic, strong) NSString* user_id;
@property (nonatomic, strong) NSString* treatment;
@property (nonatomic, strong) NSString* city;
@property (nonatomic, strong) NSString* place;
@property (nonatomic, strong) NSString* date;
@property (nonatomic, strong) NSString* time;
@property (nonatomic, strong) NSString* budget;
@property (nonatomic, strong) NSString* desc;

- (NSMutableDictionary *)createRequestDictionary;

@end
