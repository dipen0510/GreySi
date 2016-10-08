//
//  ProfileSubDetailViewController.m
//  GreySi
//
//  Created by Dipen Sekhsaria on 09/08/16.
//  Copyright © 2016 GreyScissors. All rights reserved.
//

#import "ProfileSubDetailViewController.h"
#import "PriceListViewController.h"
#import "PlaceBidViewController.h"

@interface ProfileSubDetailViewController ()

@end

@implementation ProfileSubDetailViewController

@synthesize adDict;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupUI];
    
}

- (void) setupUI {
    
    [self convertTreatmentAndPriceArrToStr];
    
    self.profileImageView.layer.masksToBounds = YES;
    self.profileImageView.layer.cornerRadius = self.profileImageView.frame.size.height/2.;
    self.chatButton.layer.cornerRadius = self.chatButton.frame.size.height/2.;
    self.bookButton.layer.cornerRadius = self.chatButton.frame.size.height/2.;
    self.priceListButton.layer.cornerRadius = 2.0;
    self.priceLabel.layer.cornerRadius = 2.0;
    
    if ([[[SharedClass sharedInstance] userObj].flag intValue]==1) {
        [self.bookButton setTitle:@"Bid" forState:UIControlStateNormal];
        self.treatmentLabel.text = adDict[@"Treatment"];
        self.priceLabel.text = [NSString stringWithFormat:@"$%@",adDict[@"Budget"]];
    }
    else {
        [self.bookButton setTitle:@"Book" forState:UIControlStateNormal];
        self.treatmentLabel.text = treatmentStr;
        self.priceLabel.text = budgetStr;
    }
    
    
    self.noOfBidsLabel.text = @"";
    self.profileNameLabel.text = adDict[@"Name"];
    self.descriptionLabel.text = adDict[@"Short_description"];
    self.locationLabel.text = [NSString stringWithFormat:@"Location : %@",adDict[@"Address"]];
    
    __weak UIImageView* weakImageView = self.profileImageView;
    [self.profileImageView setImageWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[adDict[@"Profile_pi"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]
                                                                   cachePolicy:NSURLRequestReturnCacheDataElseLoad
                                                               timeoutInterval:60.0] placeholderImage:[UIImage imageNamed:@"blankProfile"] success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
        
        
        weakImageView.alpha = 0.0;
        weakImageView.image = image;
        [UIView animateWithDuration:0.25
                         animations:^{
                             weakImageView.alpha = 1.0;
                         }];
    } failure:NULL];
    
}

- (void) convertTreatmentAndPriceArrToStr {
    
    id treatmentDict = [NSJSONSerialization JSONObjectWithData:[[adDict valueForKey:@"Treatment"] dataUsingEncoding:NSUTF8StringEncoding] options:0 error:nil];
    id budgetDict = [NSJSONSerialization JSONObjectWithData:[[adDict valueForKey:@"Budget"]  dataUsingEncoding:NSUTF8StringEncoding] options:0 error:nil];
    
    treatmentStr = [[[treatmentDict valueForKey:@"treatmentsArray"] valueForKey:@"name"] componentsJoinedByString:@", "];
    
    NSNumber *max=[[[budgetDict valueForKey:@"pricesArray"] valueForKey:@"name"] valueForKeyPath:@"@max.self"];
    NSNumber *min=[[[budgetDict valueForKey:@"pricesArray"] valueForKey:@"name"] valueForKeyPath:@"@min.self"];
    
    budgetArr = [[NSMutableArray alloc] initWithArray:[budgetDict valueForKey:@"pricesArray"]];
    treatmentArr = [[NSMutableArray alloc] initWithArray:[treatmentDict valueForKey:@"treatmentsArray"]];
    
    budgetStr = [NSString stringWithFormat:@"$%@ - $%@",max,min];
    
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
     
     if ([segue.identifier isEqualToString:@"showPriceListSegue"]) {
         
         PriceListViewController* controller = (PriceListViewController *)[segue destinationViewController];
         controller.priceArr = budgetArr;
         controller.treatmentArr = treatmentArr;
         
     }
     else if ([segue.identifier isEqualToString:@"showPlaceBidSegue"]) {
         
         PlaceBidViewController* controller = (PlaceBidViewController *)[segue destinationViewController];
         controller.projectId = [adDict valueForKey:@"Project_id"];
         
     }
     
     
 }


- (IBAction)backButtonTapped:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (IBAction)bookButtonTapped:(id)sender {
    
    if ([[[SharedClass sharedInstance] userObj].flag intValue] == 1) {
        [self performSegueWithIdentifier:@"showPlaceBidSegue" sender:nil];
    }
    else {
        [self startBookProjectService];
    }
    
}

- (IBAction)chatButtonTapped:(id)sender {
}

- (IBAction)priceListButtonTapped:(id)sender {
    
    [self performSegueWithIdentifier:@"showPriceListSegue" sender:nil];
    
}

- (IBAction)showOnMapButtonTapped:(id)sender {
}


- (void) startBookProjectService {
    
    [SVProgressHUD showWithStatus:@"Booking project..."];
    
    DataSyncManager* manager = [[DataSyncManager alloc] init];
    manager.serviceKey = kCustomerBookProjectService;
    manager.delegate = self;
    [manager startPOSTWebServicesWithParams:[self prepareDictionaryForBookProject]];
    
}

#pragma mark - DATASYNCMANAGER Delegates

-(void) didFinishServiceWithSuccess:(id)responseData andServiceKey:(NSString *)requestServiceKey {
    
    
    if ([requestServiceKey isEqualToString:kCustomerBookProjectService]) {
        
        [SVProgressHUD showSuccessWithStatus:@"Project Booked successfully"];
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

- (NSMutableDictionary *) prepareDictionaryForBookProject {
    
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    
    [dict setObject:treatmentStr forKey:@"Treatment"];
    [dict setObject:[[SharedClass sharedInstance] userObj].user_id forKey:@"Booker_id"];
    [dict setObject:adDict[@"User_id"] forKey:@"Hairdresser_id"];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
    [dateFormatter setTimeZone:timeZone];
    [dateFormatter setDateFormat:@"dd/MM/yyyy"];
    
   [dict setObject:[dateFormatter stringFromDate:[NSDate date]] forKey:@"Date"];
    
    return dict;
    
}
@end
