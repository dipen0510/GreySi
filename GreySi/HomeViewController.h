//
//  HomeViewController.h
//  GreySi
//
//  Created by Dipen Sekhsaria on 30/03/16.
//  Copyright © 2016 GreyScissors. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "FiltersViewController.h"
#import "District.h"
#import "GenericPinAnnotationView.h"
#import "MultiRowCalloutAnnotationView.h"
#import "MultiRowAnnotation.h"
#import "CKRadialMenu.h"


@interface HomeViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, DataSyncManagerDelegate, FiltersViewDelegate, MKMapViewDelegate,CKRadialMenuDelegate> {
    
    NSMutableArray* addContentArr;
    NSMutableArray* filteredAddContentArr;
    long selectedIndex;
    NSString* treatmentStr;
    NSString* budgetStr;
    NSMutableArray* budgetArr;
    NSMutableArray* treatmentArr;
    NSMutableArray* newAdArr;
    
}

@property (weak, nonatomic) IBOutlet UIButton *revealButtonItem;
@property (weak, nonatomic) IBOutlet UITableView *adsTblView;
@property (weak, nonatomic) IBOutlet UIButton *addButton;

- (IBAction)locationButtonTapped:(id)sender;
- (IBAction)addButtonTapped:(id)sender;
- (IBAction)filterButtonTapped:(id)sender;

@end
