//
//  WebViewController.m
//  MobileWebKitToolbox
//
//  Created by Justin D'Arcangelo on 4/24/12.
//  Copyright (c) 2012 None. All rights reserved.
//

#import "WebViewController.h"

@implementation WebViewController

@synthesize flipsidePopoverController = _flipsidePopoverController;
@synthesize isRemoteInspectorEnabled = _isRemoteInspectorEnabled;
@synthesize isWebGLEnabled = _isWebGLEnabled;
@synthesize webView = _webView;
@synthesize urlField = _urlField;
@synthesize activityIndicator = _activityIndicator;

- (void)enableRemoteInspector {
  [NSClassFromString(@"WebView") performSelector:@selector(_enableRemoteInspector)];
  _isRemoteInspectorEnabled = YES;
}

- (void)disableRemoteInspector {
  [NSClassFromString(@"WebView") performSelector:@selector(_disableRemoteInspector)];
  _isRemoteInspectorEnabled = NO;
}

- (void)enableWebGL {
  id browserView = [_webView performSelector:@selector(_browserView)];
  id webView = [browserView performSelector:@selector(webView)];
  
  [webView performSelector:@selector(_setWebGLEnabled:) withObject:[NSNumber numberWithBool:YES]];
  _isWebGLEnabled = YES;
}

- (void)disableWebGL {
  id browserView = [_webView performSelector:@selector(_browserView)];
  id webView = [browserView performSelector:@selector(webView)];
  
  [webView performSelector:@selector(_setWebGLEnabled:) withObject:[NSNumber numberWithBool:NO]];
  _isWebGLEnabled = NO;
}

- (IBAction)go:(id)sender {
  NSString *urlString = [_urlField text];
  NSRange httpRange = [urlString rangeOfString:@"http://"];
  NSRange httpsRange = [urlString rangeOfString:@"https://"];
  
  if (httpRange.location == NSNotFound && httpsRange.location == NSNotFound) urlString = [NSString stringWithFormat:@"http://%@", urlString];
  
  [_urlField setText:urlString];
  
  NSURL *url = [NSURL URLWithString:urlString];
  NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60];
  
  [_webView loadRequest:urlRequest];
}

- (IBAction)refresh:(id)sender {
  [_webView reload];
}

- (IBAction)showInfo:(id)sender {
  if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
    SettingsViewController *controller = [[SettingsViewController alloc] initWithNibName:@"SettingsViewController" bundle:nil];
    controller.delegate = self;
    controller.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    
    [self presentModalViewController:controller animated:YES];
  } else {
    if (!self.flipsidePopoverController) {
      SettingsViewController *controller = [[SettingsViewController alloc] initWithNibName:@"SettingsViewController" bundle:nil];
      controller.delegate = self;
      
      self.flipsidePopoverController = [[UIPopoverController alloc] initWithContentViewController:controller];
    }
    
    if ([self.flipsidePopoverController isPopoverVisible]) {
      [self.flipsidePopoverController dismissPopoverAnimated:YES];
    } else {
      [self.flipsidePopoverController presentPopoverFromBarButtonItem:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    }
  }
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
  if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
    _isRemoteInspectorEnabled = NO;
    _isWebGLEnabled = NO;
  }
  
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];
	
  // Do any additional setup after loading the view, typically from a nib.
  NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
  
  if ([userDefaults boolForKey:kUserDefaultsKeyRemoteInspector]) [self enableRemoteInspector];
  if ([userDefaults boolForKey:kUserDefaultsKeyWebGL]) [self enableWebGL];
}

- (void)viewDidUnload {
  [super viewDidUnload];
  
  // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
  if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
  } else {
    return YES;
  }
}

#pragma mark - UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
  if (navigationType != UIWebViewNavigationTypeOther) [_urlField setText:[[request URL] absoluteString]];
  
  return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
  [_activityIndicator startAnimating];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
  [_activityIndicator stopAnimating];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
  [_activityIndicator stopAnimating];
}

#pragma mark - SettingsViewControllerDelegate

- (void)settingsViewControllerDidFinish:(SettingsViewController *)controller {
  if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
    [self dismissModalViewControllerAnimated:YES];
  } else {
    [self.flipsidePopoverController dismissPopoverAnimated:YES];
  }
  
  NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
  [userDefaults setBool:_isRemoteInspectorEnabled forKey:kUserDefaultsKeyRemoteInspector];
  [userDefaults setBool:_isWebGLEnabled forKey:kUserDefaultsKeyWebGL];
  [userDefaults synchronize];
}

@end
