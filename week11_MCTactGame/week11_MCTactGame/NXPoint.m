//
//  NXPoint.m
//  week11_MCTactGame
//
//  Created by Lee Kyu-Won on 8/24/16.
//  Copyright © 2016 Lee Kyu-Won. All rights reserved.
//

#import "NXPoint.h"

@implementation NXPoint

// Designated initializer
- (id)initWithPeerID:(MCPeerID *)peerID direction:(PointDirection)direction{
    if (self = [super init]) {
        _peerID = peerID;
        _direction = direction;
    }
    return self;
}

@end
