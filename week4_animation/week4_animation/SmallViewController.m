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
    
    UIImageView *lithuaniaView =[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 375 , 100)];
    lithuaniaView.contentMode = UIViewContentModeScaleAspectFill;
    lithuaniaView.clipsToBounds = YES;
    UIImage *lithuania = [UIImage imageNamed:@"lithu.jpg"];
    lithuaniaView.image = lithuania;
    [self.view addSubview:lithuaniaView];

    float xPosition = self.view.frame.origin.x + self.view.frame.size.width/2 - 40;
    float yPosition = self.view.frame.origin.y + 30;
    UIButton *back = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [back setFrame:CGRectMake(xPosition,  yPosition, 80, 40)];
    [back setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [back setTitle: @"back" forState:UIControlStateNormal];
    [back addTarget:self action:@selector(goBackToOrigin) forControlEvents:UIControlEventTouchUpInside];
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
