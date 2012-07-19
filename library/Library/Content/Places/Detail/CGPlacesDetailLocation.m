//
//
//  Copyright 2011 CityGrid Media, LLC All rights reserved.
//
#import "CGPlacesDetailLocation.h"
#import "CGPlacesDetailUrls.h"
#import "CGPlacesDetailCustomerContent.h"
#import "CGPlacesDetailReviews.h"
#import "CGAdsTracker.h"

@interface CGPlacesDetailLocation ()

@property (nonatomic, assign, readwrite) NSInteger referenceId;
@property (nonatomic, retain, readwrite) NSString* publicId;
@property (nonatomic, assign, readwrite) BOOL displayAd;
@property (nonatomic, assign, readwrite) NSInteger infoUsaId;
@property (nonatomic, retain, readwrite) NSString* teaser;
@property (nonatomic, retain, readwrite) NSString* callPhone;
@property (nonatomic, retain, readwrite) NSURL* displayUrl;
@property (nonatomic, retain, readwrite) NSArray* markets; // NSString*
@property (nonatomic, retain, readwrite) NSArray* neighborhoods; // NSString*
@property (nonatomic, retain, readwrite) CGPlacesDetailUrls* urls;
@property (nonatomic, retain, readwrite) CGPlacesDetailCustomerContent* customerContent;
@property (nonatomic, retain, readwrite) NSArray* offers; // CGPlacesDetailOffer*
@property (nonatomic, retain, readwrite) NSArray* categories; // CGPlacesDetailCategory*
@property (nonatomic, retain, readwrite) NSArray* attributes; // CGPlacesDetailAttribute*
@property (nonatomic, retain, readwrite) NSString* businessHours;
@property (nonatomic, retain, readwrite) NSString* parking;
@property (nonatomic, retain, readwrite) NSArray* tips; // CGPlacesDetailTip*
@property (nonatomic, retain, readwrite) NSArray* images; // CGPlacesDetailImage*
@property (nonatomic, retain, readwrite) NSArray* editorials; // CGPlacesDetailEditorial*
@property (nonatomic, retain, readwrite) CGPlacesDetailReviews* reviews;

@end

@implementation CGPlacesDetailLocation

@synthesize referenceId = referenceId_;
@synthesize publicId = publicId_;
@synthesize displayAd = displayAd_;
@synthesize infoUsaId = infoUsaId_;
@synthesize teaser = teaser_;
@synthesize callPhone = callPhone_;
@synthesize displayUrl = displayUrl_;
@synthesize markets = markets_;
@synthesize neighborhoods = neighborhoods_;
@synthesize urls = urls_;
@synthesize customerContent = customerContent_;
@synthesize offers = offers_;
@synthesize categories = categories_;
@synthesize attributes = attributes_;
@synthesize businessHours = businessHours_;
@synthesize parking = parking_;
@synthesize tips = tips_;
@synthesize images = images_;
@synthesize editorials = editorials_;
@synthesize reviews = reviews_;

#pragma mark -
#pragma mark Lifecycle

- (id) initImmutable:(NSInteger) locationId impressionId:(NSString*) impressionId name:(NSString*) name
			 address:(id) address latlon:(CLLocation*) latlon image:(NSURL*) image phone:(NSString*) phone
			  rating:(NSInteger) rating
            publicId:(NSString*) publicId
		 referenceId:(NSInteger) referenceId displayAd:(BOOL) displayAd infoUsaId:(NSInteger) infoUsaId teaser:(NSString*) teaser
		   callPhone:(NSString*) callPhone displayUrl:(NSURL*) displayUrl markets:(NSArray*) markets
	   neighborhoods:(NSArray*) neighborhoods urls:(CGPlacesDetailUrls*) urls
	 customerContent:(CGPlacesDetailCustomerContent*) customerContent offers:(NSArray*) offers
		  categories:(NSArray*) categories attributes:(NSArray*) attributes businessHours:(NSString*) businessHours
			 parking:(NSString*) parking tips:(NSArray*) tips images:(NSArray*) images
		  editorials:(NSArray*) editorials reviews:(CGPlacesDetailReviews*) reviews {
	self = [super initImmutable:locationId impressionId:impressionId name:name
						address:address latlon:latlon image:image phone:phone rating:rating];
	
	if (self) {
		self.referenceId = referenceId;
        self.publicId = publicId;
		self.displayAd = displayAd;
		self.infoUsaId = infoUsaId;
		self.teaser = teaser;
		self.callPhone = callPhone;
		self.displayUrl = displayUrl;
		self.markets = markets;
		self.neighborhoods = neighborhoods;
		self.urls = urls;
		self.customerContent = customerContent;
		self.offers = offers;
		self.categories = categories;
		self.attributes = attributes;
		self.businessHours = businessHours;
		self.parking = parking;
		self.tips = tips;
		self.images = images;
		self.editorials = editorials;
		self.reviews = reviews;
	}
	
	return self;
}

- (void) dealloc {
    self.publicId = nil;
	self.teaser = nil;
	self.callPhone = nil;
	self.displayUrl = nil;
	self.markets = nil;
	self.neighborhoods = nil;
	self.urls = nil;
	self.customerContent = nil;
	self.offers = nil;
	self.categories = nil;
	self.attributes = nil;
	self.businessHours = nil;
	self.parking = nil;
	self.tips = nil;
	self.images = nil;
	self.editorials = nil;
	self.reviews = nil;
	
	[super dealloc];
}

#pragma mark -
#pragma mark NSCoding

- (id) initWithCoder:(NSCoder*) decoder {
	self = [super initWithCoder:decoder];
	
	if (self) {
		self.referenceId = [decoder decodeIntegerForKey:@"referenceId"];
        self.publicId = [decoder decodeObjectForKey:@"publicId"];
		self.displayAd = [decoder decodeBoolForKey:@"displayAd"];
		self.infoUsaId = [decoder decodeIntegerForKey:@"infoUsaId"];
		self.teaser = [decoder decodeObjectForKey:@"teaser"];
		self.callPhone = [decoder decodeObjectForKey:@"callPhone"];
		self.displayUrl = [decoder decodeObjectForKey:@"displayUrl"];
		self.markets = [decoder decodeObjectForKey:@"markets"];
		self.neighborhoods = [decoder decodeObjectForKey:@"neighborhoods"];
		self.urls = [decoder decodeObjectForKey:@"urls"];
		self.customerContent = [decoder decodeObjectForKey:@"customerContent"];
		self.offers = [decoder decodeObjectForKey:@"offers"];
		self.categories = [decoder decodeObjectForKey:@"categories"];
		self.attributes = [decoder decodeObjectForKey:@"attributes"];
		self.businessHours = [decoder decodeObjectForKey:@"businessHours"];
		self.parking = [decoder decodeObjectForKey:@"parking"];
		self.tips = [decoder decodeObjectForKey:@"tips"];
		self.images = [decoder decodeObjectForKey:@"images"];
		self.editorials = [decoder decodeObjectForKey:@"editorials"];
		self.reviews = [decoder decodeObjectForKey:@"reviews"];
	}
	
	return self;
}

- (void) encodeWithCoder:(NSCoder*) encoder {
	[super encodeWithCoder:encoder];
	
	[encoder encodeInteger:self.referenceId forKey:@"referenceId"];
    [encoder encodeObject:self.publicId forKey:@"publicId"];
	[encoder encodeBool:self.displayAd forKey:@"displayAd"];
	[encoder encodeInteger:self.infoUsaId forKey:@"infoUsaId"];
	[encoder encodeObject:self.teaser forKey:@"teaser"];
	[encoder encodeObject:self.callPhone forKey:@"callPhone"];
	[encoder encodeObject:self.displayUrl forKey:@"displayUrl"];
	[encoder encodeObject:self.markets forKey:@"markets"];
	[encoder encodeObject:self.neighborhoods forKey:@"neighborhoods"];
	[encoder encodeObject:self.urls forKey:@"urls"];
	[encoder encodeObject:self.customerContent forKey:@"customerContent"];
	[encoder encodeObject:self.offers forKey:@"offers"];
	[encoder encodeObject:self.categories forKey:@"categories"];
	[encoder encodeObject:self.attributes forKey:@"attributes"];
	[encoder encodeObject:self.businessHours forKey:@"businessHours"];
	[encoder encodeObject:self.parking forKey:@"parking"];
	[encoder encodeObject:self.tips forKey:@"tips"];
	[encoder encodeObject:self.images forKey:@"images"];
	[encoder encodeObject:self.editorials forKey:@"editorials"];
	[encoder encodeObject:self.reviews forKey:@"reviews"];
}

#pragma mark -
#pragma mark NSCopying

- (id) copyWithZone:(NSZone*) zone {
	CGPlacesDetailLocation* copy = [super copyWithZone:zone];
	if (copy) {
		copy.referenceId = self.referenceId;
        copy.publicId = [[self.publicId copyWithZone:zone] autorelease];
		copy.displayAd = self.displayAd;
		copy.infoUsaId = self.infoUsaId;
		copy.teaser = [[self.teaser copyWithZone:zone] autorelease];
		copy.callPhone = [[self.callPhone copyWithZone:zone] autorelease];
		copy.displayUrl = [[self.displayUrl copyWithZone:zone] autorelease];
		copy.markets = [[self.markets copyWithZone:zone] autorelease];
		copy.neighborhoods = [[self.neighborhoods copyWithZone:zone] autorelease];
		copy.urls = [[self.urls copyWithZone:zone] autorelease];
		copy.customerContent = [[self.customerContent copyWithZone:zone] autorelease];
		copy.offers = [[self.offers copyWithZone:zone] autorelease];
		copy.categories = [[self.categories copyWithZone:zone] autorelease];
		copy.attributes = [[self.attributes copyWithZone:zone] autorelease];
		copy.businessHours = [[self.businessHours copyWithZone:zone] autorelease];
		copy.parking = [[self.parking copyWithZone:zone] autorelease];
		copy.tips = [[self.tips copyWithZone:zone] autorelease];
		copy.images = [[self.images copyWithZone:zone] autorelease];
		copy.editorials = [[self.editorials copyWithZone:zone] autorelease];
		copy.reviews = [[self.reviews copyWithZone:zone] autorelease];
	}
	
	return copy;
}

#pragma mark -
#pragma mark NSObject

- (BOOL) isEqualToPlacesDetailLocation:(CGPlacesDetailLocation*) other {
	return
	[super isEqualToLocation:other] &&
	self.referenceId == other.referenceId &&
    [self isEqualWithNull:self.publicId other:other.publicId] &&
	self.displayAd == other.displayAd &&
	self.infoUsaId == other.infoUsaId &&
	[self isEqualWithNull:self.teaser other:other.teaser] &&
	[self isEqualWithNull:self.callPhone other:other.callPhone] &&
	[self isEqualWithNull:self.displayUrl other:other.displayUrl] &&
	[self isEqualWithNull:self.markets other:other.markets] &&
	[self isEqualWithNull:self.neighborhoods other:other.neighborhoods] &&
	[self isEqualWithNull:self.urls other:other.urls] &&
	[self isEqualWithNull:self.customerContent other:other.customerContent] &&
	[self isEqualWithNull:self.offers other:other.offers] &&
	[self isEqualWithNull:self.categories other:other.categories] &&
	[self isEqualWithNull:self.attributes other:other.attributes] &&
	[self isEqualWithNull:self.businessHours other:other.businessHours] &&
	[self isEqualWithNull:self.parking other:other.parking] &&
	[self isEqualWithNull:self.tips other:other.tips] &&
	[self isEqualWithNull:self.images other:other.images] &&
	[self isEqualWithNull:self.editorials other:other.editorials] &&
	[self isEqualWithNull:self.reviews other:other.reviews];
}

- (BOOL) isEqual:(id) other {
	if (other == self) {
		return YES;
	}
	if (! other || ! [other isKindOfClass:[self class]]) {
		return NO;
	}
	
	return [self isEqualToPlacesDetailLocation:other];
}

- (NSUInteger) hash {
	NSUInteger h = [super hash];
	h += self.referenceId;
    h += [self.publicId hash];
	h += self.displayAd;
	h += self.infoUsaId;
	h += [self.teaser hash];
	h += [self.callPhone hash];
	h += [self.displayUrl hash];
	h += [self.markets hash];
	h += [self.neighborhoods hash];
	h += [self.urls hash];
	h += [self.customerContent hash];
	h += [self.offers hash];
	h += [self.categories hash];
	h += [self.attributes hash];
	h += [self.businessHours hash];
	h += [self.parking hash];
	h += [self.tips hash];
	h += [self.images hash];
	h += [self.editorials hash];
	h += [self.reviews hash];
	return h;
}

- (NSString*) description {
	NSMutableString* description = [[NSMutableString alloc] initWithCapacity:64];
	[description appendFormat:@"<CGPlacesDetailLocation %@ ", [super description]];
	[description appendFormat:@"referenceId=%i", self.referenceId];
    [description appendFormat:@",publicId=%@", self.publicId];
	[description appendFormat:@",displayAd=%i", self.displayAd];
	[description appendFormat:@",infoUsaId=%i", self.infoUsaId];
	[description appendFormat:@",teaser=%@", self.teaser];
	[description appendFormat:@",callPhone=%@", self.callPhone];
	[description appendFormat:@",displayUrl=%@", self.displayUrl];
	[description appendFormat:@",markets=%@", self.markets];
	[description appendFormat:@",neighborhoods=%@", self.neighborhoods];
	[description appendFormat:@",urls=%@", self.urls];
	[description appendFormat:@",customerContent=%@", self.customerContent];
	[description appendFormat:@",offers=%@", self.offers];
	[description appendFormat:@",categories=%@", self.categories];
	[description appendFormat:@",attributes=%@", self.attributes];
	[description appendFormat:@",businessHours=%@", self.businessHours];
	[description appendFormat:@",parking=%@", self.parking];
	[description appendFormat:@",tips=%@", self.tips];
	[description appendFormat:@",images=%@", self.images];
	[description appendFormat:@",editorials=%@", self.editorials];
	[description appendFormat:@",reviews=%@", self.reviews];
	[description appendString:@">"];
	
	return [description autorelease];
}

#pragma mark -
#pragma mark Tracking Helpers

- (CGAdsTracker*) adsTracker {
	CGAdsTracker* detail = [CGAdsTracker adsTracker];
	detail.locationId = self.locationId;
	detail.impressionId = self.impressionId;
	detail.referenceId = self.referenceId;
	detail.dialPhone = [self.callPhone length] > 0 ? self.callPhone : self.phone;
	return detail;
}

- (NSArray*) track:(CGAdsTrackerActionTarget) actionTarget {
	CGAdsTracker* tracker = [self adsTracker];
	tracker.actionTarget = actionTarget;
	return [tracker track];
}

- (NSArray*) track:(CGAdsTrackerActionTarget) actionTarget placement:(NSString*) placement {
	CGAdsTracker* tracker = [self adsTracker];
	tracker.actionTarget = actionTarget;
	tracker.placement = placement;
	return [tracker track];
}

@end
