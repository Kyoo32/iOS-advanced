//
//  ViewController.m
//  week11_MCTactGame
//
//  Created by Lee Kyu-Won on 8/24/16.
//  Copyright © 2016 Lee Kyu-Won. All rights reserved.
//
@import MultipeerConnectivity;

#import "ViewController.h"

NSString *const kNXDefaultDisplayName = @"kyoo";
NSString *const kNXDefaultServiceType = @"nextios";

@interface ViewController()<SessionContainerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = kNXDefaultDisplayName;
    self.myPoint.text = @"0";
    self.myPointInt = 0;
    [self createSession];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBAction methods

// Action method when pressing the "browse" (search icon).  It presents the MCBrowserViewController: a framework UI which enables users to invite and connect to other peers with the same room name (aka service type).
- (IBAction)browseForPeers:(id)sender
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
    
    // Instantiate and present the MCBrowserViewController
   MCBrowserViewController *browserViewController = [[MCBrowserViewController alloc] initWithServiceType:kNXDefaultServiceType session:self.sessionContainer.session];
    browserViewController.delegate = self;
    browserViewController.minimumNumberOfPeers = kMCSessionMinimumNumberOfPeers;
    browserViewController.maximumNumberOfPeers = kMCSessionMaximumNumberOfPeers;
    
    [self presentViewController:browserViewController animated:YES completion:nil];
}

- (IBAction)sendPlus:(id)sender {
    [_sessionContainer sendPoint:@"+"];
}
- (IBAction)sendMinus:(id)sender {
    _myPointInt--;
    dispatch_async(dispatch_get_main_queue(), ^{
        self.myPoint.text = [NSString stringWithFormat:@"%d", self.myPointInt];
    });
    
}

#pragma mark - SessionContainerDelegate
- (void)receivedPoint:(NXPoint *)Point
{
    self.myPointInt++;
    // Add to table view data source and update on main thread
    dispatch_async(dispatch_get_main_queue(), ^{
        self.myPoint.text = [NSString stringWithFormat:@"%d", self.myPointInt];
    });
}

#pragma mark - MCBrowserViewControllerDelegate methods
 
// Override this method to filter out peers based on application specific needs
- (BOOL)browserViewController:(MCBrowserViewController *)browserViewController shouldPresentNearbyPeer:(MCPeerID *)peerID withDiscoveryInfo:(NSDictionary *)info
{
    return YES;
}

// Override this to know when the user has pressed the "done" button in the MCBrowserViewController
- (void)browserViewControllerDidFinish:(MCBrowserViewController *)browserViewController
{
    [browserViewController dismissViewControllerAnimated:YES completion:nil];
}

// Override this to know when the user has pressed the "cancel" button in the MCBrowserViewController
- (void)browserViewControllerWasCancelled:(MCBrowserViewController *)browserViewController
{
    [browserViewController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - private methods
    
// Private helper method for the Multipeer Connectivity local peerID, session, and advertiser.  This makes the application discoverable and ready to accept invitations
- (void)createSession{
    // Create the SessionContainer for managing session related functionality.
    self.sessionContainer = [[SessionContainer alloc] initWithDisplayName:kNXDefaultDisplayName serviceType:kNXDefaultServiceType];
    // Set this view controller as the SessionContainer delegate so we can display incoming Transcripts and session state changes in our table view.
    _sessionContainer.delegate = self;
}

    
@end

