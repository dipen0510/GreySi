//
//  ShowOnMapViewController.h
//  GreySi
//
//  Created by Dipen Sekhsaria on 10/10/16.
//  Copyright © 2016 GreyScissors. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface ShowOnMapViewController : UIViewController

@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@property (strong, nonatomic) NSString* annotLat;
@property (strong, nonatomic) NSString* annotLong;

- (IBAction)backButtonTapped:(id)sender;

@end
