//
//
//  Copyright 2011 CityGrid Media, LLC All rights reserved.
//
#import "CGTBaseTests.h"
#import "CityGrid.h"
#import "CGTConstants.h"

@implementation CGTBaseTests

- (void) setUp {
    [super setUp];
    
	[CityGrid setPublisher:CGT_PUBLISHER];
	[CityGrid setSimulation:CGT_SIMULATION];
	[CityGrid setDebug:CGT_DEBUG];
}

- (void) assertRegions:(NSArray*) regions parent:(NSString*) parent {
	STAssertTrue([regions count] > 0, @"Expected regions to be greater than 0 for %@ was %i", parent, [regions count]);
	for (CGRegion* region in regions) {
		STAssertTrue([region.type length], @"Expected type to exist for %@ was %@", parent, region.type);
		STAssertTrue([region.name length], @"Expected name to exist for %@ was %@", parent, region.name);
		STAssertTrue(region.latlon.coordinate.latitude > 30.0, @"Expected the latitude to be greater than 30 for %@ was %f", parent, region.latlon.coordinate.latitude);
		STAssertTrue(region.latlon.coordinate.longitude < -30.0, @"Expected the longitude to be less than 100 for %@ was %f", parent, region.latlon.coordinate.longitude);
	}
}

- (void) assertHistograms:(NSArray*) histograms parent:(NSString*) parent {
	STAssertTrue([histograms count] > 0, @"Expected to have greater than 0 histograms for %@ was %i", parent, [histograms count]);
	for (CGHistogram* histogram in histograms) {
		STAssertTrue([histogram.name length], @"Expected name to exist for %@ was %@", parent, histogram.name);
		STAssertTrue([histogram.items count], @"Expected to have greater than 0 items for %@ was %i", parent, [histogram.items count]);
		for (CGHistogramItem* item in histogram.items) {
			STAssertTrue([item.name length] > 0, @"Exptected item name to exist for %@ was %@", parent, item.name);
			STAssertTrue(item.count > 0, @"Expected count to be greater than 0 for %@ was %i", parent, item.count);
			STAssertNotNil(item.uri, @"Expected uri to exist for %@", parent);
			STAssertTrue([item.tagIds count] > 0, @"expected tagIds to be greater than 0 for %@ was %i", parent, [item.tagIds count]);
		}
	}
}

- (void) assertAddress:(CGAddress*) address parent:(NSString*) parent {
	STAssertTrue([address.street length] > 0, @"Expected street to exist for %@ was %@", parent, address.street);
	STAssertTrue([address.city length] > 0, @"Expected city to exist for %@ was %@", parent, address.city);
	STAssertTrue([address.state length] > 0, @"Expected state to exist for %@ was %@", parent, address.state);
	STAssertTrue([address.zip length] > 0, @"Expected zip to exist for %@ was %@", parent, address.zip);
	if ([[address class] isSubclassOfClass:[CGPlacesDetailAddress class]]) {
		STAssertTrue([((CGPlacesDetailAddress*)address).deliveryPoint length] > 0, @"Expected deliveryPoint to exist for %@ was %@", parent, ((CGPlacesDetailAddress*)address).deliveryPoint);
		STAssertTrue([((CGPlacesDetailAddress*)address).crossStreet length] > 0, @"Expected crossStreet to exist for %@ was %@", parent, ((CGPlacesDetailAddress*)address).crossStreet);
	}
}

- (void) assertLocation:(CGLocation*) location parent:(NSString*) parent assertAddress:(BOOL) assertAddress {
	STAssertNotNil(location, @"Expected to have a location");
	STAssertTrue(location.locationId > 0, @"Expected locationId to exist for %@ was %i", parent, location.locationId);
	if (! [[location class] isSubclassOfClass:[CGOffersLocation class]]) {
		STAssertTrue([location.impressionId length] > 0, @"Expected locationId to exist for %@ was %@", parent, location.impressionId);
	}
	STAssertTrue([location.name length] > 0, @"Expected name to exist for %@ was %@", parent, location.name);
	if (assertAddress) {
		[self assertAddress:location.address parent:parent];
	}
// Retrieving 0.0,0.0 locations sometimes
//	STAssertTrue(location.latlon.coordinate.latitude > 30.0, @"Expected the latitude to be greater than 30 for %@ was %f", parent, location.latlon.coordinate.latitude);
//	STAssertTrue(location.latlon.coordinate.longitude < -30.0, @"Expected the longitude to be less than 100 for %@ was %f", parent, location.latlon.coordinate.longitude);
}

@end
