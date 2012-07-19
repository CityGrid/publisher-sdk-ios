//
//
//  Copyright 2011 CityGrid Media, LLC All rights reserved.
//
#import "CGOffersDetailResults.h"
#import "CGOffersOffer.h"

@interface CGOffersDetailResults ()

@property (nonatomic, retain, readwrite) CGOffersOffer* offer;

@end

@implementation CGOffersDetailResults

@synthesize offer = offer_;

#pragma mark -
#pragma mark Lifecycle

- (id) initImmutable:(CGOffersOffer*) offer {
	self = [super init];
	
	if (self) {
		self.offer = offer;
	}
	
	return self;
}

- (void) dealloc {
	self.offer = nil;
	
	[super dealloc];
}

#pragma mark -
#pragma mark NSCoding

- (id) initWithCoder:(NSCoder*) decoder {
	self = [super initWithCoder:decoder];
	
	if (self) {
		self.offer = [decoder decodeObjectForKey:@"offer"];
	}
	
	return self;
}

- (void) encodeWithCoder:(NSCoder*) encoder {
	[super encodeWithCoder:encoder];
	[encoder encodeObject:self.offer forKey:@"offer"];
}

#pragma mark -
#pragma mark NSCopying

- (id) copyWithZone:(NSZone*) zone {
	CGOffersDetailResults* copy = [super copyWithZone:zone];
	if (copy) {
		copy.offer = [[self.offer copyWithZone:zone] autorelease];
	}
	
	return copy;
}

#pragma mark -
#pragma mark NSObject

- (BOOL) isEqualToOffersDetailResults:(CGOffersDetailResults*) other {
	return [self isEqualWithNull:self.offer other:other.offer];
}

- (BOOL) isEqual:(id) other {
	if (other == self) {
		return YES;
	}
	if (! other || ! [other isKindOfClass:[self class]]) {
		return NO;
	}
	
	return [self isEqualToOffersDetailResults:other];
}

- (NSUInteger) hash {
	NSUInteger h = 0;
	h += [self.offer hash];
	return h;
}

- (NSString*) description {
	return [NSString stringWithFormat:@"<CGOffersDetailResults offer=%@>", self.offer];
}

@end
