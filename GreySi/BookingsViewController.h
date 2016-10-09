//
//  BookingsViewController.h
//  GreySi
//
//  Created by Dipen Sekhsaria on 20/09/16.
//  Copyright © 2016 GreyScissors. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BookingsViewController : UIViewController <DataSyncManagerDelegate> {
    NSMutableArray* bookingsArr;
    NSString* selectedProjectBookingId;
}

@property (weak, nonatomic) IBOutlet UITableView *bookingsTblView;


- (IBAction)backButtonTapped:(id)sender;

@end
