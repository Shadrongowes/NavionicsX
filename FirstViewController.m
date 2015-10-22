//
//  FirstViewController.m
//  NavionicsX
//
//  Created by Jason Paolasini on 2015-09-24.
//  Copyright © 2015 Jason Paolasini. All rights reserved.
//

#import "FirstViewController.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "PlacesLoader.h"
#import "Place.h"
#import "PlaceAnnotation.h"

NSString * const kNameKey = @"name";
NSString * const kReferenceKey = @"reference";
NSString * const kAddressKey = @"vicinity";
NSString * const kLatitudeKeypath = @"geometry.location.lat";
NSString * const kLongitudeKeypath = @"geometry.location.lng";

@interface FirstViewController () <CLLocationManagerDelegate, MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (nonatomic, strong) CLLocationManager *locationManager;
//@property (nonatomic, strong) NSArray *locations;
@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setLocationManager:[[CLLocationManager alloc] init]];
    [_locationManager setDelegate:self];
    self.tabBarController.delegate = self;
    [self.locationManager requestAlwaysAuthorization];
    [_locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    [_locationManager startUpdatingLocation];
  
}

-(void)viewDidAppear:(BOOL)animated{
    
   [_locationManager startUpdatingLocation];
}

-(BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    if ([viewController isKindOfClass:[SecondViewController class]]){
        SecondViewController *svc = (SecondViewController *) viewController;
        svc.fishlocations = self.maplocations;
    }
    return TRUE;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - CLLocationManager Delegate

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)maplocations {
   
    CLLocation *lastLocation = [maplocations lastObject];
    CLLocationAccuracy accuracy = [lastLocation horizontalAccuracy];
    NSLog(@"Received location %@ with accuracy %f", lastLocation, accuracy);
    
	if(accuracy < 100.0) {
		MKCoordinateSpan span = MKCoordinateSpanMake(0.14, 0.14);
        MKCoordinateRegion region = MKCoordinateRegionMake([lastLocation coordinate], span);
        
        [_mapView setRegion:region animated:YES];
        
        [[PlacesLoader sharedInstance] loadPOIsForLocation:[maplocations lastObject] radius:500.0 successHandler:^(NSDictionary *response) {
            NSLog(@"Response: %@", response);
           
                if([[response objectForKey:@"status"] isEqualToString:@"OK"]) {
                   
                    id places = [response objectForKey:@"results"];
                  
                    NSMutableArray *temp = [NSMutableArray array];
                    
                 
                    if([places isKindOfClass:[NSArray class]]) {
                        for(NSDictionary *resultsDict in places) {
                    
                            CLLocation *location = [[CLLocation alloc] initWithLatitude:[[resultsDict valueForKeyPath:kLatitudeKeypath] floatValue] longitude:[[resultsDict valueForKeyPath:kLongitudeKeypath] floatValue]];
                         
                            Place *currentPlace = [[Place alloc] initWithLocation:location reference:[resultsDict objectForKey:kReferenceKey] name:[resultsDict objectForKey:kNameKey] address:[resultsDict objectForKey:kAddressKey]];
                            
                            [temp addObject:currentPlace];
                            
                          
                            PlaceAnnotation *annotation = [[PlaceAnnotation alloc] initWithPlace:currentPlace];
                            [_mapView addAnnotation:annotation];
                        }
                    }
                    
                    
                    _maplocations = [temp copy];
                    
                    NSLog(@"Locations: %@", _maplocations);
                }
            } errorHandler:^(NSError *error) {
                NSLog(@"Error: %@", error);
            }];
            
    
        
        [manager stopUpdatingLocation];
    }
}

- (void)secondViewControllerDidFinish:(SecondViewController *)controller {
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showAlternate"]) {
        [[segue destinationViewController] setDelegate:self];
        [[segue destinationViewController] setLocations:_maplocations];
        [[segue destinationViewController] setUserLocation:[_mapView userLocation]];
    }
}

@end

