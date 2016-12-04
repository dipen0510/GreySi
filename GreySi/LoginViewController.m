//
//  LoginViewController.m
//  GreySi
//
//  Created by Dipen Sekhsaria on 25/02/16.
//  Copyright © 2016 GreyScissors. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginTableViewCell.h"
#import "LoginRequestModal.h"
#import "SignUpResponseModal.h"
#import "WhatAreYouViewController.h";

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //[self addGradientToBGView];

}

-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self setupInitialUI];
    
}

- (void) addGradientToBGView {
    
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height);
    gradient.colors = [NSArray arrayWithObjects:(id)[[UIColor colorWithRed:150./255. green:24./255. blue:206./255. alpha:1.0] CGColor], (id)[[UIColor colorWithRed:183./255. green:10./255. blue:197./255. alpha:1.0] CGColor], nil];
    [self.view.layer insertSublayer:gradient atIndex:0];
    
}

- (void) setupInitialUI {
    
    self.loginTableView.layer.cornerRadius = 5.0;
    self.loginButton.layer.cornerRadius = 5.0;
    
    viewCenter = self.view.center;
    showKeyboardAnimation = true;
    
    self.splashImgView.alpha = 1.0;
    self.splashImgView.hidden = NO;
    self.loginBgImgView.alpha = 0.0;
    
    [UIView animateWithDuration:2.0 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^
     {
         self.splashImgView.alpha = 0.0;
         self.loginBgImgView.alpha = 1.0;
     }
                     completion:^(BOOL finished){
                         self.splashImgView.hidden = YES;
                     }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) startLoginService {
    
    DataSyncManager* manager = [[DataSyncManager alloc] init];
    manager.serviceKey = kLoginService;
    manager.delegate = self;
    [manager startPOSTWebServicesWithParams:[self prepareDictionaryForLogin]];
    
}

- (void) startCheckIfEmailExistsService {
    
    [SVProgressHUD showWithStatus:@"Logging In..."];
    
    DataSyncManager* manager = [[DataSyncManager alloc] init];
    manager.serviceKey = [NSString stringWithFormat:@"%@%@",kCheckIfEmailExists,fbEmail];;
    manager.delegate = self;
    [manager startGETWebServices];
    
}

- (void) startLoginWithFBService {
    
    [SVProgressHUD showWithStatus:@"Logging In..."];
    
    DataSyncManager* manager = [[DataSyncManager alloc] init];
    manager.serviceKey = kLoginWithFB;
    manager.delegate = self;
    [manager startPOSTWebServicesWithParams:[self prepareDictionaryForLoginWithFB]];
    
}

#pragma mark - DATASYNCMANAGER Delegates

-(void) didFinishServiceWithSuccess:(id)responseData andServiceKey:(NSString *)requestServiceKey {
    
    if ([requestServiceKey isEqualToString:kLoginService] || [requestServiceKey isEqualToString:kLoginWithFB]) {
        
        [SVProgressHUD dismiss];
        [SVProgressHUD showSuccessWithStatus:@"Login Successful"];
        
        [[SharedClass sharedInstance] setUserObj:responseData];
        
        [self performSegueWithIdentifier:@"showHomeSegue" sender:nil];
        
    }
    if ([requestServiceKey containsString:kCheckIfEmailExists]) {
        
        if ([responseData[@"result"] intValue] == 0) {
            [SVProgressHUD dismiss];
            [self performSegueWithIdentifier:@"showWhatAreYouSegue" sender:nil];
        }
        else {
            fbFlag = [[responseData[@"info"] objectAtIndex:0] valueForKey:@"Flag"];
            [self startLoginWithFBService];
        }
        
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

- (NSMutableDictionary *) prepareDictionaryForLogin {
    
    LoginRequestModal* signUpObj = [[LoginRequestModal alloc] init];
    
    [[NSUserDefaults standardUserDefaults] setObject:emailText forKey:token1Key];
    [[NSUserDefaults standardUserDefaults] setObject:passwordText forKey:token2Key];
    
    signUpObj.email = emailText;
    signUpObj.password = passwordText;
    
    return [signUpObj createRequestDictionary];
    
}

- (NSMutableDictionary *) prepareDictionaryForLoginWithFB {
    
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    
    [dict setObject:fbName forKey:@"Name"];
    [dict setObject:fbEmail forKey:@"Email"];
    [dict setObject:fbId forKey:@"Fb_id"];
    [dict setObject:fbFlag forKey:@"Flag"];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - UITableView Datasource -

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 2;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    NSString* identifier = @"LoginCell";
    LoginTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        cell = (LoginTableViewCell *)[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    if (indexPath.row) {
        cell.txtField.placeholder = @"Lösenord";
        cell.separatorView.hidden = YES;
        cell.txtField.secureTextEntry = YES;
    }
    else {
        cell.txtField.placeholder = @"E-post";
        cell.separatorView.hidden = NO;
    }
    
    cell.txtField.delegate = self;
    
    return cell;
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

#pragma mark - UITableView Delegate -
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    
    
    
}

#pragma mark - User Action Events

- (IBAction)backButtonTapped:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (IBAction)submitButtonTapped:(id)sender {
    
    
    LoginTableViewCell* tmpCell = (LoginTableViewCell *)[_loginTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    emailText = tmpCell.txtField.text;
    
    tmpCell = (LoginTableViewCell *)[_loginTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    passwordText = tmpCell.txtField.text;
    
    
    
    BOOL emailIsValid = [self validateEmailWithString:emailText];
  
//    [self performSegueWithIdentifier:@"showHomeSegue" sender:nil];
    
    if ([emailText isEqualToString:@""]) {
        
        [self didFinishServiceWithFailure:NSLocalizedString(@"Please enter your email address", nil)];
    }
    
    else if (!emailIsValid) {
        
        [self didFinishServiceWithFailure:NSLocalizedString(@"Please enter a valid email address", nil)];
    }
    else if ([passwordText isEqualToString:@""]) {
        
        [self didFinishServiceWithFailure:NSLocalizedString(@"Please enter your password", nil)];
    }
    else {
        [SVProgressHUD showWithStatus:@"Logging In..."];
        [self startLoginService];
    }
    
    
    
}

- (IBAction)fbLoginButtonTapped:(id)sender {
    
    if ([FBSDKAccessToken currentAccessToken]) {
        // User is logged in, do work such as go to next view controller.
        [self getFBUserDetails];
    }
    else {
        [self loginWithFB];
    }
    
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    showKeyboardAnimation = true;
    [self.view endEditing:YES];
    
}

#pragma mark - TextField Delegates

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    showKeyboardAnimation = true;
    [textField endEditing:YES];
    return true;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    
    
    if (showKeyboardAnimation) {
        CGPoint MyPoint = self.view.center;
        
        [UIView animateWithDuration:0.3
                         animations:^{
                             
                             self.view.center = CGPointMake(MyPoint.x, MyPoint.y - 200);
                         }];
        
        showKeyboardAnimation=false;
    }
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (showKeyboardAnimation) {
        //CGPoint MyPoint = self.view.center;
        
        [UIView animateWithDuration:0.3
                         animations:^{
                             
                             self.view.center = CGPointMake(viewCenter.x, viewCenter.y);
                         }];
        
    }
}


#pragma mark - Form Validations

- (BOOL)validateEmailWithString:(NSString*)email {
    
    
    return true;
    
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{1,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

#pragma mark - FB Helpers

- (void) loginWithFB {
    
    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
    [login
     logInWithReadPermissions: @[@"public_profile", @"email", @"user_friends"]
     fromViewController:self
     handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
         if (error) {
             NSLog(@"Process error");
         } else if (result.isCancelled) {
             NSLog(@"Cancelled");
         } else {
             NSLog(@"Logged in");
             [self getFBUserDetails];
         }
     }];
    
}

- (void) getFBUserDetails {
    
    [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:@{@"fields": @"email,name,first_name"}]
     startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
         if (!error) {
             NSLog(@"fetched user:%@", result);
             NSLog(@"%@",result[@"email"]);
             fbName = result[@"name"];
             fbEmail = result[@"email"];
             fbId = result[@"id"];
             
             [self startCheckIfEmailExistsService];
             
         }
     }];
    
    
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"showWhatAreYouSegue"]) {
        
        WhatAreYouViewController* controller = (WhatAreYouViewController *)[segue destinationViewController];
        
        controller.isFBLoginType = YES;
        controller.fbName = fbName;
        controller.fbEmail = fbEmail;
        controller.fbId = fbId;
        
    }
    
}

@end
