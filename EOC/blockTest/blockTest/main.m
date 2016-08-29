//
//  main.m
//  blockTest
//
//  Created by Lee Kyu-Won on 8/28/16.
//  Copyright © 2016 Lee Kyu-Won. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        //1
        int (^addBlock)(int a, int b) = ^(int a, int b){
            return a + b;
        };
        
        int add = addBlock(2,5);
        NSLog(@"1 : %d", add); // 7
        
        //2
        int additional = 5;
        int (^addBlock2)(int a, int b) = ^(int a, int b){
            return a + b + additional;
        };
        
        int add2 = addBlock2(2,5);
        NSLog(@"2 : %d", add2); // 12
        
        //3
        int test = 3;
        void (^testBlock)() = ^{
            NSLog(@"3 : test value is %d", test);
        };
        test = 5;
        
        testBlock(); // 3
        
        //4
        NSDictionary *dict = [[NSDictionary alloc]init];
        void (^testBlock2)() = ^{
            NSLog(@"4 : test value is %@", dict);
        };
        [dict release];
        
        testBlock2(); // {}
        
        //5
        __block int testValue = 5;
        void (^testBlock3)() = ^{
            testValue = testValue + 5;
            NSLog(@"5 : test value is %d", testValue);
        };
        testValue = 1;
        
        testBlock3(); // 6
        
        //6
        NSArray *array = @[@1, @2, @3, @4, @5];
        __block NSInteger count = 0;
        [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if( [obj compare:@2] == NSOrderedAscending){
                count++;
            }
        }];
        NSLog(@"6 : %ld", (long)count); // 1
    }
    return 0;
}
