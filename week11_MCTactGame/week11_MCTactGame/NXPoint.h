//
//  NXPoint.h
//  week11_MCTactGame
//
//  Created by Lee Kyu-Won on 8/24/16.
//  Copyright © 2016 Lee Kyu-Won. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MCPeerID;

// Enumeration of transcript directions
typedef enum {
    POINT_DIRECTION_SEND = 0,
    POINT_DIRECTION_RECEIVE,
    POINT_DIRECTION_LOCAL // for admin messages. i.e. "<name> connected"
} PointDirection;

@interface NXPoint : NSObject

@property (readonly, nonatomic) PointDirection direction;
// PeerID of the sender
@property (readonly, nonatomic) MCPeerID *peerID;

// Initializer used for sent/received messages
- (id)initWithPeerID:(MCPeerID *)peerID direction:(PointDirection)direction;


@end
