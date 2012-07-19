//
//
//  Copyright 2011 CityGrid Media, LLC All rights reserved.
//
#import "CGContentBuilder.h"
#import "CGRegion.h"
#import "CGAddress.h"
#import "CGPlacesDetailAddress.h"
#import "CGTag.h"
#import "CGHistogram.h"
#import "CGHistogramItem.h"

@implementation CGContentBuilder

- (NSArray*) processRegions:(NSArray*) parsedRegions {
	if (parsedRegions == nil) {
		return nil;
	}
	
	NSMutableArray* regions = [NSMutableArray arrayWithCapacity:[parsedRegions count]];
	for (NSDictionary* parsedRegion in parsedRegions) {
		NSString* type = [self objectForParsed:parsedRegion key:@"type"];
		NSString* name = [self objectForParsed:parsedRegion key:@"name"];
		CLLocation* latlon = [self locationForParsed:parsedRegion latitudeKey:@"latitude" longitudeKey:@"longitude"];
		Float32 radius = [[self objectForParsed:parsedRegion key:@"default_radius"] floatValue];
		
		CGRegion* region = [[[CGRegion alloc] initImmutable:type name:name latlon:latlon radius:radius] autorelease];
		[regions addObject:region];
	}
	return regions;
}

- (id) processLocationAddress:(NSDictionary*) parsedAddress useZip:(BOOL) useZip {
	if (parsedAddress == nil) {
		return nil;
	}
	
	NSString* street = [self objectForParsed:parsedAddress key:@"street"];
	NSString* city = [self objectForParsed:parsedAddress key:@"city"];
	NSString* state = [self objectForParsed:parsedAddress key:@"state"];
	NSString* zip = nil;
	if (useZip) {
		zip = [[self objectForParsed:parsedAddress key:@"zip"] stringValue];
	} else {
		zip = [self objectForParsed:parsedAddress key:@"postal_code"];
	}
	NSString* deliveryPoint = [self objectForParsed:parsedAddress key:@"delivery_point"];
	NSString* crossStreet = [self objectForParsed:parsedAddress key:@"crossStreet"];
	
	id address = nil;
	if ([deliveryPoint length] > 0 || [crossStreet length] > 0) {
		address =
		[[[CGPlacesDetailAddress alloc] initImmutable:street city:city state:state zip:zip
										deliveryPoint:deliveryPoint crossStreet:crossStreet] autorelease];
	} else {
		address = [[[CGAddress alloc] initImmutable:street city:city state:state zip:zip] autorelease];
	}
	
	return address;
}

- (void) appendParameter:(NSMutableString*) urlString key:(NSString*) key value:(NSString*) value {
	if ([urlString rangeOfString:@"?"].location == NSNotFound) {
		[urlString appendString:@"?"];
	} else {
		[urlString appendString:@"&"];
	}
	
	[urlString appendFormat:@"%@=%@", key, value];
}

- (NSURL*) handleUrlFields:(NSURL*) original publisher:(NSString*) publisher impressionId:(NSString*) impressionId placement:(NSString*) placement {
	if (original == nil) {
		return nil;
	}
	
	NSMutableString* urlString = [[[original absoluteString] mutableCopy] autorelease];
	if (impressionId && [urlString rangeOfString:@"&i="].location == NSNotFound && [urlString rangeOfString:@"?i="].location == NSNotFound) {
		[self appendParameter:urlString key:@"i" value:impressionId];
	}
	
	if (publisher && impressionId && [urlString rangeOfString:@"&publisher="].location == NSNotFound && [urlString rangeOfString:@"?publisher="].location == NSNotFound) {
		[self appendParameter:urlString key:@"publisher" value:publisher];
	}
	
	if (placement && impressionId && [urlString rangeOfString:@"&placement="].location == NSNotFound && [urlString rangeOfString:@"?placement="].location == NSNotFound) {
		[self appendParameter:urlString key:@"placement" value:placement];
	}
	
	return [NSURL URLWithString:urlString];
}

- (NSArray*) processTags:(NSArray*) parsedTags {
	if (parsedTags == nil) {
		return nil;
	}
	
	NSMutableArray* tags = [NSMutableArray arrayWithCapacity:[parsedTags count]];
	for (NSDictionary* parsedTag in parsedTags) {
		NSInteger tagId = [[self objectForParsed:parsedTag key:@"id"] integerValue];
		NSString* name = [self objectForParsed:parsedTag key:@"name"];
		
		CGTag* tag = [[[CGTag alloc] initImmutable:tagId name:name] autorelease];
		[tags addObject:tag];
	}
	
	return tags;
}

- (NSArray*) processTagIds:(NSArray*) parsedTagIds {
	if (parsedTagIds == nil) {
		return nil;
	}
	
	NSMutableArray* tagIds = [NSMutableArray arrayWithCapacity:[parsedTagIds count]];
	for (NSDictionary* parsedTagId in parsedTagIds) {
		NSString* tagId = [self objectForParsed:parsedTagId key:@"tag_id"];
		if (tagId) {
			[tagIds addObject:tagId];
		}
	}
	
	return tagIds;
}

- (NSArray*) processHistogramItems:(NSArray*) parsedItems {
	if (parsedItems == nil) {
		return nil;
	}
	
	NSMutableArray* items = [NSMutableArray arrayWithCapacity:[parsedItems count]];
	for (NSDictionary* parsedItem in parsedItems) {
		NSString* name = [self objectForParsed:parsedItem key:@"name"];
		NSInteger count = [[self objectForParsed:parsedItem key:@"count"] integerValue];
		NSURL* uri = [self urlForParsed:parsedItem key:@"uri"];
		NSArray* tagIds = [self processTagIds:[self objectForParsed:parsedItem key:@"tag_ids"]];
		
		CGHistogramItem* item = [[[CGHistogramItem alloc] initImmutable:name count:count uri:uri tagIds:tagIds] autorelease];
		[items addObject:item];
	}
	
	return items;
}

- (NSArray*) processHistograms:(NSArray*) parsedHistograms {
	if (parsedHistograms == nil) {
		return nil;
	}
	
	NSMutableArray* histograms = [NSMutableArray arrayWithCapacity:[parsedHistograms count]];
	for (NSDictionary* parsedHistogram in parsedHistograms) {
		NSString* name = [self objectForParsed:parsedHistogram key:@"name"];
		NSArray* items = [self processHistogramItems:[self objectForParsed:parsedHistogram key:@"items"]];
		
		CGHistogram* histogram = [[[CGHistogram alloc] initImmutable:name items:items] autorelease];
		[histograms addObject:histogram];
	}
	
	return histograms;
}

@end
