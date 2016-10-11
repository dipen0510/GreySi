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

@synthesize adDict;

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
    
}

- (void) secondStarTapped {
    
    [self clearAllStars];
    
    _firstStarImgView.image = [UIImage imageNamed:@"feedback_rating_full.png"];
    _secondStarImgView.image = [UIImage imageNamed:@"feedback_rating_full.png"];
    
}

- (void) thirdStarTapped {
    
    [self clearAllStars];
    
    _firstStarImgView.image = [UIImage imageNamed:@"feedback_rating_full.png"];
    _secondStarImgView.image = [UIImage imageNamed:@"feedback_rating_full.png"];
    _thirdStarImgView.image = [UIImage imageNamed:@"feedback_rating_full.png"];
    
}

- (void) forthStarTapped {
    
    [self clearAllStars];
    
    _firstStarImgView.image = [UIImage imageNamed:@"feedback_rating_full.png"];
    _secondStarImgView.image = [UIImage imageNamed:@"feedback_rating_full.png"];
    _thirdStarImgView.image = [UIImage imageNamed:@"feedback_rating_full.png"];
    _forthStarImgView.image = [UIImage imageNamed:@"feedback_rating_full.png"];
    
}

- (void) fifthStarTapped {
    
    [self clearAllStars];
    
    _firstStarImgView.image = [UIImage imageNamed:@"feedback_rating_full.png"];
    _secondStarImgView.image = [UIImage imageNamed:@"feedback_rating_full.png"];
    _thirdStarImgView.image = [UIImage imageNamed:@"feedback_rating_full.png"];
    _forthStarImgView.image = [UIImage imageNamed:@"feedback_rating_full.png"];
    _fifthStarImgView.image = [UIImage imageNamed:@"feedback_rating_full.png"];
    
}

- (void) clearAllStars {
    
    _firstStarImgView.image = [UIImage imageNamed:@"feedback_rating.png"];
    _secondStarImgView.image = [UIImage imageNamed:@"feedback_rating.png"];
    _thirdStarImgView.image = [UIImage imageNamed:@"feedback_rating.png"];
    _forthStarImgView.image = [UIImage imageNamed:@"feedback_rating.png"];
    _fifthStarImgView.image = [UIImage imageNamed:@"feedback_rating.png"];
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (IBAction)submitButtonTapped:(id)sender {
    
    [SVProgressHUD showSuccessWithStatus:@"Reveiw added successfully.."];
    
}

- (IBAction)backButtonTapped:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
