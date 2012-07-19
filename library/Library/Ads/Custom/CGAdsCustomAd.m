//
//
//  Copyright 2011 CityGrid Media, LLC All rights reserved.
//
#import "CGAdsCustomAd.h"

@interface CGAdsCustomAd ()

@property (nonatomic, assign, readwrite) NSInteger adId;
@property (nonatomic, retain, readwrite) NSString* type;
@property (nonatomic, retain, readwrite) NSString* tagline;
@property (nonatomic, retain, readwrite) NSString* businessDescription;
@property (nonatomic, retain, readwrite) NSURL* destinationUrl;
@property (nonatomic, retain, readwrite) NSURL* displayUrl;
@property (nonatomic, assign, readwrite) Float32 ppe;
@property (nonatomic, assign, readwrite) NSInteger reviews;
@property (nonatomic, retain, readwrite) NSString* offers;
@property (nonatomic, assign, readwrite) Float32 distance;
@property (nonatomic, retain, readwrite) NSString *attributionText;

@end

@implementation CGAdsCustomAd

@synthesize adId = adId_;
@synthesize type = type_;
@synthesize tagline = tagline_;
@synthesize businessDescription = businessDescription_;
@synthesize destinationUrl = destinationUrl_;
@synthesize displayUrl = displayUrl_;
@synthesize ppe = ppe_;
@synthesize reviews = reviews_;
@synthesize offers = offers_;
@synthesize distance = distance_;
@synthesize attributionText = attributionText_;

#pragma mark -
#pragma mark Lifecycle

- (id) initImmutable:(NSInteger) locationId impressionId:(NSString*) impressionId name:(NSString*) name
			 address:(id) address latlon:(CLLocation*) latlon image:(NSURL*) image phone:(NSString*) phone
			  rating:(NSUInteger) rating adId:(NSInteger) adId type:(NSString*) type tagline:(NSString*) tagline
 businessDescription:(NSString*) businessDescription destinationUrl:(NSURL*) destinationUrl
		  displayUrl:(NSURL*) displayUrl ppe:(Float32) ppe reviews:(NSUInteger) reviews offers:(NSString*) offers
			distance:(Float32) distance attributionText:(NSString*) attributionText{
	self = [super initImmutable:locationId impressionId:impressionId name:name address:address latlon:latlon
						  image:image phone:phone rating:rating];
	
	if (self) {
		self.adId = adId;
		self.type = type;
		self.tagline = tagline;
		self.businessDescription = businessDescription;
		self.destinationUrl = destinationUrl;
		self.displayUrl = displayUrl;
		self.ppe = ppe;
		self.reviews = reviews;
		self.offers = offers;
		self.distance = distance;
        self.attributionText = attributionText;
	}
	
	return self;
}

- (void) dealloc {
	self.type = nil;
	self.tagline = nil;
	self.businessDescription = nil;
	self.destinationUrl = nil;
	self.displayUrl = nil;
	self.offers = nil;
    self.attributionText = nil;
	
	[super dealloc];
}

#pragma mark -
#pragma mark NSCoding

- (id) initWithCoder:(NSCoder*) decoder {
	self = [super initWithCoder:decoder];
	
	if (self) {
		self.adId = [decoder decodeIntegerForKey:@"adId"];
		self.type = [decoder decodeObjectForKey:@"type"];
		self.tagline = [decoder decodeObjectForKey:@"tagline"];
		self.businessDescription = [decoder decodeObjectForKey:@"businessDescription"];
		self.destinationUrl = [decoder decodeObjectForKey:@"destinationUrl"];
		self.displayUrl = [decoder decodeObjectForKey:@"displayUrl"];
		self.ppe = [decoder decodeFloatForKey:@"ppe"];
		self.reviews = [decoder decodeIntegerForKey:@"reviews"];
		self.offers = [decoder decodeObjectForKey:@"offers"];
		self.distance = [decoder decodeFloatForKey:@"distance"];
        self.attributionText = [decoder decodeObjectForKey:@"attributionText"];
	}
	
	return self;
}

- (void) encodeWithCoder:(NSCoder*) encoder {
	[super encodeWithCoder:encoder];
	[encoder encodeInteger:self.adId forKey:@"adId"];
	[encoder encodeObject:self.type forKey:@"type"];
	[encoder encodeObject:self.tagline forKey:@"tagline"];
	[encoder encodeObject:self.businessDescription forKey:@"businessDescription"];
	[encoder encodeObject:self.destinationUrl forKey:@"destinationUrl"];
	[encoder encodeObject:self.displayUrl forKey:@"displayUrl"];
	[encoder encodeFloat:self.ppe forKey:@"ppe"];
	[encoder encodeInteger:self.reviews forKey:@"reviews"];
	[encoder encodeObject:self.offers forKey:@"offers"];
	[encoder encodeFloat:self.distance forKey:@"distance"];
    [encoder encodeObject:self.attributionText forKey:@"attributionText"];
}

#pragma mark -
#pragma mark NSCopying

- (id) copyWithZone:(NSZone*) zone {
	CGAdsCustomAd* copy = [super copyWithZone:zone];
	if (copy) {
		copy.adId = self.adId;
		copy.type = [[self.type copyWithZone:zone] autorelease];
		copy.tagline = [[self.tagline copyWithZone:zone] autorelease];
		copy.businessDescription = [[self.businessDescription copyWithZone:zone] autorelease];
		copy.destinationUrl = [[self.destinationUrl copyWithZone:zone] autorelease];
		copy.displayUrl = [[self.displayUrl copyWithZone:zone] autorelease];
		copy.ppe = self.ppe;
		copy.reviews = self.reviews;
		copy.offers = [[self.offers copyWithZone:zone] autorelease];
		copy.distance = self.distance;
        copy.attributionText = [[self.attributionText copyWithZone:zone] autorelease];
	}
	
	return copy;
}

#pragma mark -
#pragma mark NSObject

- (BOOL) isEqualToAdsCustomAd:(CGAdsCustomAd*) other {
	return
	self.adId == other.adId &&
	[self isEqualWithNull:self.type other:other.type] &&
	[self isEqualWithNull:self.tagline other:other.tagline] &&
	[self isEqualWithNull:self.businessDescription other:other.businessDescription] &&
	[self isEqualWithNull:self.destinationUrl other:other.destinationUrl] &&
	[self isEqualWithNull:self.displayUrl other:other.displayUrl] &&
	self.ppe == other.ppe &&
	self.reviews == other.reviews &&
	[self isEqualWithNull:self.offers other:other.offers] &&
	self.distance == other.distance &&
    [self isEqualWithNull:self.attributionText other:other.attributionText];
}

- (BOOL) isEqual:(id) other {
	if (other == self) {
		return YES;
	}
	if (! other || ! [other isKindOfClass:[self class]]) {
		return NO;
	}
	
	return [self isEqualToAdsCustomAd:other];
}

- (NSUInteger) hash {
	NSUInteger h = [super hash];
	h += self.adId;
	h += [self.type hash];
	h += [self.tagline hash];
	h += [self.businessDescription hash];
	h += [self.destinationUrl hash];
	h += [self.displayUrl hash];
	h += self.ppe;
	h += self.reviews;
	h += [self.offers hash];
	h += self.distance;
    h += [self.attributionText hash];
	return h;
}

- (NSString*) description {
	NSMutableString* description = [NSMutableString stringWithCapacity:64];
	[description appendFormat:@"<CGAdsCustomAd %@ ", [super description]];
	[description appendFormat:@"adId=%i", self.adId];
	[description appendFormat:@",type=%@", self.type];
	[description appendFormat:@",tagline=%@", self.tagline];
	[description appendFormat:@",businessDescription=%@", self.businessDescription];
	[description appendFormat:@",destinationUrl=%@", self.destinationUrl];
	[description appendFormat:@",displayUrl=%@", self.displayUrl];
	[description appendFormat:@",ppe=%f", self.ppe];
	[description appendFormat:@",reviews=%i", self.reviews];
	[description appendFormat:@",reviews=%@", self.offers];
	[description appendFormat:@",distance=%f", self.distance];
    [description appendFormat:@",attributionText=%@", self.attributionText];
	[description appendString:@">"];
	return description;
}

@end
