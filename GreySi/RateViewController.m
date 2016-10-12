//
//  RateViewController.m
//  GreySi
//
//  Created by Dipen Sekhsaria on 11/10/16.
//  Copyright © 2016 GreyScissors. All rights reserved.
//

#import "RateViewController.h"

@interface RateViewController ()

@end

@implementation RateViewController

@synthesize projectId,hairDresserId;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.reviewTvtView.layer.cornerRadius = 10.0;
    self.reviewTvtView.layer.borderColor = [UIColor colorWithRed:211./255. green:211./255. blue:211./255. alpha:1.0].CGColor;
    self.reviewTvtView.layer.borderWidth = 1.0;
    
    UITapGestureRecognizer* firstTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(firstStarTapped)];
    _firstStarImgView.userInteractionEnabled = YES;
    [_firstStarImgView addGestureRecognizer:firstTap];
    
    UITapGestureRecognizer* secondTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(secondStarTapped)];
    _secondStarImgView.userInteractionEnabled = YES;
    [_secondStarImgView addGestureRecognizer:secondTap];
    
    UITapGestureRecognizer* thirdTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(thirdStarTapped)];
    _thirdStarImgView.userInteractionEnabled = YES;
    [_thirdStarImgView addGestureRecognizer:thirdTap];
    
    UITapGestureRecognizer* forthTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(forthStarTapped)];
    _forthStarImgView.userInteractionEnabled = YES;
    [_forthStarImgView addGestureRecognizer:forthTap];
    
    UITapGestureRecognizer* fifthTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fifthStarTapped)];
    _fifthStarImgView.userInteractionEnabled = YES;
    [_fifthStarImgView addGestureRecognizer:fifthTap];
    
    rating = @"";
    self.reviewTvtView.text = @"";
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void) firstStarTapped {

    [self clearAllStars];
    
    _firstStarImgView.image = [UIImage imageNamed:@"feedback_rating_full.png"];
    
    rating = @"1";
    
}

- (void) secondStarTapped {
    
    [self clearAllStars];
    
    _firstStarImgView.image = [UIImage imageNamed:@"feedback_rating_full.png"];
    _secondStarImgView.image = [UIImage imageNamed:@"feedback_rating_full.png"];
    
    rating = @"2";
    
}

- (void) thirdStarTapped {
    
    [self clearAllStars];
    
    _firstStarImgView.image = [UIImage imageNamed:@"feedback_rating_full.png"];
    _secondStarImgView.image = [UIImage imageNamed:@"feedback_rating_full.png"];
    _thirdStarImgView.image = [UIImage imageNamed:@"feedback_rating_full.png"];
    
    rating = @"3";
    
}

- (void) forthStarTapped {
    
    [self clearAllStars];
    
    _firstStarImgView.image = [UIImage imageNamed:@"feedback_rating_full.png"];
    _secondStarImgView.image = [UIImage imageNamed:@"feedback_rating_full.png"];
    _thirdStarImgView.image = [UIImage imageNamed:@"feedback_rating_full.png"];
    _forthStarImgView.image = [UIImage imageNamed:@"feedback_rating_full.png"];
    
    rating = @"4";
    
}

- (void) fifthStarTapped {
    
    [self clearAllStars];
    
    _firstStarImgView.image = [UIImage imageNamed:@"feedback_rating_full.png"];
    _secondStarImgView.image = [UIImage imageNamed:@"feedback_rating_full.png"];
    _thirdStarImgView.image = [UIImage imageNamed:@"feedback_rating_full.png"];
    _forthStarImgView.image = [UIImage imageNamed:@"feedback_rating_full.png"];
    _fifthStarImgView.image = [UIImage imageNamed:@"feedback_rating_full.png"];
    
    rating = @"5";
    
}

- (void) clearAllStars {
    
    _firstStarImgView.image = [UIImage imageNamed:@"feedback_rating.png"];
    _secondStarImgView.image = [UIImage imageNamed:@"feedback_rating.png"];
    _thirdStarImgView.image = [UIImage imageNamed:@"feedback_rating.png"];
    _forthStarImgView.image = [UIImage imageNamed:@"feedback_rating.png"];
    _fifthStarImgView.image = [UIImage imageNamed:@"feedback_rating.png"];
    
    rating = @"";
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (IBAction)submitButtonTapped:(id)sender {
    
    if (![rating isEqualToString:@""]) {
        
        [self startRateService];
        
    }
    else {
        
        [self didFinishServiceWithFailure:@"Please rate at least 1 star."];
        
    }
    
}

- (IBAction)backButtonTapped:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) startRateService {
    
    [SVProgressHUD showWithStatus:@"Posting Review..."];
    
    DataSyncManager* manager = [[DataSyncManager alloc] init];
    manager.serviceKey = kCustomerPostReviewService;
    manager.delegate = self;
    [manager startPOSTWebServicesWithParams:[self prepareDictionaryForPostReview]];
    
}

#pragma mark - DATASYNCMANAGER Delegates

-(void) didFinishServiceWithSuccess:(id)responseData andServiceKey:(NSString *)requestServiceKey {
    
    
    if ([requestServiceKey isEqualToString:kCustomerPostReviewService]) {
        
        [SVProgressHUD showSuccessWithStatus:@"Reveiw added successfully.."];
        [self.navigationController popViewControllerAnimated:YES];
        
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

- (NSMutableDictionary *) prepareDictionaryForPostReview {
    
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    
    [dict setObject:projectId forKey:@"Project_id"];
    [dict setObject:[[SharedClass sharedInstance] userObj].user_id forKey:@"Reviewer_id"];
    [dict setObject:hairDresserId forKey:@"Hairdresser_id"];
    [dict setObject:rating forKey:@"Rating"];
    [dict setObject:self.reviewTvtView.text forKey:@"Review"];
    
    
    return dict;
    
}

@end
