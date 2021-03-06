//
//
//  Copyright 2011 CityGrid Media LLC All rights reserved.
//
#import "CGEPlacesViewController.h"
#import <CityGrid/CityGrid.h>
#import "CGEAppDelegate.h"
#import "CGEPlaceViewController.h"

//
// The following is to hardcode CoreLocation to a value as it's broken in iOS Simulators 4.0.2, 4.1, 4.2 beta1-4
// Once the simulator is fixed this can be removed
//
#ifdef TARGET_IPHONE_SIMULATOR
@interface CLLocationManager (Simulator)
@end

@implementation CLLocationManager (Simulator)

- (CLLocation*) location {
    return [[[CLLocation alloc] initWithLatitude:34.090660 longitude:-118.384131] autorelease];
}

- (void) startUpdatingLocation {
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        [self.delegate locationManager:self
                   didUpdateToLocation:self.location
                          fromLocation:self.location];    
    }];
}

@end
#endif // TARGET_IPHONE_SIMULATOR

@interface CGEPlacesViewController ()

@property (nonatomic, retain) NSOperationQueue* queue;
@property (nonatomic, retain) CLLocationManager* locationManager;
@property (nonatomic, retain) NSArray* places;
@property (nonatomic, retain) NSString* where;
@property (nonatomic, retain) NSString* what;
@property (nonatomic, retain) NSString* clientIp;

@end

@implementation CGEPlacesViewController

@synthesize queue = queue_;
@synthesize locationManager = locationManager_;
@synthesize places = places_;
@synthesize what = what_;
@synthesize where = where_;
@synthesize clientIp = clientIp_;

- (void) loadPlaces {
	[[CGEAppDelegate sharedAppDelegate] showActivity:self];
	
	[self.queue addOperationWithBlock:^{
		CGPlacesSearch* search = [CityGrid placesSearch];

        if (self.where) {
            search.where = self.where;
        }
        else{
            search.latlon = self.locationManager.location;
        }
        
		search.radius = 20.0;
		search.resultsPerPage = 20;
        search.what = self.what;
        
        self.clientIp = [search ipAddress];
		
		NSArray* errors = nil;
		NSArray* tmpPlaces = [search search:&errors].locations;
		if ([errors count] > 0) {
			NSError* first = [errors objectAtIndex:0];
			[[NSOperationQueue mainQueue] addOperationWithBlock:^{
				UIAlertView* alert = [[[UIAlertView alloc] initWithTitle:@"Error" message:first.localizedDescription delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil] autorelease];
				[alert show];
			}];
		} else {
			self.places = tmpPlaces;
			[[NSOperationQueue mainQueue] addOperationWithBlock:^{
				[self.tableView reloadData];
				self.tableView.hidden = NO;
			}];
		}
        
		[[CGEAppDelegate sharedAppDelegate] hideActivity:self];
	}];
}

- (void) locationManager:(CLLocationManager*) manager didUpdateToLocation:(CLLocation*) newLocation fromLocation:(CLLocation*) oldLocation {
    [self.locationManager stopUpdatingLocation];
    
    if ([self.queue operationCount] == 0) {
        [self loadPlaces];
    }
}

- (void) locationManager:(CLLocationManager*) manager didFailWithError:(NSError*) error {
	NSLog(@"error=%@", error);
	UIAlertView* alert = [[[UIAlertView alloc] initWithTitle:@"Location Error" message:[error localizedDescription] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil] autorelease];
	[alert show];
}


- (CGEPlacesViewController*) initWithWhere:(NSString*)where andWithWhat:(NSString *)what{
    self = [super initWithNibName:@"CGEPlaces" bundle:nil];
    
    if(self){
        self.where = where;
        self.what = what;
        where = nil;
        what = nil;
    }
    
    return self;
}


- (void) viewDidLoad {
	[super viewDidLoad];
	self.title = @"Places";
	self.queue = [[[NSOperationQueue alloc] init] autorelease];
	
	self.locationManager = [[[CLLocationManager alloc] init] autorelease];
	self.locationManager.delegate = self;
	[self.locationManager startUpdatingLocation];
}

- (NSInteger) numberOfSectionsInTableView:(UITableView*) tableView {
	return 1;
}

- (NSInteger) tableView:(UITableView*) tableView numberOfRowsInSection:(NSInteger) section {
	return [self.places count];
}

- (UITableViewCell*) tableView:(UITableView*) tableView cellForRowAtIndexPath:(NSIndexPath*) indexPath {
    static NSString* CellIdentifier = @"PlaceCell";
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
	if ([self.places count] > indexPath.row) {
		CGPlacesSearchLocation* place = [self.places objectAtIndex:indexPath.row];
		cell.textLabel.text = place.name;
		cell.detailTextLabel.text = place.tagline ? place.tagline : place.neighborhood;
	} else {
		cell.textLabel.text = nil;
		cell.detailTextLabel.text = nil;
	}
	
    return cell;
}

- (void) tableView:(UITableView*) tableView didSelectRowAtIndexPath:(NSIndexPath*) indexPath {
	if ([self.places count] > indexPath.row) {
        CGPlacesSearchLocation* place = [self.places objectAtIndex:indexPath.row];

        CGEPlaceViewController* detailView = [[CGEPlaceViewController alloc] initWithLocationId:place.locationId andWithPublicId: place.publicId andWithIp:self.clientIp andWithRawWhat:self.what];
        [self.navigationController pushViewController:detailView animated:YES];
        [detailView release];
	}
}


- (void) viewDidUnload {

    [super viewDidUnload];
}

- (void) dealloc {
    [self.locationManager stopUpdatingLocation];
	[self.queue cancelAllOperations];
	self.queue = nil;
	self.locationManager = nil;
	[places_ release];
    [clientIp_ release];
}

@end
