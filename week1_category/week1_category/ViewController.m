//
//  ViewController.m
//  week1_category
//
//  Created by Lee Kyu-Won on 6/22/16.
//  Copyright © 2016 Lee Kyu-Won. All rights reserved.
//

#import "ViewController.h"
#import "NSString+Encoding.h"

@interface ViewController ()

@end

@implementation ViewController
- (IBAction)getData:(id)sender {
    NSString *original = @"http://www.osxdev.org/forum/index.php?threads/";
    NSString *param = @"ios8-에서-webgl-지원.356/";
    NSString *encoded = [param urlEncode];
    original = [original stringByAppendingString:encoded];
    NSLog(@" %@", original);
    
   
    NSURL *url = [NSURL URLWithString:original];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    NSOperationQueue *queue = [NSOperationQueue mainQueue];
    [NSURLConnection sendAsynchronousRequest:urlRequest queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
    {

        if (error)
        {
        }
        else
        {
            NSString *result = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
            NSLog(@"%@", result);
            [self showAlertWithMessage:result];
        }
    }];

    
}
- (IBAction)getKorean:(id)sender {
    NSString *longOriginal = @"http://www.osxdev.org/forum/index.php?threads/swift-2-0에서-try-catch-fatal-error-잡을-수-있나요.382/" ;
    
    NSLog(@"%@", [longOriginal koreanWords]);
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)showAlertWithMessage:(NSString*)message{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [[[UIAlertView alloc] initWithTitle:@"Result data"
                                    message:message
                                   delegate:nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil, nil] show];
        
    });
}

@end
