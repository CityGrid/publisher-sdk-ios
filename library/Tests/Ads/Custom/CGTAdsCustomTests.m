//
//
//  Copyright 2011 CityGrid Media, LLC All rights reserved.
//
#import <CoreLocation/CoreLocation.h>
#import "CGTAdsCustomTests.h"
#import "CGTConstants.h"
#import "CityGrid.h"
#import "CGConstants.h"

@implementation CGTAdsCustomTests

- (CGAdsCustom*) build {
	CGAdsCustom* builder = [[CGAdsCustom alloc] init:CGT_PUBLISHER];
	builder.what = @"WHAT";
	builder.where = @"WHERE";
	builder.max = 1111;
	builder.placement = @"PLACEMENT";
	builder.impressionId = @"IMPRESSION_ID";
	builder.latlon = [[[CLLocation alloc] initWithLatitude:2.0 longitude:3.0] autorelease];
	builder.radius = 2222.0;
	builder.timeout = 3333.0;
	return [builder autorelease];
}

- (void) testDescription {
	CGAdsCustom* search = [self build];
	
	NSString* description = [search description];
	STAssertTrue([description rangeOfString:@"publisher=test"].location != NSNotFound, @"Couldn't find publisher in %@", description);
	STAssertTrue([description rangeOfString:@"what=WHAT"].location != NSNotFound, @"Couldn't find what in %@", description);
	STAssertTrue([description rangeOfString:@"where=WHERE"].location != NSNotFound, @"Couldn't find where in %@", description);
	STAssertTrue([description rangeOfString:@"max=1111"].location != NSNotFound, @"Couldn't find max in %@", description);
	STAssertTrue([description rangeOfString:@"placement=PLACEMENT"].location != NSNotFound, @"Couldn't find placement in %@", description);
	STAssertTrue([description rangeOfString:@"impressionId=IMPRESSION_ID"].location != NSNotFound, @"Couldn't find impressionId in %@", description);
	STAssertTrue([description rangeOfString:@"latlon=<+2.00000000"].location != NSNotFound, @"Couldn't find lat in %@", description);
	STAssertTrue([description rangeOfString:@"+3.00000000>"].location != NSNotFound, @"Couldn't find lon in %@", description);
	STAssertTrue([description rangeOfString:@"radius=2222"].location != NSNotFound, @"Couldn't find radius in %@", description);
	STAssertTrue([description rangeOfString:@"timeout=3333"].location != NSNotFound, @"Couldn't find timeout in %@", description);
}

- (void) assertBuilder:(CGAdsCustom*) builder parent:(NSString*) parent {
	STAssertNotNil(builder, @"builder is nil");
	STAssertTrue([builder.publisher isEqualToString:@"test"], @"what %@ for %@ is not test", builder.what, parent);
	STAssertTrue([builder.what isEqualToString:@"WHAT"], @"what %@ for %@ is not WHAT", builder.what, parent);
	STAssertTrue([builder.where isEqualToString:@"WHERE"], @"where %@ for %@ is not WHERE", builder.where, parent);
	STAssertTrue(builder.max == 1111, @"radius %i for %@ is not 1111", builder.radius, parent);
	STAssertTrue([builder.placement isEqualToString:@"PLACEMENT"], @"placement %@ for %@ is not PLACEMENT", builder.placement, parent);
	STAssertTrue([builder.impressionId isEqualToString:@"IMPRESSION_ID"], @"impressionId %@ for %@ is not IMPRESSION_ID", builder.impressionId, parent);
	STAssertTrue(builder.latlon.coordinate.latitude == 2.0 && builder.latlon.coordinate.longitude == 3.0, @"latlon %f,%f for %@ is not %f,%f", builder.latlon.coordinate.latitude, builder.latlon.coordinate.longitude, parent, 2.0, 3.0);
	STAssertTrue(builder.radius == 2222.0, @"radius %f for %@ is not %f", builder.radius, parent, 2222.0);
	STAssertTrue(builder.timeout == 3333.0, @"timeout %f for %@ is not %f", builder.timeout, parent, 3333.0);
}

- (void) testCopy {
	CGAdsCustom* builder1 = [self build];
	CGAdsCustom* builder2 = [[builder1 copy] autorelease];
	
	STAssertTrue([builder1 isEqualToAdsCustom:builder2], @"Specific equals failed");
	STAssertTrue([builder1 isEqual:builder2], @"Generic equals failed");
	[self assertBuilder:builder2 parent:@"testCopy"];
}

- (void) testCoding {
	CGAdsCustom* builder1 = [self build];
	NSData* archive = [NSKeyedArchiver archivedDataWithRootObject:builder1];
	CGAdsCustom* builder2 = [NSKeyedUnarchiver unarchiveObjectWithData:archive];
	
	STAssertTrue([builder1 isEqualToAdsCustom:builder2], @"Specific equals failed");
	STAssertTrue([builder1 isEqual:builder2], @"Generic equals failed");
	[self assertBuilder:builder2 parent:@"testCoding"];
}

- (void) testWhereValidation {
	NSArray* errors = nil;
	CGAdsCustom* search1 = [[[CGAdsCustom alloc] init:nil] autorelease];
	[search1 search:&errors];
	STAssertTrue([errors count] == 3, @"Empty search, expected 3 errors, got %i", [errors count]);
	search1.what = @"pizza";
	[search1 search:&errors];
	STAssertTrue([errors count] == 2, @"Search with what, expected 2 errors, got %i", [errors count]);
    search1.what = @"pasta italian french milano";
	[search1 search:&errors];
	STAssertTrue([errors count] == 3, @"Search with multiplewhat terms (more than 3), expected 3 errors, got %i", [errors count]);
	search1.what = @"pizza";
	search1.publisher = CGT_PUBLISHER;
	[search1 search:&errors];
	STAssertTrue([errors count] == 1, @"Search with publisher, expected 1 error, got %i", [errors count]);
	search1.publisher = nil;
	search1.where = @"90034";
	[search1 search:&errors];
	STAssertTrue([errors count] == 1, @"Search with where, expected 1 error, got %i", [errors count]);
	search1.max = 0.0;
	[search1 search:&errors];
	STAssertTrue([errors count] == 2, @"Search with max < 1, expected 2 error, got %i", [errors count]);
	search1.max = 11.0;
	[search1 search:&errors];
	STAssertTrue([errors count] == 2, @"Search with max > 11, expected 2 error, got %i", [errors count]);
}

- (void) testLatLonValidation {
	NSArray* errors = nil;
	CGAdsCustom* search1 = [[[CGAdsCustom alloc] init:nil] autorelease];
	[search1 search:&errors];
	STAssertTrue([errors count] == 3, @"Empty search, expected 3 errors, got %i", [errors count]);
	search1.what = @"pizza";
	[search1 search:&errors];
	STAssertTrue([errors count] == 2, @"Search with what, expected 2 errors, got %i", [errors count]);
    search1.what = @"pasta italian french milano";
	[search1 search:&errors];
	STAssertTrue([errors count] == 3, @"Search with multiplewhat terms (more than 3), expected 3 errors, got %i", [errors count]);
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
	STAssertTrue([errors count] == 1, @"Search with radius, expected 1 error, got %i", [errors count]);
	search1.latlon = [[[CLLocation alloc] initWithLatitude:181.0 longitude:181.0] autorelease];
	[search1 search:&errors];
	STAssertTrue([errors count] == 3, @"Search with latlon > 180, expected 3 errors, got %i", [errors count]);
	search1.latlon = [[[CLLocation alloc] initWithLatitude:30.0 longitude:30.0] autorelease];
	search1.radius = CG_FLOAT32_UNKNOWN;
	[search1 search:&errors];
	STAssertTrue([errors count] == 2, @"Search with no radius, expected 2 errors, got %i", [errors count]);
	search1.radius = 0.0;
	[search1 search:&errors];
	STAssertTrue([errors count] == 2, @"Search with radius = 0.0, expected 2 errors, got %i", [errors count]);
}

- (void) assertAds:(NSArray*) ads parent:(NSString*) parent {
	STAssertTrue([ads count] > 0, @"Expected to have ads for %@", parent);
	for (CGAdsCustomAd* ad in ads) {
		[self assertLocation:ad parent:parent assertAddress:NO];
		STAssertTrue(ad.adId > 0, @"Expected to have adId for %@", parent);
		STAssertTrue([ad.type length] > 0, @"Expected to have type for %@", parent);
        //		STAssertTrue([ad.tagline length] > 0, @"Expected to have tagline for %@", parent);
		STAssertNotNil(ad.destinationUrl, @"Expected to have destinationUrl for %@", parent);
		STAssertNotNil(ad.displayUrl, @"Expected to have displayUrl for %@", parent);
        STAssertNotNil(ad.attributionText, @"Expected to have attributionText for %@", parent);
	}
}

- (void) assertResults:(CGAdsCustomResults*) results parent:(NSString*) parent {
	STAssertNotNil(results, @"Expected to have results for %@", parent);
	[self assertAds:results.ads parent:parent];
}

- (void) testFindRestaurantsInLosAngeles {
	CGAdsCustom* search = [CityGrid adsCustom];
	search.what = @"restaurant";
	search.where = @"Los Angeles, CA";
	
	NSArray* errors = nil;
	CGAdsCustomResults* results = [search search:&errors];
	
	STAssertNil(errors, @"Expected to have no errors, had %@", errors);
	if ([errors count] == 0) {
		[self assertResults:results parent:@"testFindRestaurantsInLosAngeles"];
	}
}

- (void) testFindRestaurantsIn90069 {
	CGAdsCustom* search = [CityGrid adsCustom];
	search.what = @"restaurant";
	search.where = @"90069";
	
	NSArray* errors = nil;
	CGAdsCustomResults* results = [search search:&errors];
	
	STAssertNil(errors, @"Expected to have no errors, had %@", errors);
	if ([errors count] == 0) {
		[self assertResults:results parent:@"testFindRestaurantsIn90069"];
	}
}

- (void) testFind5SpasIn90069 {
	CGAdsCustom* search = [CityGrid adsCustom];
	search.what = @"spa";
	search.where = @"90069";
	search.max = 5;
	
	NSArray* errors = nil;
	CGAdsCustomResults* results = [search search:&errors];
	
	STAssertNil(errors, @"Expected to have no errors, had %@", errors);
	if ([errors count] == 0) {
		[self assertResults:results parent:@"testFind5SpasIn90069"];
	}
	
	STAssertTrue([results.ads count] <= 5, @"Expected to have less than 5 spas in 90069 had %i", [results.ads count]);
}

- (void) testFind10BarsIn90004 {
	CGAdsCustom* search = [CityGrid adsCustom];
	search.what = @"pet";
	search.where = @"90004";
	
	NSArray* errors = nil;
	CGAdsCustomResults* results = [search search:&errors];
	
	STAssertNil(errors, @"Expected to have no errors, had %@", errors);
	if ([errors count] == 0) {
		[self assertResults:results parent:@"testFind10BarsIn90004"];
	}
}

- (void) testLatLon {
	CGAdsCustom* search = [CityGrid adsCustom];
	search.what = @"restaurant";
	search.latlon = [[CLLocation alloc] initWithLatitude:34.0522222 longitude:-118.2427778];
	search.radius = 20.0;
	
	NSArray* errors = nil;
	CGAdsCustomResults* results = [search search:&errors];
	
	STAssertNil(errors, @"Expected to have no errors, had %@", errors);
	if ([errors count] == 0) {
		[self assertResults:results parent:@"testLatLon"];
	}
}

- (void) testOptionalParameters {
    CGAdsCustom* search = [CityGrid adsCustom];
    search.what = @"restaurant";
    
    NSArray* errors = nil;
	[search search:&errors];
	
	STAssertTrue([errors count] == 1, @"Search with what, expected 1 error, got %i", [errors count]);
    
	search.clientIp = [search ipAddress];
	search.radius = 20.0;
    [search search:&errors];
    STAssertTrue([errors count] == 1, @"Search with client_ip, expected 1 error, got %i", [errors count]);
    
    search.ua = @"Mozilla";
    [search search:&errors];
    STAssertTrue([errors count] == 1, @"Search with user_agent, expected 1 error, got %i", [errors count]);
    
    search.serveUrl = @"citygridmedia.com";
    [search search:&errors];
    STAssertTrue([errors count] == 1, @"Search with serve_url, expected 1 error, got %i", [errors count]);
    
    search.rawWhere= @"in los angeles 90069";
    [search search:&errors];
    STAssertTrue([errors count] == 1, @"Search with raw_where, expected 1 error, got %i", [errors count]);
    
    search.rawWhere= @"very good restaurant";
    [search search:&errors];
    STAssertTrue([errors count] == 1, @"Search with raw_what, expected 1 error, got %i", [errors count]);
    
    NSLog(@"IP Client : %@",search.clientIp);
    NSLog(@"User agent : %@",search.ua);
    NSLog(@"Serve Url : %@",search.serveUrl);
    NSLog(@"rawWhere : %@", search.rawWhere);
    NSLog(@"rawWhat : %@", search.rawWhat);
}


- (void) testResults {
	CGAdsCustom* search = [CityGrid adsCustom];
	search.what = @"restaurant";
	search.where = @"90069";
	search.max = 1;
	
	NSArray* errors = nil;
	CGAdsCustomResults* results = [search search:&errors];
	
	STAssertNil(errors, @"Expected to have no errors, had %@", errors);
	if ([errors count] == 0) {
		[self assertResults:results parent:@"testResults"];
	}
	
	NSString* description = [results description];
	STAssertNotNil(description, @"Expected description was %@", description);
	
	CGAdsCustomResults* resultsCopy = [results copy];
	STAssertTrue([results isEqualToAdsCustomResults:resultsCopy], @"Specific equals failed");
	STAssertTrue([results isEqual:resultsCopy], @"Generic equals failed");
	
	NSData* archive = [NSKeyedArchiver archivedDataWithRootObject:results];
	CGAdsCustomResults* resultsArchive = [NSKeyedUnarchiver unarchiveObjectWithData:archive];
	STAssertTrue([results isEqualToAdsCustomResults:resultsArchive], @"Specific equals failed");
	STAssertTrue([results isEqual:resultsArchive], @"Generic equals failed");
}

@end
