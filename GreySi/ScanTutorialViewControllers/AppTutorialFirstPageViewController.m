//
//  AppTutorialFirstPageViewController.m
//  Happ Post
//
//  Created by Dipen Sekhsaria on 30/10/15.
//  Copyright © 2015 Stardeep. All rights reserved.
//

#import "AppTutorialFirstPageViewController.h"

@interface AppTutorialFirstPageViewController ()

@end

@implementation AppTutorialFirstPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if ([[[SharedClass sharedInstance] userObj].flag intValue] == 1) {
        self.pageImgView.image = [UIImage imageNamed:@"th1.png"];
    }
    else {
        self.pageImgView.image = [UIImage imageNamed:@"tc1.png"];
    }
    
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

@end
