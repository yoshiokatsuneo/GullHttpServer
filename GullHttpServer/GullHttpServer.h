//
//  GullHttpServer.h
//  GullHttpServer
//
//  Created by Yoshioka Tsuneo on 2/11/14.
//  Copyright (c) 2014 Yoshioka Tsuneo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GullHttpServer : NSObject
- (id)initWithHost:(NSString*)host port:(int)port;
-(void)run;

@property NSURL *currentURL;
@end
