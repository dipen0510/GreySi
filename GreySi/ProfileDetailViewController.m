//
//  ProfileDetailViewController.m
//  GreySi
//
//  Created by Dipen Sekhsaria on 03/08/16.
//  Copyright © 2016 GreyScissors. All rights reserved.
//

#import "ProfileDetailViewController.h"
#import "ProfileSocialTableViewCell.h"
#import "ProfileReviewTableViewCell.h"
#import "RateViewController.h"

@interface ProfileDetailViewController ()

@end

@implementation ProfileDetailViewController

@synthesize userId,adDict;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupUI];
    [self startGetProfileInfoService];
    
}

- (void) setupUI {
    
    reviewArr = [[NSMutableArray alloc] init];
    
    self.profileImgView.layer.masksToBounds = YES;
    self.profileImgView.layer.cornerRadius = self.profileImgView.frame.size.height/2.;
    self.chatButton.layer.cornerRadius = 2.0;
    self.rateReviewButton.layer.cornerRadius = 2.0;
    
    self.socialTblView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.reviewTblView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
}

- (void) updateUIAfterAPISuccess {
    
    [self updateReviewStarUI];
    
    NSMutableDictionary* infoDict = [[NSMutableDictionary alloc] initWithDictionary:[[responseDict valueForKey:@"info"] objectAtIndex:0]];
    reviewArr = [[NSMutableArray alloc] initWithArray:[responseDict valueForKey:@"Reviews"]];
    
    self.profileNameLabel.text = [infoDict valueForKey:@"Name"];
    self.treatmentLabel.text = [infoDict valueForKey:@"Short_description"];
    self.completedProjectsLabel.text = [NSString stringWithFormat:@"Completed Projects : %@",[responseDict valueForKey:@"completed_projects"]];
    self.starOutOfProjectsLabel.text = [NSString stringWithFormat:@"%0.2f star from %@ projects",[[responseDict valueForKey:@"average_rating"] floatValue],[responseDict valueForKey:@"completed_projects"]];
    self.descriptionLabel.text = [infoDict valueForKey:@"Long_description"];
    
    __weak UIImageView* weakImageView = self.profileImgView;
    [self.profileImgView setImageWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[infoDict[@"Profile_pi"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]
                                                                   cachePolicy:NSURLRequestReturnCacheDataElseLoad
                                                               timeoutInterval:60.0] placeholderImage:[UIImage imageNamed:@"blankProfile"] success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
        
        
        weakImageView.alpha = 0.0;
        weakImageView.image = image;
        [UIView animateWithDuration:0.25
                         animations:^{
                             weakImageView.alpha = 1.0;
                         }];
    } failure:NULL];
    
    [self.reviewTblView reloadData];
    [self.socialTblView reloadData];
    
}

- (void) updateReviewStarUI {
    
    double avgRating = [[responseDict valueForKey:@"average_rating"] doubleValue];
    
    if (avgRating>=0.5 && avgRating < 1.0) {
        self.firstStarImgView.image = [UIImage imageNamed:@"feedback_ratinghalf.png"];
    }
    else if (avgRating>=1.0 && avgRating < 1.5) {
        self.firstStarImgView.image = [UIImage imageNamed:@"feedback_rating_full.png"];
    }
    else if (avgRating>=1.5 && avgRating < 2.0) {
        self.firstStarImgView.image = [UIImage imageNamed:@"feedback_rating_full.png"];
        self.secondStarImgView.image = [UIImage imageNamed:@"feedback_ratinghalf.png"];
    }
    else if (avgRating>=2.0 && avgRating < 2.5) {
        self.firstStarImgView.image = [UIImage imageNamed:@"feedback_rating_full.png"];
        self.secondStarImgView.image = [UIImage imageNamed:@"feedback_rating_full.png"];
    }
    else if (avgRating>=2.5 && avgRating < 3.0) {
        self.firstStarImgView.image = [UIImage imageNamed:@"feedback_rating_full.png"];
        self.secondStarImgView.image = [UIImage imageNamed:@"feedback_rating_full.png"];
        self.thirdStarImgView.image = [UIImage imageNamed:@"feedback_ratinghalf.png"];
    }
    else if (avgRating>=3.0 && avgRating < 3.5) {
        self.firstStarImgView.image = [UIImage imageNamed:@"feedback_rating_full.png"];
        self.secondStarImgView.image = [UIImage imageNamed:@"feedback_rating_full.png"];
        self.thirdStarImgView.image = [UIImage imageNamed:@"feedback_rating_full.png"];
    }
    else if (avgRating>=3.5 && avgRating < 4.0) {
        self.firstStarImgView.image = [UIImage imageNamed:@"feedback_rating_full.png"];
        self.secondStarImgView.image = [UIImage imageNamed:@"feedback_rating_full.png"];
        self.thirdStarImgView.image = [UIImage imageNamed:@"feedback_rating_full.png"];
        self.forthStarImgView.image = [UIImage imageNamed:@"feedback_ratinghalf.png"];
    }
    else if (avgRating>=4.0 && avgRating < 4.5) {
        self.firstStarImgView.image = [UIImage imageNamed:@"feedback_rating_full.png"];
        self.secondStarImgView.image = [UIImage imageNamed:@"feedback_rating_full.png"];
        self.thirdStarImgView.image = [UIImage imageNamed:@"feedback_rating_full.png"];
        self.forthStarImgView.image = [UIImage imageNamed:@"feedback_rating_full.png"];
    }
    else if (avgRating>=4.5 && avgRating < 5.0) {
        self.firstStarImgView.image = [UIImage imageNamed:@"feedback_rating_full.png"];
        self.secondStarImgView.image = [UIImage imageNamed:@"feedback_rating_full.png"];
        self.thirdStarImgView.image = [UIImage imageNamed:@"feedback_rating_full.png"];
        self.forthStarImgView.image = [UIImage imageNamed:@"feedback_rating_full.png"];
        self.fifthStarImgView.image = [UIImage imageNamed:@"feedback_ratinghalf.png"];
    }
    else if (avgRating>=5.0) {
        self.firstStarImgView.image = [UIImage imageNamed:@"feedback_rating_full.png"];
        self.secondStarImgView.image = [UIImage imageNamed:@"feedback_rating_full.png"];
        self.thirdStarImgView.image = [UIImage imageNamed:@"feedback_rating_full.png"];
        self.forthStarImgView.image = [UIImage imageNamed:@"feedback_rating_full.png"];
        self.fifthStarImgView.image = [UIImage imageNamed:@"feedback_rating_full.png"];
    }
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([segue.identifier isEqualToString:@"ratePushSegue"]) {
        
        RateViewController* controller = (RateViewController *)[segue destinationViewController];
        controller.adDict = adDict;
        
    }
    
}


- (IBAction)backButtonTapped:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - UITableView Datasource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (tableView == _socialTblView) {
        return 3;
    }
    
    return reviewArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView == _socialTblView) {
        NSString* identifier = @"ProfileSocialTableViewCell";
        ProfileSocialTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        
        if (cell == nil) {
            NSArray *nib=[[NSBundle mainBundle] loadNibNamed:@"ProfileSocialTableViewCell" owner:self options:nil];
            cell=[nib objectAtIndex:0];
        }
        
        
        [self displayContentForSocialCell:cell atIndexPath:indexPath];
        
        return cell;
        
    }
    
    NSString* identifier = @"ProfileReviewTableViewCell";
    ProfileReviewTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        NSArray *nib=[[NSBundle mainBundle] loadNibNamed:@"ProfileReviewTableViewCell" owner:self options:nil];
        cell=[nib objectAtIndex:0];
    }
    
    
    [self displayContentForReviewCell:cell atIndexPath:indexPath];
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == _socialTblView) {
        return 25;
    }
    return 80.0;
}

#pragma mark - UITableView Delegate -
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    
}

- (void) displayContentForSocialCell:(ProfileSocialTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    
    if (responseDict.count>0) {
        if (indexPath.row == 0) {
            cell.imgView.image = [UIImage imageNamed:@"fb_logo.png"];
            cell.headingLabel.text = [[[responseDict valueForKey:@"info"] objectAtIndex:0] valueForKey:@"FB"];
        }
        else if (indexPath.row == 1) {
            cell.imgView.image = [UIImage imageNamed:@"insta_logo.png"];
            cell.headingLabel.text = [[[responseDict valueForKey:@"info"] objectAtIndex:0] valueForKey:@"Twitter"];
        }
        else if (indexPath.row == 2) {
            cell.imgView.image = [UIImage imageNamed:@"web_logo.png"];
            cell.headingLabel.text = [[[responseDict valueForKey:@"info"] objectAtIndex:0] valueForKey:@"Website"];
        }
    }
    
    
    
    
}

- (void) displayContentForReviewCell:(ProfileReviewTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    
    if (responseDict.count>0) {
        NSMutableDictionary* dict = [[NSMutableDictionary alloc] initWithDictionary:[[responseDict valueForKey:@"Reviews"] objectAtIndex:indexPath.row]];
        
        cell.headingLabel.text = dict[@"Name"];
        cell.subHeadingLabel.text = dict[@"Review"];
        
        
        __weak UIImageView* weakImageView = cell.imgView;
        [cell.imgView setImageWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[dict[@"Profile_pi"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]
                                                              cachePolicy:NSURLRequestReturnCacheDataElseLoad
                                                          timeoutInterval:60.0] placeholderImage:[UIImage imageNamed:@"blankProfile"] success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
            
            
            weakImageView.alpha = 0.0;
            weakImageView.image = image;
            [UIView animateWithDuration:0.25
                             animations:^{
                                 weakImageView.alpha = 1.0;
                             }];
        } failure:NULL];
        
        double avgRating = [[dict valueForKey:@"Rating"] doubleValue];
        
        if (avgRating>=0.5 && avgRating < 1.0) {
            cell.firstStarImgView.image = [UIImage imageNamed:@"feedback_ratinghalf.png"];
        }
        else if (avgRating>=1.0 && avgRating < 1.5) {
            cell.firstStarImgView.image = [UIImage imageNamed:@"feedback_rating_full.png"];
        }
        else if (avgRating>=1.5 && avgRating < 2.0) {
            cell.firstStarImgView.image = [UIImage imageNamed:@"feedback_rating_full.png"];
            cell.secondStarImgView.image = [UIImage imageNamed:@"feedback_ratinghalf.png"];
        }
        else if (avgRating>=2.0 && avgRating < 2.5) {
            cell.firstStarImgView.image = [UIImage imageNamed:@"feedback_rating_full.png"];
            cell.secondStarImgView.image = [UIImage imageNamed:@"feedback_rating_full.png"];
        }
        else if (avgRating>=2.5 && avgRating < 3.0) {
            cell.firstStarImgView.image = [UIImage imageNamed:@"feedback_rating_full.png"];
            cell.secondStarImgView.image = [UIImage imageNamed:@"feedback_rating_full.png"];
            cell.thirdStarImgView.image = [UIImage imageNamed:@"feedback_ratinghalf.png"];
        }
        else if (avgRating>=3.0 && avgRating < 3.5) {
            cell.firstStarImgView.image = [UIImage imageNamed:@"feedback_rating_full.png"];
            cell.secondStarImgView.image = [UIImage imageNamed:@"feedback_rating_full.png"];
            cell.thirdStarImgView.image = [UIImage imageNamed:@"feedback_rating_full.png"];
        }
        else if (avgRating>=3.5 && avgRating < 4.0) {
            cell.firstStarImgView.image = [UIImage imageNamed:@"feedback_rating_full.png"];
            cell.secondStarImgView.image = [UIImage imageNamed:@"feedback_rating_full.png"];
            cell.thirdStarImgView.image = [UIImage imageNamed:@"feedback_rating_full.png"];
            cell.forthStarImgView.image = [UIImage imageNamed:@"feedback_ratinghalf.png"];
        }
        else if (avgRating>=4.0 && avgRating < 4.5) {
            cell.firstStarImgView.image = [UIImage imageNamed:@"feedback_rating_full.png"];
            cell.secondStarImgView.image = [UIImage imageNamed:@"feedback_rating_full.png"];
            cell.thirdStarImgView.image = [UIImage imageNamed:@"feedback_rating_full.png"];
            cell.forthStarImgView.image = [UIImage imageNamed:@"feedback_rating_full.png"];
        }
        else if (avgRating>=4.5 && avgRating < 5.0) {
            cell.firstStarImgView.image = [UIImage imageNamed:@"feedback_rating_full.png"];
            cell.secondStarImgView.image = [UIImage imageNamed:@"feedback_rating_full.png"];
            cell.thirdStarImgView.image = [UIImage imageNamed:@"feedback_rating_full.png"];
            cell.forthStarImgView.image = [UIImage imageNamed:@"feedback_rating_full.png"];
            cell.fifthStarImgView.image = [UIImage imageNamed:@"feedback_ratinghalf.png"];
        }
        else if (avgRating>=5.0) {
            cell.firstStarImgView.image = [UIImage imageNamed:@"feedback_rating_full.png"];
            cell.secondStarImgView.image = [UIImage imageNamed:@"feedback_rating_full.png"];
            cell.thirdStarImgView.image = [UIImage imageNamed:@"feedback_rating_full.png"];
            cell.forthStarImgView.image = [UIImage imageNamed:@"feedback_rating_full.png"];
            cell.fifthStarImgView.image = [UIImage imageNamed:@"feedback_rating_full.png"];
        }
    }
    
}


#pragma mark - API Helpers

- (void) startGetProfileInfoService {
    
    [SVProgressHUD showWithStatus:@"Fetching Profile Info..."];
    
    DataSyncManager* manager = [[DataSyncManager alloc] init];
    manager.serviceKey = [NSString stringWithFormat:@"%@%@",kGetProfileInfo,userId];
    manager.delegate = self;
    [manager startGETWebServices];
    
}

#pragma mark - DATASYNCMANAGER Delegates

-(void) didFinishServiceWithSuccess:(id)responseData andServiceKey:(NSString *)requestServiceKey {
    
    
    if ([requestServiceKey containsString:kGetProfileInfo]) {
        
        [SVProgressHUD showSuccessWithStatus:@"Profile Details fetched succesfully"];
        responseDict = [[NSMutableDictionary alloc] initWithDictionary:responseData];
        [self updateUIAfterAPISuccess];
        
    }
    
    
    
}


- (void) didFinishServiceWithFailure:(NSString *)errorMsg {
    
    
    [SVProgressHUD dismiss];
    UIAlertView* alert=[[UIAlertView alloc] initWithTitle:nil
                                                  message:NSLocalizedString(@"An issue occured while processing your request. Please try again later.", nil)
                                                 delegate:self
                                        cancelButtonTitle:NSLocalizedString(@"OK", nil)
                                        otherButtonTitles: nil];
    
    if (![errorMsg isEqualToString:@""]) {
        [alert setMessage:errorMsg];
    }
    
    if ([errorMsg isEqualToString:NSLocalizedString(@"Verify your internet connection and try again", nil)]) {
        [alert setTitle:NSLocalizedString(@"Connection unsuccessful", nil)];
    }

    
    [alert show];
    
    return;
    
}

@end
