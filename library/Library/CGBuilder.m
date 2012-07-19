//
//
//  Copyright 2011 CityGrid Media, LLC All rights reserved.
//
#import <ifaddrs.h> 
#import <arpa/inet.h>
#import "CGBuilder.h"
#import "CGShared.h"

@implementation CGBuilder

- (NSURL*) urlForParsed:(NSDictionary*) parsed key:(NSString*) key {
	return [NSURL URLWithString:[self objectForParsed:parsed key:key]];
}

- (id) objectForParsed:(NSDictionary*) parsed key:(NSString*) key {
	NSString* string = [parsed objectForKey:key];
	if ([[NSNull null] isEqual:string]) {
		return nil;
	}
	return string;
}

- (CLLocation*) locationForParsed:(NSDictionary*) parsed latitudeKey:(NSString*) latitudeKey longitudeKey:(NSString*) longitudeKey {
	NSDecimalNumber* latitude = [self objectForParsed:parsed key:latitudeKey];
	NSDecimalNumber* longitude = [self objectForParsed:parsed key:longitudeKey];
	if (latitude && longitude) {
		return [[[CLLocation alloc] initWithLatitude:[latitude doubleValue] longitude:[longitude doubleValue]] autorelease];
	}
	
	return nil;
}

- (NSDate*) dateForParsed:(NSDictionary*) parsed key:(NSString*) key {
	NSDate* date = nil;
	NSString* string = [self objectForParsed:parsed key:key];
	// Strip the last ":"
    NSInteger length = [string length];
	if (length == 20 || length == 25 || length == 29) {
		NSString* adjusted = [NSString stringWithFormat:@"%@%@", [string substringToIndex:[string length] - 3], [string substringFromIndex:[string length] - 2]];
		NSDateFormatter* formatter = [[[NSDateFormatter alloc] init] autorelease];
		if (length == 20) {
			[formatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss'Z'"];
        } else if (length == 25) {
			[formatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZZZ"];
		} else {
			[formatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSZZZ"];
		}
		date = [formatter dateFromString:adjusted];
	}
	return date;
}

- (NSArray*) trimAndSplit:(NSString*) string {
	NSArray* splits = [string componentsSeparatedByString:@","];
	NSMutableArray* categories = [NSMutableArray arrayWithCapacity:[splits count]];
	
	for (NSString* split in splits) {
		[categories addObject:[split stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@" \n"]]];
	}
	
	return categories;
}

- (NSString*) ipAddress {
	// http://blog.zachwaugh.com/post/309927273/programmatically-retrieving-ip-address-of-iphone
	NSString* address = nil;
	struct ifaddrs* interfaces = NULL;
	struct ifaddrs* temp_addr = NULL;
	int success = 0;
    
	// retrieve the current interfaces - returns 0 on success
	success = getifaddrs(&interfaces);
	if (success == 0) {
		// Loop through linked list of interfaces
		temp_addr = interfaces;
		while (temp_addr != NULL) {
			if (temp_addr->ifa_addr->sa_family == AF_INET) {
				// Check if interface is en0 which is the wifi connection on the iPhone
				if ([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
					// Get NSString from C String
					address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
				}
			}
			temp_addr = temp_addr->ifa_next; 
		} 
	}	
    
	// Free memory
	freeifaddrs(interfaces);
	if(!address || address == nil) {
		address = @"127.0.0.1"; //default just in case
	}
	
	return address; 
}


@end
