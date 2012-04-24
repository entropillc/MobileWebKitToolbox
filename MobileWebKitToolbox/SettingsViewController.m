//
//  SettingsViewController.m
//  MobileWebKitToolbox
//
//  Created by Justin D'Arcangelo on 4/24/12.
//  Copyright (c) 2012 None. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController()

- (void)remoteInspectorSwitchDidChange:(id)sender;
- (void)webGLSwitchDidChange:(id)sender;

@end

@implementation SettingsViewController

@synthesize appDelegate = _appDelegate;
@synthesize webViewController = _webViewController;
@synthesize delegate = _delegate;
@synthesize remoteInspectorSwitch = _remoteInspectorSwitch;
@synthesize webGLSwitch = _webGLSwitch;
@synthesize tableView = _tableView;

- (void)remoteInspectorSwitchDidChange:(id)sender {
  if ([_remoteInspectorSwitch isOn]) {
    [_webViewController enableRemoteInspector];
  } else {
    [_webViewController disableRemoteInspector];
  }
  
  [_tableView reloadData];
}

- (void)webGLSwitchDidChange:(id)sender {
  if ([_webGLSwitch isOn]) {
    [_webViewController enableWebGL];
  } else {
    [_webViewController disableWebGL];
  }
  
  [_tableView reloadData];
}

- (IBAction)done:(id)sender {
  [self.delegate settingsViewControllerDidFinish:self];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
  if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
    self.contentSizeForViewInPopover = CGSizeMake(320.0, 480.0);
    
    _appDelegate = [[UIApplication sharedApplication] delegate];
    _webViewController = [_appDelegate webViewController];
    
    _remoteInspectorSwitch = [[UISwitch alloc] initWithFrame:CGRectZero];
    [_remoteInspectorSwitch setOn:[_webViewController isRemoteInspectorEnabled]];
    [_remoteInspectorSwitch addTarget:self action:@selector(remoteInspectorSwitchDidChange:) forControlEvents:UIControlEventValueChanged];
    
    _webGLSwitch = [[UISwitch alloc] initWithFrame:CGRectZero];
    [_webGLSwitch setOn:[_webViewController isWebGLEnabled]];
    [_webGLSwitch addTarget:self action:@selector(webGLSwitchDidChange:) forControlEvents:UIControlEventValueChanged];
  }
  
  return self;
}
							
- (void)viewDidLoad {
  [super viewDidLoad];
	
  // Do any additional setup after loading the view, typically from a nib.
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

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  
  // Return the number of sections.
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  
  // Return the number of rows in the section.
  return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  static NSString *CellIdentifier = @"Cell";
  
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
  if (cell == nil) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
  }
  
  switch (indexPath.row) {
    case kSettingsIndexPathRemoteInspector:
      cell.textLabel.text = @"Remote Inspector";
      cell.detailTextLabel.text = [_remoteInspectorSwitch isOn] ? @"Enabled on Port: 9999" : @"Disabled";
      cell.accessoryView = _remoteInspectorSwitch;
      break;
    case kSettingsIndexPathWebGL:
      cell.textLabel.text = @"WebGL";
      cell.detailTextLabel.text = [_webGLSwitch isOn] ? @"Enabled" : @"Disabled";
      cell.accessoryView = _webGLSwitch;
      break;
    default:
      break;
  }
  
  return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {

  // Return NO if you do not want the specified item to be editable.
  return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
  if (editingStyle == UITableViewCellEditingStyleDelete) {
    // Delete the row from the data source
    [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
  }

  else if (editingStyle == UITableViewCellEditingStyleInsert) {
    // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
  }
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {

}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {

  // Return NO if you do not want the item to be re-orderable.
  return YES;
}
*/

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  
}

@end
