//
//
//  Copyright 2011 CityGrid Media, LLC All rights reserved.
//
#import "CGExample.h"
#import "CityGrid.h"

@implementation CGExample

+ (void) initialize {
	[CityGrid setPublisher:@"test"];
	[CityGrid setTimeout:10.0];
	[CityGrid setSimulation:YES];
	[CityGrid setDebug:NO];
}

- (void) places {
	// Pretends the user chose to find Movie Theater's in 90045 within the application
	// and this is read from your UI or model
	CGPlacesSearch* search = [CityGrid placesSearch];
	search.type = CGPlacesSearchTypeMovieTheater;
	search.where = @"90045";
    
	// Executes the where query and returns the results
	NSArray* errors = nil;
	NSArray* locations = [search search:&errors].locations;
	
	// Display any errors
	for (NSError* error in errors) {
		NSLog(@"An error occurred while searching %@", error);
		STFail(@"Had an error with getting places");
	}
	
	// Display the results in the aplication
	for (CGPlacesSearchLocation* location in locations) {
		NSLog(@"Found id=%i, name=%@, publicId=%@", location.locationId, location.name, location.publicId);
	}
	
	// Pretend the user selected the last result and wants to display the full location data
	// Usually this is a navigation to a detail view.
	CGPlacesSearchLocation* searchLocation = [locations lastObject];
	
	// Get the detail (This will populate the locationId and impressionId for you)
	// You could alternatively use the locationId and impressionId yourself, but this is easier
	CGPlacesDetailLocation* location = [searchLocation placesDetailLocation:&errors];
	
	// Display any errors
	for (NSError* error in errors) {
		NSLog(@"An error occurred while retrieving the location %@", error);
		STFail(@"Had an error with getting a location");
	}
	
	// Display the location
	NSLog(@"Showing listingId=%i, name=%@, publicId=%@", location.locationId, location.name, location.publicId);
	
	// Track that the location was displayed
	errors = [location track:CGAdsTrackerActionTargetListingProfile];
    
	// Display any errors
	for (NSError* error in errors) {
		NSLog(@"An error occurred while tracking the location %@", error);
		STFail(@"Had an error with tracking a location");
	}
}

- (void) reviews {
	// Pretends the user chose to find Movie Theater Reviews in 90045 within the application
	// and this is read from your UI or model
	CGReviewsSearch* search = [CityGrid reviewsSearch];
	search.type = CGReviewTypeUserReview;
    search.sort = CGReviewsSearchSortCreateDate;
	search.where = @"90025";
	
	// Executes the where query and returns the results
	NSArray* errors = nil;
	NSArray* reviews = [search search:&errors].reviews;
	
	// Display any errors
	for (NSError* error in errors) {
		NSLog(@"An error occurred while searching %@", error);
		STFail(@"Had an error with getting reviews");
	}
	
	// Display the results in the aplication
	for (CGReviewsSearchReview* review in reviews) {
		NSLog(@"Found id=%@, businessName=%@, date=%@", review.reviewId, review.businessName, review.date);
	}
	
	// Pretend the user selected last result and wants to display the full location data
	// Usually this is a navigation to a detail view.
	CGReviewsSearchReview* review = [reviews lastObject];
	
	// Get the detail (This will populate the locationId and impressionId for you)
	// You could alternatively use the locationId and impressionId yourself, but this is easier
	CGPlacesDetailLocation* location = [review placesDetailLocation:&errors];
	
	// Display any errors
	for (NSError* error in errors) {
		NSLog(@"An error occurred while retrieving the location %@", error);
		STFail(@"Had an error with getting a location");
	}
	
	// Display the location
	NSLog(@"Showing id=%i, name=%@", location.locationId, location.name);
}

- (void) offers {
	// Pretends the user chose to restaurant offers in 90404 within the application
	// and this is read from your UI or model
	CGOffersSearch* search = [CityGrid offersSearch];
	search.what = @"restaurants";
	search.where = @"90404";
	
	// Executes the where query and returns the results
	NSArray* errors = nil;
	NSArray* offers = [search search:&errors].offers;
	
	// Display any errors
	for (NSError* error in errors) {
		NSLog(@"An error occurred while searching %@", error);
		STFail(@"Had an error with getting offers");
	}
	
	// Display the results in the aplication
	for (CGOffersOffer* offer in offers) {
		NSLog(@"Found id=%@, title=%@", offer.offerId, offer.title);
	}
	
	// Pretend the user selected the last offer and wants to display the offer information for
	// just the last locationId (an offer may be for more than one location)
	// Usually this is a navigation to a detail view.
	CGOffersOffer* selectedOffer = [offers lastObject];
	NSInteger locationId = ((CGOffersLocation*)[selectedOffer.locations lastObject]).locationId;
	
	// Get the detail for only the offer and the last location id (This will populate the offerId, locationId
	// and impressionId for you). You could alternatively use the offerId, locationId and impressionId yourself,
	// but this is easier
	CGOffersDetail* detail = [selectedOffer offersDetail];
	detail.locationId = locationId;
	CGOffersOffer* offer = [detail detail:&errors].offer;
	
	// Display any errors
	for (NSError* error in errors) {
		NSLog(@"An error occurred while retrieving the location %@", error);
		STFail(@"Had an error with getting a location");
	}
	
	// Display the location
	NSLog(@"Showing id=%@, title=%@", offer.offerId, offer.title);
}

- (void) ads {
	// Pretends the application chose to show a single featured location or ad to the user in 90069.
	// This typically read from your UI or model
	CGAdsCustom* search = [CityGrid adsCustom];
	search.what = @"restaurant";
	search.latlon = [[[CLLocation alloc] initWithLatitude:33.786594 longitude:-118.298662] autorelease];
    search.clientIp = [search ipAddress];
	search.radius = 25.0;
    search.rawWhat = @"italian restaurant in Los angeles";
    search.rawWhere = @"Los angeles 90069";
    search.ua = @"Mozilla FireFox";
    search.serveUrl = @"citysearch.com";
	search.max = 1;
    
	// Executes the where query and returns the results
	NSArray* errors = nil;
	CGAdsCustomAd* ad = [search search:&errors].ad;
	STAssertNotNil(ad, @"Should have found an ad");
	
	// Display any errors
	for (NSError* error in errors) {
		NSLog(@"An error occurred while searching %@", error);
		STFail(@"Had an error with getting an ad");
	}
	
	NSLog(@"Found id=%i, businessDescription=%@, attributionText=%@", ad.adId, ad.businessDescription, ad.attributionText);
	
	// Pretend the user clicked on the ad and wants to display the detail for that ad
	// (This will populate the locationId and impressionId for you)
	// Usually this is an application navigation
	// You could alternatively use the locationId and impressionId yourself, but this is easier.
	CGPlacesDetailLocation* detail = [ad placesDetailLocation:&errors];
	STAssertNotNil(detail, @"Should have found an ad");
	
	// Display any errors
	for (NSError* error in errors) {
		NSLog(@"An error occurred while retrieving the location %@", error);
		STFail(@"Had an error with getting a detail");
	}
	
	// Display the location
	NSLog(@"Showing locationId=%i, name=%@, publicId=%@", detail.locationId, detail.name, detail.publicId);
}

- (void) banners {
	// Pretends the application chose to show a restaurant banner ad in 90069
	// This is typically read from your UI or model
	CGAdsMobile* search = [CityGrid adsMobile];
	search.latlon = [[[CLLocation alloc] initWithLatitude:33.786594 longitude:-118.298662] autorelease];
	search.radius = 50.0;
	search.what = @"restaurant";
	search.collection = CGAdsMobileCollection320x50;
	search.size = CGSizeMake(320.0, 50.0);
	search.max = 1;
	
	// Executes the banner query and returns the results
	NSArray* errors = nil;
	CGAdsMobileAd* ad = [search banner:&errors].ad;
	STAssertNotNil(ad, @"Should have found an ad");
	
	// Display any errors
	for (NSError* error in errors) {
		NSLog(@"An error occurred while searching %@", error);
		STFail(@"Had an error with getting an ad");
	}
	
	NSLog(@"Found id=%@, image=%@", ad.adId, ad.image);
	
	// Pretend the user clicked on the ad and wants to display the detail for that location id
	// Usually this is an application navigation
	CGPlacesDetailLocation* detail = [ad placesDetailLocation:&errors];
	STAssertNotNil(detail, @"Should have found an ad");
	
	// Display any errors
	for (NSError* error in errors) {
		NSLog(@"An error occurred while retrieving the location %@", error);
		STFail(@"Had an error with getting a detail");
	}
	
	// Display the location
	NSLog(@"Showing locationId=%i, name=%@", detail.locationId, detail.name);
}

- (void) tracking {
	NSArray* errors;
	
	// Pretends a detail was already loaded in the application and we need to track
	// the impression and other actions.
	CGPlacesDetailLocation* location;
	
	// Track that the location was displayed
	errors = [location track:CGAdsTrackerActionTargetListingProfile];
	
	// Display any errors
	for (NSError* error in errors) {
		NSLog(@"An error occurred while tracking the location %@", error);
	}
	
	// Pretend that the user made a call to the location.
	errors = [location track:CGAdsTrackerActionTargetClickToCall];
	
	// Display any errors
	for (NSError* error in errors) {
		NSLog(@"An error occurred while tracking the location %@", error);
	}
	
	// Pretends we don't have the Location, but the identifiers for a location
	// and tracks the impression.
	CGAdsTracker* tracker = [CityGrid adsTracker];
	tracker.locationId = 1;
	tracker.impressionId = @"1";
	tracker.referenceId = 2;
	tracker.actionTarget = CGAdsTrackerActionTargetListingProfile;
    
	errors = [tracker track];
    
	// Display any errors
	for (NSError* error in errors) {
		NSLog(@"An error occurred while tracking the location %@", error);
	}
	
	// Pretend that the user looked at the reviews for the location.
	tracker.actionTarget = CGAdsTrackerActionTargetListingReview;
	errors = [tracker track];
	
	// Display any errors
	for (NSError* error in errors) {
		NSLog(@"An error occurred while tracking the location %@", error);
	}
}

- (void) testPlaces {
	[self places];
}

- (void) testReviews {
	[self reviews];
}

- (void) testOffers {
	[self offers];
}

- (void) testAds {
	[self ads];
}

- (void) testBanners {
	[self banners];
}

@end
