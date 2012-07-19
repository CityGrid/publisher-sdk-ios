//
//
//  Copyright 2011 CityGrid Media, LLC All rights reserved.
//
#import "CGPlacesDetailReviews.h"

@interface CGPlacesDetailReviews ()

@property (nonatomic, assign, readwrite) NSInteger rating;
@property (nonatomic, assign, readwrite) NSInteger count;
@property (nonatomic, assign, readwrite) NSInteger shown;
@property (nonatomic, retain, readwrite) NSArray* reviews; // CGReview*

@end

@implementation CGPlacesDetailReviews

@synthesize rating = rating_;
@synthesize count = count_;
@synthesize shown = shown_;
@synthesize reviews = reviews_;

#pragma mark -
#pragma mark Lifecycle

- (id) initImmutable:(NSInteger) rating count:(NSInteger) count
			   shown:(NSInteger) shown reviews:(NSArray*) reviews {
	self = [super init];
	
	if (self) {
		self.rating = rating;
		self.count = count;
		self.shown = shown;
		self.reviews = reviews;
	}
	
	return self;
}

- (void) dealloc {
	self.reviews = nil;
	
	[super dealloc];
}

#pragma mark -
#pragma mark NSCoding

- (id) initWithCoder:(NSCoder*) decoder {
	self = [super initWithCoder:decoder];
	
	if (self) {
		self.rating = [decoder decodeIntegerForKey:@"rating"];
		self.count = [decoder decodeIntegerForKey:@"count"];
		self.shown = [decoder decodeIntegerForKey:@"shown"];
		self.reviews = [decoder decodeObjectForKey:@"reviews"];
	}
	
	return self;
}

- (void) encodeWithCoder:(NSCoder*) encoder {
	[super encodeWithCoder:encoder];
	[encoder encodeInteger:self.rating forKey:@"rating"];
	[encoder encodeInteger:self.count forKey:@"count"];
	[encoder encodeInteger:self.shown forKey:@"shown"];
	[encoder encodeObject:self.reviews forKey:@"reviews"];
}

#pragma mark -
#pragma mark NSCopying

- (id) copyWithZone:(NSZone*) zone {
	CGPlacesDetailReviews* copy = [super copyWithZone:zone];
	if (copy) {
		copy.rating = self.rating;
		copy.count = self.count;
		copy.shown = self.shown;
		copy.reviews = [[self.reviews copyWithZone:zone] autorelease];
	}
	
	return copy;
}

#pragma mark -
#pragma mark NSObject

- (BOOL) isEqualToPlacesDetailReviews:(CGPlacesDetailReviews*) other {
	return
	self.rating == other.rating &&
	self.count == other.count &&
	self.shown == other.shown &&
	[self isEqualWithNull:self.reviews other:other.reviews];
}

- (BOOL) isEqual:(id) other {
	if (other == self) {
		return YES;
	}
	if (! other || ! [other isKindOfClass:[self class]]) {
		return NO;
	}
	
	return [self isEqualToPlacesDetailReviews:other];
}

- (NSUInteger) hash {
	NSUInteger h = 0;
	h += self.rating;
	h += self.count;
	h += self.shown;
	h += [self.reviews hash];
	return h;
}

- (NSString*) description {
	return [NSString stringWithFormat:@"<CGPlacesDetailReviews rating=%i,count=%i,shown=%i,reviews=%@>",
			self.rating, self.count, self.shown, self.reviews];
}

@end
