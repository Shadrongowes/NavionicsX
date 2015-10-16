//
//  PlaceAnnotation.h
//  NavionicsX
//
//  Created by Jason Paolasini on 2015-10-15.
//  Copyright © 2015 Jason Paolasini. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@class Place;

@interface PlaceAnnotation : NSObject <MKAnnotation>

- (id)initWithPlace:(Place *)place;
- (CLLocationCoordinate2D)coordinate;
- (NSString *)title;

@end