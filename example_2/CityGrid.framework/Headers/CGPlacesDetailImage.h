//
//
//  Copyright 2011 CityGrid Media, LLC All rights reserved.
//
#import "CGObject.h"
#import "CGPlacesDetailImageType.h"

@interface CGPlacesDetailImage : CGObject

#pragma mark -
#pragma mark Properties

@property (nonatomic, assign, readonly) CGPlacesDetailImageType type;
@property (nonatomic, assign, readonly) NSInteger height;
@property (nonatomic, assign, readonly) NSInteger width;
@property (nonatomic, retain, readonly) NSURL* url;

#pragma mark -
#pragma mark Initialization

- (id) initImmutable:(CGPlacesDetailImageType) type height:(NSInteger) height width:(NSInteger) width
				 url:(NSURL*) url;

#pragma mark -
#pragma mark NSObject

- (BOOL) isEqualToPlacesDetailImage:(CGPlacesDetailImage*) other;

@end
