//
//  CustomerGetProjectsResponseModal.m
//  GreySi
//
//  Created by Dipen Sekhsaria on 03/09/16.
//  Copyright © 2016 GreyScissors. All rights reserved.
//

#import "CustomerGetProjectsResponseModal.h"

@implementation CustomerGetProjectsResponseModal

- (id)initWithDictionary:(NSDictionary *)dictionary {
    self = [self init];
    if (self == nil) return nil;
    
    _info = dictionary[customerProjectsInfoKey];
    
    
    return self;
}

@end
