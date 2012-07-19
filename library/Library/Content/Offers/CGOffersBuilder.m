//
//
//  Copyright 2011 CityGrid Media, LLC All rights reserved.
//
#import "CGOffersBuilder.h"
#import "CGOffersLocation.h"
#import "CGOffersOffer.h"

@implementation CGOffersBuilder

- (NSArray*) processOfferTypes:(NSArray*) parsedTypes {
	if (parsedTypes == nil || [[NSNull null] isEqual:parsedTypes]) {
		return nil;
	}
	
	NSMutableArray* types = [NSMutableArray arrayWithCapacity:[parsedTypes count]];
	for (NSString* parsedType in parsedTypes) {
		NSNumber* type = [NSNumber numberWithInteger:[parsedType integerValue]];
		[types addObject:type];
	}
	
	return types;
}

- (NSArray*) processOffersLocations:(NSArray*) parsedLocations {
	if (parsedLocations == nil) {
		return nil;
	}
	
	NSMutableArray* locations = [NSMutableArray arrayWithCapacity:[parsedLocations count]];
	for (NSDictionary* parsedLocation in parsedLocations) {
		NSInteger locationId = [[self objectForParsed:parsedLocation key:@"id"] integerValue];
		NSString* impressionId = [self objectForParsed:parsedLocation key:@"impression_id"];
		NSString* name = [self objectForParsed:parsedLocation key:@"name"];
		id address = [self processLocationAddress:[parsedLocation objectForKey:@"address"] useZip:NO];
		CLLocation* latlon = [self locationForParsed:parsedLocation latitudeKey:@"latitude" longitudeKey:@"longitude"];
		NSURL* image = [self urlForParsed:parsedLocation key:@"image_url"];
		NSString* phone = [self objectForParsed:parsedLocation key:@"phone_number"];
		NSInteger rating = [[self objectForParsed:parsedLocation key:@"rating"] integerValue];
		NSString* businessHours = [self objectForParsed:parsedLocation key:@"business_hours"];
		NSArray* tags = [self processTags:[self objectForParsed:parsedLocation key:@"tags"]];
		
		CGOffersLocation* location =
		[[[CGOffersLocation alloc] initImmutable:locationId impressionId:impressionId name:name
										 address:address latlon:latlon image:image phone:phone
										  rating:rating businessHours:businessHours tags:tags] autorelease];
		[locations addObject:location];
	}
	
	return locations;
}

- (CGOffersOffer*) processOffer:(NSDictionary*) parsedOffer {
	if (parsedOffer == nil) {
		return nil;
	}
	
	NSString* offerId = [self objectForParsed:parsedOffer key:@"id"];
	NSInteger referenceId = [[self objectForParsed:parsedOffer key:@"reference_id"] integerValue];
	NSString* impressionId = [self objectForParsed:parsedOffer key:@"impression_id"];
	NSString* title = [self objectForParsed:parsedOffer key:@"title"];
	NSString* offerDescription = [self objectForParsed:parsedOffer key:@"description"];
	NSInteger redemptionTypeId = [[self objectForParsed:parsedOffer key:@"redemption_type_id"] integerValue];
	NSString* redemptionType = [self objectForParsed:parsedOffer key:@"redemption_type"];
	NSURL* redemptionUrl = [self urlForParsed:parsedOffer key:@"redemption_url"];
	NSString* terms = [self objectForParsed:parsedOffer key:@"terms"];
	NSString* source = [self objectForParsed:parsedOffer key:@"source"];
	NSArray* types = [self processOfferTypes:[self objectForParsed:parsedOffer key:@"offer_types"]];
	NSURL* imageUrl = [self urlForParsed:parsedOffer key:@"image_url"];
	NSDate* startDate = [self dateForParsed:parsedOffer key:@"start_date"];
	NSDate* expirationDate = [self dateForParsed:parsedOffer key:@"expiration_date"];
	NSInteger popularity = [[self objectForParsed:parsedOffer key:@"popularity"] integerValue];
	Float32 faceValue = [[self objectForParsed:parsedOffer key:@"face_value"] floatValue];
	Float32 discountValue = [[self objectForParsed:parsedOffer key:@"discount_value"] floatValue];
	NSArray* locations = [self processOffersLocations:[self objectForParsed:parsedOffer key:@"locations"]];
	NSString* attributionSource = [self objectForParsed:parsedOffer key:@"attribution_source"];
	NSURL* attributionLogo = [self urlForParsed:parsedOffer key:@"attribution_logo"];
	
	CGOffersOffer* offer =
	[[[CGOffersOffer alloc] initImmutable:offerId referenceId:referenceId impressionId:impressionId
									title:title offerDescription:offerDescription redemptionTypeId:redemptionTypeId
						   redemptionType:redemptionType redemptionUrl:redemptionUrl terms:terms
								   source:source types:types imageUrl:imageUrl startDate:startDate
						   expirationDate:expirationDate popularity:popularity faceValue:faceValue
							discountValue:discountValue locations:locations attributionSource:attributionSource
						  attributionLogo:attributionLogo] autorelease];
	return offer;
}

@end
