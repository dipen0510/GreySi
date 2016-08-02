//
//  ProfileDetailViewController.m
//  GreySi
//
//  Created by Dipen Sekhsaria on 03/08/16.
//  Copyright © 2016 GreyScissors. All rights reserved.
//

#import "ProfileDetailViewController.h"

@interface ProfileDetailViewController ()

@end

@implementation ProfileDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupUI];
    
}

- (void) setupUI {
    
    self.profileImgView.layer.masksToBounds = YES;
    self.profileImgView.layer.cornerRadius = self.profileImgView.frame.size.height/2.;
    self.chatButton.layer.cornerRadius = 2.0;
    self.rateReviewButton.layer.cornerRadius = 2.0;
    
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

- (IBAction)backButtonTapped:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
