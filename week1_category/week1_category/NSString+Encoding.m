//
//  NSString+Encoding.m
//  week1_category
//
//  Created by Lee Kyu-Won on 6/22/16.
//  Copyright © 2016 Lee Kyu-Won. All rights reserved.
//

#import "NSString+Encoding.h"

@implementation NSString (Encoding)

-(NSString*)urlEncode{
    
    return (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL,
                                                                                 (CFStringRef)self,
                                                                                 NULL,
                                                                                 (CFStringRef)@"!*'\"();:@&=+$,/?%#[]% ",
                                                                                 CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding)));
    
    //reference - https://madebymany.com/blog/url-encoding-an-nsstring-on-ios
}


-(NSArray*)koreanWords{
    NSArray *compo = [[self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"/-.\\"]];
    //NSLog(@"%@", compo);
    NSMutableArray *korean = [[NSMutableArray alloc] init];
    
    NSEnumerator *enumerator = [compo objectEnumerator];
   id object;

/*'\U'로 읽기는 실패.

    const char slash = '\\';
    const char uuu = 'U';
    
    NSString *uniPrefix = [NSString stringWithFormat:@"%c%c", slash ,uuu ];
    NSLog(@"%@", uniPrefix);
*/
    
    while ((object = [enumerator nextObject])) {
        if([object  isEqual: @""]) continue;
        NSMutableString *buffer = [[NSMutableString alloc]init];
        NSUInteger length = [object length];
        int lastIdx = 0;
        BOOL isFirstAppear = YES;
        
        for(int i = 0 ; i < length ; i++ ) {
            unichar curUni = [object characterAtIndex:i];
            if(curUni >= 44032 && curUni <= 55215){
                NSString *unicharString = [NSString stringWithCharacters:&curUni length:2];
                if(isFirstAppear == YES){
                    isFirstAppear = NO;
                    lastIdx = i;
                    buffer = [unicharString mutableCopy];
                } else if(i - lastIdx <= 1){
                    [buffer appendString: unicharString];
                } else {
                    [korean addObject:buffer];
                    buffer = [unicharString mutableCopy];
                }
                lastIdx = i;
            }
        }
        if([buffer length] > 0) {
            [korean addObject:buffer];
        }
        
        isFirstAppear = YES;
        buffer = [@"" mutableCopy];
    }

    return korean;
    
}

-(NSArray*)koreanWordsFromOneString{
    
    NSMutableArray *korean = [[NSMutableArray alloc] init];
    NSUInteger length = [self length];
    
    NSMutableString *buffer = [[NSMutableString alloc]init];
    int lastIdx = 0;
    BOOL isFirstAppear = YES;
    
    for(int i = 0 ; i < length ; i++ ) {
        unichar curUni = [self characterAtIndex:i];
        if(curUni >= 44032 && curUni <= 55215){
            NSString *unicharString = [NSString stringWithCharacters:&curUni length:2];
            if(isFirstAppear == YES){
                isFirstAppear = NO;
                lastIdx = i;
                buffer = [unicharString mutableCopy];
            } else if(i - lastIdx <= 1){
                [buffer appendString: unicharString];
            } else {
                [korean addObject:buffer];
                buffer = [unicharString mutableCopy];
            }
            lastIdx = i;
        }
    }
    if([buffer length] > 0) {
        [korean addObject:buffer];
    }
    
    return korean;
    
}

@end
