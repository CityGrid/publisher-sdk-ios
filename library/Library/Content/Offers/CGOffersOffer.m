//
//
//  Copyright 2011 CityGrid Media, LLC All rights reserved.
//
#import "CGOffersOffer.h"
#import "CityGrid.h"

@interface CGOffersOffer ()

@property (nonatomic, retain, readwrite) NSString* offerId;
@property (nonatomic, assign, readwrite) NSInteger referenceId;
@property (nonatomic, retain, readwrite) NSString* impressionId;
@property (nonatomic, retain, readwrite) NSString* title;
@property (nonatomic, retain, readwrite) NSString* offerDescription;
@property (nonatomic, assign, readwrite) NSInteger redemptionTypeId;
@property (nonatomic, retain, readwrite) NSString* redemptionType;
@property (nonatomic, retain, readwrite) NSURL* redemptionUrl;
@property (nonatomic, retain, readwrite) NSString* terms;
@property (nonatomic, retain, readwrite) NSString* source;
@property (nonatomic, retain, readwrite) NSArray* types; // NSNumber of CGOffersType
@property (nonatomic, retain, readwrite) NSURL* imageUrl;
@property (nonatomic, retain, readwrite) NSDate* startDate;
@property (nonatomic, retain, readwrite) NSDate* expirationDate;
@property (nonatomic, assign, readwrite) NSInteger popularity;
@property (nonatomic, assign, readwrite) Float32 faceValue;
@property (nonatomic, assign, readwrite) Float32 discountValue;
@property (nonatomic, retain, readwrite) NSArray* locations; // CGOffersLocation
@property (nonatomic, retain, readwrite) NSString* attributionSource;
@property (nonatomic, retain, readwrite) NSURL* attributionLogo;

@end

@implementation CGOffersOffer

@synthesize offerId = offerId_;
@synthesize referenceId = referenceId_;
@synthesize impressionId = impressionId_;
@synthesize title = title_;
@synthesize offerDescription = offerDescription_;
@synthesize redemptionTypeId = redemptionTypeId_;
@synthesize redemptionType = redemptionType_;
@synthesize redemptionUrl = redemptionUrl_;
@synthesize terms = terms_;
@synthesize source = source_;
@synthesize types = types_;
@synthesize imageUrl = imageUrl_;
@synthesize startDate = startDate_;
@synthesize expirationDate = expirationDate_;
@synthesize popularity = popularity_;
@synthesize faceValue = faceValue_;
@synthesize discountValue = discountValue_;
@synthesize locations = locations_;
@synthesize attributionSource = attributionSource_;
@synthesize attributionLogo = attributionLogo_;

#pragma mark -
#pragma mark Lifecycle

- (id) initImmutable:(NSString*) offerId referenceId:(NSInteger) referenceId impressionId:(NSString*) impressionId
			   title:(NSString*) title offerDescription:(NSString*) offerDescription redemptionTypeId:(NSInteger) redemptionTypeId
	  redemptionType:(NSString*) redemptionType redemptionUrl:(NSURL*) redemptionUrl terms:(NSString*) terms
			  source:(NSString*) source types:(NSArray*) types imageUrl:(NSURL*) imageUrl
		   startDate:(NSDate*) startDate expirationDate:(NSDate*) expirationDate
		  popularity:(NSInteger) popularity faceValue:(Float32) faceValue discountValue:(Float32) discountValue
		   locations:(NSArray*) locations attributionSource:(NSString*) attributionSource attributionLogo:(NSURL*) attributionLogo {
	self = [super init];
	
	if (self) {
		self.offerId = offerId;
		self.referenceId = referenceId;
		self.impressionId = impressionId;
		self.title = title;
		self.offerDescription = offerDescription;
		self.redemptionTypeId = redemptionTypeId;
		self.redemptionType = redemptionType;
		self.redemptionUrl = redemptionUrl;
		self.terms = terms;
		self.source = source;
		self.types = types;
		self.imageUrl = imageUrl;
		self.startDate = startDate;
		self.expirationDate = expirationDate;
		self.popularity = popularity;
		self.faceValue = faceValue;
		self.discountValue = discountValue;
		self.locations = locations;
		self.attributionSource = attributionSource;
		self.attributionLogo = attributionLogo;
	}
	
	return self;
}

- (void) dealloc {
	self.offerId = nil;
	self.impressionId = nil;
	self.title = nil;
	self.offerDescription = nil;
	self.redemptionType = nil;
	self.redemptionUrl = nil;
	self.terms = nil;
	self.source = nil;
	self.types = nil;
	self.imageUrl = nil;
	self.startDate = nil;
	self.expirationDate = nil;
	self.locations = nil;
	self.attributionSource = nil;
	self.attributionLogo = nil;
	
	[super dealloc];
}

#pragma mark -
#pragma mark NSCoding

- (id) initWithCoder:(NSCoder*) decoder {
	self = [super initWithCoder:decoder];
	
	if (self) {
		self.offerId = [decoder decodeObjectForKey:@"offerId"];
		self.impressionId = [decoder decodeObjectForKey:@"impressionId"];
		self.title = [decoder decodeObjectForKey:@"title"];
		self.offerDescription = [decoder decodeObjectForKey:@"offerDescription"];
		self.redemptionTypeId = [decoder decodeIntegerForKey:@"redemptionTypeId"];
		self.redemptionType = [decoder decodeObjectForKey:@"redemptionType"];
		self.redemptionUrl = [decoder decodeObjectForKey:@"redemptionUrl"];
		self.terms = [decoder decodeObjectForKey:@"terms"];
		self.source = [decoder decodeObjectForKey:@"source"];
		self.types = [decoder decodeObjectForKey:@"types"];
		self.imageUrl = [decoder decodeObjectForKey:@"imageUrl"];
		self.startDate = [decoder decodeObjectForKey:@"startDate"];
		self.expirationDate = [decoder decodeObjectForKey:@"expirationDate"];
		self.popularity = [decoder decodeIntegerForKey:@"popularity"];
		self.faceValue = [decoder decodeFloatForKey:@"faceValue"];
		self.discountValue = [decoder decodeFloatForKey:@"discountValue"];
		self.locations = [decoder decodeObjectForKey:@"locations"];
		self.attributionSource = [decoder decodeObjectForKey:@"attributionSource"];
		self.attributionLogo = [decoder decodeObjectForKey:@"attributionLogo"];
	}
	
	return self;
}

- (void) encodeWithCoder:(NSCoder*) encoder {
	[super encodeWithCoder:encoder];
	[encoder encodeObject:self.offerId forKey:@"offerId"];
	[encoder encodeObject:self.impressionId forKey:@"impressionId"];
	[encoder encodeObject:self.title forKey:@"title"];
	[encoder encodeObject:self.offerDescription forKey:@"offerDescription"];
	[encoder encodeInteger:self.redemptionTypeId forKey:@"redemptionTypeId"];
	[encoder encodeObject:self.redemptionType forKey:@"redemptionType"];
	[encoder encodeObject:self.redemptionUrl forKey:@"redemptionUrl"];
	[encoder encodeObject:self.terms forKey:@"terms"];
	[encoder encodeObject:self.source forKey:@"source"];
	[encoder encodeObject:self.types forKey:@"types"];
	[encoder encodeObject:self.imageUrl forKey:@"imageUrl"];
	[encoder encodeObject:self.startDate forKey:@"startDate"];
	[encoder encodeObject:self.expirationDate forKey:@"expirationDate"];
	[encoder encodeInteger:self.popularity forKey:@"popularity"];
	[encoder encodeFloat:self.faceValue forKey:@"faceValue"];
	[encoder encodeFloat:self.discountValue forKey:@"discountValue"];
	[encoder encodeObject:self.locations forKey:@"locations"];
	[encoder encodeObject:self.attributionSource forKey:@"attributionSource"];
	[encoder encodeObject:self.attributionLogo forKey:@"attributionLogo"];
}

#pragma mark -
#pragma mark NSCopying

- (id) copyWithZone:(NSZone*) zone {
	CGOffersOffer* copy = [super copyWithZone:zone];
	if (copy) {
		self.offerId = [[copy.offerId copyWithZone:zone] autorelease];
		self.impressionId = [[copy.impressionId copyWithZone:zone] autorelease];
		self.title = [[copy.title copyWithZone:zone] autorelease];
		self.offerDescription = [[copy.offerDescription copyWithZone:zone] autorelease];
		self.redemptionTypeId = copy.redemptionTypeId;
		self.redemptionType = [[copy.redemptionType copyWithZone:zone] autorelease];
		self.redemptionUrl = [[copy.redemptionUrl copyWithZone:zone] autorelease];
		self.terms = [[copy.terms copyWithZone:zone] autorelease];
		self.source = [[copy.source copyWithZone:zone] autorelease];
		self.types = [[copy.types copyWithZone:zone] autorelease];
		self.imageUrl = [[copy.imageUrl copyWithZone:zone] autorelease];
		self.startDate = [[copy.startDate copyWithZone:zone] autorelease];
		self.expirationDate = [[copy.expirationDate copyWithZone:zone] autorelease];
		self.popularity = copy.popularity;
		self.faceValue = copy.faceValue;
		self.discountValue = copy.discountValue;
		self.locations = [[copy.locations copyWithZone:zone] autorelease];
		self.attributionSource = [[copy.attributionSource copyWithZone:zone] autorelease];
		self.attributionLogo = [[copy.attributionLogo copyWithZone:zone] autorelease];
	}
	
	return copy;
}

#pragma mark -
#pragma mark NSObject

- (BOOL) isEqualToOffersOffer:(CGOffersOffer*) other {
	return
	[self isEqualWithNull:self.offerId other:other.offerId] &&
	[self isEqualWithNull:self.impressionId other:other.impressionId] &&
	[self isEqualWithNull:self.title other:other.title] &&
	[self isEqualWithNull:self.offerDescription other:other.offerDescription] &&
	self.redemptionTypeId == other.redemptionTypeId &&
	[self isEqualWithNull:self.redemptionType other:other.redemptionType] &&
	[self isEqualWithNull:self.redemptionUrl other:other.redemptionUrl] &&
	[self isEqualWithNull:self.terms other:other.terms] &&
	[self isEqualWithNull:self.source other:other.source] &&
	[self isEqualWithNull:self.types other:other.types] &&
	[self isEqualWithNull:self.imageUrl other:other.imageUrl] &&
	[self isEqualWithNull:self.startDate other:other.startDate] &&
	[self isEqualWithNull:self.expirationDate other:other.expirationDate] &&
	self.popularity == other.popularity &&
	self.faceValue == other.faceValue &&
	self.discountValue == other.discountValue &&
	[self isEqualWithNull:self.locations other:other.locations] &&
	[self isEqualWithNull:self.attributionSource other:other.attributionSource] &&
	[self isEqualWithNull:self.attributionLogo other:other.attributionLogo];
}

- (BOOL) isEqual:(id) other {
	if (other == self) {
		return YES;
	}
	if (! other || ! [other isKindOfClass:[self class]]) {
		return NO;
	}
	
	return [self isEqualToOffersOffer:other];
}

- (NSUInteger) hash {
	NSUInteger h = 0;
	h += [self.offerId hash];
	h += [self.impressionId hash];
	h += [self.title hash];
	h += [self.offerDescription hash];
	h += self.redemptionTypeId;
	h += [self.redemptionType hash];
	h += [self.redemptionUrl hash];
	h += [self.terms hash];
	h += [self.source hash];
	h += [self.types hash];
	h += [self.imageUrl hash];
	h += [self.startDate hash];
	h += [self.expirationDate hash];
	h += self.popularity;
	h += self.faceValue;
	h += self.discountValue;
	h += [self.locations hash];
	h += [self.attributionSource hash];
	h += [self.attributionLogo hash];
	return h;
}

- (NSString*) description {
	NSMutableString* description = [NSMutableString stringWithCapacity:64];
	
	[description appendString:@"<CGOffersOffer "];
	[description appendFormat:@"offerId=%@", self.offerId];
	[description appendFormat:@",impressionId=%@", self.impressionId];
	[description appendFormat:@",title=%@", self.title];
	[description appendFormat:@",offerDescription=%@", self.offerDescription];
	[description appendFormat:@",redemptionTypeId=%i", self.redemptionTypeId];
	[description appendFormat:@",redemptionType=%@", self.redemptionType];
	[description appendFormat:@",redemptionUrl=%@", self.redemptionUrl];
	[description appendFormat:@",terms=%@", self.terms];
	[description appendFormat:@",source=%@", self.source];
	[description appendFormat:@",types=%@", self.types];
	[description appendFormat:@",imageUrl=%@", self.imageUrl];
	[description appendFormat:@",startDate=%@", self.startDate];
	[description appendFormat:@",expirationDate=%@", self.expirationDate];
	[description appendFormat:@",popularity=%i", self.popularity];
	[description appendFormat:@",faceValue=%f", self.faceValue];
	[description appendFormat:@",discountValue=%f", self.discountValue];
	[description appendFormat:@",locations=%@", self.locations];
	[description appendFormat:@",attributionSource=%@", self.attributionSource];
	[description appendFormat:@",attributionLogo=%@", self.attributionLogo];
	[description appendString:@">"];
	
	return description;
}

#pragma mark -
#pragma mark Offers Helpers

- (CGOffersDetail*) offersDetail {
	CGOffersDetail* builder = [CityGrid offersDetail];
	builder.offerId = self.offerId;
	builder.impressionId = self.impressionId;
	return builder;
}

- (CGOffersOffer*) offersDetailOffer:(NSArray**) errors {
	return [[self offersDetail] detail:errors].offer;
}

@end