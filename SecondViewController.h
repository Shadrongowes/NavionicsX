//
//  SecondViewController.h
//  NavionicsX
//
//  Created by Jason Paolasini on 2015-09-24.
//  Copyright © 2015 Jason Paolasini. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "ARKit.h"

@class SecondViewController;

@protocol SecondViewControllerDelegate
- (void)secondViewControllerDidFinish:(SecondViewController *)controller;
@end

@interface SecondViewController : UIViewController <ARLocationDelegate, ARDelegate, ARMarkerDelegate>
@property (weak, nonatomic) id <SecondViewControllerDelegate> delegate;
@property (nonatomic, strong) NSArray *fishlocations;
@property (nonatomic, strong) MKUserLocation *userLocation;

- (IBAction)done:(id)sender;

@end

