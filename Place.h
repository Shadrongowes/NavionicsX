//
//  Place.h
//  NavionicsX
//
//  Created by Jason Paolasini on 2015-10-15.
//  Copyright © 2015 Jason Paolasini. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CLLocation;

@interface Place : NSObject

@property (nonatomic, strong) CLLocation *location;
@property (nonatomic, copy) NSString *reference;
@property (nonatomic, copy) NSString *placeName;
@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *phoneNumber;
@property (nonatomic, copy) NSString *website;

- (id)initWithLocation:(CLLocation *)location reference:(NSString *)reference name:(NSString *)name address:(NSString *)address;

@end
