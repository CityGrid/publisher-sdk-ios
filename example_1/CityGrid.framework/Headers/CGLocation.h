//
//
//  Copyright 2011 CityGrid Media, LLC All rights reserved.
//
#import "CGObject.h"

@class CGPlacesDetail;
@class CGPlacesDetailLocation;

@interface CGLocation : CGObject

#pragma mark -
#pragma mark Properties

@property (nonatomic, assign, readonly) NSInteger locationId;
@property (nonatomic, retain, readonly) NSString* impressionId;
@property (nonatomic, retain, readonly) NSString* name;
@property (nonatomic, retain, readonly) id address; // CGAddress or CGPlacesDetailAddress
@property (nonatomic, retain, readonly) CLLocation* latlon;
@property (nonatomic, retain, readonly) NSURL* image;
@property (nonatomic, retain, readonly) NSString* phone;
@property (nonatomic, assign, readonly) NSInteger rating;

#pragma mark -
#pragma mark Initialization

- (id) initImmutable:(NSInteger) locationId impressionId:(NSString*) impressionId name:(NSString*) name
			 address:(id) address latlon:(CLLocation*) latlon image:(NSURL*) image phone:(NSString*) phone
			  rating:(NSInteger) rating;

#pragma mark -
#pragma mark NSObject

- (BOOL) isEqualToLocation:(CGLocation*) other;

#pragma mark -
#pragma mark Detail Helpers

- (CGPlacesDetail*) placesDetail;
- (CGPlacesDetailLocation*) placesDetailLocation:(NSArray**) errors;

@end
