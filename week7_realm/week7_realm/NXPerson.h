//
//  NXPerson.h
//  week7_realm
//
//  Created by Lee Kyu-Won on 10/4/16.
//  Copyright © 2016 Lee Kyu-Won. All rights reserved.
//

#import <Realm/Realm.h>

@interface NXPerson : RLMObject
@property int age;
@property NSString* name;

@end
