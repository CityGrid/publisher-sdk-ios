//
//
//  Copyright 2011 CityGrid Media, LLC All rights reserved.
//
#import "CGObject.h"

@interface CGPlacesSearchResults : CGObject

#pragma mark -
#pragma mark Properties

@property (nonatomic, assign, readonly) NSInteger firstHit;
@property (nonatomic, assign, readonly) NSInteger lastHit;
@property (nonatomic, assign, readonly) NSInteger totalHits;
@property (nonatomic, assign, readonly) NSInteger page;
@property (nonatomic, assign, readonly) NSInteger resultsPerPage;
@property (nonatomic, retain, readonly) NSURL* uri;
@property (nonatomic, retain, readonly) NSString* didYouMean;
@property (nonatomic, retain, readonly) NSArray* regions; // CGSearchRegion
@property (nonatomic, retain, readonly) NSArray* locations; // CGPlacesSearchLocation
@property (nonatomic, retain, readonly) NSArray* histograms; // CGSearchHistogram

#pragma mark -
#pragma mark Initialization

- (id) initImmutable:(NSInteger) firstHit lastHit:(NSInteger) lastHit totalHits:(NSInteger) totalHits
				page:(NSInteger) page resultsPerPage:(NSInteger) resultsPerPage uri:(NSURL*) uri
		  didYouMean:(NSString*) didYouMean regions:(NSArray*) regions locations:(NSArray*) locations
		  histograms:(NSArray*) histograms;

#pragma mark -
#pragma mark NSObject

- (BOOL) isEqualToPlacesSearchResults:(CGPlacesSearchResults*) other;

@end
