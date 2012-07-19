//
//
//  Copyright 2011 CityGrid Media, LLC All rights reserved.
//
#import "CGReview.h"

@interface CGReview ()

@property (nonatomic, retain, readwrite) NSString* reviewId;
@property (nonatomic, retain, readwrite) NSURL* url;
@property (nonatomic, retain, readwrite) NSString* title;
@property (nonatomic, retain, readwrite) NSString* author;
@property (nonatomic, retain, readwrite) NSString* text;
@property (nonatomic, retain, readwrite) NSString* pros;
@property (nonatomic, retain, readwrite) NSString* cons;
@property (nonatomic, retain, readwrite) NSDate* date;
@property (nonatomic, assign, readwrite) NSInteger rating;
@property (nonatomic, assign, readwrite) NSInteger helpful;
@property (nonatomic, assign, readwrite) NSInteger unhelpful;
@property (nonatomic, retain, readwrite) NSString* attributionText;
@property (nonatomic, retain, readwrite) NSURL* attributionLogo;
@property (nonatomic, assign, readwrite) NSInteger attributionSource;

@end

@implementation CGReview

@synthesize reviewId = reviewId_;
@synthesize url = url_;
@synthesize title = title_;
@synthesize author = author_;
@synthesize text = text_;
@synthesize pros = pros_;
@synthesize cons = cons_;
@synthesize date = date_;
@synthesize rating = rating_;
@synthesize helpful = helpful_;
@synthesize unhelpful = unhelpful_;
@synthesize attributionText = attributionText_;
@synthesize attributionLogo = attributionLogo_;
@synthesize attributionSource = attributionSource_;

#pragma mark -
#pragma mark Lifecycle

- (id) initImmutable:(NSString*) reviewId url:(NSURL*) url title:(NSString*) title author:(NSString*) author
				text:(NSString*) text pros:(NSString*) pros cons:(NSString*) cons date:(NSDate*) date
			  rating:(NSInteger) rating  helpful:(NSInteger) helpful unhelpful:(NSInteger) unhelpful
	 attributionText:(NSString*) attributionText attributionLogo:(NSURL*) attributionLogo
   attributionSource:(NSInteger) attributionSource {
	self = [super init];
	
	if (self) {
		self.reviewId = reviewId;
		self.url = url;
		self.title = title;
		self.author = author;
		self.text = text;
		self.pros = pros;
		self.cons = cons;
		self.date = date;
		self.rating = rating;
		self.helpful = helpful;
		self.unhelpful = unhelpful;
		self.attributionText = attributionText;
		self.attributionLogo = attributionLogo;
		self.attributionSource = attributionSource;
	}
	
	return self;
}

- (void) dealloc {
	self.reviewId = nil;
	self.url = nil;
	self.title = nil;
	self.author = nil;
	self.text = nil;
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
		self.reviewId = [decoder decodeObjectForKey:@"reviewId"];
		self.url = [decoder decodeObjectForKey:@"url"];
		self.title = [decoder decodeObjectForKey:@"title"];
		self.author = [decoder decodeObjectForKey:@"author"];
		self.text = [decoder decodeObjectForKey:@"text"];
		self.pros = [decoder decodeObjectForKey:@"pros"];
		self.cons = [decoder decodeObjectForKey:@"cons"];
		self.date = [decoder decodeObjectForKey:@"date"];
		self.rating = [decoder decodeIntegerForKey:@"rating"];
		self.helpful = [decoder decodeIntegerForKey:@"helpful"];
		self.unhelpful = [decoder decodeIntegerForKey:@"unhelpful"];
		self.attributionText = [decoder decodeObjectForKey:@"attributionText"];
		self.attributionLogo = [decoder decodeObjectForKey:@"attributionLogo"];
		self.attributionSource = [decoder decodeIntegerForKey:@"attributionSource"];
	}
	
	return self;
}

- (void) encodeWithCoder:(NSCoder*) encoder {
	[super encodeWithCoder:encoder];
	[encoder encodeObject:self.reviewId forKey:@"reviewId"];
	[encoder encodeObject:self.url forKey:@"url"];
	[encoder encodeObject:self.title forKey:@"title"];
	[encoder encodeObject:self.author forKey:@"author"];
	[encoder encodeObject:self.text	forKey:@"text"];
	[encoder encodeObject:self.pros forKey:@"pros"];
	[encoder encodeObject:self.cons forKey:@"cons"];
	[encoder encodeObject:self.date forKey:@"date"];
	[encoder encodeInteger:self.rating forKey:@"rating"];
	[encoder encodeInteger:self.helpful forKey:@"helpful"];
	[encoder encodeInteger:self.unhelpful forKey:@"unhelpful"];
	[encoder encodeObject:self.attributionText forKey:@"attributionText"];
	[encoder encodeObject:self.attributionLogo forKey:@"attributionLogo"];
	[encoder encodeInteger:self.attributionSource forKey:@"attributionSource"];
}

#pragma mark -
#pragma mark NSCopying

- (id) copyWithZone:(NSZone*) zone {
	CGReview* copy = [super copyWithZone:zone];
	if (copy) {
		copy.reviewId = [[self.reviewId copyWithZone:zone] autorelease];
		copy.url = [[self.url copyWithZone:zone] autorelease];
		copy.title = [[self.title copyWithZone:zone] autorelease];
		copy.author = [[self.author copyWithZone:zone] autorelease];
		copy.text = [[self.text copyWithZone:zone] autorelease];
		copy.pros = [[self.pros copyWithZone:zone] autorelease];
		copy.cons = [[self.cons copyWithZone:zone] autorelease];
		copy.date = [[self.date copyWithZone:zone] autorelease];
		copy.rating = self.rating;
		copy.helpful = self.helpful;
		copy.unhelpful = self.unhelpful;
		copy.attributionText = [[self.attributionText copyWithZone:zone] autorelease];
		copy.attributionLogo = [[self.attributionLogo copyWithZone:zone] autorelease];
		copy.attributionSource = self.attributionSource;
	}
	
	return copy;
}

#pragma mark -
#pragma mark NSObject

- (BOOL) isEqualToReview:(CGReview*) other {
	return
	[self isEqualWithNull:self.reviewId other:other.reviewId] &&
	[self isEqualWithNull:self.url other:other.url] &&
	[self isEqualWithNull:self.title other:other.title] &&
	[self isEqualWithNull:self.author other:other.author] &&
	[self isEqualWithNull:self.text other:other.text] &&
	[self isEqualWithNull:self.pros other:other.pros] &&
	[self isEqualWithNull:self.cons other:other.cons] &&
	[self isEqualWithNull:self.date other:other.date] &&
	self.rating == other.rating &&
	self.helpful == other.helpful &&
	self.unhelpful == other.unhelpful &&
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
	
	return [self isEqualToReview:other];
}

- (NSUInteger) hash {
	NSUInteger h = 0;
	h += [self.reviewId hash];
	h += [self.url hash];
	h += [self.title hash];
	h += [self.author hash];
	h += [self.text hash];
	h += [self.pros hash];
	h += [self.cons hash];
	h += [self.date hash];
	h += self.rating;
	h += self.helpful;
	h += self.unhelpful;
	h += [self.attributionText hash];
	h += [self.attributionLogo hash];
	h += self.attributionSource;
	return h;
}

- (NSString*) description {
	return [NSString stringWithFormat:@"<CGReview reviewId=%@,url=%@,title=%@,author=%@,text=%@,pros=%@,cons=%@,date=%@,rating=%i,helpful=%ui,unhelpful=%i,attributionText=%@,attributionLogo=%@,attributionSource=%i>",
			self.reviewId, self.url, self.title, self.author, self.text, self.pros, self.cons, self.date, self.rating, self.helpful,
			self.unhelpful, self.attributionText, self.attributionLogo, self.attributionSource];
}

@end
