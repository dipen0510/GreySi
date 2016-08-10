//
//  PostNewAdViewController.h
//  GreySi
//
//  Created by Dipen Sekhsaria on 10/08/16.
//  Copyright © 2016 GreyScissors. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActionSheetPicker.h"

@interface PostNewAdViewController : UIViewController  {
    
    NSMutableArray* treatmentOptionsArr;
    NSMutableArray* cityOptionsArr;
    
}

@property (weak, nonatomic) IBOutlet UIView *treatmentTabView;
@property (weak, nonatomic) IBOutlet UIView *platsTabView;



@property (weak, nonatomic) IBOutlet UIButton *treatmentButton;
@property (weak, nonatomic) IBOutlet UIButton *platsButton;
@property (weak, nonatomic) IBOutlet UIButton *budgetButton;
@property (weak, nonatomic) IBOutlet UIButton *selectCityButton;
@property (weak, nonatomic) IBOutlet UIButton *selectDateTimeButton;



- (IBAction)treatmentButtonTapped:(id)sender;
- (IBAction)platsButtonTapped:(id)sender;
- (IBAction)budgetButtonTapped:(id)sender;
- (IBAction)selectCityButtonTapped:(id)sender;
- (IBAction)selectDateTimeButtonTapped:(id)sender;
- (IBAction)backButtonTapped:(id)sender;

@end
