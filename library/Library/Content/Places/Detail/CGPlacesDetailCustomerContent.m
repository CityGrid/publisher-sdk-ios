//
//
//  Copyright 2011 CityGrid Media, LLC All rights reserved.
//
#import "CGPlacesDetailCustomerContent.h"
#import "CGPlacesDetailCustomerMessage.h"

@interface CGPlacesDetailCustomerContent ()

@property (nonatomic, retain, readwrite) CGPlacesDetailCustomerMessage* message;
@property (nonatomic, retain, readwrite) NSArray* bullets; // NSString*
@property (nonatomic, retain, readwrite) NSURL* url;

@end

@implementation CGPlacesDetailCustomerContent

@synthesize message = message_;
@synthesize bullets = bullets_;
@synthesize url = url_;

#pragma mark -
#pragma mark Lifecycle

- (id) initImmutable:(CGPlacesDetailCustomerMessage*) message bullets:(NSArray*) bullets
				 url:(NSURL*) url {
	self = [super init];
	
	if (self) {
		self.message = message;
		self.bullets = bullets;
		self.url = url;
	}
	
	return self;
}

- (void) dealloc {
	self.message = nil;
	self.bullets = nil;
	self.url = nil;
	
	[super dealloc];
}

#pragma mark -
#pragma mark NSCoding

- (id) initWithCoder:(NSCoder*) decoder {
	self = [super initWithCoder:decoder];
	
	if (self) {
		self.message = [decoder decodeObjectForKey:@"message"];
		self.bullets = [decoder decodeObjectForKey:@"bullets"];
		self.url = [decoder decodeObjectForKey:@"url"];
	}
	
	return self;
}

- (void) encodeWithCoder:(NSCoder*) encoder {
	[super encodeWithCoder:encoder];
	[encoder encodeObject:self.message forKey:@"message"];
	[encoder encodeObject:self.bullets forKey:@"bullets"];
	[encoder encodeObject:self.url forKey:@"url"];
}

#pragma mark -
#pragma mark NSCopying

- (id) copyWithZone:(NSZone*) zone {
	CGPlacesDetailCustomerContent* copy = [super copyWithZone:zone];
	if (copy) {
		copy.message = [[self.message copyWithZone:zone] autorelease];
		copy.bullets = [[self.bullets copyWithZone:zone] autorelease];
		copy.url = [[self.url copyWithZone:zone] autorelease];
	}
	
	return copy;
}

#pragma mark -
#pragma mark NSObject

- (BOOL) isEqualToPlacesDetailCustomerContent:(CGPlacesDetailCustomerContent*) other {
	return
	[self isEqualWithNull:self.message other:other.message] &&
	[self isEqualWithNull:self.bullets other:other.bullets] &&
	[self isEqualWithNull:self.url other:other.url];
}

- (BOOL) isEqual:(id) other {
	if (other == self) {
		return YES;
	}
	if (! other || ! [other isKindOfClass:[self class]]) {
		return NO;
	}
	
	return [self isEqualToPlacesDetailCustomerContent:other];
}

- (NSUInteger) hash {
	NSUInteger h = 0;
	h += [self.message hash];
	h += [self.bullets hash];
	h += [self.url hash];
	return h;
}

- (NSString*) description {
	return [NSString stringWithFormat:@"<CGPlacesDetailCustomerContent message=%@,bullets=%@,url=%@>",
			self.message, self.bullets, self.url];
}

@end
