//
//
//  Copyright 2011 CityGrid Media, LLC All rights reserved.
//
#import "CGAddress.h"

@interface CGPlacesDetailAddress : CGAddress <NSCoding, NSCopying>

#pragma mark -
#pragma mark Properties

@property (nonatomic, retain, readonly) NSString* deliveryPoint;
@property (nonatomic, retain, readonly) NSString* crossStreet;

#pragma mark -
#pragma mark Initialization

- (id) initImmutable:(NSString*) street city:(NSString*) city state:(NSString*) state zip:(NSString*) zip
	   deliveryPoint:(NSString*) deliveryPoint crossStreet:(NSString*) crossStreet;

#pragma mark -
#pragma mark NSObject

- (BOOL) isEqualToPlacesDetailAddress:(CGPlacesDetailAddress*) other;

@end
