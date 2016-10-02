//
//  ProfileDetailViewController.h
//  GreySi
//
//  Created by Dipen Sekhsaria on 03/08/16.
//  Copyright © 2016 GreyScissors. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfileDetailViewController : UIViewController<DataSyncManagerDelegate> {
    NSMutableDictionary* responseDict;
    NSMutableArray *reviewArr;
}

@property (weak, nonatomic) IBOutlet UIImageView *profileImgView;
@property (weak, nonatomic) IBOutlet UIButton *chatButton;
@property (weak, nonatomic) IBOutlet UIButton *rateReviewButton;
@property (weak, nonatomic) IBOutlet UILabel *profileNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *treatmentLabel;
@property (weak, nonatomic) IBOutlet UILabel *completedProjectsLabel;
@property (weak, nonatomic) IBOutlet UIImageView *firstStarImgView;
@property (weak, nonatomic) IBOutlet UIImageView *secondStarImgView;
@property (weak, nonatomic) IBOutlet UIImageView *thirdStarImgView;
@property (weak, nonatomic) IBOutlet UIImageView *forthStarImgView;
@property (weak, nonatomic) IBOutlet UIImageView *fifthStarImgView;
@property (weak, nonatomic) IBOutlet UILabel *starOutOfProjectsLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UITableView *reviewTblView;
@property (weak, nonatomic) IBOutlet UITableView *socialTblView;

@property (strong, nonatomic) NSString* userId;

- (IBAction)backButtonTapped:(id)sender;

@end
