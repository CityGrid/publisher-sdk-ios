//
//
//  Copyright 2011 CityGrid Media, LLC All rights reserved.
//
#import "CGTPlacesDetailTests.h"
#import "CityGrid.h"
#import "CGTConstants.h"

@implementation CGTPlacesDetailTests

- (CGPlacesDetail*) build {
	CGPlacesDetail* builder = [[[CGPlacesDetail alloc] init:CGT_PUBLISHER] autorelease];
	builder.locationId = 1111;
	builder.infoUsaId = 2222;
	builder.phone = @"3333";
	builder.customerOnly = YES;
	builder.allResults = YES;
	builder.reviewCount = 4444;
	builder.placement = @"PLACEMENT";
	builder.timeout = 10.0;
	builder.impressionId = @"IMPRESSION_ID";
	return builder;
}

- (void) assertBuilder:(CGPlacesDetail*) builder parent:(NSString*) parent {
	STAssertNotNil(builder, @"builder is nil");
	STAssertTrue(builder.locationId == 1111, @"locationId %i for %@ is not 1111", builder.locationId, parent);
	STAssertTrue(builder.infoUsaId == 2222, @"infoUsaId %i for %@ is not 2222", builder.infoUsaId, parent);
	STAssertTrue([builder.phone isEqualToString:@"3333"], @"phone %@ for %@ is not 3333", builder.phone, parent);
	STAssertTrue(builder.customerOnly, @"customerOnly %i for %@ is not true", builder.customerOnly, parent);
	STAssertTrue(builder.allResults, @"allResults %i for %@ is not true", builder.allResults, parent);
	STAssertTrue(builder.reviewCount == 4444, @"reviewCount %i for %@ is not 4444", builder.reviewCount, parent);
	STAssertTrue([builder.placement isEqualToString:@"PLACEMENT"], @"placement %@ for %@ is not PLACEMENT", builder.placement, parent);
	STAssertTrue(builder.timeout == 10.0, @"timeout %f for %@ is not 10.0", builder.timeout, parent);
	STAssertTrue([builder.impressionId isEqualToString:@"IMPRESSION_ID"], @"impressionId %@ for %@ is not IMPRESSION_ID", builder.impressionId, parent);
}

- (void) testDescription {
	CGPlacesDetail* builder = [[[CGPlacesDetail alloc] init:CGT_PUBLISHER] autorelease];
	builder.locationId = 1111;
	builder.infoUsaId = 2222;
	builder.phone = @"3333";
	builder.customerOnly = YES;
	builder.allResults = YES;
	builder.reviewCount = 4444;
	builder.placement = @"PLACEMENT";
	builder.timeout = 10.0;
	builder.impressionId = @"IMPRESSION_ID";
    builder.publicId = @"PUBLIC_ID";
    builder.placeId = @"PLACE_ID";
    //builder.idType = CGPlacesDetailTypeInfoUSA;
	builder.idType = @"iusa";
    
	NSString* description = [builder description];
	STAssertTrue([description rangeOfString:@"publisher=test"].location != NSNotFound, @"Couldn't find publisher in %@", description);
	STAssertTrue([description rangeOfString:@"locationId=1111"].location != NSNotFound, @"Couldn't find locationId in %@", description);
	STAssertTrue([description rangeOfString:@"infoUsaId=2222"].location != NSNotFound, @"Couldn't find infoUsaId in %@", description);
	STAssertTrue([description rangeOfString:@"phone=3333"].location != NSNotFound, @"Couldn't find phone in %@", description);
	STAssertTrue([description rangeOfString:@"customerOnly=1"].location != NSNotFound, @"Couldn't find customerOnly in %@", description);
	STAssertTrue([description rangeOfString:@"allResults=1"].location != NSNotFound, @"Couldn't find allResults in %@", description);
	STAssertTrue([description rangeOfString:@"reviewCount=4444"].location != NSNotFound, @"Couldn't find reviewCount in %@", description);
	STAssertTrue([description rangeOfString:@"placement=PLACEMENT"].location != NSNotFound, @"Couldn't find placement in %@", description);
	STAssertTrue([description rangeOfString:@"timeout=10.0"].location != NSNotFound, @"Couldn't find timeout in %@", description);
	STAssertTrue([description rangeOfString:@"impressionId=IMPRESSION_ID"].location != NSNotFound, @"Couldn't find impressionId in %@", description);
    STAssertTrue([description rangeOfString:@"publicId=PUBLIC_ID"].location != NSNotFound, @"Couldn't find publicId in %@", description);
    STAssertTrue([description rangeOfString:@"placeId=PLACE_ID"].location != NSNotFound, @"Couldn't find placeId in %@", description);
    STAssertTrue([description rangeOfString:@"idType=iusa"].location != NSNotFound, @"Couldn't find idType in %@", description);
}

- (void) testCopy {
	CGPlacesDetail* builder1 = [self build];
	CGPlacesDetail* builder2 = [[builder1 copy] autorelease];
	
	STAssertTrue([builder1 isEqualToPlacesDetail:builder2], @"Specific equals failed");
	STAssertTrue([builder1 isEqual:builder2], @"Generic equals failed");
	[self assertBuilder:builder2 parent:@"testCopy"];
}

- (void) testCoding {
	CGPlacesDetail* builder1 = [self build];
	NSData* archive = [NSKeyedArchiver archivedDataWithRootObject:builder1];
	CGPlacesDetail* builder2 = [NSKeyedUnarchiver unarchiveObjectWithData:archive];
	
	STAssertTrue([builder1 isEqualToPlacesDetail:builder2], @"Specific equals failed");
	STAssertTrue([builder1 isEqual:builder2], @"Generic equals failed");
	[self assertBuilder:builder2 parent:@"testCoding"];
}

- (void) assertDetailLocation:(CGPlacesDetailLocation*) location parent:(NSString*) parent {
	[self assertLocation:location parent:parent assertAddress:YES];
	
	STAssertTrue(location.referenceId != 0, @"Expected referenceId to not be 0 for %@ was %i", parent, location.referenceId);
//	STAssertTrue(location.infoUsaId > 0, @"Expected infoUsaId to be greater than 0 for %@ was %i", parent, location.infoUsaId);
    STAssertTrue([location.publicId length] >0, @"Expected publicId to exist for %@ was %@", parent, location.publicId);
	STAssertTrue([location.markets count] > 0, @"Expected to have markets for %@ was %i", parent, [location.markets count]);
	STAssertTrue([location.neighborhoods count] > 0, @"Expected to have neighborhoods for %@ was %i", parent, [location.neighborhoods count]);
	STAssertNotNil(location.urls, @"Expected to have urls for %@", parent);
	STAssertNotNil(location.customerContent, @"Expected to have customerContent for %@", parent);
	STAssertTrue([location.categories count] > 0, @"Expected to have categories for %@ was %i", parent, [location.categories count]);
}

- (void) assertResults:(CGPlacesDetailResults*) results parent:(NSString*) parent {
	STAssertNotNil(results, @"Expected to have results for %@", parent);
	STAssertTrue([results.locations count], @"Expected to have locations for %@", parent);
	for (CGPlacesDetailLocation* location in results.locations) {
		[self assertDetailLocation:location parent:parent];
	}
}

- (void) testListingId295889 {
	CGPlacesDetail* builder = [CityGrid placesDetail];
	builder.locationId = 295889;
	builder.placement = @"search_page";
	
	NSArray* errors = nil;
	CGPlacesDetailResults* results = [builder detail:&errors];
	
	STAssertNil(errors, @"Expected to have no errors, had %@", errors);
	if ([errors count] == 0) {
		[self assertResults:results parent:@"testListingId295889"];
	}
}

- (void) testInfoUsaId {
	CGPlacesDetail* builder = [CityGrid placesDetail];
	builder.infoUsaId = 382016681;
	
	NSArray* errors = nil;
	CGPlacesDetailResults* results = [builder detail:&errors];
	
	STAssertNil(errors, @"Expected to have no errors, had %@", errors);
	if ([errors count] == 0) {
		[self assertResults:results parent:@"testInfoUsaId"];
	}
}

- (void) testPlaceId {
    CGPlacesDetail* builder = [CityGrid placesDetail];
	builder.placeId = @"41735803";
	
	NSArray* errors = nil;
	CGPlacesDetailResults* results = [builder detail:&errors];
	
    STAssertTrue([errors count] == 1, @"Search without idType, expected 1 errors, got %i", [errors count]);
    
    errors = nil;
    //builder.idType = CGPlacesDetailTypeCityGridPublicId;
    builder.idType = @"cg";
    
    results = [builder detail:&errors];
    
	STAssertNil(errors, @"Expected to have no errors, had %@", errors);
	if ([errors count] == 0) {
		[self assertResults:results parent:@"testPlaceId"];
	} 
}

- (void) testPhone3232569617 {
	CGPlacesDetail* builder = [CityGrid placesDetail];
	builder.phone = @"3232569617";
	
	NSArray* errors = nil;
	CGPlacesDetailResults* results = [builder detail:&errors];
	
	STAssertNil(errors, @"Expected to have no errors, had %@", errors);
	if ([errors count] == 0) {
		[self assertResults:results parent:@"testPhone3232569617"];
	}
}

- (void) testPhone3232569617AllResults {
	CGPlacesDetail* builder = [CityGrid placesDetail];
	builder.phone = @"3232569617";
	builder.placement = @"search_page";
	builder.allResults = YES;
	
	NSArray* errors = nil;
	CGPlacesDetailResults* results = [builder detail:&errors];
	
	STAssertNil(errors, @"Expected to have no errors, had %@", errors);
	if ([errors count] == 0) {
		[self assertResults:results parent:@"testPhone3232569617AllResults"];
	}
}

- (void) testPhone3232569617ReviewCount {
	CGPlacesDetail* builder = [CityGrid placesDetail];
	builder.phone = @"3232569617";
	builder.placement = @"search_page";
	builder.reviewCount = 10;
	
	NSArray* errors = nil;
	CGPlacesDetailResults* results = [builder detail:&errors];
	NSString* desc = [results description];
	
	STAssertNil(errors, @"Expected to have no errors, had %@", errors);
	if ([errors count] == 0) {
		[self assertResults:results parent:@"testPhone3232569617ReviewCount"];
	}
}

- (void) testPublicId {
    CGPlacesDetail* builder = [CityGrid placesDetail];
	builder.publicId = @"yoshisushi-west_hollywood-1 ";
	
	NSArray* errors = nil;
	CGPlacesDetailResults* results = [builder detail:&errors];
	
	STAssertNil(errors, @"Expected to have no errors, had %@", errors);
	if ([errors count] == 0) {
		[self assertResults:results parent:@"testPublicId"];
	}
}

- (void) testResults {
	CGPlacesDetail* builder = [CityGrid placesDetail];
	builder.locationId = 295889;
	
	NSArray* errors = nil;
	CGPlacesDetailResults* results = [builder detail:&errors];
	NSString* desc = [results description];
	
	STAssertNil(errors, @"Expected to have no errors, had %@", errors);
	if ([errors count] == 0) {
		[self assertResults:results parent:@"testResults"];
	}
	
    NSLog(@"Printing order link...");
    NSLog(@"%@\n", results.location.urls.orderUrl);
    
	NSString* description = [results description];
	STAssertNotNil(description, @"Expected description was %@", description);
	
	CGPlacesDetailResults* resultsCopy = [results copy];
	STAssertTrue([results isEqualToPlacesDetailResults:resultsCopy], @"Specific equals failed");
	STAssertTrue([results isEqual:resultsCopy], @"Generic equals failed");
	
	NSData* archive = [NSKeyedArchiver archivedDataWithRootObject:results];
	CGPlacesDetailResults* resultsArchive = [NSKeyedUnarchiver unarchiveObjectWithData:archive];
	STAssertTrue([results isEqualToPlacesDetailResults:resultsArchive], @"Specific equals failed");
	STAssertTrue([results isEqual:resultsArchive], @"Generic equals failed");
}

@end
