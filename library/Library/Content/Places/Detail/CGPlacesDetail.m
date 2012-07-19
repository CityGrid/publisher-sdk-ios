//
//
//  Copyright 2011 CityGrid Media, LLC All rights reserved.
//
#import "CGPlacesDetail.h"
#import "CGConstants.h"
#import "CGShared.h"
#import "CGPlacesDetailLocation.h"
#import "CGPlacesDetailResults.h"
#import "CGPlacesDetailUrls.h"
#import "CGPlacesDetailCustomerContent.h"
#import "CGPlacesDetailCustomerMessage.h"
#import "CGPlacesDetailOffer.h"
#import "CGPlacesDetailCategory.h"
#import "CGPlacesDetailGroup.h"
#import "CGPlacesDetailAttribute.h"
#import "CGPlacesDetailTip.h"
#import "CGPlacesDetailImage.h"
#import "CGPlacesDetailEditorial.h"
#import "CGReview.h"
#import "CGPlacesDetailReviews.h"

#define CGPlacesDetailUri @"content/places/v2/detail"

@implementation CGPlacesDetail

@synthesize publisher = publisher_;
@synthesize locationId = locationId_;
@synthesize publicId = publicId_;
@synthesize infoUsaId = infoUsaId_;
@synthesize phone = phone_;
@synthesize customerOnly = customerOnly_;
@synthesize allResults = allResults_;
@synthesize reviewCount = reviewCount_;
@synthesize placement = placement_;
@synthesize timeout = timeout_;
@synthesize impressionId = impressionId_;
@synthesize placeId = placeId_;
@synthesize idType = idType_;
@synthesize clientIp = clientIp_;

#pragma mark -
#pragma mark Lifecycle

- (id) init:(NSString*) publisher {
	self = [super init];
	
	if (self) {
		self.publisher = publisher;
		self.locationId = CG_NSINTEGER_UNKNOWN;
        self.publicId = nil;
		self.infoUsaId = CG_NSINTEGER_UNKNOWN;
		self.phone = nil;
		self.customerOnly = NO;
		self.allResults = NO;
		self.reviewCount = CG_NSINTEGER_UNKNOWN;
		self.placement = nil;
		self.timeout = [CGShared sharedInstance].timeout;
		self.impressionId = nil;
        self.placeId = nil;
        //self.idType = CGPlacesDetailTypeUnknown;
        self.idType = nil;
        self.clientIp = nil;
	}
	
	return self;
}

+ (id) placesDetail {
	return [[self class] placesDetailWithPublisher:nil placement:nil];
}

+ (id) placesDetailWithPublisher:(NSString*) publisher {
	return [[self class] placesDetailWithPublisher:publisher placement:nil];
}

+ (id) placesDetailWithPlacement:(NSString*) placement {
	return [[self class] placesDetailWithPublisher:nil placement:placement];
}

+ (id) placesDetailWithPublisher:(NSString*) publisher placement:(NSString*) placement {
	NSString* resolvedPublisher = publisher ? publisher : [CGShared sharedInstance].publisher;
	NSString* resolvedPlacement = placement ? placement : [CGShared sharedInstance].placement;
	
	CGPlacesDetail* builder = [[[[self class] alloc] init:resolvedPublisher] autorelease];
	builder.placement = resolvedPlacement;
	return builder;
}

- (void) dealloc {
	self.publisher = nil;
	self.phone = nil;
	self.placement = nil;
	self.impressionId = nil;
    self.placeId = nil;
    self.clientIp = nil;
    self.idType = nil;
	
	[super dealloc];
}

#pragma mark -
#pragma mark NSCoding

- (id) initWithCoder:(NSCoder*) decoder {
	self = [super initWithCoder:decoder];
	
	if (self) {
		self.publisher = [decoder decodeObjectForKey:@"publisher"];
		self.locationId = [decoder decodeIntegerForKey:@"locationId"];
        self.publicId = [decoder decodeObjectForKey:@"publicId"];
		self.infoUsaId = [decoder decodeIntegerForKey:@"infoUsaId"];
		self.phone = [decoder decodeObjectForKey:@"phone"];
		self.customerOnly = [decoder decodeBoolForKey:@"customerOnly"];
		self.allResults = [decoder decodeBoolForKey:@"allResults"];
		self.reviewCount = [decoder decodeIntegerForKey:@"reviewCount"];
		self.placement = [decoder decodeObjectForKey:@"placement"];
		self.timeout = [decoder decodeDoubleForKey:@"timeout"];
		self.impressionId = [decoder decodeObjectForKey:@"impressionId"];
        self.placeId = [decoder decodeObjectForKey:@"placeId"];
        //self.idType = [decoder decodeIntegerForKey:@"idType"];
        self.idType = [decoder decodeObjectForKey:@"idType"];
        self.clientIp = [decoder decodeObjectForKey:@"clientIp"];
	}
	
	return self;
}

- (void) encodeWithCoder:(NSCoder*) encoder {
	[super encodeWithCoder:encoder];
	[encoder encodeObject:self.publisher forKey:@"publisher"];
	[encoder encodeInteger:self.locationId forKey:@"locationId"];
    [encoder encodeObject:self.publicId forKey:@"publicId"];
	[encoder encodeInteger:self.infoUsaId forKey:@"infoUsaId"];
	[encoder encodeObject:self.phone forKey:@"phone"];
	[encoder encodeBool:self.customerOnly forKey:@"customerOnly"];
	[encoder encodeBool:self.allResults forKey:@"allResults"];
	[encoder encodeInteger:self.reviewCount forKey:@"reviewCount"];
	[encoder encodeObject:self.placement forKey:@"placement"];
	[encoder encodeDouble:self.timeout forKey:@"timeout"];
	[encoder encodeObject:self.impressionId forKey:@"impressionId"];
    [encoder encodeObject:self.placeId forKey:@"placeId"];
    //[encoder encodeInteger:self.idType forKey:@"idType"];
    [encoder encodeObject:self.idType forKey:@"idType"];
    [encoder encodeObject:self.clientIp forKey:@"clientIp"];
}

#pragma mark -
#pragma mark NSCopying

- (id) copyWithZone:(NSZone*) zone {
	CGPlacesDetail* copy = [super copyWithZone:zone];
	if (copy) {
		copy.publisher = [[self.publisher copyWithZone:zone] autorelease];
		copy.locationId = self.locationId;
        copy.publicId = [[self.publicId copyWithZone:zone] autorelease];
		copy.infoUsaId = self.infoUsaId;
		copy.phone = [[self.phone copyWithZone:zone] autorelease];
		copy.customerOnly = self.customerOnly;
		copy.allResults = self.allResults;
		copy.reviewCount = self.reviewCount;
		copy.placement = [[self.placement copyWithZone:zone] autorelease];
		copy.timeout = self.timeout;
		copy.impressionId = [[self.impressionId copyWithZone:zone] autorelease];
        copy.placeId = [[self.placeId copyWithZone:zone] autorelease];
        //copy.idType = self.idType;
        copy.idType = [[self.idType copyWithZone:zone] autorelease];
        copy.clientIp = [[self.clientIp copyWithZone:zone] autorelease];
	}
	
	return copy;
}

#pragma mark -
#pragma mark NSObject

- (BOOL) isEqualToPlacesDetail:(CGPlacesDetail*) other {
	return 
	[self isEqualWithNull:self.publisher other:other.publisher] &&
	self.locationId == other.locationId &&
    [self isEqualWithNull:self.publicId other:other.publicId] &&
	self.infoUsaId == other.infoUsaId &&
	[self isEqualWithNull:self.phone other:other.phone] &&
	self.customerOnly == other.customerOnly &&
	self.allResults == other.allResults &&
	self.reviewCount == other.reviewCount &&
	[self isEqualWithNull:self.placement other:other.placement] &&
	self.timeout == other.timeout &&
	[self isEqualWithNull:self.impressionId other:other.impressionId] &&
    [self isEqualWithNull:self.placeId other:other.placeId] &&
    [self isEqualWithNull:self.clientIp other:other.clientIp] &&
    //self.idType == other.idType;
    [self isEqualWithNull:self.idType other:other.idType];
}

- (BOOL) isEqual:(id) other {
	if (other == self) {
		return YES;
	}
	if (! other || ! [other isKindOfClass:[self class]]) {
		return NO;
	}
	
	return [self isEqualToPlacesDetail:other];
}

- (NSUInteger) hash {
	NSUInteger h = 0;
	h += [self.publisher hash];
	h += self.locationId;
    h += [self.publicId hash];
	h += self.infoUsaId;
	h += [self.phone hash];
	h += self.customerOnly;
	h += self.allResults;
	h += self.reviewCount;
	h += [self.placement hash];
	h += (NSUInteger) self.timeout;
	h += [self.impressionId hash];
    h += [self.placeId hash];
    h += [self.clientIp hash];
    //h += self.idType;
    h += [self.idType hash];
	return h;
}

- (NSString*) description {
	NSMutableString* description = [[NSMutableString alloc] initWithCapacity:64];
	[description appendString:@"<CGPlacesDetail "];
	[description appendFormat:@"publisher=%@", self.publisher];
	[description appendFormat:@",locationId=%i", self.locationId];
    [description appendFormat:@",publicId=%@", self.publicId];
	[description appendFormat:@",infoUsaId=%i", self.infoUsaId];
	[description appendFormat:@",phone=%@", self.phone];
	[description appendFormat:@",customerOnly=%i", self.customerOnly];
	[description appendFormat:@",allResults=%i", self.allResults];
	[description appendFormat:@",reviewCount=%i", self.reviewCount];
	[description appendFormat:@",placement=%@", self.placement];
	[description appendFormat:@",timeout=%f", self.timeout];
	[description appendFormat:@",impressionId=%@", self.impressionId];
    [description appendFormat:@",placeId=%@", self.placeId];
    //[description appendFormat:@",idType=%i", self.idType];
    [description appendFormat:@",idType=%@", self.idType];
	return [description autorelease];
}

#pragma mark -
#pragma mark Actions

- (NSArray*) validate {
	NSMutableArray* errors = [[NSMutableArray alloc] initWithCapacity:0];
	
	if ([self.publisher length] == 0) {
		[errors addObject:[[CGShared sharedInstance] errorWithErrorNum:CGErrorNumPublisherRequired]];
	}
	if (self.locationId == CG_NSINTEGER_UNKNOWN && self.infoUsaId == CG_NSINTEGER_UNKNOWN && [self.phone length] == 0 && [self.publicId length] == 0 && [self.placeId length] == 0) {
		[errors addObject:[[CGShared sharedInstance] errorWithErrorNum:CGErrorNumUnderspecified]];
	}
	if ([self.phone length] > 10) {
		[errors addObject:[[CGShared sharedInstance] errorWithErrorNum:CGErrorNumPhoneIllegal]];
	}
	if (self.locationId != CG_NSINTEGER_UNKNOWN && self.locationId < 0) {
		[errors addObject:[[CGShared sharedInstance] errorWithErrorNum:CGErrorNumLocationIdOutOfRange]];
	}
	if (self.infoUsaId != CG_NSINTEGER_UNKNOWN && self.infoUsaId < 0) {
		[errors addObject:[[CGShared sharedInstance] errorWithErrorNum:CGErrorNumInfoUsaIdOutOfRange]];
	}
	if (self.reviewCount != CG_NSINTEGER_UNKNOWN && (self.reviewCount < 0 || self.reviewCount > 20)) {
		[errors addObject:[[CGShared sharedInstance] errorWithErrorNum:CGErrorNumReviewCountOutOfRange]];
	}
    /*if ([self.placeId length] > 0 && self.idType == CGPlacesDetailTypeUnknown) {
        [errors addObject:[[CGShared sharedInstance] errorWithErrorNum:CGErrorNumIdTypeNotFound]];
    }*/
    if ([self.placeId length] > 0 && [self.idType length] == 0) {
        [errors addObject:[[CGShared sharedInstance] errorWithErrorNum:CGErrorNumIdTypeNotFound]];
    }
	
	[errors autorelease];
	return [errors count] == 0 ? nil : errors;
}

/*- (NSString*) idTypeAsParameter {
	NSString* value = nil;
	
	switch (self.idType) {
		case CGPlacesDetailTypeCityGridPublicId:
			value = @"cg";
			break;
		case CGPlacesDetailTypeCitySearch:
			value = @"cs";
			break;
		case CGPlacesDetailTypeInfoUSA:
			value = @"iusa";
			break;
		case CGPlacesDetailTypeAllMenus:
			value = @"allm";
			break;
		case CGPlacesDetailTypeDemandForce:
			value = @"dforce";
			break;
		case CGPlacesDetailTypeGrubHub:
			value = @"grub";
			break;
		case CGPlacesDetailTypeGoMobo:
			value = @"mobo";
			break;
		case CGPlacesDetailTypeSpaFinder:
			value = @"spab";
			break;
        case CGPlacesDetailTypeTripAdvisor:
			value = @"ta";
			break;
		default:
			break;
	}
	
	return value;
}*/

- (NSDictionary*) buildWhere {
	NSMutableDictionary* parameters = [[NSMutableDictionary alloc] initWithCapacity:11];
	if ([self.publisher length] > 0) {
		[parameters setObject:self.publisher forKey:@"publisher"];
	}
	if ([self.placement length] > 0) {
		[parameters setObject:self.placement forKey:@"placement"];
	}
	if (self.locationId != CG_NSINTEGER_UNKNOWN && self.locationId > 0) {
		[parameters setObject:[NSString stringWithFormat:@"%i", self.locationId] forKey:@"listing_id"];
	}
    if ([self.publicId length] > 0) {
        [parameters setObject:self.publicId forKey:@"public_id"];
    }
	if (self.infoUsaId != CG_NSINTEGER_UNKNOWN) {
		[parameters setObject:[NSString stringWithFormat:@"%i", self.infoUsaId] forKey:@"infousa_id"];
	}
    if ([self.placeId length] > 0){
        [parameters setObject:self.placeId forKey:@"id"];
    }
    /*NSString* idTypeString = [self idTypeAsParameter];
	if ([idTypeString length] > 0) {
		[parameters setObject:idTypeString forKey:@"id_type"];
	}*/
    if ([self.idType length] > 0) {
		[parameters setObject:self.idType forKey:@"id_type"];
	}
	if ([self.phone length] > 0) {
		[parameters setObject:self.phone forKey:@"phone"];
	}
	[parameters setObject:self.customerOnly ? @"true" : @"false" forKey:@"customer_only"];
	[parameters setObject:self.allResults ? @"true" : @"false" forKey:@"all_results"];
	if (self.reviewCount != CG_NSINTEGER_UNKNOWN) {
		[parameters setObject:[NSString stringWithFormat:@"%i", self.reviewCount] forKey:@"review_count"];
	}
    //if ([self.clientIp length] > 0) {
    //    [parameters setObject:self.clientIp forKey:@"client_ip"];
    //}
    //else{
    //    [parameters setObject:[self ipAddress] forKey:@"client_ip"];
    //}
    [parameters setObject:[self ipAddress] forKey:@"client_ip"];
	
	[parameters setObject:@"json" forKey:@"format"];
	if ([self.impressionId length] > 0) {
		[parameters setObject:self.impressionId forKey:@"i"];
	}
	
	return [parameters autorelease];
}

- (CGPlacesDetailUrls*) processUrls:(NSDictionary*) parsedUrls impressionId:(NSString*) impressionId {
	NSURL* profile = [self handleUrlFields:[self urlForParsed:parsedUrls key:@"profile_url"]
								 publisher:self.publisher impressionId:impressionId placement:self.placement];
	NSURL* reviews = [self handleUrlFields:[self urlForParsed:parsedUrls key:@"reviews_url"]
								 publisher:self.publisher impressionId:impressionId placement:self.placement];
	NSURL* video = [self handleUrlFields:[self urlForParsed:parsedUrls key:@"video_url"]
							   publisher:self.publisher impressionId:impressionId placement:self.placement];
	NSURL* website = [self handleUrlFields:[self urlForParsed:parsedUrls key:@"website_url"]
								 publisher:self.publisher impressionId:impressionId placement:self.placement];
	NSURL* menu = [self handleUrlFields:[self urlForParsed:parsedUrls key:@"menu_url"]
							  publisher:self.publisher impressionId:impressionId placement:self.placement];
	NSURL* reservation = [self handleUrlFields:[self urlForParsed:parsedUrls key:@"reservation_url"]
									 publisher:self.publisher impressionId:impressionId placement:self.placement];
	NSURL* map = [self handleUrlFields:[self urlForParsed:parsedUrls key:@"map_url"]
							 publisher:self.publisher impressionId:impressionId placement:self.placement];
	NSURL* sendToFriend = [self handleUrlFields:[self urlForParsed:parsedUrls key:@"send_to_friend_url"]
									  publisher:self.publisher impressionId:impressionId placement:self.placement];
	NSURL* email = [self handleUrlFields:[self urlForParsed:parsedUrls key:@"email_url"]
							   publisher:self.publisher impressionId:impressionId placement:self.placement];
	NSURL* custom1 = [self handleUrlFields:[self urlForParsed:parsedUrls key:@"custom_link_1"]
								 publisher:self.publisher impressionId:impressionId placement:self.placement];
	NSURL* custom2 = [self handleUrlFields:[self urlForParsed:parsedUrls key:@"custom_link_2"]
								 publisher:self.publisher impressionId:impressionId placement:self.placement];
	NSURL* orderUrl = [self handleUrlFields:[self urlForParsed:parsedUrls key:@"order_url"]
								 publisher:self.publisher impressionId:impressionId placement:self.placement];
    
	CGPlacesDetailUrls* urls =
	[[[CGPlacesDetailUrls alloc] initImmutable:profile reviews:reviews video:video website:website menu:menu
								   reservation:reservation map:map sendToFriend:sendToFriend email:email
									   custom1:custom1 custom2:custom2 orderUrl:orderUrl] autorelease];
	return urls;
}

- (CGPlacesDetailCustomerMessage*) processCustomerMessage:(NSDictionary*) parsedCustomerMessage {
	NSString* message = [self objectForParsed:parsedCustomerMessage key:@"value"];
	NSString* attributionText = [self objectForParsed:parsedCustomerMessage key:@"attribution_text"];
	NSURL* attributionLogo = [self urlForParsed:parsedCustomerMessage key:@"attribution_logo"];
	NSInteger attributionSource = [[self objectForParsed:parsedCustomerMessage key:@"attribution_source"] integerValue];
	
	CGPlacesDetailCustomerMessage* customerMessage =
	[[[CGPlacesDetailCustomerMessage alloc] initImmutable:message attributionText:attributionText
										  attributionLogo:attributionLogo attributionSource:attributionSource] autorelease];
	return customerMessage;
}

- (CGPlacesDetailCustomerContent*) processCustomerContent:(NSDictionary*) parsedCustomerContent {
	CGPlacesDetailCustomerMessage* customerMessage = 
	[self processCustomerMessage:[self objectForParsed:parsedCustomerContent key:@"customer_message"]];
	NSArray* bullets = [self objectForParsed:parsedCustomerContent key:@"bullets"];
	NSURL* url = [self urlForParsed:parsedCustomerContent key:@"customer_message_url"];
	
	CGPlacesDetailCustomerContent* customerContent =
	[[[CGPlacesDetailCustomerContent alloc] initImmutable:customerMessage bullets:bullets url:url] autorelease];
	return customerContent;
}

- (NSArray*) processGroups:(NSArray*) parsedGroups {
	NSMutableArray* groups = [NSMutableArray arrayWithCapacity:[parsedGroups count]];
	for (NSDictionary* parsedGroup in parsedGroups) {
		NSInteger groupId = [[self objectForParsed:parsedGroup key:@"group_id"] integerValue];
		NSString* name = [self objectForParsed:parsedGroup key:@"name"];
		
		CGPlacesDetailGroup* group = [[[CGPlacesDetailGroup alloc] initImmutable:groupId name:name] autorelease];
		[groups addObject:group];
	}
	
	return groups;
}

- (NSArray*) processCategories:(NSArray*) parsedCategories {
	NSMutableArray* categories = [NSMutableArray arrayWithCapacity:[parsedCategories count]];
	for (NSDictionary* parsedCategory in parsedCategories) {
		NSInteger categoryId = [[self objectForParsed:parsedCategory key:@"name_id"] integerValue];
		NSString* name = [self objectForParsed:parsedCategory key:@"name"];
		NSInteger parentId = [[self objectForParsed:parsedCategory key:@"parent_id"] integerValue];
		NSString* parent = [self objectForParsed:parsedCategory key:@"parent"];
		NSArray* groups = [self processGroups:[self objectForParsed:parsedCategory key:@"groups"]];
		
		CGPlacesDetailCategory* category = 
		[[[CGPlacesDetailCategory alloc] initImmutable:categoryId name:name parentId:parentId
												parent:parent groups:groups] autorelease];
		[categories addObject:category];
	}
	
	return categories;
}

- (NSArray*) processOffers:(NSArray*) parsedOffers {
	NSMutableArray* offers = [NSMutableArray arrayWithCapacity:[parsedOffers count]];
	for (NSDictionary* parsedOffer in parsedOffers) {
		NSString* name = [self objectForParsed:parsedOffer key:@"offer_name"];
		NSString* text = [self objectForParsed:parsedOffer key:@"offer_text"];
		NSString* description = [self objectForParsed:parsedOffer key:@"offer_description"];
		NSURL* url = [self urlForParsed:parsedOffer key:@"offer_url"];
		NSDate* expirationDate = [self dateForParsed:parsedOffer key:@"offer_expiration_date"];
		
		CGPlacesDetailOffer* offer = 
		[[[CGPlacesDetailOffer alloc] initImmutable:name text:text offerDescription:description
												url:url expirationDate:expirationDate] autorelease];
		[offers addObject:offer];
	}
	
	return offers;
}

- (NSArray*) processAttributes:(NSArray*) parsedAttributes {
	NSMutableArray* attributes = [NSMutableArray arrayWithCapacity:[parsedAttributes count]];
	for (NSDictionary* parsedAttribute in parsedAttributes) {
		NSInteger attributeId = [[self objectForParsed:parsedAttribute key:@"attribute_id"] integerValue];
		NSString* value = [self objectForParsed:parsedAttribute key:@"value"];
		NSString* name = [self objectForParsed:parsedAttribute key:@"name"];
		
		CGPlacesDetailAttribute* attribute =
		[[[CGPlacesDetailAttribute alloc] initImmutable:attributeId name:name value:value] autorelease];
		[attributes addObject:attribute];
	}
	return attributes;
}

- (NSArray*) processTips:(NSArray*) parsedTips {
	NSMutableArray* tips = [NSMutableArray arrayWithCapacity:[parsedTips count]];
	for (NSDictionary* parsedTip in parsedTips) {
		NSString* name = [self objectForParsed:parsedTip key:@"tip_name"];
		NSString* text = [self objectForParsed:parsedTip key:@"tip_text"];
		
		CGPlacesDetailTip* tip = [[[CGPlacesDetailTip alloc] initImmutable:name text:text] autorelease];
		[tips addObject:tip];
	}
	return tips;
}

- (NSArray*) processImages:(NSArray*) parsedImages {
	NSMutableArray* images = [NSMutableArray arrayWithCapacity:[parsedImages count]];
	for (NSDictionary* parsedImage in parsedImages) {
		CGPlacesDetailImageType type = CGPlacesDetailImageTypeUnknown;
		NSString* typeString = [self objectForParsed:parsedImage key:@"type"];
		if ([typeString isEqualToString:@"GENERIC_IMAGE"]) {
			type = CGPlacesDetailImageTypeGenericImage;
		} else if ([typeString isEqualToString:@"WEBSITE_THUMBNAIL"]) {
			type = CGPlacesDetailImageTypeWebsiteThumbnail;
		}
		NSInteger height = [[self objectForParsed:parsedImage key:@"height"] integerValue];
		NSInteger width = [[self objectForParsed:parsedImage key:@"width"] integerValue];
		NSURL* url = [self urlForParsed:parsedImage key:@"image_url"];
		
		CGPlacesDetailImage* image =
		[[[CGPlacesDetailImage alloc] initImmutable:type height:height width:width url:url] autorelease];
		[images addObject:image];
	}
	return images;
}

- (NSArray*) processEditorials:(NSArray*) parsedEditorials {
	NSMutableArray* editorials = [NSMutableArray arrayWithCapacity:[parsedEditorials count]];
	for (NSDictionary* parsedEditorial in parsedEditorials) {
		NSInteger editorialId = [[self objectForParsed:parsedEditorial key:@"editorial_id"] integerValue];
		NSURL* url = [self urlForParsed:parsedEditorial key:@"editorial_url"];
		NSString* title = [self objectForParsed:parsedEditorial key:@"editorial_title"];
		NSString* author = [self objectForParsed:parsedEditorial key:@"editorial_author"];
		NSString* review = [self objectForParsed:parsedEditorial key:@"editorial_review"];
		NSString* pros = [self objectForParsed:parsedEditorial key:@"pros"];
		NSString* cons = [self objectForParsed:parsedEditorial key:@"cons"];
		NSDate* date = [self dateForParsed:parsedEditorial key:@"editorial_date"];
		NSInteger reviewRating = [[self objectForParsed:parsedEditorial key:@"review_rating"] integerValue];
		NSInteger helpfulnessTotal = [[self objectForParsed:parsedEditorial key:@"helpfulness_total_count"] integerValue];
		NSInteger helpfulness = [[self objectForParsed:parsedEditorial key:@"helpful_count"] integerValue];
		NSInteger unhelpfulness = [[self objectForParsed:parsedEditorial key:@"unhelpful_count"] integerValue];
		NSString* attributionText = [self objectForParsed:parsedEditorial key:@"attribution_text"];
		NSURL* attributionLogo = [self urlForParsed:parsedEditorial key:@"attribution_logo"];
		NSInteger attributionSource = [[self objectForParsed:parsedEditorial key:@"attribution_source"] integerValue];
		
		CGPlacesDetailEditorial* editorial =
		[[[CGPlacesDetailEditorial alloc] initImmutable:editorialId url:url title:title author:author review:review
												   pros:pros cons:cons date:date reviewRating:reviewRating
									   helpfulnessTotal:helpfulnessTotal helpfulness:helpfulness unhelpfulness:unhelpfulness
										attributionText:attributionText attributionLogo:attributionLogo
									  attributionSource:attributionSource] autorelease];
		[editorials addObject:editorial];
	}
	return editorials;
}

- (NSArray*) processReviews:(NSArray*) parsedReviews {
	NSMutableArray* reviews = [NSMutableArray arrayWithCapacity:[parsedReviews count]];
	for (NSDictionary* parsedReview in parsedReviews) {
		NSString* reviewId = [self objectForParsed:parsedReview key:@"review_id"];
		NSURL* url = [self urlForParsed:parsedReview key:@"review_url"];
		NSString* title = [self objectForParsed:parsedReview key:@"review_title"];
		NSString* author = [self objectForParsed:parsedReview key:@"review_author"];
		NSString* text = [self objectForParsed:parsedReview key:@"review_text"];
		NSString* pros = [self objectForParsed:parsedReview key:@"pros"];
		NSString* cons = [self objectForParsed:parsedReview key:@"cons"];
		NSDate* date = [self dateForParsed:parsedReview key:@"review_date"];
		NSInteger rating = [[self objectForParsed:parsedReview key:@"review_rating"] integerValue];
		NSInteger helpfulTotal = [[self objectForParsed:parsedReview key:@"helpfulness_total_count"] integerValue];
		NSInteger helpful = [[self objectForParsed:parsedReview key:@"helpful_count"] integerValue];
		NSInteger unhelpful = [[self objectForParsed:parsedReview key:@"unhelpful_count"] integerValue];
		NSString* attributionText = [self objectForParsed:parsedReview key:@"attribution_text"];
		NSURL* attributionLogo = [self urlForParsed:parsedReview key:@"attribution_logo"];
		NSInteger attributionSource = [[self objectForParsed:parsedReview key:@"attribution_source"] integerValue];
		
		CGReview* review = [[[CGReview alloc] initImmutable:reviewId url:url title:title author:author text:text
													   pros:pros cons:cons date:date rating:rating helpful:helpful
												  unhelpful:unhelpful attributionText:attributionText attributionLogo:attributionLogo
										  attributionSource:attributionSource] autorelease];
		[reviews addObject:review];
	}
	return reviews;
}

- (CGPlacesDetailReviews*) processReviewsInfo:(NSDictionary*) parsedReviews {
	NSInteger rating = [[self objectForParsed:parsedReviews key:@"overall_review_rating"] integerValue];
	NSInteger count = [[self objectForParsed:parsedReviews key:@"total_user_reviews"] integerValue];
	NSInteger shown = [[self objectForParsed:parsedReviews key:@"total_user_reviews_shown"] integerValue];
	NSArray* reviews = [self processReviews:[self objectForParsed:parsedReviews key:@"reviews"]];
	
	CGPlacesDetailReviews* reviewsInfo =
	[[[CGPlacesDetailReviews alloc] initImmutable:rating count:count shown:shown reviews:reviews] autorelease];
	return reviewsInfo;
}

- (CGPlacesDetailLocation*) processLocation:(NSDictionary*) parsedLocation {
	NSInteger listingId = [[self objectForParsed:parsedLocation key:@"id"] integerValue];
    NSString* publicId = [self objectForParsed:parsedLocation key:@"public_id"];
	NSString* impressionId = [self objectForParsed:parsedLocation key:@"impression_id"];
	NSString* name = [self objectForParsed:parsedLocation key:@"name"];
	NSDictionary* parsedAddress = [self objectForParsed:parsedLocation key:@"address"];
	id address = [self processLocationAddress:parsedAddress useZip:NO];
	CLLocation* latlon = [self locationForParsed:parsedAddress latitudeKey:@"latitude" longitudeKey:@"longitude"];
	NSInteger referenceId = [[self objectForParsed:parsedLocation key:@"reference_id"] integerValue];
	BOOL displayAd = [[self objectForParsed:parsedLocation key:@"dipslay_ad"] boolValue];
	NSInteger infoUsaId = [[self objectForParsed:parsedLocation key:@"infousa_id"] integerValue];
	NSString* teaser = [self objectForParsed:parsedLocation key:@"teaser"];
	NSArray* markets = [self objectForParsed:parsedLocation key:@"markets"];
	NSArray* neighborhoods = [self objectForParsed:parsedLocation key:@"neighborhoods"];
	CGPlacesDetailUrls* urls = [self processUrls:[self objectForParsed:parsedLocation key:@"urls"] impressionId:impressionId];
	CGPlacesDetailCustomerContent* customerContent = [self processCustomerContent:[self objectForParsed:parsedLocation key:@"customer_content"]];
	NSArray* offers = [self processOffers:[self objectForParsed:parsedLocation key:@"offers"]];
	NSArray* categories = [self processCategories:[self objectForParsed:parsedLocation key:@"categories"]];
	NSArray* attributes = [self processAttributes:[self objectForParsed:parsedLocation key:@"attributes"]];
	NSString* businessHours = [self objectForParsed:parsedLocation key:@"business_hours"];
	NSString* parking = [self objectForParsed:parsedLocation key:@"parking"];
	NSArray* tips = [self processTips:[self objectForParsed:parsedLocation key:@"tips"]];
	NSArray* images = [self processImages:[self objectForParsed:parsedLocation key:@"images"]];
	NSArray* editorials = [self processEditorials:[self objectForParsed:parsedLocation key:@"editorials"]];
	CGPlacesDetailReviews* reviews = [self processReviewsInfo:[self objectForParsed:parsedLocation key:@"review_info"]];
	NSInteger rating = reviews.rating;
	
	NSDictionary* parsedContactInfo = [self objectForParsed:parsedLocation key:@"contact_info"];
	NSString* phone = [self objectForParsed:parsedContactInfo key:@"display_phone"];
	NSString* callPhone = phone;
	NSURL* displayUrl = [self urlForParsed:parsedContactInfo key:@"display_url"];

	NSURL* image = nil;
	for (CGPlacesDetailImage* detailImage in images) {
		if (detailImage.type == CGPlacesDetailImageTypeGenericImage) {
			image = detailImage.url;
			break;
		}
	}
	
	CGPlacesDetailLocation* location =
	[[[CGPlacesDetailLocation alloc] initImmutable:listingId impressionId:impressionId name:name address:address
											latlon:latlon image:image phone:phone rating:rating publicId:publicId referenceId:referenceId
										 displayAd:displayAd infoUsaId:infoUsaId teaser:teaser callPhone:callPhone displayUrl:displayUrl
										   markets:markets neighborhoods:neighborhoods urls:urls customerContent:customerContent
											offers:offers categories:categories attributes:attributes businessHours:businessHours
										   parking:parking tips:tips images:images editorials:editorials reviews:reviews] autorelease];
	
	return location;
}

- (CGPlacesDetailResults*) processResults:(NSDictionary*) parsedJson {
	NSArray* parsedLocations = [self objectForParsed:parsedJson key:@"locations"];
	
	NSMutableArray* locations = [NSMutableArray arrayWithCapacity:[parsedLocations count]];
	
	for (NSDictionary* parsedLocation in parsedLocations) {
		CGPlacesDetailLocation* location = [self processLocation:parsedLocation];
		[locations addObject:location];
	}
	
	CGPlacesDetailResults* results = [[[CGPlacesDetailResults alloc] initImmutable:locations] autorelease];
	return results;
}

- (CGPlacesDetailResults*) detail:(NSArray**) errors {
	NSArray* validationErrors = [self validate];
	if (validationErrors) {
		if (errors != NULL) {
			*errors = validationErrors;
		}
		return nil;
	}
	
	NSURL* url = [[CGShared sharedInstance].url URLByAppendingPathComponent:CGPlacesDetailUri];
	NSDictionary* parameters = [self buildWhere];
	
	NSDictionary* parsed = [[CGShared sharedInstance] sendSynchronousRequest:url parameters:parameters timeout:self.timeout errors:errors];
	if (parsed == nil) {
		return nil;
	}
	
	CGPlacesDetailResults* results = [self processResults:parsed];
	return results;
}

@end
