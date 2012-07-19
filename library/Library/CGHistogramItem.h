//
//
//  Copyright 2011 CityGrid Media, LLC All rights reserved.
//
#import "CGObject.h"

@interface CGHistogramItem : CGObject

#pragma mark -
#pragma mark Properties

@property (nonatomic, retain, readonly) NSString* name;
@property (nonatomic, assign, readonly) NSInteger count;
@property (nonatomic, retain, readonly) NSURL* uri;
@property (nonatomic, retain, readonly) NSArray* tagIds; // NSString*

#pragma mark -
#pragma mark Initialization

- (id) initImmutable:(NSString*) name count:(NSInteger) count uri:(NSURL*) uri tagIds:(NSArray*) tagIds;

#pragma mark -
#pragma mark NSObject

- (BOOL) isEqualToHistogramItem:(CGHistogramItem*) other;

@end
