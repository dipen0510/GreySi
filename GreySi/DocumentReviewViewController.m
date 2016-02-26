//
//  DocumentReviewViewController.m
//  GreySi
//
//  Created by Dipen Sekhsaria on 26/02/16.
//  Copyright © 2016 GreyScissors. All rights reserved.
//

#import "DocumentReviewViewController.h"

@interface DocumentReviewViewController ()

@end

@implementation DocumentReviewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupInitialUI];
    
}

- (void) setupInitialUI {
    
    self.diplomaImageView.hidden = YES;
    self.sendForReviewButton.hidden = YES;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backButtonTapped:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (IBAction)uploadDiplomaButtonTapped:(id)sender {
}

- (IBAction)skipButtonTapped:(id)sender {
}

- (IBAction)sendForReviewButtonTapped:(id)sender {
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
