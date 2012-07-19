//
//
//  Copyright 2011 CityGrid Media, LLC All rights reserved.
//
#import "CGObject.h"

@interface CGRegion : CGObject

#pragma mark -
#pragma mark Properties

@property (nonatomic, retain, readonly) NSString* type;
@property (nonatomic, retain, readonly) NSString* name;
@property (nonatomic, retain, readonly) CLLocation* latlon;
@property (nonatomic, assign, readonly) Float32 radius;

#pragma mark -
#pragma mark Initialization

- (id) initImmutable:(NSString*) type name:(NSString*) name latlon:(CLLocation*) latlon
		   radius:(Float32) radius;

#pragma mark -
#pragma mark NSObject

- (BOOL) isEqualToRegion:(CGRegion*) other;

@end
