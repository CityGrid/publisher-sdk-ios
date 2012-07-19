//
//
//  Copyright 2011 CityGrid Media, LLC All rights reserved.
//
#import "CGReviewsSearchReview.h"
#import "CGPlacesDetail.h"
#import "CGPlacesDetailLocation.h"
#import "CGPlacesDetailResults.h"

@interface CGReviewsSearchReview ()

@property (nonatomic, retain, readwrite) NSString* impressionId;
@property (nonatomic, assign, readwrite) NSInteger referenceId;
@property (nonatomic, assign, readwrite) NSInteger sourceId;
@property (nonatomic, assign, readwrite) NSInteger locationId;
@property (nonatomic, retain, readwrite) NSString* businessName;
@property (nonatomic, retain, readwrite) NSURL* authorUrl;
@property (nonatomic, assign, readwrite) CGReviewType type;

@end

@implementation CGReviewsSearchReview

@synthesize impressionId = impressionId_;
@synthesize referenceId = referenceId_;
@synthesize sourceId = sourceId_;
@synthesize locationId = locationId_;
@synthesize businessName = businessName_;
@synthesize authorUrl = authorUrl_;
@synthesize type = type_;

#pragma mark -
#pragma mark Lifecycle

- (id) initImmutable:(NSString*) reviewId url:(NSURL*) url title:(NSString*) title author:(NSString*) author
				text:(NSString*) text pros:(NSString*) pros cons:(NSString*) cons date:(NSDate*) date
			  rating:(NSInteger) rating  helpful:(NSInteger) helpful unhelpful:(NSInteger) unhelpful
	 attributionText:(NSString*) attributionText attributionLogo:(NSURL*) attributionLogo
   attributionSource:(NSInteger) attributionSource
	  attributionUrl:(NSURL*) attributionUrl impressionId:(NSString*) impressionId
		 referenceId:(NSInteger) referenceId sourceId:(NSInteger) sourceId locationId:(NSInteger) locationId
		businessName:(NSString*) businessName authorUrl:(NSURL*) authorUrl type:(CGReviewType) type {
	
	self = [super initImmutable:reviewId url:url title:title author:author text:text pros:pros cons:cons
						   date:date rating:rating helpful:helpful unhelpful:unhelpful attributionText:attributionText
				attributionLogo:attributionLogo attributionSource:attributionSource];
	
	if (self) {
		self.impressionId = impressionId;
		self.referenceId = referenceId;
		self.sourceId = sourceId;
		self.locationId = locationId;
		self.businessName = businessName;
		self.authorUrl = authorUrl;
		self.type = type;
	}
	
	return self;
}

- (void) dealloc {
	self.impressionId = nil;
	self.businessName = nil;
	self.authorUrl = nil;
	
	[super dealloc];
}

#pragma mark -
#pragma mark NSCoding

- (id) initWithCoder:(NSCoder*) decoder {
	self = [super initWithCoder:decoder];
	
	if (self) {
		self.impressionId = [decoder decodeObjectForKey:@"impressionId"];
		self.referenceId = [decoder decodeIntegerForKey:@"referenceId"];
		self.sourceId = [decoder decodeIntegerForKey:@"sourceId"];
		self.locationId = [decoder decodeIntegerForKey:@"locationId"];
		self.businessName = [decoder decodeObjectForKey:@"businessName"];
		self.authorUrl = [decoder decodeObjectForKey:@"authorUrl"];
		self.type = [decoder decodeIntegerForKey:@"type"];
	}
	
	return self;
}

- (void) encodeWithCoder:(NSCoder*) encoder {
	[super encodeWithCoder:encoder];
	
	[encoder encodeObject:self.impressionId forKey:@"impressionId"];
	[encoder encodeInteger:self.referenceId forKey:@"referenceId"];
	[encoder encodeInteger:self.sourceId forKey:@"sourceId"];
	[encoder encodeInteger:self.locationId forKey:@"locationId"];
	[encoder encodeObject:self.businessName forKey:@"businessName"];
	[encoder encodeObject:self.authorUrl forKey:@"authorUrl"];
	[encoder encodeInteger:self.type forKey:@"type"];
}

#pragma mark -
#pragma mark NSCopying

- (id) copyWithZone:(NSZone*) zone {
	CGReviewsSearchReview* copy = [super copyWithZone:zone];
	if (copy) {
		copy.impressionId = [[self.impressionId copyWithZone:zone] autorelease];
		copy.referenceId = self.referenceId;
		copy.sourceId = self.sourceId;
		copy.locationId = self.locationId;
		copy.businessName = [[self.businessName copyWithZone:zone] autorelease];
		copy.authorUrl = [[self.authorUrl copyWithZone:zone] autorelease];
		copy.type = self.type;
	}
	
	return copy;
}

#pragma mark -
#pragma mark NSObject

- (BOOL) isEqualToReviewsSearchReview:(CGReviewsSearchReview*) other {
	return
	[super isEqualToReview:other] &&
	[self isEqualWithNull:self.impressionId other:other.impressionId] &&
	self.referenceId == other.referenceId &&
	self.sourceId == other.sourceId &&
	self.locationId == other.locationId &&
	[self isEqualWithNull:self.businessName other:other.businessName] &&
	[self isEqualWithNull:self.authorUrl other:other.authorUrl] &&
	self.type == other.type;
}

- (BOOL) isEqual:(id) other {
	if (other == self) {
		return YES;
	}
	if (! other || ! [other isKindOfClass:[self class]]) {
		return NO;
	}
	
	return [self isEqualToReviewsSearchReview:other];
}

- (NSUInteger) hash {
	NSUInteger h = [super hash];
	h += [self.impressionId hash];
	h += self.referenceId;
	h += self.sourceId;
	h += self.locationId;
	h += [self.businessName hash];
	h += [self.authorUrl hash];
	h += self.type;
	return h;
}

- (NSString*) description {
	NSMutableString* description = [[NSMutableString alloc] initWithCapacity:64];
	[description appendFormat:@"<CGReviewsSearchReview %@ ", [super description]];
	[description appendFormat:@",impressionId=%@", self.impressionId];
	[description appendFormat:@",referenceId=%i", self.referenceId];
	[description appendFormat:@",sourceId=%i", self.sourceId];
	[description appendFormat:@",locationId=%i", self.locationId];
	[description appendFormat:@",businessName=%@", self.businessName];
	[description appendFormat:@",authorUrl=%@", self.authorUrl];
	[description appendFormat:@",type=%i", self.type];
	[description appendString:@">"];
	return [description autorelease];
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
