//
//
//  Copyright 2011 CityGrid Media, LLC All rights reserved.
//
#import "CGObject.h"

@implementation CGObject

- (id) initWithCoder:(NSCoder*) decoder {
	if (! [decoder allowsKeyedCoding]) {
		[NSException raise:@"Unsupported Archiver" format:@"Only Keyed Archivers are supported"];
	}
	
	return [super init];
}

- (void) encodeWithCoder:(NSCoder*) encoder {
	if (! [encoder allowsKeyedCoding]) {
		[NSException raise:@"Unsupported Archiver" format:@"Only Keyed Archivers are supported"];
	}
}

- (id) copyWithZone:(NSZone*) zone {
	return [[[self class] allocWithZone:zone] init];
}

- (BOOL) isEqualWithNull:(NSObject*) o1 other:(NSObject*) o2 {
	if (o1 == nil && o2 == nil) {
		return YES;
	} else {
		return [o1 isEqual:o2];
	}
}

- (BOOL) isEqualCoordinates:(CLLocation*) o1 other:(CLLocation*) o2 {
	if (o1 == nil && o2 == nil) {
		return YES;
	} else {
		return o1.coordinate.latitude == o2.coordinate.latitude && o1.coordinate.longitude == o2.coordinate.longitude;
	}
}

- (NSString*) description {
	[NSException raise:@"Not Implemented!" format:@"Implement description"];
	return nil;
}

- (BOOL) isEqual:(id) other {
	[NSException raise:@"Not Implemented!" format:@"Implement isEqual:"];
	return NO;
}

@end
