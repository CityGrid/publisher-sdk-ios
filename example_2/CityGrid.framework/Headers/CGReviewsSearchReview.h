//
//
//  Copyright 2011 CityGrid Media, LLC All rights reserved.
//
#import "CGReview.h"
#import "CGReviewType.h"

@class CGPlacesDetail;
@class CGPlacesDetailLocation;

@interface CGReviewsSearchReview : CGReview

#pragma mark -
#pragma mark Properties

@property (nonatomic, retain, readonly) NSString* impressionId;
@property (nonatomic, assign, readonly) NSInteger referenceId;
@property (nonatomic, assign, readonly) NSInteger sourceId;
@property (nonatomic, assign, readonly) NSInteger locationId;
@property (nonatomic, retain, readonly) NSString* businessName;
@property (nonatomic, retain, readonly) NSURL* authorUrl;
@property (nonatomic, assign, readonly) CGReviewType type;

#pragma mark -
#pragma mark Initialization

- (id) initImmutable:(NSString*) reviewId url:(NSURL*) url title:(NSString*) title author:(NSString*) author
				text:(NSString*) text pros:(NSString*) pros cons:(NSString*) cons date:(NSDate*) date
			  rating:(NSInteger) rating  helpful:(NSInteger) helpful unhelpful:(NSInteger) unhelpful
	 attributionText:(NSString*) attributionText attributionLogo:(NSURL*) attributionLogo
   attributionSource:(NSInteger) attributionSource
	  attributionUrl:(NSURL*) attributionUrl impressionId:(NSString*) impressionId
		 referenceId:(NSInteger) referenceId sourceId:(NSInteger) sourceId locationId:(NSInteger) locationId
		businessName:(NSString*) businessName authorUrl:(NSURL*) authorUrl type:(CGReviewType) type;

#pragma mark -
#pragma mark NSObject

- (BOOL) isEqualToReviewsSearchReview:(CGReviewsSearchReview*) other;

#pragma mark -
#pragma mark Detail Helpers

- (CGPlacesDetail*) placesDetail;
- (CGPlacesDetailLocation*) placesDetailLocation:(NSArray**) errors;

@end
