//
//
//  Copyright 2011 CityGrid Media, LLC All rights reserved.
//
#import "CGLocation.h"

@interface CGOffersLocation : CGLocation

#pragma mark -
#pragma mark Properties

@property (nonatomic, retain, readonly) NSString* businessHours;
@property (nonatomic, retain, readonly) NSArray* tags; // CGTag*

#pragma mark -
#pragma mark Initialization

- (id) initImmutable:(NSUInteger) locationId impressionId:(NSString*) impressionId name:(NSString*) name
			 address:(id) address latlon:(CLLocation*) latlon image:(NSURL*) image phone:(NSString*) phone
			  rating:(NSUInteger) rating businessHours:(NSString*) businessHours tags:(NSArray*) tags;

#pragma mark -
#pragma mark NSObject

- (BOOL) isEqualToOffersLocation:(CGOffersLocation*) other;

@end
