//
//  RewardsSingleModal.h
//  PampersRewards
//
//  Created by Dipen Sekhsaria on 30/06/16.
//  Copyright © 2016 ProcterAndGamble. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RewardsSingleModal : NSObject

@property (nonatomic, strong) NSString* creationDate;
@property (nonatomic, strong) NSString* endDate;
@property (nonatomic, strong) NSString* imageUrl;
@property (nonatomic, strong) NSString* isActive;
@property (nonatomic, strong) NSString* itemId;
@property (nonatomic, strong) NSString* pointsValue;
@property (nonatomic, strong) NSString* rewardCategory;
@property (nonatomic, strong) NSString* rewardId;
@property (nonatomic, strong) NSString* rewardName;
@property (nonatomic, strong) NSString* rewardType;
@property (nonatomic, strong) NSString* rewardUrl;
@property (nonatomic, strong) NSString* shortDescription;
@property (nonatomic, strong) NSString* startDate;


- (id)initWithDictionary:(NSDictionary *)dictionary;

@end
