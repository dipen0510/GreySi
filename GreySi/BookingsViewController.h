//
//  BookingsViewController.h
//  GreySi
//
//  Created by Dipen Sekhsaria on 20/09/16.
//  Copyright © 2016 GreyScissors. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BookingsViewController : UIViewController <DataSyncManagerDelegate,UIAlertViewDelegate> {
    NSMutableArray* bookingsArr;
    NSString* selectedProjectBookingId;
    NSString* selectedUserId;
}

@property (weak, nonatomic) IBOutlet UITableView *bookingsTblView;


- (IBAction)backButtonTapped:(id)sender;

@end
