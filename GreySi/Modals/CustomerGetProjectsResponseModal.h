//
//  CustomerGetProjectsResponseModal.h
//  GreySi
//
//  Created by Dipen Sekhsaria on 03/09/16.
//  Copyright © 2016 GreyScissors. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CustomerGetProjectsResponseModal : NSObject

@property (nonatomic, strong) NSMutableArray* info;

- (id)initWithDictionary:(NSDictionary *)dictionary;

@end
