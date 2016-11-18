//
//  LocationViewController.m
//  GreySi
//
//  Created by Dipen Sekhsaria on 20/09/16.
//  Copyright © 2016 GreyScissors. All rights reserved.
//

#import "LocationViewController.h"
#import "HomeViewController.h"

@interface LocationViewController ()

@end

@implementation LocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _submitButton.layer.cornerRadius = 4.;
    _currentLocationButton.layer.cornerRadius = 4.;
    
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    
    NSUInteger code = [CLLocationManager authorizationStatus];
        if (code == kCLAuthorizationStatusNotDetermined && ([locationManager respondsToSelector:@selector(requestAlwaysAuthorization)] || [locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)])) {
            // choose one request according to your business.
            if([[NSBundle mainBundle] objectForInfoDictionaryKey:@"NSLocationAlwaysUsageDescription"]){
                [locationManager requestAlwaysAuthorization];
            } else if([[NSBundle mainBundle] objectForInfoDictionaryKey:@"NSLocationWhenInUseUsageDescription"]) {
                [locationManager  requestWhenInUseAuthorization];
            } else {
                NSLog(@"Info.plist does not contain NSLocationAlwaysUsageDescription or NSLocationWhenInUseUsageDescription");
            }
        }
    
    [locationManager startUpdatingLocation];
    
    [self startGetLocationService];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError: %@", error);
    UIAlertView *errorAlert = [[UIAlertView alloc]
                               initWithTitle:@"Error" message:@"Failed to Get Your Location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [errorAlert show];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    currentLocation = newLocation;
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)submitButtonTapped:(id)sender {
    
    [SVProgressHUD showWithStatus:@"Validating your address..."];
    [self performSelectorInBackground:@selector(getLocationFromAddress) withObject:nil];
    
}

- (IBAction)currentLocationButtonTapped:(id)sender {
    
    if (currentLocation) {
        [self getCurrentCityAndCountry];
    }
    else {
        UIAlertView *errorAlert = [[UIAlertView alloc]
                                   initWithTitle:@"Error" message:@"Failed to Get Your Location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [errorAlert show];
    }

}

- (IBAction)backButtonTapped:(id)sender {
    
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    HomeViewController* controller = (HomeViewController*)[mainStoryboard instantiateViewControllerWithIdentifier:@"homeViewController"];
    [self.revealViewController setFrontViewController:controller animated:YES];
    
}

- (void) getCurrentCityAndCountry {
    
    [SVProgressHUD showWithStatus:@"Fetching your address..."];
    
    CLGeocoder *reverseGeocoder = [[CLGeocoder alloc] init];
    
    [reverseGeocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *placemarks, NSError *error)
     {
         [SVProgressHUD dismiss];
         
         NSLog(@"reverseGeocodeLocation:completionHandler: Completion Handler called!");
         if (error){
             NSLog(@"Geocode failed with error: %@", error);
             return;
         }
         
         NSLog(@"Received placemarks: %@", placemarks);
         
         
         CLPlacemark *myPlacemark = [placemarks objectAtIndex:0];
         NSString *countryCode = myPlacemark.ISOcountryCode;
         NSString *countryName = myPlacemark.country;
         NSLog(@"My country code: %@ and countryName: %@", countryCode, countryName);
         
         self.addressTxtField.text = [NSString stringWithFormat:@"%@, %@",myPlacemark.locality,countryName];
         
     }];
    
}



-(void) getLocationFromAddress {
    double latitude = 0, longitude = 0;
    NSString *esc_addr =  [self.addressTxtField.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *req = [NSString stringWithFormat:@"http://maps.google.com/maps/api/geocode/json?sensor=false&address=%@", esc_addr];
    NSString *result = [NSString stringWithContentsOfURL:[NSURL URLWithString:req] encoding:NSUTF8StringEncoding error:NULL];
    if (result) {
        NSScanner *scanner = [NSScanner scannerWithString:result];
        if ([scanner scanUpToString:@"\"lat\" :" intoString:nil] && [scanner scanString:@"\"lat\" :" intoString:nil]) {
            [scanner scanDouble:&latitude];
            if ([scanner scanUpToString:@"\"lng\" :" intoString:nil] && [scanner scanString:@"\"lng\" :" intoString:nil]) {
                [scanner scanDouble:&longitude];
            }
        }
    }
    CLLocationCoordinate2D center;
    center.latitude=latitude;
    center.longitude = longitude;
    NSLog(@"View Controller get Location Logitute : %f",center.latitude);
    NSLog(@"View Controller get Location Latitute : %f",center.longitude);
    
    if (!(latitude == 0.0 && longitude == 0.0)) {
        finalLat = [NSString stringWithFormat:@"%lf",latitude];
        finalLong = [NSString stringWithFormat:@"%lf",longitude];
        [self performSelectorOnMainThread:@selector(startPostingLocationService) withObject:nil waitUntilDone:NO];
    }
    else {
        isAddressInvalid = YES;
        [self performSelectorOnMainThread:@selector(didFinishServiceWithFailure:) withObject:nil waitUntilDone:NO];
    }
    
    
    
    
}

- (void) startPostingLocationService {
    
    [SVProgressHUD showWithStatus:@"Updating location..."];
    
    DataSyncManager* manager = [[DataSyncManager alloc] init];
    manager.serviceKey = kPostLocation;
    manager.delegate = self;
    [manager startPOSTWebServicesWithParams:[self prepareDictionaryForPostLocation]];
    
}

- (void) startGetLocationService {
    
    [SVProgressHUD showWithStatus:@"Fetching location..."];
    
    DataSyncManager* manager = [[DataSyncManager alloc] init];
    manager.serviceKey = [NSString stringWithFormat:@"%@%@",kGetLocation,[[SharedClass sharedInstance] userObj].user_id];
    manager.delegate = self;
    [manager startGETWebServices];
    
}

#pragma mark - DATASYNCMANAGER Delegates

-(void) didFinishServiceWithSuccess:(id)responseData andServiceKey:(NSString *)requestServiceKey {
    
    
    if ([requestServiceKey containsString:kGetLocation]) {
        
        [SVProgressHUD showSuccessWithStatus:@"Location fetched succesfully"];
        
        self.addressTxtField.text = [[[responseData valueForKey:@"info"] objectAtIndex:0] valueForKey:@"Address"];
        
    }
    else {
        [SVProgressHUD dismiss];
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
    if (isAddressInvalid) {
        isAddressInvalid = NO;
        [alert setMessage:@"Please enter valid address to continue"];
    }
    
    if (alert.message) {
        [alert show];
    }
    
    return;
    
}

#pragma mark - Modalobject

- (NSMutableDictionary *) prepareDictionaryForPostLocation {
    
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    
    [dict setObject:[[SharedClass sharedInstance] userObj].user_id forKey:@"User_id"];
    [dict setObject:self.addressTxtField.text forKey:@"Address"];
    [dict setObject:finalLat forKey:@"Lat"];
    [dict setObject:finalLong forKey:@"Longi"];
    
    return dict;
    
}

@end
