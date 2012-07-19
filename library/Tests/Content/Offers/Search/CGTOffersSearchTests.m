//
//
//  Copyright 2011 CityGrid Media, LLC All rights reserved.
//
#import <CoreLocation/CoreLocation.h>
#import "CGTOffersSearchTests.h"
#import "CGTConstants.h"
#import "CityGrid.h"
#import "CGConstants.h"

@implementation CGTOffersSearchTests

- (CGOffersSearch*) buildSearch {
	CGOffersSearch* search = [[CGOffersSearch alloc] init:CGT_PUBLISHER];
	search.type = CGOffersTypeDailyDeal;
	search.what = @"WHAT";
	search.tag = 1111;
	search.where = @"WHERE";
	search.tagOperation = CGOffersSearchTagOperationAnd;
	search.excludeTag = 2222;
	search.page = 3333;
	search.resultsPerPage = 4444;
	search.startDate = [NSDate dateWithTimeIntervalSince1970:5555];
	search.expiresBefore = [NSDate dateWithTimeIntervalSince1970:6666];
	search.hasBudget = YES;
	search.sort = CGOffersSearchSortAlphabetical;
	search.source = @"SOURCE";
	search.popularity = 7777;
	search.histograms = YES;
	search.placement = @"PLACEMENT";
	search.impressionId = @"IMPRESSION_ID";
	search.latlon = [[[CLLocation alloc] initWithLatitude:2.0 longitude:3.0] autorelease];
	search.latlon2 = [[[CLLocation alloc] initWithLatitude:4.0 longitude:5.0] autorelease];
	search.radius = 8888.0;
	search.timeout = 9999.0;
	return [search autorelease];
}

- (void) testDescription {
	CGOffersSearch* search = [self buildSearch];
	
	NSString* description = [search description];
	STAssertTrue([description rangeOfString:@"publisher=test"].location != NSNotFound, @"Couldn't find publisher in %@", description);
	STAssertTrue([description rangeOfString:@"type=10"].location != NSNotFound, @"Couldn't find type in %@", description);
	STAssertTrue([description rangeOfString:@"what=WHAT"].location != NSNotFound, @"Couldn't find what in %@", description);
	STAssertTrue([description rangeOfString:@"tag=1111"].location != NSNotFound, @"Couldn't find tag in %@", description);
	STAssertTrue([description rangeOfString:@"where=WHERE"].location != NSNotFound, @"Couldn't find where in %@", description);
	STAssertTrue([description rangeOfString:@"tagOperation=1"].location != NSNotFound, @"Couldn't find tagOperation in %@", description);
	STAssertTrue([description rangeOfString:@"excludeTag=2222"].location != NSNotFound, @"Couldn't find excludeTag in %@", description);
	STAssertTrue([description rangeOfString:@"page=3333"].location != NSNotFound, @"Couldn't find page in %@", description);
	STAssertTrue([description rangeOfString:@"resultsPerPage=4444"].location != NSNotFound, @"Couldn't find resultsPerPage in %@", description);
	STAssertTrue([description rangeOfString:@"startDate="].location != NSNotFound, @"Couldn't find startDate in %@", description);
	STAssertTrue([description rangeOfString:@"expiresBefore="].location != NSNotFound, @"Couldn't find expiresBefore in %@", description);
	STAssertTrue([description rangeOfString:@"hasBudget=1"].location != NSNotFound, @"Couldn't find hasBudget in %@", description);
	STAssertTrue([description rangeOfString:@"sort=6"].location != NSNotFound, @"Couldn't find sort in %@", description);
	STAssertTrue([description rangeOfString:@"source=SOURCE"].location != NSNotFound, @"Couldn't find source in %@", description);
	STAssertTrue([description rangeOfString:@"popularity=7777"].location != NSNotFound, @"Couldn't find popularity in %@", description);
	STAssertTrue([description rangeOfString:@"histograms=1"].location != NSNotFound, @"Couldn't find histograms in %@", description);
	STAssertTrue([description rangeOfString:@"placement=PLACEMENT"].location != NSNotFound, @"Couldn't find placement in %@", description);
	STAssertTrue([description rangeOfString:@"impressionId=IMPRESSION_ID"].location != NSNotFound, @"Couldn't find impressionId in %@", description);
	STAssertTrue([description rangeOfString:@"latlon=<+2.00000000"].location != NSNotFound, @"Couldn't find lat in %@", description);
	STAssertTrue([description rangeOfString:@"+3.00000000>"].location != NSNotFound, @"Couldn't find lon in %@", description);
	STAssertTrue([description rangeOfString:@"latlon2=<+4.00000000"].location != NSNotFound, @"Couldn't find lat2 in %@", description);
	STAssertTrue([description rangeOfString:@"+5.00000000>"].location != NSNotFound, @"Couldn't find lon2 in %@", description);
	STAssertTrue([description rangeOfString:@"radius=8888"].location != NSNotFound, @"Couldn't find radius in %@", description);
	STAssertTrue([description rangeOfString:@"timeout=9999"].location != NSNotFound, @"Couldn't find timeout in %@", description);
}

- (void) assertSearch:(CGOffersSearch*) search parent:(NSString*) parent {
	STAssertNotNil(search, @"search is nil");
	STAssertTrue([search.publisher isEqualToString:@"test"], @"what %@ for %@ is not test", search.what, parent);
	STAssertTrue(search.type == CGOffersTypeDailyDeal, @"type %i for %@ is not %i", search.type, parent, CGOffersTypeDailyDeal);
	STAssertTrue([search.what isEqualToString:@"WHAT"], @"what %@ for %@ is not WHAT", search.what, parent);
	STAssertTrue(search.tag == 1111, @"tag %i for %@ is not 1111", search.tag, parent);
	STAssertTrue([search.where isEqualToString:@"WHERE"], @"where %@ for %@ is not WHERE", search.where, parent);
	STAssertTrue(search.tagOperation == 1, @"tagOperation %i for %@ is not 1", search.page, parent);
	STAssertTrue(search.excludeTag == 2222, @"excludeTag %i for %@ is not 2222", search.page, parent);
	STAssertTrue(search.page == 3333, @"page %i for %@ is not 3333", search.page, parent);
	
	
	STAssertTrue(search.resultsPerPage == 4444, @"resultsPerPage %i for %@ is not 4444", search.resultsPerPage, parent);
	STAssertTrue(search.sort == 6, @"sort %i for %@ is not 6", search.sort, parent);
	STAssertTrue(search.histograms, @"histograms %i for %@ is not 1", search.histograms, parent);
	STAssertTrue([search.placement isEqualToString:@"PLACEMENT"], @"placement %@ for %@ is not PLACEMENT", search.placement, parent);
	STAssertTrue([search.impressionId isEqualToString:@"IMPRESSION_ID"], @"impressionId %@ for %@ is not IMPRESSION_ID", search.impressionId, parent);
	STAssertTrue(search.latlon.coordinate.latitude == 2.0 && search.latlon.coordinate.longitude == 3.0, @"latlon %f,%f for %@ is not %f,%f", search.latlon.coordinate.latitude, search.latlon.coordinate.longitude, parent, 2.0, 3.0);
	STAssertTrue(search.latlon2.coordinate.latitude == 4.0 && search.latlon2.coordinate.longitude == 5.0, @"latlon %%f,%f for %@ is not %f,%f", search.latlon.coordinate.latitude, search.latlon.coordinate.longitude, parent, 4.0, 5.0);
	STAssertTrue(search.radius == 8888.0, @"radius %f for %@ is not %f", search.radius, parent, 8888.0);
	STAssertTrue(search.timeout == 9999.0, @"timeout %f for %@ is not %f", search.timeout, parent, 9999.0);
}

- (void) testCopy {
	CGOffersSearch* search1 = [self buildSearch];
	CGOffersSearch* search2 = [[search1 copy] autorelease];
	
	STAssertTrue([search1 isEqualToOffersSearch:search2], @"Specific equals failed");
	STAssertTrue([search1 isEqual:search2], @"Generic equals failed");
	[self assertSearch:search2 parent:@"testCopy"];
}

- (void) testCoding {
	CGOffersSearch* search1 = [self buildSearch];
	NSData* archive = [NSKeyedArchiver archivedDataWithRootObject:search1];
	CGOffersSearch* search2 = [NSKeyedUnarchiver unarchiveObjectWithData:archive];
	
	STAssertTrue([search1 isEqualToOffersSearch:search2], @"Specific equals failed");
	STAssertTrue([search1 isEqual:search2], @"Generic equals failed");
	[self assertSearch:search2 parent:@"testCoding"];
}

- (void) testWhereValidation {
	NSArray* errors = nil;
	CGOffersSearch* search1 = [[[CGOffersSearch alloc] init:nil] autorelease];
	[search1 search:&errors];
	STAssertTrue([errors count] == 3, @"Empty search, expected 3 errors, got %i", [errors count]);
	search1.what = @"pizza";
	[search1 search:&errors];
	STAssertTrue([errors count] == 2, @"Search with what, expected 2 errors, got %i", [errors count]);
	search1.what = nil;
	search1.type = CGOffersTypeFree;
	[search1 search:&errors];
	STAssertTrue([errors count] == 2, @"Search with type, expected 2 errors, got %i", [errors count]);
	search1.type = CGOffersTypeUnknown;
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
}

- (void) testLatLonValidation {
	NSArray* errors = nil;
	CGOffersSearch* search1 = [[[CGOffersSearch alloc] init:nil] autorelease];
	[search1 search:&errors];
	STAssertTrue([errors count] == 3, @"Empty search, expected 3 errors, got %i", [errors count]);
	search1.what = @"pizza";
	[search1 search:&errors];
	STAssertTrue([errors count] == 2, @"Search with what, expected 2 errors, got %i", [errors count]);
	search1.what = nil;
	search1.type = CGOffersTypeDailyDeal;
	[search1 search:&errors];
	STAssertTrue([errors count] == 2, @"Search with type, expected 2 errors, got %i", [errors count]);
	search1.type = CGOffersTypeUnknown;
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
	search1.latlon2 = [[[CLLocation alloc] initWithLatitude:181.0 longitude:181.0] autorelease];
	[search1 search:&errors];
	STAssertTrue([errors count] == 5, @"Search with where, expected 5 errors, got %i", [errors count]);
	search1.latlon = [[[CLLocation alloc] initWithLatitude:30.0 longitude:30.0] autorelease];
	search1.latlon2 = nil;
	search1.radius = CG_FLOAT32_UNKNOWN;
	[search1 search:&errors];
	STAssertTrue([errors count] == 2, @"Search with where, expected 2 errors, got %i", [errors count]);
	search1.radius = 0.0;
	[search1 search:&errors];
	STAssertTrue([errors count] == 2, @"Search with where, expected 2 errors, got %i", [errors count]);
}

- (void) assertLocations:(NSArray*) locations parent:(NSString*) parent {
	STAssertTrue([locations count] > 0, @"Expected to have locations for %@ was %i", parent, [locations count]);
	for (CGOffersLocation* location in locations) {
		[self assertLocation:location parent:parent assertAddress:YES];
		STAssertTrue([location.tags count] > 0, @"Expectd to have tags greater than 0 for %@ was %i", parent, [location.tags count]);
	}
}

- (void) assertOffers:(NSArray*) offers parent:(NSString*) parent {
	STAssertTrue([offers count] > 0, @"Expected to have offers for %@", parent);
	for (CGOffersOffer* offer in offers) {
		STAssertTrue([offer.offerId length] > 0, @"Expected to have offerId for %@", parent);
		STAssertTrue([offer.impressionId length] > 0, @"Expected to have impressionId for %@", parent);
		STAssertTrue([offer.title length] > 0, @"Expected to have title for %@", parent);
		STAssertTrue([offer.offerDescription length] > 0, @"Expected to have offerDescription for %@", parent);
		STAssertTrue(offer.redemptionTypeId > 0, @"Expected to have a redemptionTypeId greater than 0 for %@ was %i", parent, offer.redemptionTypeId);
		STAssertTrue([offer.redemptionType length] > 0, @"Expected to have redemptionType for %@", parent);
		STAssertTrue([offer.terms length] > 0, @"Expected to have terms for %@", parent);
//		STAssertTrue([offer.source length] > 0, @"Expected to have source for %@", parent);
		STAssertTrue([offer.types count] > 0, @"Expected to have types for %@", parent);
		STAssertNotNil(offer.startDate, @"Expected to have startDate for %@", parent);
		STAssertTrue([offer.attributionSource length] > 0, @"Expected to have attributionSource for %@", parent);
		[self assertLocations:offer.locations parent:parent];
	}
}

- (void) assertResults:(CGOffersSearchResults*) results parent:(NSString*) parent {
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
	[self assertOffers:results.offers parent:parent];
}

- (void) testFindSushiInLosAngeles {
	CGOffersSearch* search = [CityGrid offersSearch];
	search.what = @"sushi";
	search.where = @"Los Angeles, CA";
	search.histograms = YES;
	
	NSArray* errors = nil;
	CGOffersSearchResults* results = [search search:&errors];
	
	STAssertNil(errors, @"Expected to have no errors, had %@", errors);
	if ([errors count] == 0) {
		[self assertResults:results parent:@"testFindSushiInLosAngeles"];
	}
}

- (void) testFindSushiIn90025 {
	CGOffersSearch* search = [CityGrid offersSearch];
	search.what = @"sushi";
	search.where = @"90025";
	
	NSArray* errors = nil;
	CGOffersSearchResults* results = [search search:&errors];
	
	STAssertNil(errors, @"Expected to have no errors, had %@", errors);
	if ([errors count] == 0) {
		[self assertResults:results parent:@"testFindSushiInLosAngeles"];
	}
}

- (void) testFindSushiInLatLon {
	CGOffersSearch* search = [CityGrid offersSearch];
	search.what = @"sushi";
	search.latlon = [[[CLLocation alloc] initWithLatitude:34.10652 longitude:-118.411509] autorelease];
	search.radius = 10.0;
	
	NSArray* errors = nil;
	CGOffersSearchResults* results = [search search:&errors];
	
	STAssertNil(errors, @"Expected to have no errors, had %@", errors);
	if ([errors count] == 0) {
		[self assertResults:results parent:@"testFindSushiInLosAngeles"];
	}
}

- (void) testResults {
	CGOffersSearch* search = [CityGrid offersSearch];
	search.what = @"restaurant";
	search.where = @"90069";
	search.resultsPerPage = 1;
	
	NSArray* errors = nil;
	CGOffersSearchResults* results = [search search:&errors];
	
	STAssertNil(errors, @"Expected to have no errors, had %@", errors);
	if ([errors count] == 0) {
		[self assertResults:results parent:@"testResults"];
	}
	
	NSString* description = [results description];
	STAssertNotNil(description, @"Expected description was %@", description);
	
	CGOffersSearchResults* resultsCopy = [results copy];
	STAssertTrue([results isEqualToOffersSearchResults:resultsCopy], @"Specific equals failed");
	STAssertTrue([results isEqual:resultsCopy], @"Generic equals failed");
	
	NSData* archive = [NSKeyedArchiver archivedDataWithRootObject:results];
	CGOffersSearchResults* resultsArchive = [NSKeyedUnarchiver unarchiveObjectWithData:archive];
	STAssertTrue([results isEqualToOffersSearchResults:resultsArchive], @"Specific equals failed");
	STAssertTrue([results isEqual:resultsArchive], @"Generic equals failed");
}

@end
