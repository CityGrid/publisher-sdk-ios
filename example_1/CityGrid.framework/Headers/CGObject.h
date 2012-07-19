//
//
//  Copyright 2011 CityGrid Media, LLC All rights reserved.
//
#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface CGObject : NSObject <NSCoding, NSCopying>

- (BOOL) isEqualWithNull:(NSObject*) o1 other:(NSObject*) o2;
- (BOOL) isEqualCoordinates:(CLLocation*) o1 other:(CLLocation*) o2;

@end
