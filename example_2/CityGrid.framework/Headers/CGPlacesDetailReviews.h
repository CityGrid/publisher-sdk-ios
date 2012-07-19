//
//
//  Copyright 2011 CityGrid Media, LLC All rights reserved.
//
#import "CGObject.h"

@class CGPlacesDetailReview;

@interface CGPlacesDetailReviews : CGObject

#pragma mark -
#pragma mark Properties

@property (nonatomic, assign, readonly) NSInteger rating;
@property (nonatomic, assign, readonly) NSInteger count;
@property (nonatomic, assign, readonly) NSInteger shown;
@property (nonatomic, retain, readonly) NSArray* reviews; // CGReview*

#pragma mark -
#pragma mark Initialization

- (id) initImmutable:(NSInteger) rating count:(NSInteger) count
		  shown:(NSInteger) shown reviews:(NSArray*) reviews;

#pragma mark -
#pragma mark NSObject

- (BOOL) isEqualToPlacesDetailReviews:(CGPlacesDetailReviews*) other;

@end
