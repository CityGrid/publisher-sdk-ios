//
//
//  Copyright 2011 CityGrid Media, LLC All rights reserved.
//
#import "CGAdsMobileAd.h"
#import "CGPlacesDetail.h"
#import "CGPlacesDetailResults.h"
#import "CGPlacesDetailLocation.h"

@interface CGAdsMobileAd ()

@property (nonatomic, assign, readwrite) NSInteger locationId;
@property (nonatomic, retain, readwrite) NSString* impressionId;
@property (nonatomic, retain, readwrite) NSString* adId;
@property (nonatomic, retain, readwrite) NSURL* destinationUrl;
@property (nonatomic, retain, readwrite) NSURL* image;

@end

@implementation CGAdsMobileAd

@synthesize locationId = locationId_;
@synthesize impressionId = impressionId_;
@synthesize adId = adId_;
@synthesize destinationUrl = destinationUrl_;
@synthesize image = image_;

#pragma mark -
#pragma mark Lifecycle

- (id) initImmutable:(NSInteger) locationId impressionId:(NSString*) impressionId adId:(NSString*) adId
	  destinationUrl:(NSURL*) destinationUrl image:(NSURL*) image {
	self = [super init];
	
	if (self) {
		self.locationId = locationId;
		self.impressionId = impressionId;
		self.adId = adId;
		self.destinationUrl = destinationUrl;
		self.image = image;
	}
	
	return self;
}

- (void) dealloc {
	self.impressionId = nil;
    self.adId = nil;
	self.destinationUrl = nil;
	self.image = nil;
	
	[super dealloc];
}

#pragma mark -
#pragma mark NSCoding

- (id) initWithCoder:(NSCoder*) decoder {
	self = [super initWithCoder:decoder];
	
	if (self) {
		self.locationId = [decoder decodeIntegerForKey:@"locationId"];
		self.impressionId = [decoder decodeObjectForKey:@"impressionId"];
		self.adId = [decoder decodeObjectForKey:@"adId"];
		self.destinationUrl = [decoder decodeObjectForKey:@"destinationUrl"];
		self.image = [decoder decodeObjectForKey:@"image"];
	}
	
	return self;
}

- (void) encodeWithCoder:(NSCoder*) encoder {
	[super encodeWithCoder:encoder];
	[encoder encodeInteger:self.locationId forKey:@"locationId"];
	[encoder encodeObject:self.impressionId forKey:@"impressionId"];
	[encoder encodeObject:self.adId forKey:@"adId"];
	[encoder encodeObject:self.destinationUrl forKey:@"destinationUrl"];
	[encoder encodeObject:self.image forKey:@"image"];
}

#pragma mark -
#pragma mark NSCopying

- (id) copyWithZone:(NSZone*) zone {
	CGAdsMobileAd* copy = [super copyWithZone:zone];
	if (copy) {
		copy.locationId = self.locationId;
		copy.impressionId = [[self.impressionId copyWithZone:zone] autorelease];
		copy.adId = [[self.adId copyWithZone:zone] autorelease];
		copy.destinationUrl = [[self.destinationUrl copyWithZone:zone] autorelease];
		copy.image = [[self.image copyWithZone:zone] autorelease];
	}
	
	return copy;
}

#pragma mark -
#pragma mark NSObject

- (BOOL) isEqualToAdsMobileAd:(CGAdsMobileAd*) other {
	return
	self.locationId == other.locationId &&
	[self isEqualWithNull:self.impressionId other:other.impressionId] &&
    [self isEqualWithNull:self.adId other:other.adId] &&
	[self isEqualWithNull:self.destinationUrl other:other.destinationUrl] &&
	[self isEqualWithNull:self.image other:other.image];
}

- (BOOL) isEqual:(id) other {
	if (other == self) {
		return YES;
	}
	if (! other || ! [other isKindOfClass:[self class]]) {
		return NO;
	}
	
	return [self isEqualToAdsMobileAd:other];
}

- (NSUInteger) hash {
	NSUInteger h = 0;
	h += self.locationId;
	h += [self.impressionId hash];
	h += [self.adId hash];
	h += [self.destinationUrl hash];
	h += [self.image hash];
	return h;
}

- (NSString*) description {
	NSMutableString* description = [NSMutableString stringWithCapacity:64];
	[description appendString:@"<CGAdsMobileAd "];
	[description appendFormat:@"locationId=%i", self.locationId];
	[description appendFormat:@",impressionId=%@", self.impressionId];
	[description appendFormat:@"adId=%@", self.adId];
	[description appendFormat:@",destinationUrl=%@", self.destinationUrl];
	[description appendFormat:@",image=%@", self.image];
	[description appendString:@">"];
	return description;
}

#pragma mark -
#pragma mark Detail Helpers

- (CGPlacesDetail*) placesDetail {
	CGPlacesDetail* detail = [CGPlacesDetail placesDetail];
	detail.locationId = self.locationId;
	detail.impressionId = self.impressionId;
	return detail;
}

- (CGPlacesDetailLocation*) placesDetailLocation:(NSArray**) errors {
	return [[self placesDetail] detail:errors].location;
}

@end
