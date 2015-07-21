//
//  GullHttpServer.m
//  GullHttpServer
//
//  Created by Yoshioka Tsuneo on 2/11/14.
//  Copyright (c) 2014 Yoshioka Tsuneo. All rights reserved.
//

#import "GullHttpServer.h"
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>

@interface GullHttpServer ()
{
    int listen_sock;
}
@end

@implementation GullHttpServer
- (id)initWithHost:(NSString*)host port:(int)port
{
    self = [super init];
    if (self) {
        
        listen_sock = socket(AF_INET, SOCK_STREAM, 0);
        if(listen_sock == -1){
            fprintf(stderr, "socket error:%d(%s)", errno, strerror(errno));
            return nil;
        }

        int ret ;
        int val = 1;
        ret = setsockopt(listen_sock, SOL_SOCKET, SO_REUSEADDR, &val, sizeof(val));
        if(ret == -1){
            fprintf(stderr, "setsockopt(SO_REUSEADDR) error:%d(%s)", errno, strerror(errno));
            return nil;
        }
        
        struct sockaddr_in sin;
        sin.sin_family = AF_INET;
        sin.sin_addr.s_addr = inet_addr(host.UTF8String);
        sin.sin_len = sizeof(sin);
        sin.sin_port = htons(port);
        
        ret =bind(listen_sock, (struct sockaddr*)&sin, sizeof(sin));
        if(ret == -1){
            fprintf(stderr, "bind error:%d(%s)", errno, strerror(errno));
            return nil;
        }
        
        ret = listen(listen_sock, 5);
        if(ret == -1){
            fprintf(stderr, "listen error:%d(%s)", errno, strerror(errno));
            return nil;
        }
    }
    return self;
}

-(void)run
{
    while(true){
        @autoreleasepool {
            struct sockaddr_storage sin;
            unsigned int sin_len = sizeof(sin);
            int as = accept(listen_sock, (struct sockaddr*)&sin, &sin_len);
            if(as == -1){
                fprintf(stderr, "accept error:%d(%s)", errno, strerror(errno));
                return;
            }
            FILE *fp_r = fdopen(dup(as), "rb");
            FILE *fp_w = fdopen(dup(as), "wb");
            char buf[1024] = "";
            if(fgets(buf, sizeof(buf), fp_r)){
                char pathstr[1024] = "";
                sscanf(buf, "GET %1023s", pathstr);
                NSString *path = [NSString stringWithUTF8String:pathstr];
                self.currentURL = [[NSURL alloc] initWithScheme:@"http" host:@"localhost" path:path];
                NSString *objc_method_str = [[self.currentURL.path substringFromIndex:1] stringByReplacingOccurrencesOfString:@"/" withString:@"_"];
                SEL sel = NSSelectorFromString(objc_method_str);
                if([self respondsToSelector:sel]){
                    NSString *result = [self performSelector:sel];
                    fputs("HTTP/1.0 200 OK\r\n", fp_w);
                    fputs("\r\n", fp_w);
                    fputs(result.UTF8String, fp_w);
                }else{
                    fputs("HTTP/1.0 200 OK\r\n", fp_w);
                    fputs("\r\n", fp_w);
                    fprintf(fp_w, "No such method[%s] defined in this class.", path.UTF8String);
                }
            }
            fclose(fp_r);
            fclose(fp_w);
            close(as);
        }
    }
}
@end

