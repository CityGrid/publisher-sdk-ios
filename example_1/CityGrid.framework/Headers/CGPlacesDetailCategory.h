//
//
//  Copyright 2011 CityGrid Media, LLC All rights reserved.
//
#import "CGObject.h"

@class CGPlacesDetailGroup;

@interface CGPlacesDetailCategory : CGObject

#pragma mark -
#pragma mark Properties

@property (nonatomic, assign, readonly) NSInteger categoryId;
@property (nonatomic, retain, readonly) NSString* name;
@property (nonatomic, assign, readonly) NSInteger parentId;
@property (nonatomic, retain, readonly) NSString* parent;
@property (nonatomic, retain, readonly) NSArray* groups;

#pragma mark -
#pragma mark Initialization

- (id) initImmutable:(NSInteger) categoryId name:(NSString*) name parentId:(NSInteger) parentId
			  parent:(NSString*) parent groups:(NSArray*) groups;

#pragma mark -
#pragma mark NSObject

- (BOOL) isEqualToPlacesDetailCategory:(CGPlacesDetailCategory*) other;

@end
