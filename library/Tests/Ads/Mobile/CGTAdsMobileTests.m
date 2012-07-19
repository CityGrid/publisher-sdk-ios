//
//
//  Copyright 2011 CityGrid Media, LLC All rights reserved.
//
#import "CGTAdsMobileTests.h"
#import "CGTConstants.h"
#import "CityGrid.h"
#import "CGConstants.h"

@implementation CGTAdsMobileTests

- (CGAdsMobile*) build {
	CGAdsMobile* builder = [[CGAdsMobile alloc] init:CGT_PUBLISHER];
	builder.collection = CGAdsMobileCollection640x100;
	builder.what = @"WHAT";
	builder.where = @"WHERE";
	builder.latlon = [[[CLLocation alloc] initWithLatitude:2.0 longitude:3.0] autorelease];
	builder.radius = 1111.0;
	builder.max = 2222;
	builder.placement = @"PLACEMENT";
	builder.impressionId = @"IMPRESSION_ID";
	builder.timeout = 3333.0;
	builder.size = CGSizeMake(640.0, 100.0);
	return [builder autorelease];
}

- (void) testDescription {
	CGAdsMobile* search = [self build];
	
	NSString* description = [search description];
	STAssertTrue([description rangeOfString:@"publisher=test"].location != NSNotFound, @"Couldn't find publisher in %@", description);
	STAssertTrue([description rangeOfString:@"collection=2"].location != NSNotFound, @"Couldn't find collection in %@", description);
	STAssertTrue([description rangeOfString:@"what=WHAT"].location != NSNotFound, @"Couldn't find what in %@", description);
	STAssertTrue([description rangeOfString:@"where=WHERE"].location != NSNotFound, @"Couldn't find where in %@", description);
	STAssertTrue([description rangeOfString:@"latlon=<+2.00000000"].location != NSNotFound, @"Couldn't find lat in %@", description);
	STAssertTrue([description rangeOfString:@"+3.00000000>"].location != NSNotFound, @"Couldn't find lon in %@", description);
	STAssertTrue([description rangeOfString:@"radius=1111"].location != NSNotFound, @"Couldn't find radius in %@", description);
	STAssertTrue([description rangeOfString:@"max=2222"].location != NSNotFound, @"Couldn't find max in %@", description);
	STAssertTrue([description rangeOfString:@"placement=PLACEMENT"].location != NSNotFound, @"Couldn't find placement in %@", description);
	STAssertTrue([description rangeOfString:@"impressionId=IMPRESSION_ID"].location != NSNotFound, @"Couldn't find impressionId in %@", description);
	STAssertTrue([description rangeOfString:@"timeout=3333"].location != NSNotFound, @"Couldn't find timeout in %@", description);
	STAssertTrue([description rangeOfString:@"size={640.0"].location != NSNotFound, @"Couldn't find timeout in %@", description);
}

- (void) assertBuilder:(CGAdsMobile*) builder parent:(NSString*) parent {
	STAssertNotNil(builder, @"builder is nil");
	STAssertTrue([builder.publisher isEqualToString:@"test"], @"what %@ for %@ is not test", builder.what, parent);
	STAssertTrue(builder.collection == CGAdsMobileCollection640x100, @"collection %i for %@ is not 2", builder.collection, parent);
	STAssertTrue([builder.what isEqualToString:@"WHAT"], @"what %@ for %@ is not WHAT", builder.what, parent);
	STAssertTrue([builder.where isEqualToString:@"WHERE"], @"where %@ for %@ is not WHERE", builder.where, parent);
	STAssertTrue(builder.latlon.coordinate.latitude == 2.0 && builder.latlon.coordinate.longitude == 3.0, @"latlon %f,%f for %@ is not %f,%f", builder.latlon.coordinate.latitude, builder.latlon.coordinate.longitude, parent, 2.0, 3.0);
	STAssertTrue(builder.radius == 1111.0, @"radius %f for %@ is not %f", builder.radius, parent, 1111.0);
	STAssertTrue(builder.max == 2222, @"radius %i for %@ is not 2222", builder.radius, parent);
	STAssertTrue([builder.placement isEqualToString:@"PLACEMENT"], @"placement %@ for %@ is not PLACEMENT", builder.placement, parent);
	STAssertTrue([builder.impressionId isEqualToString:@"IMPRESSION_ID"], @"impressionId %@ for %@ is not IMPRESSION_ID", builder.impressionId, parent);
	STAssertTrue(builder.timeout == 3333.0, @"timeout %f for %@ is not %f", builder.timeout, parent, 3333.0);
}

- (void) testCopy {
	CGAdsMobile* builder1 = [self build];
	CGAdsMobile* builder2 = [[builder1 copy] autorelease];
	
	STAssertTrue([builder1 isEqualToAdsMobile:builder2], @"Specific equals failed");
	STAssertTrue([builder1 isEqual:builder2], @"Generic equals failed");
	[self assertBuilder:builder2 parent:@"testCopy"];
}

- (void) testCoding {
	CGAdsMobile* builder1 = [self build];
	NSData* archive = [NSKeyedArchiver archivedDataWithRootObject:builder1];
	CGAdsMobile* builder2 = [NSKeyedUnarchiver unarchiveObjectWithData:archive];
	
	STAssertTrue([builder1 isEqualToAdsMobile:builder2], @"Specific equals failed");
	STAssertTrue([builder1 isEqual:builder2], @"Generic equals failed");
	[self assertBuilder:builder2 parent:@"testCoding"];
}

- (void) testValidation {
	NSArray* errors = nil;
	CGAdsMobile* search1 = [[[CGAdsMobile alloc] init:nil] autorelease];
	[search1 banner:&errors];
	STAssertTrue([errors count] == 5, @"Empty search, expected 5 errors, got %i", [errors count]);
	search1.what = @"pizza";
	[search1 banner:&errors];
	STAssertTrue([errors count] == 4, @"Search with what, expected 4 errors, got %i", [errors count]);
	search1.what = @"pizza";
	search1.publisher = CGT_PUBLISHER;
	[search1 banner:&errors];
	STAssertTrue([errors count] == 3, @"Search with publisher, expected 3 error, got %i", [errors count]);
	search1.publisher = nil;
	search1.where = @"90034";
	[search1 banner:&errors];
	STAssertTrue([errors count] == 3, @"Search with where, expected 3 error, got %i", [errors count]);
	search1.max = 0.0;
	[search1 banner:&errors];
	STAssertTrue([errors count] == 4, @"Search with max < 1, expected 4 error, got %i", [errors count]);
	search1.max = 11.0;
	[search1 banner:&errors];
	STAssertTrue([errors count] == 4, @"Search with max > 11, expected 4 error, got %i", [errors count]);
	search1.where = nil;
	search1.latlon = [[[CLLocation alloc] initWithLatitude:30.0 longitude:30.0] autorelease];
	[search1 banner:&errors];
	STAssertTrue([errors count] == 5, @"Search with latlon, expected 5 errors, got %i", [errors count]);
	search1.radius = 3.0;
	[search1 banner:&errors];
	STAssertTrue([errors count] == 4, @"Search with radius, expected 4 errors, got %i", [errors count]);
	search1.latlon = [[[CLLocation alloc] initWithLatitude:181.0 longitude:181.0] autorelease];
	[search1 banner:&errors];
	STAssertTrue([errors count] == 6, @"Search with latlon > 180, expected 6 errors, got %i", [errors count]);
	search1.latlon = [[[CLLocation alloc] initWithLatitude:30.0 longitude:30.0] autorelease];
	search1.radius = CG_FLOAT32_UNKNOWN;
	[search1 banner:&errors];
	STAssertTrue([errors count] == 5, @"Search with no radius, expected 5 errors, got %i", [errors count]);
	search1.radius = 0.0;
	[search1 banner:&errors];
	STAssertTrue([errors count] == 5, @"Search with radius = 0.0, expected 5 errors, got %i", [errors count]);
    search1.what = @"pasta italian french milano";
    [search1 banner:&errors];
    STAssertTrue([errors count] == 6, @"Search with multiple whats terms (more than 3), expected 6 errors, got %i", [errors count]);
    search1.what = @"pasta italian milano";
    [search1 banner:&errors];
    STAssertTrue([errors count] == 5, @"Search with multiple whats terms (correct number), expected 5 errors, got %i", [errors count]);
}

- (void) assertAds:(NSArray*) ads parent:(NSString*) parent {
	STAssertTrue([ads count] > 0, @"Expected to have ads for %@", parent);
	for (CGAdsMobileAd* ad in ads) {
		STAssertTrue(ad.locationId > 0, @"Expected locationId to exist for %@ was %i", parent, ad.locationId);
		STAssertTrue([ad.impressionId length] > 0, @"Expected locationId to exist for %@ was %@", parent, ad.impressionId);
		STAssertTrue(ad.adId > 0, @"Expected to have adId for %@", parent);
		STAssertNotNil(ad.destinationUrl, @"Expected to have destinationurl for %@", parent);
		STAssertNotNil(ad.image, @"Expected to have image for %@", parent);
	}
}

- (void) assertResults:(CGAdsMobileResults*) results parent:(NSString*) parent {
	STAssertNotNil(results, @"Expected to have results for %@", parent);
	[self assertAds:results.ads parent:parent];
}

- (void) testFindRestaurantsInLosAngeles {
	CGAdsMobile* search = [CGAdsMobile adsMobile];
	search.what = @"restaurant";
	search.where = @"Los Angeles, CA";
	search.collection = CGAdsMobileCollection640x100;
	search.size = CGSizeMake(640.0, 100.0);
	
	NSArray* errors = nil;
	CGAdsMobileResults* results = [search banner:&errors];
	
	STAssertNil(errors, @"Expected to have no errors, had %@", errors);
	if ([errors count] == 0) {
		[self assertResults:results parent:@"testFindRestaurantsInLosAngeles"];
	}
}

- (void) testFindRestaurantsInLatLon {
	CGAdsMobile* search = [CGAdsMobile adsMobile];
	search.what = @"restaurant";
	search.latlon = [[[CLLocation alloc] initWithLatitude:33.786594 longitude:-118.298662] autorelease];
	search.radius = 50.0;
	search.collection = CGAdsMobileCollection640x100;
	search.size = CGSizeMake(640.0, 100.0);
	
	NSArray* errors = nil;
	CGAdsMobileResults* results = [search banner:&errors];
	
	STAssertNil(errors, @"Expected to have no errors, had %@", errors);
	if ([errors count] == 0) {
		[self assertResults:results parent:@"testFindRestaurantsInLosAngeles"];
	}
}


- (void) testOptionalParameters {
    CGAdsMobile* search = [self build];
    
    NSArray* errors = nil;
    search.max = 5;
    search.radius = 20.0;
	[search banner:&errors];
	
	STAssertNil(errors, @"Search without client_ip and user agent - Expected to have no errors, had %@", errors);
    
	//search.clientIp = [search ipAddress];
    //[search banner:&errors];
    //STAssertNil(errors, @"Search with client_ip - Expected to have no errors, had %@", errors);
    
    search.ua = @"Mozilla";
    [search banner:&errors];
    STAssertNil(errors, @"Search with user_agent - Expected to have no errors, had %@", errors);
    
    search.rawWhere= @"in los angeles 90069";
    [search banner:&errors];
    STAssertNil(errors, @"Search with raw_where - Expected to have no errors, had %@", errors);
    
    search.rawWhat= @"very good restaurant";
    [search banner:&errors];
    STAssertNil(errors, @"Search with raw_what - Expected to have no errors, had %@", errors);
    
    
    NSLog(@"IP Client : %@",search.clientIp);
    NSLog(@"User agent : %@",search.ua);
    NSLog(@"rawWhere : %@", search.rawWhere);
    NSLog(@"rawWhat : %@", search.rawWhat);
}


- (void) testResults {
	CGAdsMobile* search = [CityGrid adsMobile];
	search.what = @"restaurant";
	search.where = @"Los Angeles, CA";
	search.collection = CGAdsMobileCollection640x100;
	search.size = CGSizeMake(640.0, 100.0);
	
	NSArray* errors = nil;
	CGAdsMobileResults* results = [search banner:&errors];
	
	STAssertNil(errors, @"Expected to have no errors, had %@", errors);
	if ([errors count] == 0) {
		[self assertResults:results parent:@"testResults"];
	}
	
	NSString* description = [results description];
	STAssertNotNil(description, @"Expected description was %@", description);
	
	CGAdsMobileResults* resultsCopy = [results copy];
	STAssertTrue([results isEqualToAdsMobileResults:resultsCopy], @"Specific equals failed");
	STAssertTrue([results isEqual:resultsCopy], @"Generic equals failed");
	
	NSData* archive = [NSKeyedArchiver archivedDataWithRootObject:results];
	CGAdsMobileResults* resultsArchive = [NSKeyedUnarchiver unarchiveObjectWithData:archive];
	STAssertTrue([results isEqualToAdsMobileResults:resultsArchive], @"Specific equals failed");
	STAssertTrue([results isEqual:resultsArchive], @"Generic equals failed");
}

@end
