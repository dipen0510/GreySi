//
//  LoginRequestModal.h
//  GreySi
//
//  Created by Dipen Sekhsaria on 01/09/16.
//  Copyright © 2016 GreyScissors. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoginRequestModal : NSObject

@property (nonatomic, strong) NSString* email;
@property (nonatomic, strong) NSString* password;

- (NSMutableDictionary *)createRequestDictionary;

@end
