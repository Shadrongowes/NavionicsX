//
//  PlaceAnnotation.m
//  NavionicsX
//
//  Created by Jason Paolasini on 2015-10-15.
//  Copyright © 2015 Jason Paolasini. All rights reserved.
//

#import "PlaceAnnotation.h"
#import "Place.h"

@interface PlaceAnnotation ()
@property (nonatomic, strong) Place *place;
@end

@implementation PlaceAnnotation

- (id)initWithPlace:(Place *)place {
    if((self = [super init])) {
        _place = place;
    }
    return self;
}

- (CLLocationCoordinate2D)coordinate {
    return [_place location].coordinate;
}

- (NSString *)title {
    return [_place placeName];
}

@end
