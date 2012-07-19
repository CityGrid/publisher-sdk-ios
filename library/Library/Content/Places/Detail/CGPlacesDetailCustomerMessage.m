//
//
//  Copyright 2011 CityGrid Media, LLC All rights reserved.
//
#import "CGPlacesDetailCustomerMessage.h"

@interface CGPlacesDetailCustomerMessage ()

@property (nonatomic, retain, readwrite) NSString* message;
@property (nonatomic, retain, readwrite) NSString* attributionText;
@property (nonatomic, retain, readwrite) NSURL* attributionLogo;
@property (nonatomic, assign, readwrite) NSInteger attributionSource;

@end

@implementation CGPlacesDetailCustomerMessage

@synthesize message = message_;
@synthesize attributionText = attributionText_;
@synthesize attributionLogo = attributionLogo_;
@synthesize attributionSource = attributionSource_;

#pragma mark -
#pragma mark Lifecycle

- (id) initImmutable:(NSString*) message attributionText:(NSString*) attributionText attributionLogo:(NSURL*) attributionLogo
   attributionSource:(NSInteger) attributionSource {
	self = [super init];
	
	if (self) {
		self.message = message;
		self.attributionText = attributionText;
		self.attributionLogo = attributionLogo;
		self.attributionSource = attributionSource;
	}
	
	return self;
}

- (void) dealloc {
	self.message = nil;
	self.attributionText = nil;
	self.attributionLogo = nil;
	
	[super dealloc];
}

#pragma mark -
#pragma mark NSCoding

- (id) initWithCoder:(NSCoder*) decoder {
	self = [super initWithCoder:decoder];
	
	if (self) {
		self.message = [decoder decodeObjectForKey:@"message"];
		self.attributionText = [decoder decodeObjectForKey:@"attributionText"];
		self.attributionLogo = [decoder decodeObjectForKey:@"attributionLogo"];
		self.attributionSource = [decoder decodeIntegerForKey:@"attributionSource"];
	}
	
	return self;
}

- (void) encodeWithCoder:(NSCoder*) encoder {
	[super encodeWithCoder:encoder];
	[encoder encodeObject:self.message forKey:@"message"];
	[encoder encodeObject:self.attributionText forKey:@"attributionText"];
	[encoder encodeObject:self.attributionLogo forKey:@"attributionLogo"];
	[encoder encodeInteger:self.attributionSource forKey:@"attributionSource"];
}

#pragma mark -
#pragma mark NSCopying

- (id) copyWithZone:(NSZone*) zone {
	CGPlacesDetailCustomerMessage* copy = [self copyWithZone:zone];
	if (copy) {
		copy.message = [[self.message copyWithZone:zone] autorelease];
		copy.attributionText = [[self.attributionText copyWithZone:zone] autorelease];
		copy.attributionLogo = [[self.attributionLogo copyWithZone:zone] autorelease];
		copy.attributionSource = self.attributionSource;
	}
	
	return copy;
}

#pragma mark -
#pragma mark NSObject

- (BOOL) isEqualToPlacesDetailCustomerMessage:(CGPlacesDetailCustomerMessage*) other {
	return
	[self isEqualWithNull:self.message other:other.message] &&
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
	
	return [self isEqualToPlacesDetailCustomerMessage:other];
}

- (NSUInteger) hash {
	NSUInteger h = 0;
	h += [self.message hash];
	h += [self.attributionText hash];
	h += [self.attributionLogo hash];
	h += self.attributionSource;
	return h;
}

- (NSString*) description {
	return [NSString stringWithFormat:@"<CGPlacesDetailCustomerMessage message=%@,attributionText=%@,attributionLogo=%@,attributionSource=%i>",
			self.message, self.attributionText, self.attributionLogo, self.attributionSource];
}

@end
