//
//  DemoMapAnnotation.m
//  Created by Gregory Combs on 11/30/11.
//
//  based on work at https://github.com/grgcombs/MultiRowCalloutAnnotationView
//
//  This work is licensed under the Creative Commons Attribution 3.0 Unported License. 
//  To view a copy of this license, visit http://creativecommons.org/licenses/by/3.0/
//  or send a letter to Creative Commons, 444 Castro Street, Suite 900, Mountain View, California, 94041, USA.
//
//

#import "District.h"
#import "Representative.h"

@implementation District

#pragma mark For Demonstration Purposes

/* Naturally, you should set up your annotation objects as usual, but this demo factory helps distance the cell data from the view controller. */
+ (instancetype)demoAnnotationFactory
{
   return [District districtWithCoordinate:CLLocationCoordinate2DMake(30.274722, -97.740556) title:@"ddd" representatives:nil subtitle:@"Tempsub" budget:@"tempBudget" userImg:@"bluestar"];
}

#pragma mark - The Good Stuff

+ (instancetype)districtWithCoordinate:(CLLocationCoordinate2D)coordinate title:(NSString *)title representatives:(NSArray *)representatives subtitle:(NSString *)subtitle budget:(NSString *)budget userImg:(NSString *)userImg
{
    return [[District alloc] initWithCoordinate:coordinate title:title representatives:representatives subtitle:subtitle budget:budget userImg:userImg];
}

- (instancetype)initWithCoordinate:(CLLocationCoordinate2D)coordinate title:(NSString *)title representatives:(NSArray *)representatives subtitle:(NSString *)subtitle budget:(NSString *)budget userImg:(NSString *)userImg
{
    self = [super init];
    if (self)
    {
        _coordinate = coordinate;
        _title = title;
        _representatives = representatives;
        _subtitle = subtitle;
        _budget = budget;
        _userImg = userImg;
    }
    return self;
}


- (NSArray *)calloutCells
{
    if (!_representatives || [_representatives count] == 0)
        return nil;
    return [self valueForKeyPath:@"representatives.calloutCell"];
}

- (NSString *)subtitle
{
    return _subtitle;
}

- (NSString *)budget
{
    return _budget;
}

- (NSString *)userImg
{
    return _userImg;
}

@end
