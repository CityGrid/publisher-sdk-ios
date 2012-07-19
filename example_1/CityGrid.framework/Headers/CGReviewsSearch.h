//
//
//  Copyright 2011 CityGrid Media, LLC All rights reserved.
//
#import "CGContentBuilder.h"
#import "CGReviewType.h"
#import "CGPlacesSearchSort.h"
#import "CGReviewsSearchSort.h"

@class CGReviewsSearchResults;

@interface CGReviewsSearch : CGContentBuilder

#pragma mark -
#pragma mark Properties

@property (nonatomic, retain) NSString* publisher;
@property (nonatomic, assign) CGReviewType type;
@property (nonatomic, assign) CGReviewsSearchSort sort;
@property (nonatomic, retain) NSString* what;
@property (nonatomic, assign) NSInteger tag;
@property (nonatomic, retain) NSString* where;
@property (nonatomic, assign) Float32 radius;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, assign) NSInteger resultsPerPage;
@property (nonatomic, retain) NSString* placement;
@property (nonatomic, retain) NSString* impressionId;
@property (nonatomic, retain) CLLocation* latlon;

@property (nonatomic, assign) NSInteger rating;
@property (nonatomic, assign) NSInteger days;
@property (nonatomic, assign) BOOL customerOnly;
@property (nonatomic, assign) NSInteger locationId;

@property (nonatomic, assign) NSTimeInterval timeout;

#pragma mark -
#pragma mark Initialization

- (id) init:(NSString*) publisher;
+ (id) reviewsSearch;
+ (id) reviewsSearchWithPublisher:(NSString*) publisher;
+ (id) reviewsSearchWithPlacement:(NSString*) placement;
+ (id) reviewsSearchWithPublisher:(NSString*) publisher placement:(NSString*) placement;

#pragma mark -
#pragma mark Actions

- (CGReviewsSearchResults*) search:(NSArray**) errors;

#pragma mark -
#pragma mark NSObject

- (BOOL) isEqualToReviewsSearch:(CGReviewsSearch*) other;

@end
