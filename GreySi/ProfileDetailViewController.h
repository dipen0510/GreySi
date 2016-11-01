//
//  ProfileDetailViewController.h
//  GreySi
//
//  Created by Dipen Sekhsaria on 03/08/16.
//  Copyright © 2016 GreyScissors. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PECropViewController.h"

@interface ProfileDetailViewController : UIViewController<DataSyncManagerDelegate,UIActionSheetDelegate,PECropViewControllerDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate> {
    NSMutableDictionary* responseDict;
    NSMutableArray *reviewArr;
    UIActionSheet* actSheet;
    UIImage* profileImage;
    BOOL isProfileUpdated;
}

@property (weak, nonatomic) IBOutlet UIImageView *profileImgView;
@property (weak, nonatomic) IBOutlet UIButton *chatButton;
@property (weak, nonatomic) IBOutlet UIButton *rateReviewButton;
@property (weak, nonatomic) IBOutlet UILabel *completedProjectsLabel;
@property (weak, nonatomic) IBOutlet UIImageView *firstStarImgView;
@property (weak, nonatomic) IBOutlet UIImageView *secondStarImgView;
@property (weak, nonatomic) IBOutlet UIImageView *thirdStarImgView;
@property (weak, nonatomic) IBOutlet UIImageView *forthStarImgView;
@property (weak, nonatomic) IBOutlet UIImageView *fifthStarImgView;
@property (weak, nonatomic) IBOutlet UILabel *starOutOfProjectsLabel;
@property (weak, nonatomic) IBOutlet UITableView *reviewTblView;
@property (weak, nonatomic) IBOutlet UITableView *socialTblView;

@property (weak, nonatomic) IBOutlet UIButton *editProfileImageButton;
@property (weak, nonatomic) IBOutlet UIButton *editProfileNameButton;
@property (weak, nonatomic) IBOutlet UIButton *editProfileTreatmentButton;
@property (weak, nonatomic) IBOutlet UIButton *editProfileDescriptionButton;
@property (weak, nonatomic) IBOutlet UIButton *editProfileSocialButton;

@property (weak, nonatomic) IBOutlet UITextField *profileNameTxtField;
@property (weak, nonatomic) IBOutlet UITextField *treatmentTxtField;
@property (weak, nonatomic) IBOutlet UITextView *descriptioNTxtField;
@property (weak, nonatomic) IBOutlet UIButton *doneButton;

@property (weak, nonatomic) IBOutlet UIScrollView *contenScrollView;

@property (strong, nonatomic) NSString* userId;

@property BOOL isEditable;
@property BOOL isOpenedFromSideMenu;

- (IBAction)backButtonTapped:(id)sender;
- (IBAction)editProfileImageButtonTapped:(id)sender;
- (IBAction)editProfileNameButtonTapped:(id)sender;
- (IBAction)editProfileTreatmentButtonTapped:(id)sender;
- (IBAction)editProfileDescriptionButtonTapped:(id)sender;
- (IBAction)editProfileSocialButtonTapped:(id)sender;
- (IBAction)doneButtonTapped:(id)sender;
- (IBAction)chatButtonTapped:(id)sender;

@end
