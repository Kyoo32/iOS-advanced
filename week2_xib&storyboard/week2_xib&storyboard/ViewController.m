//
//  ViewController.m
//  week2_xib&storyboard
//
//  Created by Lee Kyu-Won on 6/29/16.
//  Copyright © 2016 Lee Kyu-Won. All rights reserved.
//

#import "ViewController.h"
#import "SecondaryViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)goSecondStoryboard:(id)sender {
    UIStoryboard *second = [UIStoryboard storyboardWithName:@"Second" bundle:self.nibBundle];
    SecondaryViewController *newView = [second instantiateViewControllerWithIdentifier:@"columbia"];
    [self.navigationController pushViewController:newView animated: YES];
}
@end
