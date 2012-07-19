//
//
//  Copyright 2011 CityGrid Media, LLC All rights reserved.
//
#import "CGObject.h"

@class CGPlacesDetailLocation;

@interface CGPlacesDetailResults : CGObject

#pragma mark -
#pragma mark Properties

@property (nonatomic, retain, readonly) NSArray* locations; // CGPlacesDetailLocation
@property (nonatomic, retain, readonly) CGPlacesDetailLocation* location;

#pragma mark -
#pragma mark Initialization

- (id) initImmutable:(NSArray*) locations;

#pragma mark -
#pragma mark NSObject

- (BOOL) isEqualToPlacesDetailResults:(CGPlacesDetailResults*) other;

@end
