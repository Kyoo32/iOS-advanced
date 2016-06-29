//
//  SecondaryViewController.h
//  week2_xib&storyboard
//
//  Created by Lee Kyu-Won on 6/29/16.
//  Copyright © 2016 Lee Kyu-Won. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SecondaryViewController : UITableViewController <UIImagePickerControllerDelegate>

@property UIImagePickerController *imagePickerController;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end
