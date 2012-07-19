//
//
//  Copyright 2011 CityGrid Media, LLC All rights reserved.
//
#import "CGTReviewsSearchTests.h"
#import "CityGrid.h"
#import "CGConstants.h"
#import "CGTConstants.h"

@implementation CGTReviewsSearchTests

- (CGReviewsSearch*) build {
	CGReviewsSearch* builder = [[[CGReviewsSearch alloc] init:CGT_PUBLISHER] autorelease];
	builder.type = CGReviewTypeUserReview;
	builder.what = @"1111";
	builder.tag = 2222;
	builder.where = @"3333";
	builder.radius = 4444.0;
	builder.page = 5555;
	builder.resultsPerPage = 6666;
	builder.placement = @"PLACEMENT";
	builder.timeout = 11.0;
	builder.impressionId = @"IMPRESSION_ID";
	builder.latlon = [[[CLLocation alloc] initWithLatitude:1.0 longitude:2.0] autorelease];
	builder.rating = 7777;
	builder.days = 8888;
	builder.customerOnly = YES;
	builder.locationId = 9999;
	return builder;
}

- (void) assertBuilder:(CGReviewsSearch*) builder parent:(NSString*) parent {
	STAssertNotNil(builder, @"builder is nil");
	STAssertTrue(builder.type == CGReviewTypeUserReview, @"type %i for %@ is not %i", builder.type, parent, CGReviewTypeUserReview);
	STAssertTrue([builder.what isEqualToString:@"1111"], @"what %@ for %@ is not 1111", builder.what, parent);
	STAssertTrue(builder.tag == 2222, @"tag %i for %@ is not 2222", builder.tag, parent);
	STAssertTrue([builder.where isEqualToString:@"3333"], @"where %@ for %@ is not 3333", builder.where, parent);
	STAssertTrue(builder.radius == 4444.0, @"radius %f for %@ is not 4444.0", builder.radius, parent);
	STAssertTrue(builder.page == 5555, @"page %i for %@ is not 5555", builder.page, parent);
	STAssertTrue(builder.resultsPerPage == 6666, @"resultsPerPage %i for %@ is not 6666", builder.resultsPerPage, parent);
	STAssertTrue([builder.placement isEqualToString:@"PLACEMENT"], @"placement %@ for %@ is not PLACEMENT", builder.placement, parent);
	STAssertTrue(builder.timeout == 11.0, @"timeout %f for %@ is not 11.0", builder.timeout, parent);
	STAssertTrue([builder.impressionId isEqualToString:@"IMPRESSION_ID"], @"placement %@ for %@ is not IMPRESSION_ID", builder.impressionId, parent);
	STAssertTrue(builder.latlon.coordinate.latitude == 1.0 && builder.latlon.coordinate.longitude == 2.0, @"latlon %f,%f for %@ is not %f,%f", builder.latlon.coordinate.latitude, builder.latlon.coordinate.longitude, parent, 1.0, 2.0);
	STAssertTrue(builder.rating == 7777, @"rating %i for %@ is not 7777", builder.rating, parent);
	STAssertTrue(builder.days == 8888, @"rating %i for %@ is not 8888", builder.days, parent);
	STAssertTrue(builder.customerOnly, @"customerOnly %u for %@ is not YES", builder.customerOnly, parent);
	STAssertTrue(builder.locationId == 9999, @"rating %i for %@ is not 9999", builder.locationId, parent);
}

- (void) testCopy {
	CGReviewsSearch* search1 = [self build];
	CGReviewsSearch* search2 = [[search1 copy] autorelease];
	
	STAssertTrue([search1 isEqualToReviewsSearch:search2], @"Specific equals failed");
	STAssertTrue([search1 isEqual:search2], @"Generic equals failed");
	[self assertBuilder:search2 parent:@"testCopy"];
}

- (void) testCoding {
	CGReviewsSearch* search1 = [self build];
	NSData* archive = [NSKeyedArchiver archivedDataWithRootObject:search1];
	CGReviewsSearch* search2 = [NSKeyedUnarchiver unarchiveObjectWithData:archive];
	
	STAssertTrue([search1 isEqualToReviewsSearch:search2], @"Specific equals failed");
	STAssertTrue([search1 isEqual:search2], @"Generic equals failed");
	[self assertBuilder:search2 parent:@"testCoding"];
}

- (void) testWhereValidation {
	NSArray* errors = nil;
	CGReviewsSearch* search1 = [[[CGReviewsSearch alloc] init:nil] autorelease];
	[search1 search:&errors];
	STAssertTrue([errors count] == 3, @"Empty search, expected 3 errors, got %i", [errors count]);
	search1.what = @"pizza";
	[search1 search:&errors];
	STAssertTrue([errors count] == 2, @"Search with what, expected 2 errors, got %i", [errors count]);
	search1.what = nil;
	search1.type = CGReviewTypeEditorialReview;
	[search1 search:&errors];
	STAssertTrue([errors count] == 2, @"Search with type, expected 2 errors, got %i", [errors count]);
	search1.type = CGReviewTypeUnknown;
	search1.what = @"pizza";
	search1.publisher = CGT_PUBLISHER;
	[search1 search:&errors];
	STAssertTrue([errors count] == 1, @"Search with publisher, expected 1 error, got %i", [errors count]);
	search1.publisher = nil;
	search1.where = @"90034";
	[search1 search:&errors];
	STAssertTrue([errors count] == 1, @"Search with where, expected 1 error, got %i", [errors count]);
	search1.tag = 0;
	[search1 search:&errors];
	STAssertTrue([errors count] == 2, @"Search with invalid tag, expected 2 errors, got %i", [errors count]);
	search1.tag = CG_NSINTEGER_UNKNOWN;
	search1.resultsPerPage = 0;
	[search1 search:&errors];
	STAssertTrue([errors count] == 2, @"Search with invalid resultsPerPage, expected 2 errors, got %i", [errors count]);
	search1.resultsPerPage = CG_NSINTEGER_UNKNOWN;
	search1.page = 0;
	[search1 search:&errors];
	STAssertTrue([errors count] == 2, @"Search with invalid page, expected 2 errors, got %i", [errors count]);
	search1.page = CG_NSINTEGER_UNKNOWN;
	search1.rating = 11;
	[search1 search:&errors];
	STAssertTrue([errors count] == 2, @"Search with invalid rating, expected 2 errors, got %i", [errors count]);
	search1.rating = CG_NSINTEGER_UNKNOWN;
	search1.days = 0;
	[search1 search:&errors];
	STAssertTrue([errors count] == 2, @"Search with invalid days, expected 2 errors, got %i", [errors count]);
}

- (void) testLatLonValidation {
	NSArray* errors = nil;
	CGReviewsSearch* search1 = [[[CGReviewsSearch alloc] init:nil] autorelease];
	[search1 search:&errors];
	STAssertTrue([errors count] == 3, @"Empty search, expected 3 errors, got %i", [errors count]);
	search1.what = @"pizza";
	[search1 search:&errors];
	STAssertTrue([errors count] == 2, @"Search with what, expected 2 errors, got %i", [errors count]);
	search1.what = nil;
	search1.type = CGReviewTypeEditorialReview;
	[search1 search:&errors];
	STAssertTrue([errors count] == 2, @"Search with type, expected 2 errors, got %i", [errors count]);
	search1.type = CGReviewTypeUnknown;
	search1.what = @"pizza";
	search1.publisher = CGT_PUBLISHER;
	[search1 search:&errors];
	STAssertTrue([errors count] == 1, @"Search with publisher, expected 1 error, got %i", [errors count]);
	search1.publisher = nil;
	search1.latlon = [[[CLLocation alloc] initWithLatitude:30.0 longitude:30.0] autorelease];
	[search1 search:&errors];
	STAssertTrue([errors count] == 2, @"Search with where, expected 2 errors, got %i", [errors count]);
	search1.radius = 3.0;
	[search1 search:&errors];
	STAssertTrue([errors count] == 1, @"Search with where, expected 1 error, got %i", [errors count]);
	search1.tag = 0;
	[search1 search:&errors];
	STAssertTrue([errors count] == 2, @"Search with invalid tag, expected 2 errors, got %i", [errors count]);
	search1.tag = CG_NSINTEGER_UNKNOWN;
	search1.resultsPerPage = 0;
	[search1 search:&errors];
	STAssertTrue([errors count] == 2, @"Search with invalid resultsPerPage, expected 2 errors, got %i", [errors count]);
	search1.resultsPerPage = CG_NSINTEGER_UNKNOWN;
	search1.page = 0;
	[search1 search:&errors];
	STAssertTrue([errors count] == 2, @"Search with invalid page, expected 2 errors, got %i", [errors count]);
	search1.page = CG_NSINTEGER_UNKNOWN;
	search1.latlon = [[[CLLocation alloc] initWithLatitude:181.0 longitude:181.0] autorelease];
	[search1 search:&errors];
	STAssertTrue([errors count] == 3, @"Search with where, expected 3 errors, got %i", [errors count]);
	search1.latlon = [[[CLLocation alloc] initWithLatitude:30.0 longitude:30.0] autorelease];
	search1.radius = CG_FLOAT32_UNKNOWN;
	[search1 search:&errors];
	STAssertTrue([errors count] == 2, @"Search with where, expected 2 errors, got %i", [errors count]);
	search1.radius = 0.0;
	[search1 search:&errors];
	STAssertTrue([errors count] == 2, @"Search with where, expected 2 errors, got %i", [errors count]);
	search1.latlon = nil;
	search1.radius = CG_FLOAT32_UNKNOWN;
	search1.rating = 11;
	[search1 search:&errors];
	STAssertTrue([errors count] == 3, @"Search with invalid rating, expected 3 errors, got %i", [errors count]);
	search1.rating = CG_NSINTEGER_UNKNOWN;
	search1.days = 0;
	[search1 search:&errors];
	STAssertTrue([errors count] == 3, @"Search with invalid days, expected 3 errors, got %i", [errors count]);
}

- (void) assertReview:(CGReview*) review parent:(NSString*) parent {
	STAssertNotNil(review, @"Expected to have review for %@", parent);
	STAssertTrue([review.reviewId length] > 0, @"Expected to have reviewId for %@", parent);
	STAssertNotNil(review.url, @"Expected to have url for %@", parent);
	STAssertTrue([review.title length] > 0, @"Expected to have title for %@", parent);
	STAssertTrue([review.author length] > 0, @"Expected to have author for %@", parent);
	STAssertTrue([review.text length] > 0, @"Expected to have text for %@", parent);
	STAssertNotNil(review.date, @"Expected to have date for %@", parent);
	STAssertTrue(review.rating != CG_NSINTEGER_UNKNOWN, @"Expected to have a rating for %@ was %i", parent, review.rating);
	STAssertTrue([review.attributionText length] > 0, @"Expected to have attributionText for %@", parent);
}

- (void) assertReviews:(NSArray*) reviews parent:(NSString*) parent {
	STAssertTrue([reviews count] > 0, @"Expected to have reviews for %@", parent);
	for (CGReviewsSearchReview* review in reviews) {
		[self assertReview:review parent:parent];
		
		STAssertTrue([review.impressionId length] > 0, @"Expected to have impressionId for %@", parent);
		STAssertTrue(review.referenceId != CG_NSINTEGER_UNKNOWN, @"Expected to have a referenceId for %@ was %i", parent, review.referenceId);
// Some times there is no business name...
//		STAssertTrue([review.businessName length] > 0, @"Expected to have businessName for %@", parent);
		STAssertTrue(review.type != CGReviewTypeUnknown, @"Expected to have a type for %@ was %i", parent, review.type);
	}
}

- (void) assertResults:(CGReviewsSearchResults*) results parent:(NSString*) parent {
	STAssertNotNil(results, @"Expected to have results for %@", parent);
	STAssertTrue(results.firstHit == 1, @"Expected firstHit to be 1 for %@ was %i", parent, results.firstHit);
	STAssertTrue(results.lastHit > 0, @"Expected lastHit to be greater than 0 for %@ was %i", parent, results.lastHit);
	STAssertTrue(results.totalHits > 0, @"Expected totalHits to be greater than 0 for %@ was %i", parent, results.totalHits);
	STAssertNotNil(results.uri, @"Expected to have uri for %@", parent);
	if (results.uri && [[results.uri absoluteString] rangeOfString:@"lat="].location == NSNotFound) {
		[self assertRegions:results.regions parent:parent];
	}
	if (results.uri && [[results.uri absoluteString] rangeOfString:@"histograms=true"].location != NSNotFound) {
		[self assertHistograms:results.histograms parent:parent];
	}
	[self assertReviews:results.reviews parent:parent];
}

- (void) testFindSushiInLosAngeles {
	CGReviewsSearch* search = [CityGrid reviewsSearch];
	search.where = @"los angeles, ca";
	search.what = @"sushi";
	
	NSArray* errors = nil;
	CGReviewsSearchResults* results = [search search:&errors];
	
	STAssertNil(errors, @"Expected to have no errors, had %@", errors);
	if ([errors count] == 0) {
		[self assertResults:results parent:@"testFindSushiInLosAngeles"];
	}
}

- (void) testFindSushiIn90025 {
	CGReviewsSearch* search = [CityGrid reviewsSearch];
	search.where = @"90025";
	search.what = @"sushi";
	
	NSArray* errors = nil;
	CGReviewsSearchResults* results = [search search:&errors];
	
	STAssertNil(errors, @"Expected to have no errors, had %@", errors);
	if ([errors count] == 0) {
		[self assertResults:results parent:@"testFindSushiIn90025"];
	}
}

- (void) testFindSushiLatLon {
	CGReviewsSearch* search = [CityGrid reviewsSearch];
	search.latlon = [[[CLLocation alloc] initWithLatitude:34.10652 longitude:-118.411509] autorelease];
	search.what = @"sushi";
	search.radius = 10.0;
	
	NSArray* errors = nil;
	CGReviewsSearchResults* results = [search search:&errors];
	
	STAssertNil(errors, @"Expected to have no errors, had %@", errors);
	if ([errors count] == 0) {
		[self assertResults:results parent:@"testFindSushiLatLon"];
	}
}

- (void) testResults {
	CGReviewsSearch* search = [CityGrid reviewsSearch];
	search.what = @"sushi";
	search.where = @"90025";
    search.sort = CGReviewsSearchSortReviewRating;
	search.resultsPerPage = 1;
	
	NSArray* errors = nil;
	CGReviewsSearchResults* results = [search search:&errors];
	
	STAssertNil(errors, @"Expected to have no errors, had %@", errors);
	if ([errors count] == 0) {
		[self assertResults:results parent:@"testResults"];
	}
	
	NSString* description = [results description];
	STAssertNotNil(description, @"Expected description was %@", description);
	
	CGReviewsSearchResults* resultsCopy = [results copy];
	STAssertTrue([results isEqualToReviewsSearchResults:resultsCopy], @"Specific equals failed");
	STAssertTrue([results isEqual:resultsCopy], @"Generic equals failed");
	
	NSData* archive = [NSKeyedArchiver archivedDataWithRootObject:results];
	CGReviewsSearchResults* resultsArchive = [NSKeyedUnarchiver unarchiveObjectWithData:archive];
	STAssertTrue([results isEqualToReviewsSearchResults:resultsArchive], @"Specific equals failed");
	STAssertTrue([results isEqual:resultsArchive], @"Generic equals failed");
}

@end
