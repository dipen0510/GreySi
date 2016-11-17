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
#import "HomeViewController.h"
#import "LoginRequestModal.h"

@interface ProfileDetailViewController ()

@end

@implementation ProfileDetailViewController

@synthesize userId,isEditable,isOpenedFromSideMenu;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupUI];
    [self startGetProfileInfoService];
    [self setupActionSheet];
    
}

- (void) setupUI {
    
    reviewArr = [[NSMutableArray alloc] init];
    
    self.profileImgView.layer.masksToBounds = YES;
    self.profileImgView.layer.cornerRadius = self.profileImgView.frame.size.height/2.;
    self.chatButton.layer.cornerRadius = 2.0;
    self.rateReviewButton.layer.cornerRadius = 2.0;
    
    profileImage = self.profileImgView.image;
    
    self.editProfileImageButton.layer.cornerRadius = self.editProfileImageButton.frame.size.height/2.;
    
    self.socialTblView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.reviewTblView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    if (isEditable) {
        _editProfileImageButton.hidden = NO;
        _editProfileNameButton.hidden = NO;
        _editProfileTreatmentButton.hidden = NO;
        _editProfileDescriptionButton.hidden = NO;
        _editProfileSocialButton.hidden = NO;
    }
    else {
        _editProfileImageButton.hidden = YES;
        _editProfileNameButton.hidden = YES;
        _editProfileTreatmentButton.hidden = YES;
        _editProfileDescriptionButton.hidden = YES;
        _editProfileSocialButton.hidden = YES;
    }
    if (isOpenedFromSideMenu) {
        self.chatButton.hidden = YES;
    }
    else {
        self.chatButton.hidden = NO;
    }
    
}

- (void) updateUIAfterAPISuccess {
    
    [self updateReviewStarUI];
    
    NSMutableDictionary* infoDict = [[NSMutableDictionary alloc] initWithDictionary:[[responseDict valueForKey:@"info"] objectAtIndex:0]];
    reviewArr = [[NSMutableArray alloc] initWithArray:[responseDict valueForKey:@"Reviews"]];
    
    self.profileNameTxtField.text = [infoDict valueForKey:@"Name"];
    self.treatmentTxtField.text = [infoDict valueForKey:@"Short_description"];
    self.completedProjectsLabel.text = [NSString stringWithFormat:@"Completed Projects : %@",[responseDict valueForKey:@"completed_projects"]];
    self.starOutOfProjectsLabel.text = [NSString stringWithFormat:@"%0.2f star from %@ projects",[[responseDict valueForKey:@"average_rating"] floatValue],[responseDict valueForKey:@"completed_projects"]];
    self.descriptioNTxtField.text = [infoDict valueForKey:@"Long_description"];
    
    __weak UIImageView* weakImageView = self.profileImgView;
    [self.profileImgView setImageWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[infoDict[@"Profile_pi"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]
                                                                   cachePolicy:NSURLRequestReturnCacheDataElseLoad
                                                               timeoutInterval:60.0] placeholderImage:[UIImage imageNamed:@"blankProfile"] success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
        
        
        weakImageView.alpha = 0.0;
        weakImageView.image = image;
        profileImage = image;
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
        
//        RateViewController* controller = (RateViewController *)[segue destinationViewController];
//        controller.adDict = adDict;
//        
    }
    
}


- (IBAction)backButtonTapped:(id)sender {
    if (isOpenedFromSideMenu) {
        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
        HomeViewController* controller = (HomeViewController*)[mainStoryboard instantiateViewControllerWithIdentifier:@"homeViewController"];
        [self.revealViewController setFrontViewController:controller animated:YES];
    }
    else
        [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)editProfileImageButtonTapped:(id)sender {
    
    if ([actSheet isVisible]) {
        [actSheet dismissWithClickedButtonIndex:0 animated:YES];
    }
    else {
        [actSheet showInView:self.view];
    }
    
}

- (IBAction)editProfileNameButtonTapped:(id)sender {
    
    self.doneButton.hidden = NO;
    _editProfileImageButton.hidden = YES;
    _editProfileNameButton.hidden = YES;
    _editProfileTreatmentButton.hidden = YES;
    _editProfileDescriptionButton.hidden = YES;
    _editProfileSocialButton.hidden = YES;
    self.profileNameTxtField.userInteractionEnabled = YES;
    [self.profileNameTxtField becomeFirstResponder];
    
    [self.contenScrollView setContentInset:UIEdgeInsetsMake(0, 0, 224, 0)];
}

- (IBAction)editProfileTreatmentButtonTapped:(id)sender {
    
    self.doneButton.hidden = NO;
    _editProfileImageButton.hidden = YES;
    _editProfileNameButton.hidden = YES;
    _editProfileTreatmentButton.hidden = YES;
    _editProfileDescriptionButton.hidden = YES;
    _editProfileSocialButton.hidden = YES;
    self.treatmentTxtField.userInteractionEnabled = YES;
    [self.treatmentTxtField becomeFirstResponder];
    
    [self.contenScrollView setContentInset:UIEdgeInsetsMake(0, 0, 224, 0)];
}

- (IBAction)editProfileDescriptionButtonTapped:(id)sender {
    
    self.doneButton.hidden = NO;
    _editProfileImageButton.hidden = YES;
    _editProfileNameButton.hidden = YES;
    _editProfileTreatmentButton.hidden = YES;
    _editProfileDescriptionButton.hidden = YES;
    _editProfileSocialButton.hidden = YES;
    self.descriptioNTxtField.userInteractionEnabled = YES;
    [self.descriptioNTxtField becomeFirstResponder];
    
    [self.contenScrollView setContentInset:UIEdgeInsetsMake(0, 0, 224, 0)];
}

- (IBAction)editProfileSocialButtonTapped:(id)sender {
    
    self.doneButton.hidden = NO;
    _editProfileImageButton.hidden = YES;
    _editProfileNameButton.hidden = YES;
    _editProfileTreatmentButton.hidden = YES;
    _editProfileDescriptionButton.hidden = YES;
    _editProfileSocialButton.hidden = YES;
    
    ProfileSocialTableViewCell* fbCell = [[_socialTblView visibleCells] objectAtIndex:0];
    ProfileSocialTableViewCell* twitterCell = [[_socialTblView visibleCells] objectAtIndex:1];
    ProfileSocialTableViewCell* WebCell = [[_socialTblView visibleCells] objectAtIndex:2];
    
    fbCell.headingTxtField.userInteractionEnabled = YES;
    twitterCell.headingTxtField.userInteractionEnabled = YES;
    WebCell.headingTxtField.userInteractionEnabled = YES;
    
    [fbCell.headingTxtField becomeFirstResponder];
    
    [self.contenScrollView setContentInset:UIEdgeInsetsMake(0, 0, 224, 0)];
    
    [self.contenScrollView scrollRectToVisible:CGRectMake(self.contenScrollView.contentSize.width - 1,self.contenScrollView.contentSize.height - 1, 1, 1) animated:YES];
    
}

- (IBAction)doneButtonTapped:(id)sender {
    
    self.doneButton.hidden = YES;
    _editProfileImageButton.hidden = NO;
    _editProfileNameButton.hidden = NO;
    _editProfileTreatmentButton.hidden = NO;
    _editProfileDescriptionButton.hidden = NO;
    _editProfileSocialButton.hidden = NO;
    
    [self.view endEditing:YES];
    self.profileNameTxtField.userInteractionEnabled = NO;
    self.treatmentTxtField.userInteractionEnabled = NO;
    self.descriptioNTxtField.userInteractionEnabled = NO;
    
    ProfileSocialTableViewCell* fbCell = [[_socialTblView visibleCells] objectAtIndex:0];
    ProfileSocialTableViewCell* twitterCell = [[_socialTblView visibleCells] objectAtIndex:1];
    ProfileSocialTableViewCell* WebCell = [[_socialTblView visibleCells] objectAtIndex:2];
    
    fbCell.headingTxtField.userInteractionEnabled = NO;
    twitterCell.headingTxtField.userInteractionEnabled = NO;
    WebCell.headingTxtField.userInteractionEnabled = NO;
    
    [self.contenScrollView setContentInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    
    [self startUpdatetProfileInfoService];
    
}

- (IBAction)chatButtonTapped:(id)sender {
    
    NSMutableDictionary* infoDict = [[NSMutableDictionary alloc] initWithDictionary:[[responseDict valueForKey:@"info"] objectAtIndex:0]];
    
    if (infoDict.count>0) {
        NSString * userIdOfReceiver =  infoDict[@"Email"];
        [[[SharedClass sharedInstance] chatManager] launchChatForUserWithDisplayName:userIdOfReceiver
                                                                         withGroupId:nil  //If launched for group, pass groupId(pass userId as nil)
                                                                  andwithDisplayName:nil //Not mendatory, if receiver is not already registered you should pass Displayname.
                                                               andFromViewController:self];
    }

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
        return 30;
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
            cell.headingTxtField.text = [[[responseDict valueForKey:@"info"] objectAtIndex:0] valueForKey:@"FB"];
        }
        else if (indexPath.row == 1) {
            cell.imgView.image = [UIImage imageNamed:@"insta_logo.png"];
            cell.headingTxtField.text = [[[responseDict valueForKey:@"info"] objectAtIndex:0] valueForKey:@"Twitter"];
        }
        else if (indexPath.row == 2) {
            cell.imgView.image = [UIImage imageNamed:@"web_logo.png"];
            cell.headingTxtField.text = [[[responseDict valueForKey:@"info"] objectAtIndex:0] valueForKey:@"Website"];
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

- (void) startUpdatetProfileInfoService {
    
    [SVProgressHUD showWithStatus:@"Updating Profile Info..."];
    
    isProfileUpdated = YES;
    
    DataSyncManager* manager = [[DataSyncManager alloc] init];
    manager.serviceKey = kUploadProfileService;
    manager.delegate = self;
    [manager startPOSTWebServicesWithParams:[self prepareDictionaryForUploadProfile]];
    
}

- (void) startLoginService {
    
    DataSyncManager* manager = [[DataSyncManager alloc] init];
    manager.serviceKey = kLoginService;
    manager.delegate = self;
    [manager startPOSTWebServicesWithParams:[self prepareDictionaryForLogin]];
    
}

#pragma mark - DATASYNCMANAGER Delegates

-(void) didFinishServiceWithSuccess:(id)responseData andServiceKey:(NSString *)requestServiceKey {
    
    
    if ([requestServiceKey containsString:kGetProfileInfo]) {
        
        [SVProgressHUD showSuccessWithStatus:@"Profile Details fetched succesfully"];
        responseDict = [[NSMutableDictionary alloc] initWithDictionary:responseData];
        [self updateUIAfterAPISuccess];
        
        if (isProfileUpdated) {
            isProfileUpdated = NO;
            [self startLoginService];
        }
        
        
    }
    if ([requestServiceKey containsString:kUploadProfileService]) {
       
        [self startGetProfileInfoService];
        
    }
    if ([requestServiceKey containsString:kLoginService]) {
        
        [SVProgressHUD showSuccessWithStatus:@"Profile Details updated succesfully"];
        [[SharedClass sharedInstance] setUserObj:responseData];
        
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

#pragma mark - Modalobject

- (NSMutableDictionary *) prepareDictionaryForUploadProfile {
    
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    
    ProfileSocialTableViewCell* fbCell = [[_socialTblView visibleCells] objectAtIndex:0];
    ProfileSocialTableViewCell* twitterCell = [[_socialTblView visibleCells] objectAtIndex:1];
    ProfileSocialTableViewCell* WebCell = [[_socialTblView visibleCells] objectAtIndex:2];
    
    [dict setObject:self.profileNameTxtField.text forKey:@"Name"];
    [dict setObject:userId forKey:@"User_id"];
    [dict setObject:self.treatmentTxtField.text forKey:@"Short_description"];
    [dict setObject:self.descriptioNTxtField.text forKey:@"Long_description"];
    
    [dict setObject:fbCell.headingTxtField.text forKey:@"FB"];
    [dict setObject:twitterCell.headingTxtField.text forKey:@"Twitter"];
    [dict setObject:WebCell.headingTxtField.text forKey:@"Website"];
    [dict setObject:[self encodeToBase64String:profileImage] forKey:@"Profile_pi"];
    [dict setObject:[[SharedClass sharedInstance] getCurrentUTCFormatDate] forKey:@"Pic_Name"];
    [dict setObject:@"1" forKey:@"Available"];
    
    return dict;
    
}

- (NSMutableDictionary *) prepareDictionaryForLogin {
    
    LoginRequestModal* signUpObj = [[LoginRequestModal alloc] init];
    
    signUpObj.email = [[NSUserDefaults standardUserDefaults] objectForKey:token1Key];
    signUpObj.password = [[NSUserDefaults standardUserDefaults] objectForKey:token2Key];;
    
    return [signUpObj createRequestDictionary];
    
}
#pragma mark - Profile Image Change

- (void) setupActionSheet {
    
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        actSheet = [[UIActionSheet alloc] initWithTitle:nil
                                               delegate:self
                                      cancelButtonTitle:@"Cancel"
                                 destructiveButtonTitle:nil
                                      otherButtonTitles:@"Photo Library", nil];
    }
    else {
        actSheet = [[UIActionSheet alloc] initWithTitle:nil
                                               delegate:self
                                      cancelButtonTitle:@"Cancel"
                                 destructiveButtonTitle:nil
                                      otherButtonTitles:@"Photo Library", @"Camera", nil];
    }
    
}



- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (actionSheet == actSheet) {
        //FLOG(@"Button %d", buttonIndex);
        
        if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        {
            
            switch (buttonIndex) {
                    
                case 0:
                {
                    UIImagePickerController *imgPicker = [[UIImagePickerController alloc] init];
                    imgPicker.sourceType =  UIImagePickerControllerSourceTypePhotoLibrary;
                    imgPicker.delegate = self;
                    [self presentViewController:imgPicker animated:YES completion:nil];
                    break;
                }
                    
                default:
                    
                    break;
            }
            
        }
        else {
            
            switch (buttonIndex) {
                    
                case 0:
                {
                    UIImagePickerController *imgPicker = [[UIImagePickerController alloc] init];
                    imgPicker.sourceType =  UIImagePickerControllerSourceTypePhotoLibrary;
                    imgPicker.delegate = self;
                    [self presentViewController:imgPicker animated:YES completion:nil];
                    break;
                }
                    
                case 1:
                {
                    UIImagePickerController *imgPicker = [[UIImagePickerController alloc] init];
                    imgPicker.sourceType =  UIImagePickerControllerSourceTypeCamera;
                    imgPicker.delegate = self;
                    [self presentViewController:imgPicker animated:YES completion:nil];
                    break;
                }
                    
                default:
                    
                    break;
            }
            
        }
        
        
        
        
    }
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image1 = info[UIImagePickerControllerOriginalImage];
    self.profileImgView.image = image1;
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        [self openEditor:nil];
        
    } else {
        [picker dismissViewControllerAnimated:YES completion:^{
            [self openEditor:nil];
        }];
    }
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}


#pragma mark - PECropViewControllerDelegate methods

-(void)cropViewController:(PECropViewController *)controller didFinishCroppingImage:(UIImage *)croppedImage {
    
    self.profileImgView.image = croppedImage;
    profileImage = croppedImage;
    
    //[[SharedClass sharedInstance] saveProfileImage:profileImage forStudentId:[[studentObj.getStudentsInfoDetails objectAtIndex:0] valueForKey:StudentsIdKey]];
    
    [controller dismissViewControllerAnimated:YES completion:NULL];
    
    [self startUpdatetProfileInfoService];
    
}

- (void)cropViewControllerDidCancel:(PECropViewController *)controller
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        // [self updateEditButtonEnabled];
    }
    
    [controller dismissViewControllerAnimated:YES completion:NULL];
}


#pragma mark - Action methods
//#GD: 2015_0318 added method to crop the profile pic
- (IBAction)openEditor:(id)sender
{
    PECropViewController *controller = [[PECropViewController alloc] init];
    controller.delegate = self;
    controller.image = self.profileImgView.image;
    
    UIImage *image = self.profileImgView.image;
    CGFloat width = image.size.width;
    CGFloat height = image.size.height;
    CGFloat length = MIN(width, height);
    controller.imageCropRect = CGRectMake((width - length) / 2,
                                          (height - length) / 2,
                                          length,
                                          length);
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:controller];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        navigationController.modalPresentationStyle = UIModalPresentationFormSheet;
    }
    
    [self presentViewController:navigationController animated:YES completion:NULL];
    
    
}

#pragma mark - Image to String Encoding

- (NSString *)encodeToBase64String:(UIImage *)image {
    
    if (image) {
        return [UIImagePNGRepresentation(image) base64EncodedStringWithOptions:0];
    }
    
    return @"";
}

-(UIImage *)resizeImage:(UIImage *)image
{
    float actualHeight = image.size.height;
    float actualWidth = image.size.width;
    float maxHeight = 300.0;
    float maxWidth = 400.0;
    float imgRatio = actualWidth/actualHeight;
    float maxRatio = maxWidth/maxHeight;
    float compressionQuality = 0.5;//50 percent compression
    
    if (actualHeight > maxHeight || actualWidth > maxWidth)
    {
        if(imgRatio < maxRatio)
        {
            //adjust width according to maxHeight
            imgRatio = maxHeight / actualHeight;
            actualWidth = imgRatio * actualWidth;
            actualHeight = maxHeight;
        }
        else if(imgRatio > maxRatio)
        {
            //adjust height according to maxWidth
            imgRatio = maxWidth / actualWidth;
            actualHeight = imgRatio * actualHeight;
            actualWidth = maxWidth;
        }
        else
        {
            actualHeight = maxHeight;
            actualWidth = maxWidth;
        }
    }
    
    CGRect rect = CGRectMake(0.0, 0.0, actualWidth, actualHeight);
    UIGraphicsBeginImageContext(rect.size);
    [image drawInRect:rect];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    NSData *imageData = UIImageJPEGRepresentation(img, compressionQuality);
    UIGraphicsEndImageContext();
    
    return [UIImage imageWithData:imageData];
    
}

- (void) hideKeyboard {
    
    [self.view endEditing:YES];
    
}
@end
