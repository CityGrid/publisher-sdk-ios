//
//
//  Copyright 2011 CityGrid Media, LLC All rights reserved.
//
#import "CGObject.h"

@interface CGPlacesDetailEditorial : CGObject

#pragma mark -
#pragma mark Properties

@property (nonatomic, assign, readonly) NSInteger editorialId;
@property (nonatomic, retain, readonly) NSURL* url;
@property (nonatomic, retain, readonly) NSString* title;
@property (nonatomic, retain, readonly) NSString* author;
@property (nonatomic, retain, readonly) NSString* review;
@property (nonatomic, retain, readonly) NSString* pros;
@property (nonatomic, retain, readonly) NSString* cons;
@property (nonatomic, retain, readonly) NSDate* date;
@property (nonatomic, assign, readonly) NSInteger reviewRating;
@property (nonatomic, assign, readonly) NSInteger helpfulnessTotal;
@property (nonatomic, assign, readonly) NSInteger helpfulness;
@property (nonatomic, assign, readonly) NSInteger unhelpfulness;
@property (nonatomic, retain, readonly) NSString* attributionText;
@property (nonatomic, retain, readonly) NSURL* attributionLogo;
@property (nonatomic, assign, readonly) NSInteger attributionSource;

#pragma mark -
#pragma mark Initialization

- (id) initImmutable:(NSInteger) editorialId url:(NSURL*) url title:(NSString*) title author:(NSString*) author
			  review:(NSString*) review pros:(NSString*) pros cons:(NSString*) cons date:(NSDate*) date
		reviewRating:(NSInteger) reviewRating helpfulnessTotal:(NSInteger) helpfulnessTotal
		helpfulness:(NSInteger) helpfulness unhelpfulness:(NSInteger) unhelpfulness
	 attributionText:(NSString*) attributionText attributionLogo:(NSURL*) attributionLogo
   attributionSource:(NSInteger) attributionSource;

#pragma mark -
#pragma mark NSObject

- (BOOL) isEqualToPlacesDetailEditorial:(CGPlacesDetailEditorial*) other;

@end
