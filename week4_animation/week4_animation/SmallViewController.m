//
//  SmallViewController.m
//  week4_animation
//
//  Created by Lee Kyu-Won on 7/6/16.
//  Copyright © 2016 Lee Kyu-Won. All rights reserved.
//

#import "SmallViewController.h"
#import "lithuaniaTableViewController.h"

@interface SmallViewController ()

@end

@implementation SmallViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //NSLog(@" hello ");
    
    
    UIImageView *lithuaniaView =[[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y , self.view.frame.size.width, self.view.frame.size.height)];
    lithuaniaView.contentMode = UIViewContentModeScaleAspectFit;
    //lithuaniaView.contentMode = UIViewContentModeScaleAspectFit;
    lithuaniaView.image = [UIImage imageNamed:@"lithu.jpg"];
    [self.view addSubview:lithuaniaView];

    float width = self.view.bounds.origin.x + (self.view.frame.size.width / 2) - 40;
    float height = self.view.bounds.origin.y + (self.view.frame.size.height / 2) - 20;
    UIButton *back = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [back setFrame:CGRectMake(self.view.bounds.origin.x + 10,  self.view.bounds.origin.y + 30, 80, 40)];
    [back setTitle: @"back" forState:UIControlStateNormal];
    [back addTarget:self action:@selector(goBackToOrigin) forControlEvents:UIControlEventTouchUpInside];
    //[back setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:back];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)goBackToOrigin{
    _mother.presenting = NO;
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
