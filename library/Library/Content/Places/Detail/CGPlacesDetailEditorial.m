//
//
//  Copyright 2011 CityGrid Media, LLC All rights reserved.
//
#import "CGPlacesDetailEditorial.h"

@interface CGPlacesDetailEditorial ()

@property (nonatomic, assign, readwrite) NSInteger editorialId;
@property (nonatomic, retain, readwrite) NSURL* url;
@property (nonatomic, retain, readwrite) NSString* title;
@property (nonatomic, retain, readwrite) NSString* author;
@property (nonatomic, retain, readwrite) NSString* review;
@property (nonatomic, retain, readwrite) NSString* pros;
@property (nonatomic, retain, readwrite) NSString* cons;
@property (nonatomic, retain, readwrite) NSDate* date;
@property (nonatomic, assign, readwrite) NSInteger reviewRating;
@property (nonatomic, assign, readwrite) NSInteger helpfulnessTotal;
@property (nonatomic, assign, readwrite) NSInteger helpfulness;
@property (nonatomic, assign, readwrite) NSInteger unhelpfulness;
@property (nonatomic, retain, readwrite) NSString* attributionText;
@property (nonatomic, retain, readwrite) NSURL* attributionLogo;
@property (nonatomic, assign, readwrite) NSInteger attributionSource;

@end

@implementation CGPlacesDetailEditorial

@synthesize editorialId = editorialId_;
@synthesize url = url_;
@synthesize title = title_;
@synthesize author = author_;
@synthesize review = review_;
@synthesize pros = pros_;
@synthesize cons = cons_;
@synthesize date = date_;
@synthesize reviewRating = reviewRating_;
@synthesize helpfulnessTotal = helpfulnessTotal_;
@synthesize helpfulness = helpfulness_;
@synthesize unhelpfulness = unhelpfulness_;
@synthesize attributionText = attributionText_;
@synthesize attributionLogo = attributionLogo_;
@synthesize attributionSource = attributionSource_;

#pragma mark -
#pragma mark Lifecycle

- (id) initImmutable:(NSInteger) editorialId url:(NSURL*) url title:(NSString*) title author:(NSString*) author
			  review:(NSString*) review pros:(NSString*) pros cons:(NSString*) cons date:(NSDate*) date
		reviewRating:(NSInteger) reviewRating helpfulnessTotal:(NSInteger) helpfulnessTotal
		 helpfulness:(NSInteger) helpfulness unhelpfulness:(NSInteger) unhelpfulness
	 attributionText:(NSString*) attributionText attributionLogo:(NSURL*) attributionLogo
   attributionSource:(NSInteger) attributionSource {
	self = [super init];
	
	if (self) {
		self.editorialId = editorialId;
		self.url = url;
		self.title = title;
		self.author = author;
		self.review = review;
		self.pros = pros;
		self.cons = cons;
		self.date = date;
		self.reviewRating = reviewRating;
		self.helpfulnessTotal = helpfulnessTotal;
		self.helpfulness = helpfulness;
		self.unhelpfulness = unhelpfulness;
		self.attributionText = attributionText;
		self.attributionLogo = attributionLogo;
		self.attributionSource = attributionSource;
	}
	
	return self;
}

- (void) dealloc {
	self.url = nil;
	self.title = nil;
	self.author = nil;
	self.review = nil;
	self.pros = nil;
	self.cons = nil;
	self.date = nil;
	self.attributionText = nil;
	self.attributionLogo = nil;
	
	[super dealloc];
}

#pragma mark -
#pragma mark NSCoding

- (id) initWithCoder:(NSCoder*) decoder {
	self = [super initWithCoder:decoder];
	
	if (self) {
		self.editorialId = [decoder decodeIntegerForKey:@"editorialId"];
		self.url = [decoder decodeObjectForKey:@"url"];
		self.title = [decoder decodeObjectForKey:@"title"];
		self.author = [decoder decodeObjectForKey:@"author"];
		self.review = [decoder decodeObjectForKey:@"review"];
		self.pros = [decoder decodeObjectForKey:@"pros"];
		self.cons = [decoder decodeObjectForKey:@"cons"];
		self.date = [decoder decodeObjectForKey:@"date"];
		self.reviewRating = [decoder decodeIntegerForKey:@"reviewRating"];
		self.helpfulnessTotal = [decoder decodeIntegerForKey:@"helpfulnessTotal"];
		self.helpfulness = [decoder decodeIntegerForKey:@"helpfulness"];
		self.unhelpfulness = [decoder decodeIntegerForKey:@"unhelpfulness"];
		self.attributionText = [decoder decodeObjectForKey:@"attributionText"];
		self.attributionLogo = [decoder decodeObjectForKey:@"attributionLogo"];
		self.attributionSource = [decoder decodeIntegerForKey:@"attributionSource"];
	}
	
	return self;
}

- (void) encodeWithCoder:(NSCoder*) encoder {
	[super encodeWithCoder:encoder];
	[encoder encodeInteger:self.editorialId forKey:@"editorialId"];
	[encoder encodeObject:self.url forKey:@"url"];
	[encoder encodeObject:self.title forKey:@"title"];
	[encoder encodeObject:self.author forKey:@"author"];
	[encoder encodeObject:self.review forKey:@"review"];
	[encoder encodeObject:self.pros forKey:@"pros"];
	[encoder encodeObject:self.cons forKey:@"cons"];
	[encoder encodeObject:self.date forKey:@"date"];
	[encoder encodeInteger:self.reviewRating forKey:@"reviewRating"];
	[encoder encodeInteger:self.helpfulnessTotal forKey:@"helpfulnessTotal"];
	[encoder encodeInteger:self.helpfulness forKey:@"helpfulness"];
	[encoder encodeInteger:self.unhelpfulness forKey:@"unhelpfulness"];
	[encoder encodeObject:self.attributionText forKey:@"attributionText"];
	[encoder encodeObject:self.attributionLogo forKey:@"attributionLogo"];
	[encoder encodeInteger:self.attributionSource forKey:@"attributionSource"];
}

#pragma mark -
#pragma mark NSCopying

- (id) copyWithZone:(NSZone*) zone {
	CGPlacesDetailEditorial* copy = [self copyWithZone:zone];
	if (copy) {
		copy.editorialId = self.editorialId;
		copy.url = [[self.url copyWithZone:zone] autorelease];
		copy.title = [[self.title copyWithZone:zone] autorelease];
		copy.author = [[self.author copyWithZone:zone] autorelease];
		copy.review = [[self.review copyWithZone:zone] autorelease];
		copy.pros = [[self.pros copyWithZone:zone] autorelease];
		copy.cons = [[self.cons copyWithZone:zone] autorelease];
		copy.date = [[self.date copyWithZone:zone] autorelease];
		copy.reviewRating = self.reviewRating;
		copy.helpfulnessTotal = self.helpfulnessTotal;
		copy.helpfulness = self.helpfulness;
		copy.unhelpfulness = self.unhelpfulness;
		copy.attributionText = [[self.attributionText copyWithZone:zone] autorelease];
		copy.attributionLogo = [[self.attributionLogo copyWithZone:zone] autorelease];
		copy.attributionSource = self.attributionSource;
	}
	
	return copy;
}

#pragma mark -
#pragma mark NSObject

- (BOOL) isEqualToPlacesDetailEditorial:(CGPlacesDetailEditorial*) other {
	return
	self.editorialId == other.editorialId &&
	[self isEqualWithNull:self.url other:other.url] &&
	[self isEqualWithNull:self.title other:other.title] &&
	[self isEqualWithNull:self.author other:other.author] &&
	[self isEqualWithNull:self.review other:other.review] &&
	[self isEqualWithNull:self.pros other:other.pros] &&
	[self isEqualWithNull:self.cons other:other.cons] &&
	[self isEqualWithNull:self.date other:other.date] &&
	self.reviewRating == other.reviewRating &&
	self.helpfulnessTotal == other.helpfulnessTotal &&
	self.helpfulness == other.helpfulness &&
	self.unhelpfulness == other.unhelpfulness &&
	[self isEqualWithNull:self.attributionText other:other.attributionText] &&
	[self isEqualWithNull:self.attributionLogo other:other.attributionLogo] &&
	self.attributionSource == other.attributionSource;
}

- (BOOL) isEqual:(id) other {
	if (other == self) {
		return YES;
	}
	if (! other || ! [other isKindOfClass:[self class]]) {
		return NO;
	}
	
	return [self isEqualToPlacesDetailEditorial:other];
}

- (NSUInteger) hash {
	NSUInteger h = 0;
	h += self.editorialId;
	h += [self.url hash];
	h += [self.title hash];
	h += [self.author hash];
	h += [self.review hash];
	h += [self.pros hash];
	h += [self.cons hash];
	h += [self.date hash];
	h += self.reviewRating;
	h += self.helpfulnessTotal;
	h += self.helpfulness;
	h += self.unhelpfulness;
	h += [self.attributionText hash];
	h += [self.attributionLogo hash];
	h += self.attributionSource;
	return h;
}

- (NSString*) description {
	return [NSString stringWithFormat:@"<CGPlacesDetailEditorial editorialId=%i,url=%@,title=%@,author=%@,review=%@,pros=%@,cons=%@,date=%@,reviewRating=%i,helpfulnessTotal=%i,helpfulness=%i,unhelpfulness=%i,attributionText=%@,attributionLogo=%@,attributionSource=%i>",
			self.editorialId, self.url, self.title, self.author, self.review, self.pros, self.cons, self.date, self.reviewRating,
			self.helpfulnessTotal, self.helpfulness, self.unhelpfulness, self.attributionText, self.attributionLogo, self.attributionSource];
}

@end
