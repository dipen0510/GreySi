//
//  SignUpRequestModal.h
//  GreySi
//
//  Created by Dipen Sekhsaria on 30/08/16.
//  Copyright © 2016 GreyScissors. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SignUpRequestModal : NSObject

@property (nonatomic, strong) NSString* name;
@property (nonatomic, strong) NSString* email;
@property (nonatomic, strong) NSString* password;
@property (nonatomic, strong) NSString* flag;
@property (nonatomic, strong) NSString* profilePic;

- (NSMutableDictionary *)createRequestDictionary;

@end
