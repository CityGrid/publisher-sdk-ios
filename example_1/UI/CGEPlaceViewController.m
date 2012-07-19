//
//
//  Copyright 2011 CityGrid Media LLC All rights reserved.
//
#import "CGEPlaceViewController.h"
#import <CityGrid/CityGrid.h>
#import "CGEAppDelegate.h"

@interface CGEPlaceViewController ()

@property (nonatomic, assign) NSInteger locationId;
@property (nonatomic, retain) NSOperationQueue* queue;
@property (nonatomic, retain) CGPlacesDetailLocation* place;

@end

@implementation CGEPlaceViewController

@synthesize imageView = imageView_;
@synthesize streetLabel = streetLabel_;
@synthesize cityLabel = cityLabel_;
@synthesize stateLabel = stateLabel_;
@synthesize zipLabel = zipLabel_;

@synthesize locationId = locationId_;
@synthesize queue = queue_;
@synthesize place = place_;

- (id) initWithLocationId:(NSInteger) locationId {
	self = [super initWithNibName:@"CGEPlace" bundle:nil];
	
	if (self) {
		self.locationId = locationId;
	}
	
	return self;
}

#pragma mark - View lifecycle

- (void) viewDidLoad {
    [super viewDidLoad];
	
	self.title = @"Loading...";
	self.streetLabel.text = @"Loading...";
	self.cityLabel.text = @"Loading...";
	self.stateLabel.text = @"Loading...";
	self.zipLabel.text = @"Loading...";
	
	self.queue = [[[NSOperationQueue alloc] init] autorelease];
	[[CGEAppDelegate sharedAppDelegate] showActivity:self];
	[self.queue addOperationWithBlock:^{
		
		CGPlacesDetail* detail = [CityGrid placesDetail];
		
        //Deprecated
        //detail.locationId = self.locationId;
        detail.placeId = [NSString stringWithFormat:@"%i", self.locationId];
        //Notify the type of the id
        detail.idType = @"cs";
        
		NSArray* errors = nil;
		
		self.place = [detail detail:&errors].location;
		
		if ([errors count] > 0) {
			NSError* first = [errors objectAtIndex:0];
			UIAlertView* alert = [[[UIAlertView alloc] initWithTitle:@"Error" message:first.localizedDescription delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil] autorelease];
			[alert show];
		}
		
		[[NSOperationQueue mainQueue] addOperationWithBlock:^{
			self.title = self.place.name;
			CGAddress* address = self.place.address;
			self.streetLabel.text = address.street;
			self.cityLabel.text = address.city;
			self.stateLabel.text = address.state;
			self.zipLabel.text = address.zip;

			[self.queue addOperationWithBlock:^{
				NSArray* errors = [self.place track:CGAdsTrackerActionTargetListingProfile];
				
				if ([errors count] > 0) {
					NSError* first = [errors objectAtIndex:0];
					UIAlertView* alert = [[[UIAlertView alloc] initWithTitle:@"Error" message:first.localizedDescription delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil] autorelease];
					[alert show];
				}
			}];
		}];
		
		if (self.place.image) {
			[self.queue addOperationWithBlock:^{
				[[CGEAppDelegate sharedAppDelegate] showActivity:self];
				UIImage* image = [UIImage imageWithData:[NSData dataWithContentsOfURL:self.place.image]];
				
				[[NSOperationQueue mainQueue] addOperationWithBlock:^{
					self.imageView.image = image;
				}];
				[[CGEAppDelegate sharedAppDelegate] hideActivity:self];
			}];
		}
		
		[[CGEAppDelegate sharedAppDelegate] hideActivity:self];
	}];
}

- (void) unload {
	[self.queue cancelAllOperations];
	self.queue = nil;
	self.place = nil;
	self.imageView = nil;
	self.streetLabel = nil;
	self.cityLabel = nil;
	self.stateLabel = nil;
	self.zipLabel = nil;
}

- (void) viewDidUnload {
	[self unload];
    [super viewDidUnload];
}

- (void) dealloc {
	[self unload];
    [super dealloc];
}

@end
