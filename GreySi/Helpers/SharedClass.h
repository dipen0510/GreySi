//
//  SharedClass.h
//  PampersRewards
//
//  Created by Dipen Sekhsaria on 03/11/15.
//  Copyright © 2015 ProcterAndGamble. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "SignUpResponseModal.h"

@interface SharedClass : NSObject {

}

+ sharedInstance;


@property (nonatomic, strong) SignUpResponseModal* userObj;

-(NSDate *)getCurrentUTCFormatDate;
-(NSString* )getCurrentUTCFormatDateString;

- (void)saveData: (NSString*)data ForService:(NSString *)service;
- (NSString*)loadDataForService:(NSString *)service;
- (void)removeServiceData:(NSString *)service;
- (NSMutableDictionary *) getDictionaryFromJSONString:(NSString *)jsonString;

@end
