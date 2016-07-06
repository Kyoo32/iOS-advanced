//
//  SmallViewController.h
//  week4_animation
//
//  Created by Lee Kyu-Won on 7/6/16.
//  Copyright © 2016 Lee Kyu-Won. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "lithuaniaTableViewController.h"

@interface SmallViewController : UIViewController

@property (weak,nonatomic)lithuaniaTableViewController* mother;
-(void)goBackToOrigin;
@end
