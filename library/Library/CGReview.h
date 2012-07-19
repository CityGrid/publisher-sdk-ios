//
//
//  Copyright 2011 CityGrid Media, LLC All rights reserved.
//
#import "CGObject.h"

@interface CGReview : CGObject

#pragma mark -
#pragma mark Properties

@property (nonatomic, retain, readonly) NSString* reviewId;
@property (nonatomic, retain, readonly) NSURL* url;
@property (nonatomic, retain, readonly) NSString* title;
@property (nonatomic, retain, readonly) NSString* author;
@property (nonatomic, retain, readonly) NSString* text;
@property (nonatomic, retain, readonly) NSString* pros;
@property (nonatomic, retain, readonly) NSString* cons;
@property (nonatomic, retain, readonly) NSDate* date;
@property (nonatomic, assign, readonly) NSInteger rating;
@property (nonatomic, assign, readonly) NSInteger helpful;
@property (nonatomic, assign, readonly) NSInteger unhelpful;
@property (nonatomic, retain, readonly) NSString* attributionText;
@property (nonatomic, retain, readonly) NSURL* attributionLogo;
@property (nonatomic, assign, readonly) NSInteger attributionSource;

#pragma mark -
#pragma mark Initialization

- (id) initImmutable:(NSString*) reviewId url:(NSURL*) url title:(NSString*) title author:(NSString*) author
				text:(NSString*) text pros:(NSString*) pros cons:(NSString*) cons date:(NSDate*) date
			  rating:(NSInteger) rating  helpful:(NSInteger) helpful unhelpful:(NSInteger) unhelpful
	 attributionText:(NSString*) attributionText attributionLogo:(NSURL*) attributionLogo
   attributionSource:(NSInteger) attributionSource;

#pragma mark -
#pragma mark NSObject

- (BOOL) isEqualToReview:(CGReview*) other;

@end
