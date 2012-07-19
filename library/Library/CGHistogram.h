//
//
//  Copyright 2011 CityGrid Media, LLC All rights reserved.
//
#import "CGObject.h"

@interface CGHistogram : CGObject

#pragma mark -
#pragma mark Properties

@property (nonatomic, retain, readonly) NSString* name;
@property (nonatomic, retain, readonly) NSArray* items; // CGHistogramItem

#pragma mark -
#pragma mark Initialization

- (id) initImmutable:(NSString*) name items:(NSArray*) items;

#pragma mark -
#pragma mark NSObject

- (BOOL) isEqualToHistogram:(CGHistogram*) other;

@end
