//
//  PostNewAdViewController.h
//  GreySi
//
//  Created by Dipen Sekhsaria on 10/08/16.
//  Copyright © 2016 GreyScissors. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActionSheetPicker.h"

@interface PostNewAdViewController : UIViewController<DataSyncManagerDelegate> {
    
    NSMutableArray* treatmentOptionsArr;
    NSMutableArray* cityOptionsArr;
    NSMutableArray* selectedTreamentsArr;
    NSString* finalSelectedDate;
    NSString* finalSelectedTime;
    
}

@property (weak, nonatomic) IBOutlet UIView *treatmentTabView;
@property (weak, nonatomic) IBOutlet UIView *platsTabView;
@property (weak, nonatomic) IBOutlet UIView *budgetTabView;



@property (weak, nonatomic) IBOutlet UIButton *treatmentButton;
@property (weak, nonatomic) IBOutlet UIButton *platsButton;
@property (weak, nonatomic) IBOutlet UIButton *budgetButton;
@property (weak, nonatomic) IBOutlet UIButton *selectCityButton;
@property (weak, nonatomic) IBOutlet UIButton *selectDateTimeButton;
@property (weak, nonatomic) IBOutlet UIButton *treatmentTabNextButton;
@property (weak, nonatomic) IBOutlet UIButton *myPlaceButton;
@property (weak, nonatomic) IBOutlet UIButton *yourPlaceButton;
@property (weak, nonatomic) IBOutlet UITextField *budgetTxtField;
@property (weak, nonatomic) IBOutlet UITextField *descriptionTxtField;

@property BOOL isOpenedFromSideMenu;

- (IBAction)treatmentButtonTapped:(id)sender;
- (IBAction)platsButtonTapped:(id)sender;
- (IBAction)budgetButtonTapped:(id)sender;
- (IBAction)selectCityButtonTapped:(id)sender;
- (IBAction)selectDateTimeButtonTapped:(id)sender;
- (IBAction)backButtonTapped:(id)sender;
- (IBAction)treatmentTabNextButtonTapped:(id)sender;
- (IBAction)myPlaceButtonTapped:(id)sender;
- (IBAction)yourPlaceButtonTapped:(id)sender;
- (IBAction)placeTabNextButtonTapped:(id)sender;
- (IBAction)addButtonTapped:(id)sender;


@end
