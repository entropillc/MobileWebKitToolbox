//
//  WebViewController.h
//  MobileWebKitToolbox
//
//  Created by Justin D'Arcangelo on 4/24/12.
//  Copyright (c) 2012 None. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SettingsViewController.h"

#define kUserDefaultsKeyRemoteInspector @"co.entropi.mobilewebkittoolbox.remoteinspector"
#define kUserDefaultsKeyWebGL           @"co.entropi.mobilewebkittoolbox.webgl"

@class SettingsViewController;

@protocol SettingsViewControllerDelegate;

@interface WebViewController : UIViewController <UIWebViewDelegate, SettingsViewControllerDelegate>

@property (strong, nonatomic) UIPopoverController *flipsidePopoverController;

@property (nonatomic, readonly) BOOL isRemoteInspectorEnabled;
@property (nonatomic, readonly) BOOL isWebGLEnabled;

@property (strong, nonatomic) IBOutlet UIWebView *webView;
@property (strong, nonatomic) IBOutlet UITextField *urlField;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

- (void)enableRemoteInspector;
- (void)disableRemoteInspector;
- (void)enableWebGL;
- (void)disableWebGL;

- (IBAction)go:(id)sender;
- (IBAction)refresh:(id)sender;
- (IBAction)showInfo:(id)sender;

@end
