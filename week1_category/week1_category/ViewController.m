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
  
/* from NSConnention
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
*/ // NSSession
    
    NSURL *URL = [NSURL URLWithString:original];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                            completionHandler:
                                  ^(NSData *data, NSURLResponse *response, NSError *error) {
                                      if (error)
                                      {
                                      }
                                      else
                                      {
                                          NSString *result = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
                                          //NSLog(@"%@", result);
                                          [self showAlertWithMessage:[result substringToIndex:200]];
                                      }
                                  }];
    
    [task resume];
    //more reference(1) - https://developer.apple.com/library/ios/documentation/Cocoa/Conceptual/URLLoadingSystem/URLLoadingSystem.html#//apple_ref/doc/uid/10000165i
    //(2) - https://www.objc.io/issues/5-ios7/from-nsurlconnection-to-nsurlsession/
    
}


- (IBAction)getKorean:(id)sender {
    NSString *longOriginal = @"http://www.osxdev.org/forum/index.php?threads/swift-2-0에서-try-catch로-fatal-error-잡을-수-있나요.382/" ;
    NSLog(@"%@", [longOriginal koreanWordsFromOneString]);
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)showAlertWithMessage:(NSString*)message{
    dispatch_async(dispatch_get_main_queue(), ^{
        /* deprecated
        [[[UIAlertView alloc] initWithTitle:@"Result data"
                                    message:message
                                   delegate:nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil, nil] show];
         */
       UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Result Data"
                                                                                        message:message
                                                                                        preferredStyle:1];
        [alert addAction:[UIAlertAction actionWithTitle:@"Done" style:0 handler:^(UIAlertAction * _Nonnull action) {}]];
        [self presentViewController:alert animated:YES completion:nil];
        
    });
}

@end
