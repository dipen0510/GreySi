//
//  ForgotPasswordViewController.m
//  GreySi
//
//  Created by Dipen Sekhsaria on 21/11/16.
//  Copyright © 2016 GreyScissors. All rights reserved.
//

#import "ForgotPasswordViewController.h"
#import "LoginTableViewCell.h"

@interface ForgotPasswordViewController ()

@end

@implementation ForgotPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupInitialUI];
    
}

- (void) setupInitialUI {
    
    self.loginTableView.layer.cornerRadius = 5.0;
    self.loginButton.layer.cornerRadius = 5.0;
    
    viewCenter = self.view.center;
    showKeyboardAnimation = true;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) startForgotPasswordServiceService {
    
    DataSyncManager* manager = [[DataSyncManager alloc] init];
    manager.serviceKey = kForgotPasswordService;
    manager.delegate = self;
    [manager startPOSTWebServicesWithParams:[self prepareDictionaryForForgotPassword]];
    
}

#pragma mark - DATASYNCMANAGER Delegates

-(void) didFinishServiceWithSuccess:(SignUpResponseModal *)responseData andServiceKey:(NSString *)requestServiceKey {
    
    [SVProgressHUD dismiss];
    [SVProgressHUD showSuccessWithStatus:@"Ett nytt lösenord har skickats till din e-post."];
    
    if ([requestServiceKey isEqualToString:kForgotPasswordService]) {
        
        [self backButtonTapped:nil];
        
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

- (NSMutableDictionary *) prepareDictionaryForForgotPassword {
    
    NSMutableDictionary* signUpObj = [[NSMutableDictionary alloc] init];
    
    [signUpObj setObject:emailText forKey:@"Email"];
    
    return signUpObj;
    
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
    
    return 1;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    NSString* identifier = @"LoginCell";
    LoginTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        cell = (LoginTableViewCell *)[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    cell.txtField.placeholder = @"E-post";
    cell.separatorView.hidden = NO;
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
    
    
    BOOL emailIsValid = [self validateEmailWithString:emailText];
    
    //    [self performSegueWithIdentifier:@"showHomeSegue" sender:nil];
    
    if ([emailText isEqualToString:@""]) {
        
        [self didFinishServiceWithFailure:NSLocalizedString(@"Please enter your email address", nil)];
    }
    
    else if (!emailIsValid) {
        
        [self didFinishServiceWithFailure:NSLocalizedString(@"Please enter a valid email address", nil)];
    }
    else {
        [SVProgressHUD showWithStatus:@"Creating new password..."];
        [self startForgotPasswordServiceService];
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
    
//    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{1,4}";
//    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
//    return [emailTest evaluateWithObject:email];
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
