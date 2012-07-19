//
//
//  Copyright 2011 CityGrid Media, LLC All rights reserved.
//
#import "CGOffersBuilder.h"
#import "CGOffersSearchSort.h"
#import "CGOffersType.h"
#import "CGOffersSearchTagOperation.h"

@class CGOffersSearchResults;

@interface CGOffersSearch : CGOffersBuilder

#pragma mark -
#pragma mark Properties

@property (nonatomic, retain) NSString* publisher;
@property (nonatomic, assign) CGOffersType type;
@property (nonatomic, retain) NSString* what;
@property (nonatomic, assign) NSInteger tag;
@property (nonatomic, retain) NSString* where;
@property (nonatomic, assign) CGOffersSearchTagOperation tagOperation;
@property (nonatomic, assign) NSInteger excludeTag;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, assign) NSInteger resultsPerPage;
@property (nonatomic, retain) NSDate* startDate;
@property (nonatomic, retain) NSDate* expiresBefore;
@property (nonatomic, assign) BOOL hasBudget;
@property (nonatomic, assign) CGOffersSearchSort sort;
@property (nonatomic, retain) NSString* source;
@property (nonatomic, assign) NSInteger popularity;
@property (nonatomic, assign) BOOL histograms;
@property (nonatomic, retain) NSString* placement;
@property (nonatomic, retain) NSString* impressionId;
@property (nonatomic, retain) CLLocation* latlon;
@property (nonatomic, retain) CLLocation* latlon2;
@property (nonatomic, assign) Float32 radius;
@property (nonatomic, assign) NSTimeInterval timeout;

#pragma mark -
#pragma mark Initialization

- (id) init:(NSString*) publisher;
+ (id) offersSearch;
+ (id) offersSearchWithPublisher:(NSString*) publisher;
+ (id) offersSearchWithPublisher:(NSString*) publisher placement:(NSString*) placement;
+ (id) offersSearchWithPlacement:(NSString*) placement;

#pragma mark -
#pragma mark Actions

- (CGOffersSearchResults*) search:(NSArray**) errors;

#pragma mark -
#pragma mark NSObject

- (BOOL) isEqualToOffersSearch:(CGOffersSearch*) other;

@end
