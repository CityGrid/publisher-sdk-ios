//
//
//  Copyright 2011 CityGrid Media, LLC All rights reserved.
//
#import "CGAdsMobileResults.h"
#import "CGAdsMobileAd.h"

@interface CGAdsMobileResults ()

@property (nonatomic, retain, readwrite) NSArray* ads; // CGAdsMobileAd

@end

@implementation CGAdsMobileResults

@synthesize ads = ads_;
@dynamic ad;

#pragma mark -
#pragma mark Lifecycle

- (id) initImmutable:(NSArray*) ads {
	self = [super init];
	
	if (self) {
		self.ads = ads;
	}
	
	return self;
}

- (void) dealloc {
	self.ads = nil;
	
	[super dealloc];
}

#pragma mark -
#pragma mark NSCoding

- (id) initWithCoder:(NSCoder*) decoder {
	self = [super initWithCoder:decoder];
	
	if (self) {
		self.ads = [decoder decodeObjectForKey:@"ads"];
	}
	
	return self;
}

- (void) encodeWithCoder:(NSCoder*) encoder {
	[super encodeWithCoder:encoder];
	[encoder encodeObject:self.ads forKey:@"ads"];
}

#pragma mark -
#pragma mark NSCopying

- (id) copyWithZone:(NSZone*) zone {
	CGAdsMobileResults* copy = [super copyWithZone:zone];
	if (copy) {
		copy.ads = [[self.ads copyWithZone:zone] autorelease];
	}
	
	return copy;
}

#pragma mark -
#pragma mark NSObject

- (BOOL) isEqualToAdsMobileResults:(CGAdsMobileResults*) other {
	return [self isEqualWithNull:self.ads other:other.ads];
}

- (BOOL) isEqual:(id) other {
	if (other == self) {
		return YES;
	}
	if (! other || ! [other isKindOfClass:[self class]]) {
		return NO;
	}
	
	return [self isEqualToAdsMobileResults:other];
}

- (NSUInteger) hash {
	NSUInteger h = 0;
	h += [self.ads hash];
	return h;
}

- (NSString*) description {
	return [NSString stringWithFormat:@"<CGAdsMobileResults ads=%@>", self.ads];
}

#pragma mark -
#pragma mark Helpers

- (CGAdsMobileAd*) ad {
	if ([self.ads count] > 0) {
		return [self.ads objectAtIndex:0];
	}
	
	return nil;
}

@end
