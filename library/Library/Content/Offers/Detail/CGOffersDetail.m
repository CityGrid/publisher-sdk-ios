//
//
//  Copyright 2011 CityGrid Media, LLC All rights reserved.
//
#import "CGOffersDetail.h"
#import "CGConstants.h"
#import "CGShared.h"
#import "CGOffersDetailResults.h"
#import "CGOffersOffer.h"

#define CGOffersDetailUri @"content/offers/v2/detail"

@implementation CGOffersDetail

@synthesize publisher = publisher_;
@synthesize offerId = offerId_;
@synthesize locationId = locationId_;
@synthesize impressionId = impressionId_;
@synthesize placement = placement_;
@synthesize timeout = timeout_;

#pragma mark -
#pragma mark Lifecycle

- (id) init:(NSString*) publisher {
	self = [super init];
	
	if (self) {
		self.publisher = publisher;
		self.offerId = nil;
		self.locationId = CG_NSINTEGER_UNKNOWN;
		self.impressionId = nil;
		self.placement = nil;
		self.timeout = [CGShared sharedInstance].timeout;
	}
	
	return self;
}

+ (id) offersDetail {
	return [[self class] offersDetailWithPublisher:nil placement:nil];
}

+ (id) offersDetailWithPublisher:(NSString*) publisher {
	return [[self class] offersDetailWithPublisher:publisher placement:nil];
}

+ (id) offersDetailWithPlacement:(NSString*) placement {
	return [[self class] offersDetailWithPublisher:nil placement:placement];
}

+ (id) offersDetailWithPublisher:(NSString*) publisher placement:(NSString*) placement {
	NSString* resolvedPublisher = publisher ? publisher : [CGShared sharedInstance].publisher;
	NSString* resolvedPlacement = placement ? placement : [CGShared sharedInstance].placement;
	
	CGOffersDetail* builder = [[[[self class] alloc] init:resolvedPublisher] autorelease];
	builder.placement = resolvedPlacement;
	return builder;
}

- (void) dealloc {
	self.publisher = nil;
	self.offerId = nil;
	self.impressionId = nil;
	self.placement = nil;
	
	[super dealloc];
}

#pragma mark -
#pragma mark NSCoding

- (id) initWithCoder:(NSCoder*) decoder {
	self = [super initWithCoder:decoder];
	
	if (self) {
		self.publisher = [decoder decodeObjectForKey:@"publisher"];
		self.offerId = [decoder decodeObjectForKey:@"offerId"];
		self.locationId = [decoder decodeIntegerForKey:@"locationId"];
		self.impressionId = [decoder decodeObjectForKey:@"impressionId"];
		self.placement = [decoder decodeObjectForKey:@"placement"];
		self.timeout = [decoder decodeDoubleForKey:@"timeout"];
	}
	
	return self;
}

- (void) encodeWithCoder:(NSCoder*) encoder {
	[super encodeWithCoder:encoder];
	[encoder encodeObject:self.publisher forKey:@"publisher"];
	[encoder encodeObject:self.offerId forKey:@"offerId"];
	[encoder encodeInteger:self.locationId forKey:@"locationId"];
	[encoder encodeObject:self.impressionId forKey:@"impressionId"];
	[encoder encodeObject:self.placement forKey:@"placement"];
	[encoder encodeDouble:self.timeout forKey:@"timeout"];
}

#pragma mark -
#pragma mark NSCopying

- (id) copyWithZone:(NSZone*) zone {
	CGOffersDetail* copy = [super copyWithZone:zone];
	if (copy) {
		copy.publisher = [[self.publisher copyWithZone:zone] autorelease];
		copy.offerId = [[self.offerId copyWithZone:zone] autorelease];
		copy.locationId = self.locationId;
		copy.impressionId = [[self.impressionId copyWithZone:zone] autorelease];
		copy.placement = [[self.placement copyWithZone:zone] autorelease];
		copy.timeout = self.timeout;
	}
	
	return copy;
}

#pragma mark -
#pragma mark NSObject

- (BOOL) isEqualToOffersDetail:(CGOffersDetail*) other {
	return
	[self isEqualWithNull:self.publisher other:other.publisher] &&
	[self isEqualWithNull:self.offerId other:other.offerId] &&
	self.locationId == other.locationId &&
	[self isEqualWithNull:self.impressionId other:other.impressionId] &&
	[self isEqualWithNull:self.placement other:other.placement] &&
	self.timeout == other.timeout;
}

- (BOOL) isEqual:(id) other {
	if (other == self) {
		return YES;
	}
	if (! other || ! [other isKindOfClass:[self class]]) {
		return NO;
	}
	
	return [self isEqualToOffersDetail:other];
}

- (NSUInteger) hash {
	NSUInteger h = 0;
	h += [self.publisher hash];
	h += [self.offerId hash];
	h += self.locationId;
	h += [self.impressionId hash];
	h += [self.placement hash];
	h += (NSUInteger) self.timeout;
	return h;
}

- (NSString*) description {
	NSMutableString* description = [[NSMutableString alloc] initWithCapacity:64];
	[description appendString:@"<CGOffersDetail "];
	[description appendFormat:@"publisher=%@", self.publisher];
	[description appendFormat:@",offerId=%@", self.offerId];
	[description appendFormat:@",locationId=%i", self.locationId];
	[description appendFormat:@",impressionId=%@", self.impressionId];
	[description appendFormat:@",placement=%@", self.placement];
	[description appendFormat:@",timeout=%f", self.timeout];
	return [description autorelease];
}

#pragma mark -
#pragma mark Actions

- (NSArray*) validate {
	NSMutableArray* errors = [[NSMutableArray alloc] initWithCapacity:0];
	
	if ([self.publisher length] == 0) {
		[errors addObject:[[CGShared sharedInstance] errorWithErrorNum:CGErrorNumPublisherRequired]];
	}
	if ([self.offerId length] == 0) {
		[errors addObject:[[CGShared sharedInstance] errorWithErrorNum:CGErrorNumOfferIdRequired]];
	}
	if (self.locationId != CG_NSINTEGER_UNKNOWN && self.locationId < 0) {
		[errors addObject:[[CGShared sharedInstance] errorWithErrorNum:CGErrorNumLocationIdOutOfRange]];
	}
	
	[errors autorelease];
	return [errors count] == 0 ? nil : errors;
}

- (NSDictionary*) build {
	NSMutableDictionary* parameters = [[NSMutableDictionary alloc] initWithCapacity:10];
	if ([self.publisher length] > 0) {
		[parameters setObject:self.publisher forKey:@"publisher"];
	}
	if ([self.offerId length] > 0) {
		[parameters setObject:self.offerId forKey:@"id"];
	}
	if (self.locationId != CG_NSINTEGER_UNKNOWN) {
		[parameters setObject:[NSString stringWithFormat:@"%i", self.locationId] forKey:@"location_id"];
	}
	if ([self.impressionId length] > 0) {
		[parameters setObject:self.impressionId forKey:@"i"];
	}
	if ([self.placement length] > 0) {
		[parameters setObject:self.placement forKey:@"placement"];
	}
	[parameters setObject:@"json" forKey:@"format"];
	
	return [parameters autorelease];
}

- (CGOffersDetailResults*) processResults:(NSDictionary*) parsedJson {
	CGOffersOffer* offer = [self processOffer:parsedJson];
	
	CGOffersDetailResults* results = [[[CGOffersDetailResults alloc] initImmutable:offer] autorelease];
	return results;
}

- (CGOffersDetailResults*) detail:(NSArray**) errors {
	NSArray* validationErrors = [self validate];
	if (validationErrors) {
		if (errors != NULL) {
			*errors = validationErrors;
		}
		return nil;
	}
	
	NSURL* url = [[CGShared sharedInstance].url URLByAppendingPathComponent:CGOffersDetailUri];
	NSDictionary* parameters = [self build];
	
	NSDictionary* parsed = [[CGShared sharedInstance] sendSynchronousRequest:url parameters:parameters timeout:self.timeout errors:errors];
	if (parsed == nil) {
		return nil;
	}
	
	CGOffersDetailResults* results = [self processResults:parsed];
	return results;
}

@end
