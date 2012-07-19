//
//
//  Copyright 2011 CityGrid Media, LLC All rights reserved.
//
#import "CGObject.h"

@interface CGTag : CGObject

#pragma mark -
#pragma mark Properties

@property (nonatomic, assign, readonly) NSInteger tagId;
@property (nonatomic, retain, readonly) NSString* name;

#pragma mark -
#pragma mark Initialization

- (id) initImmutable:(NSInteger) tagId name:(NSString*) name;

#pragma mark -
#pragma mark NSObject

- (BOOL) isEqualToTag:(CGTag*) other;

@end
