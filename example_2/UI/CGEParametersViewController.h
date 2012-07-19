//
//  CGEParametersViewController.h
//  CityGridExample
//
//  Created by Christophe Vong on 8/29/11.
//  Copyright 2011 CityGrid Media. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGEPlacesViewController.h"
#import "CGEReviewsViewController.h"
#import "CGESearchType.h"

@interface CGEParametersViewController : UIViewController {
    IBOutlet UITextField* whereTextField;
    IBOutlet UITextField* whatTextField;
}

@property (nonatomic, retain) IBOutlet UITextField* whereTextField;
@property (nonatomic, retain) IBOutlet UITextField* whatTextField;

- (IBAction) validate;
-(BOOL)textFieldShouldReturn:(UITextField *)textField;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andSearchType:(CGSearchType) searchType;

@end
