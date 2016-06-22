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
    NSArray *compo = [self componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"/-.:"]];
    NSLog(@"%@", compo);
    NSMutableArray *korean = [[NSMutableArray alloc] init];
    
    NSEnumerator *enumerator = [compo objectEnumerator];
   id object;

// '\U'로 읽기는 실패.
//
//    const char slash = '\\';
//    const char uuu = 'U';
//    
//    NSString *uniPrefix = [NSString stringWithFormat:@"%c%c", slash ,uuu ];
//    NSLog(@"%@", uniPrefix);
    
    
    while ((object = [enumerator nextObject])) {
        NSUInteger length = [object length];
        for(int i =0 ; i < length ; i++ ) {
            unichar curUni = [object characterAtIndex:i];
            if(curUni < 44032 || curUni > 55215){
                
            }
        }
    
    }

    return korean;
    
}


@end
