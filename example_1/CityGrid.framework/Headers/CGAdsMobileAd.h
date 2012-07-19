//
//
//  Copyright 2011 CityGrid Media, LLC All rights reserved.
//
#import "CGObject.h"

@class CGPlacesDetail;
@class CGPlacesDetailLocation;

@interface CGAdsMobileAd : CGObject

#pragma mark -
#pragma mark Properties

@property (nonatomic, assign, readonly) NSInteger locationId;
@property (nonatomic, retain, readonly) NSString* impressionId;
@property (nonatomic, retain, readonly) NSString* adId;
@property (nonatomic, retain, readonly) NSURL* destinationUrl;
@property (nonatomic, retain, readonly) NSURL* image;

#pragma mark -
#pragma mark Initialization

- (id) initImmutable:(NSInteger) locationId impressionId:(NSString*) impressionId adId:(NSString*) adId
	  destinationUrl:(NSURL*) destinationUrl image:(NSURL*) image;

#pragma mark -
#pragma mark NSObject

- (BOOL) isEqualToAdsMobileAd:(CGAdsMobileAd*) other;

#pragma mark -
#pragma mark Detail Helpers

- (CGPlacesDetail*) placesDetail;
- (CGPlacesDetailLocation*) placesDetailLocation:(NSArray**) errors;

@end
