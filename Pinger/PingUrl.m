//
//  PingUrl.m
//  Ping
//
//  Created by MAC on 15/3/12.
//  Copyright (c) 2015年 SaiDiCaprio. All rights reserved.
//

#import "PingUrl.h"

@implementation PingUrl 

- (void) Ping:(NSString *)strURL{
    _isOvertime = YES;
    NSURL *url = [NSURL URLWithString:[strURL URLEncodedString]];
     _request = [[NSMutableURLRequest alloc] initWithURL:url];
    [_request setHTTPMethod:@"POST"];
    [_request setValue:@"application/json;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];  //设置头文件类型
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:_request delegate:self];
    if(connection)
        NSLog(@"异步请求成功");
    //_myTimer = [NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(timerFired) userInfo:nil repeats:NO];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    _returnInt = 1;
    _isOvertime = NO;
   // NSLog(@"%d,%hhd",_returnInt,_isOvertime);
}

@end