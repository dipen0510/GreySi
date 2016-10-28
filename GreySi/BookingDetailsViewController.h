//
//  BookingDetailsViewController.h
//  GreySi
//
//  Created by Dipen Sekhsaria on 10/10/16.
//  Copyright © 2016 GreyScissors. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActionSheetPicker.h"

@interface BookingDetailsViewController : UIViewController<DataSyncManagerDelegate> {
    
    NSMutableArray* selectedTreatmentArr;
    NSString* finalSelectedDate;
    NSString* finalSelectedTime;
    
}

@property (strong, nonatomic) NSString* hairDresserId;
@property (strong, nonatomic) NSMutableArray* treatmentArr;

@property (weak, nonatomic) IBOutlet UITableView *listTblView;
@property (weak, nonatomic) IBOutlet UIButton *selectDateButton;



- (IBAction)backButtonTapped:(id)sender;
- (IBAction)selectDateButtonTapped:(id)sender;
- (IBAction)bookButtonTapped:(id)sender;

@end
