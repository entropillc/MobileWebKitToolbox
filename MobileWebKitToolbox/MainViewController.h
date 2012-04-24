//
//  MainViewController.h
//  MobileWebKitToolbox
//
//  Created by Justin D'Arcangelo on 4/24/12.
//  Copyright (c) 2012 None. All rights reserved.
//

#import "FlipsideViewController.h"

@interface MainViewController : UIViewController <FlipsideViewControllerDelegate>

@property (strong, nonatomic) UIPopoverController *flipsidePopoverController;

- (IBAction)showInfo:(id)sender;

@end
