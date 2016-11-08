//
//  LocationViewController.h
//  GreySi
//
//  Created by Dipen Sekhsaria on 20/09/16.
//  Copyright © 2016 GreyScissors. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface LocationViewController : UIViewController<CLLocationManagerDelegate, DataSyncManagerDelegate> {
    CLLocationManager* locationManager;
    CLLocation* currentLocation;
    NSString* finalLat;
    NSString* finalLong;
    BOOL isAddressInvalid;
}

@property (weak, nonatomic) IBOutlet UITextField *addressTxtField;
@property (weak, nonatomic) IBOutlet UIButton *submitButton;
@property (weak, nonatomic) IBOutlet UIButton *currentLocationButton;

- (IBAction)submitButtonTapped:(id)sender;
- (IBAction)currentLocationButtonTapped:(id)sender;
- (IBAction)backButtonTapped:(id)sender;

@end
