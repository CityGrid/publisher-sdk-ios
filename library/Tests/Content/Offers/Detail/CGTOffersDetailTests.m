//
//
//  Copyright 2011 CityGrid Media, LLC All rights reserved.
//
#import "CGTOffersDetailTests.h"
#import "CityGrid.h"
#import "CGTConstants.h"

@implementation CGTOffersDetailTests

- (CGOffersDetail*) build {
	CGOffersDetail* builder = [[[CGOffersDetail alloc] init:CGT_PUBLISHER] autorelease];
	builder.offerId = @"OFFER_ID";
	builder.locationId = 1111;
	builder.impressionId = @"IMPRESSION_ID";
	builder.placement = @"PLACEMENT";
	builder.timeout = 10.0;
	return builder;
}

- (void) assertBuilder:(CGOffersDetail*) builder parent:(NSString*) parent {
	STAssertNotNil(builder, @"builder is nil");
	STAssertTrue([builder.offerId isEqualToString:@"OFFER_ID"], @"offerId %@ for %@ is not OFFER_ID", builder.offerId, parent);
	STAssertTrue(builder.locationId == 1111, @"locationId %i for %@ is not 1111", builder.locationId, parent);
	STAssertTrue([builder.impressionId isEqualToString:@"IMPRESSION_ID"], @"impressionId %@ for %@ is not IMPRESSION_ID", builder.impressionId, parent);
	STAssertTrue([builder.placement isEqualToString:@"PLACEMENT"], @"placement %@ for %@ is not PLACEMENT", builder.placement, parent);
	STAssertTrue(builder.timeout == 10.0, @"timeout %f for %@ is not 10.0", builder.timeout, parent);
}

- (void) testDescription {
	CGOffersDetail* builder = [self build];
	
	NSString* description = [builder description];
	STAssertTrue([description rangeOfString:@"publisher=test"].location != NSNotFound, @"Couldn't find publisher in %@", description);
	STAssertTrue([description rangeOfString:@"offerId=OFFER_ID"].location != NSNotFound, @"Couldn't find offerId in %@", description);
	STAssertTrue([description rangeOfString:@"locationId=1111"].location != NSNotFound, @"Couldn't find locationId in %@", description);
	STAssertTrue([description rangeOfString:@"placement=PLACEMENT"].location != NSNotFound, @"Couldn't find placement in %@", description);
	STAssertTrue([description rangeOfString:@"impressionId=IMPRESSION_ID"].location != NSNotFound, @"Couldn't find impressionId in %@", description);
	STAssertTrue([description rangeOfString:@"timeout=10.0"].location != NSNotFound, @"Couldn't find timeout in %@", description);
}

- (void) testCopy {
	CGOffersDetail* builder1 = [self build];
	CGOffersDetail* builder2 = [[builder1 copy] autorelease];
	
	STAssertTrue([builder1 isEqualToOffersDetail:builder2], @"Specific equals failed");
	STAssertTrue([builder1 isEqual:builder2], @"Generic equals failed");
	[self assertBuilder:builder2 parent:@"testCopy"];
}

- (void) testCoding {
	CGOffersDetail* builder1 = [self build];
	NSData* archive = [NSKeyedArchiver archivedDataWithRootObject:builder1];
	CGOffersDetail* builder2 = [NSKeyedUnarchiver unarchiveObjectWithData:archive];
	
	STAssertTrue([builder1 isEqualToOffersDetail:builder2], @"Specific equals failed");
	STAssertTrue([builder1 isEqual:builder2], @"Generic equals failed");
	[self assertBuilder:builder2 parent:@"testCoding"];
}

- (void) testValidation {
	NSArray* errors = nil;
	CGOffersDetail* search1 = [[[CGOffersDetail alloc] init:nil] autorelease];
	[search1 detail:&errors];
	STAssertTrue([errors count] == 2, @"Empty search, expected 2 errors, got %i", [errors count]);
	search1.offerId = @"OFFER_ID";
	[search1 detail:&errors];
	STAssertTrue([errors count] == 1, @"Search with what, expected 1 error, got %i", [errors count]);
}

- (void) assertLocations:(NSArray*) locations parent:(NSString*) parent {
	STAssertTrue([locations count] > 0, @"Expected to have locations for %@ was %i", parent, [locations count]);
	for (CGOffersLocation* location in locations) {
		[self assertLocation:location parent:parent assertAddress:YES];
		STAssertTrue([location.tags count] > 0, @"Expectd to have tags greater than 0 for %@ was %i", parent, [location.tags count]);
	}
}

- (void) assertOffer:(CGOffersOffer*) offer parent:(NSString*) parent {
	STAssertNotNil(offer, @"Expected to have offer for %@", parent);
	STAssertTrue([offer.offerId length] > 0, @"Expected to have offerId for %@", parent);
	STAssertTrue([offer.impressionId length] > 0, @"Expected to have impressionId for %@", parent);
	STAssertTrue([offer.title length] > 0, @"Expected to have title for %@", parent);
	STAssertTrue([offer.offerDescription length] > 0, @"Expected to have offerDescription for %@", parent);
	STAssertTrue(offer.redemptionTypeId > 0, @"Expected to have a redemptionTypeId greater than 0 for %@ was %i", parent, offer.redemptionTypeId);
	STAssertTrue([offer.redemptionType length] > 0, @"Expected to have redemptionType for %@", parent);
	STAssertTrue([offer.terms length] > 0, @"Expected to have terms for %@", parent);
	STAssertTrue([offer.types count] > 0, @"Expected to have types for %@", parent);
	STAssertNotNil(offer.startDate, @"Expected to have startDate for %@", parent);
	STAssertTrue([offer.attributionSource length] > 0, @"Expected to have attributionSource for %@", parent);
	[self assertLocations:offer.locations parent:parent];
}

- (void) assertResults:(CGOffersDetailResults*) results parent:(NSString*) parent {
	STAssertNotNil(results, @"Expected to have results for %@", parent);
	[self assertOffer:results.offer parent:parent];
}

- (void) testOffer {
	CGOffersDetail* builder = [CGOffersDetail offersDetail];
	builder.offerId = @"cg_61413312";
	
	NSArray* errors = nil;
	CGOffersDetailResults* results = [builder detail:&errors];
	
	STAssertNil(errors, @"Expected to have no errors, had %@", errors);
	if ([errors count] == 0) {
		[self assertResults:results parent:@"testOffer"];
	}
}

- (void) testOfferLocationId {
	CGOffersDetail* builder = [CGOffersDetail offersDetail];
	builder.offerId = @"cg_61413312";
	builder.locationId = 11579059;
	
	NSArray* errors = nil;
	CGOffersDetailResults* results = [builder detail:&errors];
	
	STAssertNil(errors, @"Expected to have no errors, had %@", errors);
	if ([errors count] == 0) {
		[self assertResults:results parent:@"testOffer"];
	}
}

- (void) testResults {
	CGOffersDetail* builder = [CityGrid offersDetail];
	builder.offerId = @"cg_61413312";
	
	NSArray* errors = nil;
	CGOffersDetailResults* results = [builder detail:&errors];
	NSString* desc = [results description];
	
	STAssertNil(errors, @"Expected to have no errors, had %@", errors);
	if ([errors count] == 0) {
		[self assertResults:results parent:@"testResults"];
	}
	
	NSString* description = [results description];
	STAssertNotNil(description, @"Expected description was %@", description);
	
	CGOffersDetailResults* resultsCopy = [results copy];
	STAssertTrue([results isEqualToOffersDetailResults:resultsCopy], @"Specific equals failed");
	STAssertTrue([results isEqual:resultsCopy], @"Generic equals failed");
	
	NSData* archive = [NSKeyedArchiver archivedDataWithRootObject:results];
	CGOffersDetailResults* resultsArchive = [NSKeyedUnarchiver unarchiveObjectWithData:archive];
	STAssertTrue([results isEqualToOffersDetailResults:resultsArchive], @"Specific equals failed");
	STAssertTrue([results isEqual:resultsArchive], @"Generic equals failed");
}

@end
