//
//
//  Copyright 2011 CityGrid Media, LLC All rights reserved.
//
#import <CoreLocation/CoreLocation.h>
#import "CGTPlacesSearchTests.h"
#import "CGTConstants.h"
#import "CityGrid.h"
#import "CGConstants.h"
#import "CGPlacesSearchLocation.h"

@implementation CGTPlacesSearchTests

- (CGPlacesSearch*) buildSearch {
	CGPlacesSearch* search = [[CGPlacesSearch alloc] init:CGT_PUBLISHER];
	search.type = 1111;
	search.what = @"WHAT";
	search.tag = 2222;
	search.chain = 3333;
	search.first = @"z";
	search.where = @"44444";
	search.radius = 1.0;
	search.page = 5555;
	search.resultsPerPage = 6666;
	search.sort = 7777;
	search.placement = @"PLACEMENT";
	search.offers = YES;
	search.histograms = YES;
	search.latlon = [[[CLLocation alloc] initWithLatitude:2.0 longitude:3.0] autorelease];
	search.latlon2 = [[[CLLocation alloc] initWithLatitude:4.0 longitude:5.0] autorelease];
	search.timeout = 10.0;
	search.impressionId = @"IMPRESSION_ID";
	return [search autorelease];
}

- (void) testDescription {
	CGPlacesSearch* search = [self buildSearch];
	
	NSString* description = [search description];
	STAssertTrue([description rangeOfString:@"type=1111"].location != NSNotFound, @"Couldn't find type in %@", description);
	STAssertTrue([description rangeOfString:@"what=WHAT"].location != NSNotFound, @"Couldn't find what in %@", description);
	STAssertTrue([description rangeOfString:@"tag=2222"].location != NSNotFound, @"Couldn't find tag in %@", description);
	STAssertTrue([description rangeOfString:@"chain=3333"].location != NSNotFound, @"Couldn't find chain in %@", description);
	STAssertTrue([description rangeOfString:@"first=z"].location != NSNotFound, @"Couldn't find z in %@", description);
	STAssertTrue([description rangeOfString:@"where=44444"].location != NSNotFound, @"Couldn't find where in %@", description);
	STAssertTrue([description rangeOfString:@"radius=1.0"].location != NSNotFound, @"Couldn't find radius in %@", description);
	STAssertTrue([description rangeOfString:@"page=5555"].location != NSNotFound, @"Couldn't find page in %@", description);
	STAssertTrue([description rangeOfString:@"resultsPerPage=6666"].location != NSNotFound, @"Couldn't find resultsPerPage in %@", description);
	STAssertTrue([description rangeOfString:@"sort=7777"].location != NSNotFound, @"Couldn't find sort in %@", description);
	STAssertTrue([description rangeOfString:@"placement=PLACEMENT"].location != NSNotFound, @"Couldn't find placement in %@", description);
	STAssertTrue([description rangeOfString:@"offers=1"].location != NSNotFound, @"Couldn't find offers in %@", description);
	STAssertTrue([description rangeOfString:@"histograms=1"].location != NSNotFound, @"Couldn't find histograms in %@", description);
	STAssertTrue([description rangeOfString:@"latlon=<+2.00000000"].location != NSNotFound, @"Couldn't find lat in %@", description);
	STAssertTrue([description rangeOfString:@"+3.00000000>"].location != NSNotFound, @"Couldn't find lon in %@", description);
	STAssertTrue([description rangeOfString:@"latlon2=<+4.00000000"].location != NSNotFound, @"Couldn't find lat2 in %@", description);
	STAssertTrue([description rangeOfString:@"+5.00000000>"].location != NSNotFound, @"Couldn't find lon2 in %@", description);
	STAssertTrue([description rangeOfString:@"timeout=10.0"].location != NSNotFound, @"Couldn't find timeout in %@", description);
	STAssertTrue([description rangeOfString:@"impressionId=IMPRESSION_ID"].location != NSNotFound, @"Couldn't find impressionId in %@", description);
}

- (void) assertSearch:(CGPlacesSearch*) search parent:(NSString*) parent {
	STAssertNotNil(search, @"search is nil");
	STAssertTrue(search.type == 1111, @"type %i for %@ is not 1111", search.type, parent);
	STAssertTrue([search.what isEqualToString:@"WHAT"], @"what %@ for %@ is not WHAT", search.what, parent);
	STAssertTrue(search.tag == 2222, @"tag %i for %@ is not 2222", search.tag, parent);
	STAssertTrue(search.chain == 3333, @"chain %i for %@ is not 3333", search.chain, parent);
	STAssertTrue([search.first isEqualToString:@"z"], @"first %@ for %@ is not z", search.first, parent);
	STAssertTrue([search.where isEqualToString:@"44444"], @"where %@ for %@ is not 44444", search.where, parent);
	STAssertTrue(search.radius == 1.0, @"radius %f for %@ is not %f", search.radius, parent, 1.0);
	STAssertTrue(search.page == 5555, @"page %i for %@ is not 5555", search.page, parent);
	STAssertTrue(search.resultsPerPage == 6666, @"resultsPerPage %i for %@ is not 6666", search.resultsPerPage, parent);
	STAssertTrue(search.sort == 7777, @"sort $i for %@ is not 7777", search.sort, parent);
	STAssertTrue([search.placement isEqualToString:@"PLACEMENT"], @"placement %@ for %@ is not PLACEMENT", search.placement, parent);
	STAssertTrue(search.offers, @"offers %i for %@ is not 1", search.offers, parent);
	STAssertTrue(search.histograms, @"histograms %i for %@ is not 1", search.histograms, parent);
	STAssertTrue(search.latlon.coordinate.latitude == 2.0 && search.latlon.coordinate.longitude == 3.0, @"latlon %f,%f for %@ is not %f,%f", search.latlon.coordinate.latitude, search.latlon.coordinate.longitude, parent, 2.0, 3.0);
	STAssertTrue(search.latlon2.coordinate.latitude == 4.0 && search.latlon2.coordinate.longitude == 5.0, @"latlon %%f,%f for %@ is not %f,%f", search.latlon.coordinate.latitude, search.latlon.coordinate.longitude, parent, 4.0, 5.0);
	STAssertTrue(search.timeout == 10.0, @"timeout %f for %@ is not %f", search.timeout, parent, 10.0);
	STAssertTrue([search.impressionId isEqualToString:@"IMPRESSION_ID"], @"impressionId %@ for %@ is not IMPRESSION_ID", search.impressionId, parent);
}

- (void) testCopy {
	CGPlacesSearch* search1 = [self buildSearch];
	CGPlacesSearch* search2 = [[search1 copy] autorelease];
	
	STAssertTrue([search1 isEqualToPlacesSearch:search2], @"Specific equals failed");
	STAssertTrue([search1 isEqual:search2], @"Generic equals failed");
	[self assertSearch:search2 parent:@"testCopy"];
}

- (void) testCoding {
	CGPlacesSearch* search1 = [self buildSearch];
	NSData* archive = [NSKeyedArchiver archivedDataWithRootObject:search1];
	CGPlacesSearch* search2 = [NSKeyedUnarchiver unarchiveObjectWithData:archive];
	
	STAssertTrue([search1 isEqualToPlacesSearch:search2], @"Specific equals failed");
	STAssertTrue([search1 isEqual:search2], @"Generic equals failed");
	[self assertSearch:search2 parent:@"testCoding"];
}

- (void) testWhereValidation {
	NSArray* errors = nil;
	CGPlacesSearch* search1 = [[[CGPlacesSearch alloc] init:nil] autorelease];
	[search1 search:&errors];
	STAssertTrue([errors count] == 3, @"Empty search, expected 3 errors, got %i", [errors count]);
	search1.what = @"pizza";
	[search1 search:&errors];
	STAssertTrue([errors count] == 2, @"Search with what, expected 2 errors, got %i", [errors count]);
	search1.what = nil;
	search1.type = CGPlacesSearchTypeHotel;
	[search1 search:&errors];
	STAssertTrue([errors count] == 2, @"Search with type, expected 2 errors, got %i", [errors count]);
	search1.type = CGPlacesSearchTypeUnknown;
	search1.chain = 1;
	[search1 search:&errors];
	STAssertTrue([errors count] == 2, @"Search with type, expected 2 errors, got %i", [errors count]);
	search1.chain = CG_NSINTEGER_UNKNOWN;
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
	search1.chain = 0;
	[search1 search:&errors];
	STAssertTrue([errors count] == 2, @"Search with invalid chain, expected 2 errors, got %i", [errors count]);
	search1.chain = CG_NSINTEGER_UNKNOWN;
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
	CGPlacesSearch* search1 = [[[CGPlacesSearch alloc] init:nil] autorelease];
	[search1 search:&errors];
	STAssertTrue([errors count] == 3, @"Empty search, expected 3 errors, got %i", [errors count]);
	search1.what = @"pizza";
	[search1 search:&errors];
	STAssertTrue([errors count] == 2, @"Search with what, expected 2 errors, got %i", [errors count]);
	search1.what = nil;
	search1.type = CGPlacesSearchTypeHotel;
	[search1 search:&errors];
	STAssertTrue([errors count] == 2, @"Search with type, expected 2 errors, got %i", [errors count]);
	search1.type = CGPlacesSearchTypeUnknown;
	search1.chain = 1;
	[search1 search:&errors];
	STAssertTrue([errors count] == 2, @"Search with type, expected 2 errors, got %i", [errors count]);
	search1.chain = CG_NSINTEGER_UNKNOWN;
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
	search1.chain = 0;
	[search1 search:&errors];
	STAssertTrue([errors count] == 2, @"Search with invalid chain, expected 2 errors, got %i", [errors count]);
	search1.chain = CG_NSINTEGER_UNKNOWN;
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
	for (CGPlacesSearchLocation* location in locations) {
		[self assertLocation:location parent:parent assertAddress:YES];
		STAssertNotNil(location.profile, @"Expected to have a profile");
		STAssertTrue([location.categories count] > 0, @"Expected to have categories greater than 0 for %@ was %i", parent, [location.categories count]);
		STAssertTrue([location.tags count] > 0, @"Expectd to have tags greater than 0 for %@ was %i", parent, [location.tags count]);
        STAssertTrue([location.publicId length] >0, @"Expected publicId to exist for %@ was %@", parent, location.publicId);
	}
}

- (void) assertResults:(CGPlacesSearchResults*) results parent:(NSString*) parent {
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
	[self assertLocations:results.locations parent:parent];
}

- (void) testFindMovieTheatersInZipCode90045 {
	CGPlacesSearch* search = [CityGrid placesSearch];
	search.type = CGPlacesSearchTypeMovieTheater;
	search.where = @"90045";
	search.histograms = YES;
	
	NSArray* errors = nil;
	CGPlacesSearchResults* results = [search search:&errors];
	
	STAssertNil(errors, @"Expected to have no errors, had %@", errors);
	if ([errors count] == 0) {
		[self assertResults:results parent:@"testFindMovieTheatersInZipCode90045"];
	}
}

- (void) testFindItalianRestaurantsInChicago {
	CGPlacesSearch* search = [CityGrid placesSearch];
	search.what = @"restaurant";
	search.tag = 11279;
	search.where = @"chicago,IL";
	search.placement = @"sec-5";
	
	NSArray* errors = nil;
	CGPlacesSearchResults* results = [search search:&errors];
	
	STAssertNil(errors, @"Expected to have no errors, had %@", errors);
	if ([errors count] == 0) {
		[self assertResults:results parent:@"testFindItalianRestaurantsInChicago"];
	}
}

- (void) testFindHotelsInBostonViewingResultsAlphabetical {
	CGPlacesSearch* search = [CityGrid placesSearch];
	search.what = @"hotels";
	search.where = @"boston,ma";
	search.page = 1;
	search.resultsPerPage = 5;
	search.sort = CGPlacesSearchSortAlphabetical;
	
	NSArray* errors = nil;
	CGPlacesSearchResults* results = [search search:&errors];
	
	STAssertNil(errors, @"Expected to have no errors, had %@", errors);
	if ([errors count] == 0) {
		[self assertResults:results parent:@"testFindHotelsInBostonViewingResultsAlphabetical"];
	}
}

- (void) testFindPharmaciesNearLACountyMusicCenter {
	CGPlacesSearch* search = [CityGrid placesSearch];
	search.what = @"pharmacy";
	search.where = @"135 N Grand,Los Angeles,ca";
	search.sort = CGPlacesSearchSortDistance;
	
	NSArray* errors = nil;
	CGPlacesSearchResults* results = [search search:&errors];
	
	STAssertNil(errors, @"Expected to have no errors, had %@", errors);
	if ([errors count] == 0) {
		[self assertResults:results parent:@"testFindPharmaciesNearLACountyMusicCenter"];
	}
}

- (void) testFindMovieTheatersRadius {
	CGPlacesSearch* search = [CityGrid placesSearch];
	search.type = CGPlacesSearchTypeMovieTheater;
	search.latlon = [[[CLLocation alloc] initWithLatitude:34.03 longitude:-118.28] autorelease];
	search.radius = 5.0;
	
	NSArray* errors = nil;
	CGPlacesSearchResults* results = [search search:&errors];
	
	STAssertNil(errors, @"Expected to have no errors, had %@", errors);
	if ([errors count] == 0) {
		[self assertResults:results parent:@"testFindMovieTheatersRadius"];
	}
}

- (void) testFindMovieTheatersBox {
	CGPlacesSearch* search = [CityGrid placesSearch];
	search.type = CGPlacesSearchTypeMovieTheater;
	search.latlon = [[[CLLocation alloc] initWithLatitude:34.03 longitude:-118.28] autorelease];
	search.latlon2 = [[[CLLocation alloc] initWithLatitude:34.08 longitude:-118.23] autorelease];
	
	NSArray* errors = nil;
	CGPlacesSearchResults* results = [search search:&errors];
	
	STAssertNil(errors, @"Expected to have no errors, had %@", errors);
	if ([errors count] == 0) {
		[self assertResults:results parent:@"testFindMovieTheatersBox"];
	}
}

- (void) testResults {
	CGPlacesSearch* search = [CityGrid placesSearch];
	search.what = @"restaurant";
	search.where = @"90069";
	search.resultsPerPage = 1;
	
	NSArray* errors = nil;
	CGPlacesSearchResults* results = [search search:&errors];
	
	STAssertNil(errors, @"Expected to have no errors, had %@", errors);
	if ([errors count] == 0) {
		[self assertResults:results parent:@"testResults"];
	}
	
	NSString* description = [results description];
	STAssertNotNil(description, @"Expected description was %@", description);
	
	CGPlacesSearchResults* resultsCopy = [results copy];
	STAssertTrue([results isEqualToPlacesSearchResults:resultsCopy], @"Specific equals failed");
	STAssertTrue([results isEqual:resultsCopy], @"Generic equals failed");
	
	NSData* archive = [NSKeyedArchiver archivedDataWithRootObject:results];
	CGPlacesSearchResults* resultsArchive = [NSKeyedUnarchiver unarchiveObjectWithData:archive];
	STAssertTrue([results isEqualToPlacesSearchResults:resultsArchive], @"Specific equals failed");
	STAssertTrue([results isEqual:resultsArchive], @"Generic equals failed");
}

@end
