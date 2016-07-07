//
//  main.m
//  jsAlgorithm
//
//  Created by Lee Kyu-Won on 7/6/16.
//  Copyright © 2016 Lee Kyu-Won. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DuplicationDeleter.h"






int main(int argc, const char * argv[]) {
    @autoreleasepool {
        DuplicationDeleter *tester = [[DuplicationDeleter alloc]init];
        
        NSLog(@"programming => %@", [tester makeDuplicationOutOfString:@"programming"]);
        NSLog(@"hackerearth => %@", [tester makeDuplicationOutOfString:@"hackerearth"]);
    }
    return 0;
}
