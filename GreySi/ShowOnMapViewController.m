//
//  ShowOnMapViewController.m
//  GreySi
//
//  Created by Dipen Sekhsaria on 10/10/16.
//  Copyright © 2016 GreyScissors. All rights reserved.
//

#import "ShowOnMapViewController.h"

@interface ShowOnMapViewController ()

@end

@implementation ShowOnMapViewController
@synthesize annotLat,annotLong;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadInitialSetup];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Map View


- (void) loadInitialSetup {
    
    if (annotLat && annotLong && ([annotLat floatValue]<=90 && [annotLat floatValue]>=-90) && ([annotLong floatValue]<=180 && [annotLong floatValue]>=-180)) {
            CLLocationCoordinate2D coord = CLLocationCoordinate2DMake([annotLat floatValue], [annotLong floatValue]);
            
            MKCoordinateSpan span = MKCoordinateSpanMake(10.0, 10.0);
            MKCoordinateRegion region = {coord, span};
            
            MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
            [annotation setCoordinate:coord];
            
            [self.mapView setRegion:region];
            [self.mapView addAnnotation:annotation];
        }
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)backButtonTapped:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
