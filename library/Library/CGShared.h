//
//
//  Copyright 2011 CityGrid Media, LLC All rights reserved.
//
#import <Foundation/Foundation.h>
#import "CGErrorNum.h"

@interface CGShared : NSObject

@property (nonatomic, retain) NSString* publisher;
@property (nonatomic, retain) NSString* placement;
@property (nonatomic, assign) NSTimeInterval timeout;
@property (nonatomic, retain) NSURL* url;
@property (nonatomic, assign) BOOL debug;
@property (nonatomic, assign) BOOL simulation;

+ (CGShared*) sharedInstance;

- (NSError*) errorWithCode:(CGErrorNum) code description:(NSString*) description recoverySuggestion:(NSString*) recoverySuggestion;
- (NSError*) errorWithCode:(CGErrorNum) code description:(NSString*) description recoverySuggestion:(NSString*) recoverySuggestion error:(NSError*) error;
- (NSError*) errorWithErrorNum:(CGErrorNum) errorNum;

- (NSDictionary*) sendSynchronousRequest:(NSURL*) url parameters:(NSDictionary*) parameters timeout:(NSTimeInterval) timeout errors:(NSArray**) errors;

@end
