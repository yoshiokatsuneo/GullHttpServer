//
//  main.m
//  GullHttpServer
//
//  Created by Yoshioka Tsuneo on 2/11/14.
//  Copyright (c) 2014 Yoshioka Tsuneo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MyGullHttpServer.h"

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        
        // insert code here...
        NSLog(@"Hello, World!");
        MyGullHttpServer *server = [[MyGullHttpServer alloc] initWithHost:@"127.0.0.1" port:12345];
        [server run];
    }
    return 0;
}

