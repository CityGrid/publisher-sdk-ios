//
//
//  Copyright 2011 CityGrid Media, LLC All rights reserved.
//
#import "CGObject.h"

@interface CGAddress : CGObject

#pragma mark -
#pragma mark Properties

@property (nonatomic, retain, readonly) NSString* street;
@property (nonatomic, retain, readonly) NSString* city;
@property (nonatomic, retain, readonly) NSString* state;
@property (nonatomic, retain, readonly) NSString* zip;

#pragma mark -
#pragma mark Initialization

- (id) initImmutable:(NSString*) street city:(NSString*) city state:(NSString*) state zip:(NSString*) zip;

#pragma mark -
#pragma mark NSObject

- (BOOL) isEqualToAddress:(CGAddress*) other;

@end
