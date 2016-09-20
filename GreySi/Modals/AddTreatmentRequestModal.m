//
//  AddTreatmentRequestModal.m
//  GreySi
//
//  Created by Dipen Sekhsaria on 20/09/16.
//  Copyright © 2016 GreyScissors. All rights reserved.
//

#import "AddTreatmentRequestModal.h"

@implementation AddTreatmentRequestModal

@synthesize user_id,treatment,city,place,date,time,budget,desc;

- (NSMutableDictionary *)createRequestDictionary {
    
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    
    [dict setObject:user_id forKey:@"User_id"];
    [dict setObject:treatment forKey:@"Treatment"];
    [dict setObject:city forKey:@"City"];
    [dict setObject:place forKey:@"Place"];
    [dict setObject:date forKey:@"Date"];
    [dict setObject:time forKey:@"Time"];
    [dict setObject:budget forKey:@"Budget"];
    [dict setObject:desc forKey:@"Description"];
    
    
    return dict;
}

@end
