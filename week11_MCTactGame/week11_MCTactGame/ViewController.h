//
//  ViewController.h
//  week11_MCTactGame
//
//  Created by Lee Kyu-Won on 8/24/16.
//  Copyright © 2016 Lee Kyu-Won. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SessionContainer.h"

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *myPoint;
@property (retain, nonatomic) SessionContainer *sessionContainer;
@property(weak,nonatomic)MCBrowserViewController *browserViewController;
@property int myPointInt;

- (void)createSession;


@end

