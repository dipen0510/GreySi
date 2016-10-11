//
//  ShowOnMapViewController.m
//  GreySi
//
//  Created by Dipen Sekhsaria on 10/10/16.
//  Copyright © 2016 GreyScissors. All rights reserved.
//

#import "ShowOnMapViewController.h"
#import "District.h"
#import "GenericPinAnnotationView.h"
#import "MultiRowCalloutAnnotationView.h"
#import "MultiRowAnnotation.h"

@interface ShowOnMapViewController ()
@property (nonatomic,strong) MKAnnotationView *selectedAnnotationView;
@property (nonatomic,strong) MultiRowAnnotation *calloutAnnotation;
@end

@implementation ShowOnMapViewController
@synthesize annotLat,annotLong,adDict;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadInitialSetup];
}

#pragma mark - Map View


- (void) loadInitialSetup {
    
    [self convertTreatmentAndPriceArrToStr];
    
    if (annotLat && annotLong && ([annotLat floatValue]<=90 && [annotLat floatValue]>=-90) && ([annotLong floatValue]<=180 && [annotLong floatValue]>=-180)) {
            CLLocationCoordinate2D coord = CLLocationCoordinate2DMake([annotLat floatValue], [annotLong floatValue]);
            
            MKCoordinateSpan span = MKCoordinateSpanMake(10.0, 10.0);
            MKCoordinateRegion region = {coord, span};
            
            MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
            [annotation setCoordinate:coord];
            
            [self.mapView setRegion:region];
            [self.mapView addAnnotation:[District districtWithCoordinate:coord title:adDict[@"Name"] representatives:nil subtitle:treatmentStr budget:budgetStr userImg:adDict[@"Profile_pi"]]];
        }
    
}

- (void) convertTreatmentAndPriceArrToStr {
    
    if ([[[SharedClass sharedInstance] userObj].flag intValue]==1) {
        treatmentStr = [adDict valueForKey:@"Treatment"];
        budgetStr = [NSString stringWithFormat:@"Budget : $%@",[adDict valueForKey:@"Budget"] ];
    }
    else {
        id treatmentDict = [NSJSONSerialization JSONObjectWithData:[[adDict valueForKey:@"Treatment"] dataUsingEncoding:NSUTF8StringEncoding] options:0 error:nil];
        id budgetDict = [NSJSONSerialization JSONObjectWithData:[[adDict valueForKey:@"Budget"]  dataUsingEncoding:NSUTF8StringEncoding] options:0 error:nil];
        
        treatmentStr = [[[treatmentDict valueForKey:@"treatmentsArray"] valueForKey:@"name"] componentsJoinedByString:@", "];
        
        NSNumber *max=[[[budgetDict valueForKey:@"pricesArray"] valueForKey:@"name"] valueForKeyPath:@"@max.self"];
        NSNumber *min=[[[budgetDict valueForKey:@"pricesArray"] valueForKey:@"name"] valueForKeyPath:@"@min.self"];
        
        budgetArr = [[NSMutableArray alloc] initWithArray:[budgetDict valueForKey:@"pricesArray"]];
        treatmentArr = [[NSMutableArray alloc] initWithArray:[treatmentDict valueForKey:@"treatmentsArray"]];
        
        budgetStr = [NSString stringWithFormat:@"Budget : $%@ - $%@",min,max];
    }
    
    
    
}

#pragma mark - The Good Stuff

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MKUserLocation class]])
        return nil;
    
    if (![annotation conformsToProtocol:@protocol(MultiRowAnnotationProtocol)])
        return nil;
    
    NSObject <MultiRowAnnotationProtocol> *newAnnotation = (NSObject <MultiRowAnnotationProtocol> *)annotation;
    if (newAnnotation == _calloutAnnotation)
    {
        MultiRowCalloutAnnotationView *annotationView = (MultiRowCalloutAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:MultiRowCalloutReuseIdentifier];
        if (!annotationView)
        {
            annotationView = [MultiRowCalloutAnnotationView calloutWithAnnotation:newAnnotation onCalloutAccessoryTapped:^(MultiRowCalloutCell *cell, UIControl *control, NSDictionary *userData) {
                // This is where I usually push in a new detail view onto the navigation controller stack, using the object's ID
                NSLog(@"Representative (%@) with ID '%@' was tapped.", cell.subtitle, userData[@"id"]);
            }];
        }
        else
        {
            annotationView.annotation = newAnnotation;
        }
        annotationView.parentAnnotationView = _selectedAnnotationView;
        annotationView.mapView = mapView;
        return annotationView;
    }
    GenericPinAnnotationView *annotationView = (GenericPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:GenericPinReuseIdentifier];
    if (!annotationView)
    {
        annotationView = [GenericPinAnnotationView pinViewWithAnnotation:newAnnotation];
    }
    annotationView.annotation = newAnnotation;
    return annotationView;
}

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)aView
{
    id<MKAnnotation> annotation = aView.annotation;
    if (!annotation || ![aView isSelected])
        return;
    if ( NO == [annotation isKindOfClass:[MultiRowCalloutCell class]] &&
        [annotation conformsToProtocol:@protocol(MultiRowAnnotationProtocol)] )
    {
        NSObject <MultiRowAnnotationProtocol> *pinAnnotation = (NSObject <MultiRowAnnotationProtocol> *)annotation;
        if (!_calloutAnnotation)
        {
            _calloutAnnotation = [[MultiRowAnnotation alloc] init];
            [_calloutAnnotation copyAttributesFromAnnotation:pinAnnotation];
            [mapView addAnnotation:_calloutAnnotation];
        }
        _selectedAnnotationView = aView;
        return;
    }
    [mapView setCenterCoordinate:annotation.coordinate animated:YES];
    _selectedAnnotationView = aView;
}

- (void)mapView:(MKMapView *)mapView didDeselectAnnotationView:(MKAnnotationView *)aView
{
    if ( NO == [aView.annotation conformsToProtocol:@protocol(MultiRowAnnotationProtocol)] )
        return;
    if ([aView.annotation isKindOfClass:[MultiRowAnnotation class]])
        return;
    GenericPinAnnotationView *pinView = (GenericPinAnnotationView *)aView;
    if (_calloutAnnotation && !pinView.preventSelectionChange)
    {
        [mapView removeAnnotation:_calloutAnnotation];
        _calloutAnnotation = nil;
    }
}

#pragma mark - Boilerplate Stuff


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    if (self.isViewLoaded && _mapView && _mapView.annotations)
    {
        [_mapView removeAnnotations:_mapView.annotations];
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
