//
//  DuplicationDeleter.m
//  jsAlgorithm
//
//  Created by Lee Kyu-Won on 7/6/16.
//  Copyright © 2016 Lee Kyu-Won. All rights reserved.
//

#import "DuplicationDeleter.h"

@implementation DuplicationDeleter

-(NSString*)makeDuplicationOutOfString:(NSString*)input{
    int length = (int)input.length;
    NSMutableSet *set = [NSMutableSet set];
    NSMutableArray *result = [NSMutableArray array];
    
    for(int i = 0; i < length ; i++){
        NSString *newString = [input substringWithRange:NSMakeRange(i, 1)];
      //  NSLog(@" %d %@", i ,newString);
        NSMutableSet *thisTurnSet = [[NSMutableSet alloc]init];
        [thisTurnSet addObject:newString];
        //NSLog(@" set 1: %@",thisTurnSet);
        
        [thisTurnSet minusSet:set];
       // NSLog(@" set 2: %@",thisTurnSet);
        NSArray *intersectedSet = [thisTurnSet allObjects];
     //   NSLog(@"array : %@ count: %d", intersectedSet, intersectedSet.count);
        if([intersectedSet count] == 1){
       //     NSLog(@"YEs");
            [result addObject:newString];
            [set addObject:newString];
        }
    }
    
   // NSLog(@"The concatenated string is %@", result);

    NSMutableString * resultString = [[NSMutableString alloc] init];
    for (NSObject * obj in result)
    {
        if ([obj isKindOfClass:[NSString class]])
        {
            [resultString appendString: (NSString*)obj];

            // append something
        }
        else
        {
            
        }
    }
    
    
    
    
    return resultString;
}
@end

