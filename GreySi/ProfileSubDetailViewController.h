//
//  ProfileSubDetailViewController.h
//  GreySi
//
//  Created by Dipen Sekhsaria on 09/08/16.
//  Copyright © 2016 GreyScissors. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfileSubDetailViewController : UIViewController {
    
    NSString* treatmentStr;
    NSString* budgetStr;
    NSMutableArray* budgetArr;
    NSMutableArray* treatmentArr;
    
}

@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UIButton *bookButton;
@property (weak, nonatomic) IBOutlet UIButton *chatButton;
@property (weak, nonatomic) IBOutlet UIButton *priceListButton;
@property (weak, nonatomic) IBOutlet UILabel *profileNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *treatmentLabel;
@property (weak, nonatomic) IBOutlet UILabel *noOfBidsLabel;
@property (weak, nonatomic) IBOutlet UITextView *descriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *myplaceYourPlaceLabel;
@property (weak, nonatomic) IBOutlet UITableView *priceListTblView;

@property (strong, nonatomic) NSMutableDictionary* adDict;

- (IBAction)backButtonTapped:(id)sender;
- (IBAction)bookButtonTapped:(id)sender;
- (IBAction)chatButtonTapped:(id)sender;
- (IBAction)priceListButtonTapped:(id)sender;
- (IBAction)showOnMapButtonTapped:(id)sender;

@end
