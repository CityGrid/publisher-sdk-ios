//
//
//  Copyright 2011 CityGrid Media, LLC All rights reserved.
//
#import "CGPlacesDetailImage.h"

@interface CGPlacesDetailImage ()

@property (nonatomic, assign, readwrite) CGPlacesDetailImageType type;
@property (nonatomic, assign, readwrite) NSInteger height;
@property (nonatomic, assign, readwrite) NSInteger width;
@property (nonatomic, retain, readwrite) NSURL* url;

@end

@implementation CGPlacesDetailImage

@synthesize type = type_;
@synthesize height = height_;
@synthesize width = width_;
@synthesize url = url_;

#pragma mark -
#pragma mark Lifecycle

- (id) initImmutable:(CGPlacesDetailImageType) type height:(NSInteger) height width:(NSInteger) width
				 url:(NSURL*) url {
	self = [super init];
	
	if (self) {
		self.type = type;
		self.height = height;
		self.width = width;
		self.url = url;
	}
	
	return self;
}

- (void) dealloc {
	self.url = nil;
	
	[super dealloc];
}

#pragma mark -
#pragma mark NSCoding

- (id) initWithCoder:(NSCoder*) decoder {
	self = [super initWithCoder:decoder];
	
	if (self) {
		self.type = [decoder decodeIntegerForKey:@"type"];
		self.height = [decoder decodeIntegerForKey:@"height"];
		self.width = [decoder decodeIntegerForKey:@"width"];
		self.url = [decoder decodeObjectForKey:@"url"];
	}
	
	return self;
}

- (void) encodeWithCoder:(NSCoder*) encoder {
	[super encodeWithCoder:encoder];
	[encoder encodeInteger:self.type forKey:@"type"];
	[encoder encodeInteger:self.height forKey:@"height"];
	[encoder encodeInteger:self.width forKey:@"width"];
	[encoder encodeObject:self.url forKey:@"url"];
}

#pragma mark -
#pragma mark NSCopying

- (id) copyWithZone:(NSZone*) zone {
	CGPlacesDetailImage* copy = [super copyWithZone:zone];
	if (copy) {
		copy.type = self.type;
		copy.height = self.height;
		copy.width = self.width;
		copy.url = [[self.url copyWithZone:zone] autorelease];
	}
	
	return copy;
}

#pragma mark -
#pragma mark NSObject

- (BOOL) isEqualToPlacesDetailImage:(CGPlacesDetailImage*) other {
	return
	self.type == other.type &&
	self.height == other.height &&
	self.width == other.width &&
	[self isEqualWithNull:self.url other:other.url];
}

- (BOOL) isEqual:(id) other {
	if (other == self) {
		return YES;
	}
	if (! other || ! [other isKindOfClass:[self class]]) {
		return NO;
	}
	
	return [self isEqualToPlacesDetailImage:other];
}

- (NSUInteger) hash {
	NSUInteger h = 0;
	h += self.type;
	h += self.height;
	h += self.width;
	h += [self.url hash];
	return h;
}

- (NSString*) description {
	return [NSString stringWithFormat:@"<CGPlacesDetailImage type=%i,height=%i,width=%i,url=%@>",
			self.type, self.height, self.width, self.url];
}

@end
