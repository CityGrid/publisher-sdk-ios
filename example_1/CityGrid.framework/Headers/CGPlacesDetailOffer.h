//
//
//  Copyright 2011 CityGrid Media, LLC All rights reserved.
//
#import "CGObject.h"

@interface CGPlacesDetailOffer : CGObject

#pragma mark -
#pragma mark Properties

@property (nonatomic, retain, readonly) NSString* name;
@property (nonatomic, retain, readonly) NSString* text;
@property (nonatomic, retain, readonly) NSString* offerDescription;
@property (nonatomic, retain, readonly) NSURL* url;
@property (nonatomic, retain, readonly) NSDate* expirationDate;

#pragma mark -
#pragma mark Initialization

- (id) initImmutable:(NSString*) name text:(NSString*) text offerDescription:(NSString*) offerDescription
				 url:(NSURL*) url expirationDate:(NSDate*) expirationDate;

#pragma mark -
#pragma mark NSObject

- (BOOL) isEqualToPlacesDetailOffer:(CGPlacesDetailOffer*) other;

@end
