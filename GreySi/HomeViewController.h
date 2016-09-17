//
//  HomeViewController.h
//  GreySi
//
//  Created by Dipen Sekhsaria on 30/03/16.
//  Copyright © 2016 GreyScissors. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface HomeViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, DataSyncManagerDelegate> {
    
    NSMutableArray* addContentArr;
    
}

@property (weak, nonatomic) IBOutlet UIButton *revealButtonItem;
@property (weak, nonatomic) IBOutlet UITableView *adsTblView;

- (IBAction)locationButtonTapped:(id)sender;

@end
