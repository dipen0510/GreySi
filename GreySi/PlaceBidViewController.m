//
//  PlaceBidViewController.m
//  GreySi
//
//  Created by Dipen Sekhsaria on 09/10/16.
//  Copyright © 2016 GreyScissors. All rights reserved.
//

#import "PlaceBidViewController.h"

@interface PlaceBidViewController ()

@end

@implementation PlaceBidViewController

@synthesize projectId;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.amountTxtField.keyboardType = UIKeyboardTypeNumberPad;
    self.placeBidButton.layer.cornerRadius = 2.0;
    
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

- (IBAction)placeBidButtonTapped:(id)sender {
    
    if ([self.amountTxtField.text isEqualToString:@""]) {
        [self didFinishServiceWithFailure:@"Please enter amount to proceed"];
    }
    else {
        [self startPlaceBidService];
    }
}

- (IBAction)backButtonTapped:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}


- (void) startPlaceBidService {
    
    [SVProgressHUD showWithStatus:@"Adding your bid..."];
    
    DataSyncManager* manager = [[DataSyncManager alloc] init];
    manager.serviceKey = kHairPlaceBidService;
    manager.delegate = self;
    [manager startPOSTWebServicesWithParams:[self prepareDictionaryForPlaceBid]];
    
}

#pragma mark - DATASYNCMANAGER Delegates

-(void) didFinishServiceWithSuccess:(id)responseData andServiceKey:(NSString *)requestServiceKey {
    
    
    if ([requestServiceKey isEqualToString:kHairPlaceBidService]) {
        
        [SVProgressHUD showSuccessWithStatus:@"Bid added successfully"];
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

- (NSMutableDictionary *) prepareDictionaryForPlaceBid {
    
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    
    [dict setObject:projectId forKey:@"Project_id"];
    [dict setObject:[[SharedClass sharedInstance] userObj].user_id forKey:@"User_id"];
    [dict setObject:self.amountTxtField.text forKey:@"Amount"];
   
    return dict;
    
}
@end
