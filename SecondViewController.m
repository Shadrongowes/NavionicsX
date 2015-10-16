//
//  SecondViewController.m
//  NavionicsX
//
//  Created by Jason Paolasini on 2015-09-24.
//  Copyright © 2015 Jason Paolasini. All rights reserved.
//

#import "SecondViewController.h"
#import "Place.h"
#import "PlacesLoader.h"
#import "MarkerView.h"

NSString * const kPhoneKey = @"formatted_phone_number";
NSString * const kWebsiteKey = @"website";

const int kInfoViewTag = 1001;
@interface SecondViewController () <MarkerViewDelegate>
@property (nonatomic, strong) AugmentedRealityController *arController;
@property (nonatomic, strong) NSMutableArray *geoLocations;
@end

@implementation SecondViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if(!_arController) {
        _arController = [[AugmentedRealityController alloc] initWithView:[self view] parentViewController:self withDelgate:self];
    }
    
    [_arController setMinimumScaleFactor:1];
    [_arController setScaleViewsBasedOnDistance:YES];
    [_arController setRotateViewsBasedOnPerspective:YES];
    [_arController setDebugMode:NO];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self geoLocations];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
    // Dispose of any resources that can be recreated.

#pragma mark - Actions

- (IBAction)done:(id)sender {
    [[self delegate] secondViewControllerDidFinish:self];
}

- (void)generateGeoLocations {
    [self setGeoLocations:[NSMutableArray arrayWithCapacity:[_fishlocations count]]];
    
    for(Place *place in _fishlocations) {
        ARGeoCoordinate *coordinate = [ARGeoCoordinate coordinateWithLocation:[place location] locationTitle:[place placeName]];
        [coordinate calibrateUsingOrigin:[_userLocation location]];
        MarkerView *markerView = [[MarkerView alloc] initWithCoordinate:coordinate delegate:self];
        NSLog(@"Marker view %@", markerView);
        
        [coordinate setDisplayView:markerView];
        [_arController addCoordinate:coordinate];
        [_geoLocations addObject:coordinate];
    }
}

#pragma mark - ARLocationDelegate


- (NSMutableArray *)geoLocations {
    if(!_geoLocations) {
        [self generateGeoLocations];
    }
    return _geoLocations;
}

- (void)locationClicked:(ARGeoCoordinate *)coordinate {
    NSLog(@"Tapped location %@", coordinate);
}


-(void)didUpdateHeading:(CLHeading *)newHeading {
    
}

-(void)didUpdateLocation:(CLLocation *)newLocation {
    
}

-(void)didUpdateOrientation:(UIDeviceOrientation)orientation {
    
}
- (void)didTapMarker:(ARGeoCoordinate *)coordinate {
}

@end
