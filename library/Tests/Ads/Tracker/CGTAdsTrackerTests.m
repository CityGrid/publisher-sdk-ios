//
//
//  Copyright 2011 CityGrid Media, LLC All rights reserved.
//
#import "CGTAdsTrackerTests.h"
#import "CGTConstants.h"
#import "CityGrid.h"
#import "CGConstants.h"

@implementation CGTAdsTrackerTests

- (CGAdsTracker*) build {
	CGAdsTracker* builder = [[CGAdsTracker alloc] init:CGT_PUBLISHER];
	builder.actionTarget = CGAdsTrackerActionTargetWriteReview;
	builder.locationId = 1111;
	builder.referenceId = 2222;
	builder.impressionId = @"IMPRESSION_ID";
	builder.placement = @"PLACEMENT";
	builder.sourcePhone = @"SOURCE_PHONE";
	builder.dialPhone = @"DIAL_PHONE";
	builder.timeout = 3333.0;
	return [builder autorelease];
}

- (void) testDescription {
	CGAdsTracker* search = [self build];
	
	NSString* description = [search description];
	STAssertTrue([description rangeOfString:@"publisher=test"].location != NSNotFound, @"Couldn't find publisher in %@", description);
	STAssertTrue([description rangeOfString:@"actionTarget=6"].location != NSNotFound, @"Couldn't find actionTarget in %@", description);
	STAssertTrue([description rangeOfString:@"locationId=1111"].location != NSNotFound, @"Couldn't find locationId in %@", description);
	STAssertTrue([description rangeOfString:@"referenceId=2222"].location != NSNotFound, @"Couldn't find referenceId in %@", description);
	STAssertTrue([description rangeOfString:@"impressionId=IMPRESSION_ID"].location != NSNotFound, @"Couldn't find impressionId in %@", description);
	STAssertTrue([description rangeOfString:@"placement=PLACEMENT"].location != NSNotFound, @"Couldn't find placement in %@", description);
	STAssertTrue([description rangeOfString:@"sourcePhone=SOURCE_PHONE"].location != NSNotFound, @"Couldn't find sourcePhone in %@", description);
	STAssertTrue([description rangeOfString:@"dialPhone=DIAL_PHONE"].location != NSNotFound, @"Couldn't find dialPhone in %@", description);
	STAssertTrue([description rangeOfString:@"timeout=3333"].location != NSNotFound, @"Couldn't find timeout in %@", description);
}

- (void) assertBuilder:(CGAdsTracker*) builder parent:(NSString*) parent {
	STAssertNotNil(builder, @"builder is nil");
	STAssertTrue([builder.publisher isEqualToString:@"test"], @"what %@ for %@ is not test", builder.publisher, parent);
	STAssertTrue(builder.actionTarget == CGAdsTrackerActionTargetWriteReview, @"actionTarget %i for %@ is not 6", builder.actionTarget, parent);
	STAssertTrue(builder.locationId == 1111, @"locationId %i for %@ is not 1111", builder.locationId, parent);
	STAssertTrue(builder.referenceId == 2222, @"referenceId %i for %@ is not 2222", builder.referenceId, parent);
	STAssertTrue([builder.impressionId isEqualToString:@"IMPRESSION_ID"], @"impressionId %@ for %@ is not IMPRESSION_ID", builder.impressionId, parent);
	STAssertTrue([builder.placement isEqualToString:@"PLACEMENT"], @"placement %@ for %@ is not PLACEMENT", builder.placement, parent);
	STAssertTrue([builder.sourcePhone isEqualToString:@"SOURCE_PHONE"], @"sourcePhone %@ for %@ is not SOURCE_PHONE", builder.sourcePhone, parent);
	STAssertTrue([builder.dialPhone isEqualToString:@"DIAL_PHONE"], @"dialPhone %@ for %@ is not PLACEMENT", builder.dialPhone, parent);
	STAssertTrue(builder.timeout == 3333.0, @"timeout %f for %@ is not %f", builder.timeout, parent, 3333.0);
}

- (void) testCopy {
	CGAdsTracker* builder1 = [self build];
	CGAdsTracker* builder2 = [[builder1 copy] autorelease];
	
	STAssertTrue([builder1 isEqualToAdsTracker:builder2], @"Specific equals failed");
	STAssertTrue([builder1 isEqual:builder2], @"Generic equals failed");
	[self assertBuilder:builder2 parent:@"testCopy"];
}

- (void) testCoding {
	CGAdsTracker* builder1 = [self build];
	NSData* archive = [NSKeyedArchiver archivedDataWithRootObject:builder1];
	CGAdsTracker* builder2 = [NSKeyedUnarchiver unarchiveObjectWithData:archive];
	
	STAssertTrue([builder1 isEqualToAdsTracker:builder2], @"Specific equals failed");
	STAssertTrue([builder1 isEqual:builder2], @"Generic equals failed");
	[self assertBuilder:builder2 parent:@"testCoding"];
}

- (void) testValidation {
	NSArray* errors = nil;
	CGAdsTracker* tracker = [[[CGAdsTracker alloc] init:nil] autorelease];
	errors = [tracker track];
	STAssertTrue([errors count] == 4, @"Empty track, expected 4 errors, got %i", [errors count]);
	tracker.publisher = CGT_PUBLISHER;
	errors = [tracker track];
	STAssertTrue([errors count] == 3, @"Added publisher, expected 3 errors, got %i", [errors count]);
	tracker.publisher = nil;
	tracker.locationId = 1111;
	errors = [tracker track];
	STAssertTrue([errors count] == 3, @"Added locationId, expected 3 errors, got %i", [errors count]);
	tracker.locationId = CG_NSINTEGER_UNKNOWN;
	tracker.referenceId = 2222;
	errors = [tracker track];
	STAssertTrue([errors count] == 3, @"Added referenceId, expected 3 errors, got %i", [errors count]);
	tracker.referenceId = CG_NSINTEGER_UNKNOWN;
	tracker.actionTarget = CGAdsTrackerActionTargetWriteReview;
	errors = [tracker track];
	STAssertTrue([errors count] == 3, @"Added actionTarget, expected 3 errors, got %i", [errors count]);
	tracker.actionTarget = CGAdsTrackerActionTargetClickToCall;
	errors = [tracker track];
	STAssertTrue([errors count] == 4, @"Added actionTarget as click to call, expected 4 errors, got %i", [errors count]);
	tracker.dialPhone = @"3333";
	errors = [tracker track];
	STAssertTrue([errors count] == 3, @"Added actionTarget as click to call with dialPhone, expected 3 errors, got %i", [errors count]);
}

- (void) testTrack {
	CGAdsTracker* search = [CGAdsTracker adsTracker];
	search.locationId = 886038;
	search.referenceId = 2;
	search.impressionId = @"123";
	search.actionTarget = CGAdsTrackerActionTargetListingProfile;
	
	NSArray* errors = [search track];
	
	STAssertNil(errors, @"Expected to have no errors, had %@", errors);
}

@end
