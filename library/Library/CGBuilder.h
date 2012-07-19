//
//
//  Copyright 2011 CityGrid Media, LLC All rights reserved.
//
#import "CGObject.h"

@interface CGBuilder : CGObject

- (NSURL*) urlForParsed:(NSDictionary*) parsed key:(NSString*) key;
- (id) objectForParsed:(NSDictionary*) parsed key:(NSString*) key;
- (CLLocation*) locationForParsed:(NSDictionary*) parsed latitudeKey:(NSString*) latitudeKey longitudeKey:(NSString*) longitudeKey;
- (NSDate*) dateForParsed:(NSDictionary*) parsed key:(NSString*) key;
- (NSArray*) trimAndSplit:(NSString*) string;
- (NSString*) ipAddress;

@end
