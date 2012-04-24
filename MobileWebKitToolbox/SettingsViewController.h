//
//  SettingsViewController.h
//  MobileWebKitToolbox
//
//  Created by Justin D'Arcangelo on 4/24/12.
//  Copyright (c) 2012 None. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AppDelegate.h"
#import "WebViewController.h"

#define kSettingsIndexPathRemoteInspector 0
#define kSettingsIndexPathWebGL           1

@class AppDelegate;
@class WebViewController;

@protocol SettingsViewControllerDelegate;

@interface SettingsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) AppDelegate *appDelegate;
@property (strong, nonatomic) WebViewController *webViewController;
@property (weak, nonatomic) id <SettingsViewControllerDelegate> delegate;
@property (strong, nonatomic) UISwitch *remoteInspectorSwitch;
@property (strong, nonatomic) UISwitch *webGLSwitch;

@property (strong, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)done:(id)sender;

@end

@protocol SettingsViewControllerDelegate

- (void)settingsViewControllerDidFinish:(SettingsViewController *)controller;

@end
