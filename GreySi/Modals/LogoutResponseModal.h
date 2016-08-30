//
//  LogoutResponseObject.h
//  PampersRewards
//
//  Created by Anshul Gupta on 27/11/15.
//  Copyright © 2015 ProcterAndGamble. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LogoutResponseModal : NSObject
@property BOOL success;
@property (nonatomic, strong) NSString* urn;
@property (nonatomic, strong) NSString* onecpId;
@property (nonatomic, strong) NSString* loyaltyId;
@property (nonatomic, strong) NSString* token;
@property (nonatomic, strong) NSString* expiry;
@property BOOL isLegacy;

- (id)initWithDictionary:(NSDictionary *)dictionary;
@end
