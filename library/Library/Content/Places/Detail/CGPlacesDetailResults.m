//
//
//  Copyright 2011 CityGrid Media, LLC All rights reserved.
//
#import "CGPlacesDetailResults.h"
#import "CGPlacesDetailLocation.h"

@interface CGPlacesDetailResults ()

@property (nonatomic, retain, readwrite) NSArray* locations; // CGPlacesDetailLocation

@end

@implementation CGPlacesDetailResults

@synthesize locations = locations_;
@dynamic location;

#pragma mark -
#pragma mark Lifecycle

- (id) initImmutable:(NSArray*) locations {
	self = [super init];
	
	if (self) {
		self.locations = locations;
	}
	
	return self;
}

- (void) dealloc {
	self.locations = nil;
	
	[super dealloc];
}

#pragma mark -
#pragma mark NSCoding

- (id) initWithCoder:(NSCoder*) decoder {
	self = [super initWithCoder:decoder];
	
	if (self) {
		self.locations = [decoder decodeObjectForKey:@"locations"];
	}
	
	return self;
}

- (void) encodeWithCoder:(NSCoder*) encoder {
	[super encodeWithCoder:encoder];
	[encoder encodeObject:self.locations forKey:@"locations"];
}

#pragma mark -
#pragma mark NSCopying

- (id) copyWithZone:(NSZone*) zone {
	CGPlacesDetailResults* copy = [super copyWithZone:zone];
	if (copy) {
		copy.locations = [[self.locations copyWithZone:zone] autorelease];
	}
	
	return copy;
}

#pragma mark -
#pragma mark NSObject

- (BOOL) isEqualToPlacesDetailResults:(CGPlacesDetailResults*) other {
	return [self isEqualWithNull:self.locations other:other.locations];
}

- (BOOL) isEqual:(id) other {
	if (other == self) {
		return YES;
	}
	if (! other || ! [other isKindOfClass:[self class]]) {
		return NO;
	}
	
	return [self isEqualToPlacesDetailResults:other];
}

- (NSUInteger) hash {
	NSUInteger h = 0;
	h += [self.locations hash];
	return h;
}

- (NSString*) description {
	return [NSString stringWithFormat:@"<CGPlacesDetailResults locations=%@>", self.locations];
}

#pragma mark -
#pragma mark Actions

- (CGPlacesDetailLocation*) location {
	if ([self.locations count] > 0) {
		return [self.locations objectAtIndex:0];
	}
	
	return nil;
}

@end
