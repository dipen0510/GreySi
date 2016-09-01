//
//  SharedClass.m
//  PampersRewards
//
//  Created by Dipen Sekhsaria on 03/11/15.
//  Copyright © 2015 ProcterAndGamble. All rights reserved.
//

#import "SharedClass.h"

@implementation SharedClass

@synthesize userObj;

static SharedClass *singletonObject = nil;

+ (id)sharedInstance {
    //static MyManager *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        singletonObject = [[self alloc] init];
    });
    return singletonObject;
}



- (id)init
{
    if (! singletonObject) {
        
        singletonObject = [super init];
        // Uncomment the following line to see how many times is the init method of the class is called
        // //NSLog(@"%s", __PRETTY_FUNCTION__);
    }
    return singletonObject;
}

#pragma mark - Calendar helpers

-(NSDate* )getCurrentUTCFormatDate
{
    
    NSDate* localDate = [NSDate date];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
    [dateFormatter setTimeZone:timeZone];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateString = [dateFormatter stringFromDate:localDate];
    
    NSDate* utcDate = [dateFormatter dateFromString:dateString];
    
    return utcDate;
}

-(NSString* )getCurrentUTCFormatDateString
{
    
    NSDate* localDate = [NSDate date];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
    [dateFormatter setTimeZone:timeZone];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateString = [dateFormatter stringFromDate:localDate];
    
    return dateString;
}

@end
