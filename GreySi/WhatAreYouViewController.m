//
//  WhatAreYouViewController.m
//  GreySi
//
//  Created by Dipen Sekhsaria on 26/02/16.
//  Copyright © 2016 GreyScissors. All rights reserved.
//

#import "WhatAreYouViewController.h"
#import "SignUpViewController.h"

@interface WhatAreYouViewController ()

@end

@implementation WhatAreYouViewController

@synthesize isFBLoginType,fbId,fbEmail,fbName;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    [self addGradientToBGView];
    [self setupInitialUI];
    
}

- (void) addGradientToBGView {
    
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height);
    gradient.colors = [NSArray arrayWithObjects:(id)[[UIColor colorWithRed:150./255. green:24./255. blue:206./255. alpha:1.0] CGColor], (id)[[UIColor colorWithRed:183./255. green:10./255. blue:197./255. alpha:1.0] CGColor], nil];
    [self.view.layer insertSublayer:gradient atIndex:0];
    
}

- (void) setupInitialUI {
    
    self.hairdresserButton.layer.borderColor = [UIColor whiteColor].CGColor;
    self.hairdresserButton.layer.borderWidth = 1.0;
    self.customerButton.layer.borderColor = [UIColor whiteColor].CGColor;
    self.customerButton.layer.borderWidth = 1.0;
    self.hairdresserButton.layer.cornerRadius = 10.0;
    self.customerButton.layer.cornerRadius = 10.0;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backButtonTapped:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (IBAction)hairDresserButtonTapped:(id)sender {
    
    userType = 1;
    
    if (isFBLoginType) {
        [self startLoginWithFBService];
    }
    else {
        [self performSegueWithIdentifier:@"showRegisterSegue" sender:nil];
    }
    
}

- (IBAction)customerButtonTapped:(id)sender {
    
    userType = 2;
    
    if (isFBLoginType) {
        [self startLoginWithFBService];
    }
    else {
        [self performSegueWithIdentifier:@"showRegisterSegue" sender:nil];
    }
    
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([segue.identifier isEqualToString:@"showRegisterSegue"]) {
        
        SignUpViewController* controller = (SignUpViewController *)[segue destinationViewController];
        controller.userType = userType;
        
    }
    
}


- (void) startLoginWithFBService {
    
    DataSyncManager* manager = [[DataSyncManager alloc] init];
    manager.serviceKey = kLoginWithFB;
    manager.delegate = self;
    [manager startPOSTWebServicesWithParams:[self prepareDictionaryForLoginWithFB]];
    
}

#pragma mark - DATASYNCMANAGER Delegates

-(void) didFinishServiceWithSuccess:(id)responseData andServiceKey:(NSString *)requestServiceKey {
    
    if ([requestServiceKey containsString:kLoginWithFB]) {
        
        [SVProgressHUD dismiss];
        [SVProgressHUD showSuccessWithStatus:@"Login Successful"];
        
        [[SharedClass sharedInstance] setUserObj:responseData];
        
        [self performSegueWithIdentifier:@"showHomeSegue" sender:nil];
        
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
    
    
    if (alert.message) {
        [alert show];
    }
    
    return;
    
}

#pragma mark - Modalobject

- (NSMutableDictionary *) prepareDictionaryForLoginWithFB {
    
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    
    [dict setObject:fbName forKey:@"Name"];
    [dict setObject:fbEmail forKey:@"Email"];
    [dict setObject:fbId forKey:@"Fb_id"];
    [dict setObject:[NSString stringWithFormat:@"%d",userType] forKey:@"Flag"];
    if ([[NSUserDefaults standardUserDefaults] valueForKey:@"kDeviceToken"]) {
        [dict setObject:[[NSUserDefaults standardUserDefaults] valueForKey:@"kDeviceToken"] forKey:registerGCMIdKey];
    }
    else {
        [dict setObject:@"1234567890" forKey:registerGCMIdKey];
    }
    [dict setObject:@"2" forKey:registerDeviceTypeKey];
    [dict setObject:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"] forKey:registerVersionCodeKey];
    
    return dict;
    
}


@end
