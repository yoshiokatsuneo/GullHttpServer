//
//  MyGullHttpServer.m
//  GullHttpServer
//
//  Created by Yoshioka Tsuneo on 2/11/14.
//  Copyright (c) 2014 Yoshioka Tsuneo. All rights reserved.
//

#import "MyGullHttpServer.h"

@implementation MyGullHttpServer
/* to handle "/hello" request */
- (NSString*)hello
{
    return [NSString stringWithFormat:@"Nice to meet you! Your request URL is: %@, parameter:%@", self.currentURL, self.currentURL.query];
}
@end
