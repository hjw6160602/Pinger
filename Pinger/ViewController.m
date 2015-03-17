//
//  ViewController.m
//  Pinger
//
//  Created by MAC on 15/3/12.
//  Copyright (c) 2015年 SaiDiCaprio. All rights reserved.
//

#import "ViewController.h"
#import "SimplePing.h"

@implementation ViewController

- (void)viewDidLoad{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

- (IBAction)ping:(id)sender
{
    NSString *addr = _address.text;
    NSLog(@"地址为： %@", addr);
    
    if ([addr isEqualToString:@""]) return;
    
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
    [_result setText:nil];
    
    _pinger = [SimplePing simplePingWithHostName:addr];
    _pinger.delegate = self;
    
    //总共请求次数
    _count = PING_TIMES;
    
    //每隔几秒便请求一次
    _timer = [NSTimer scheduledTimerWithTimeInterval:PING_TIME_INTERVAL target:self selector:@selector(startPinger) userInfo:nil repeats:YES];
    [_timer fire];
}

- (void)startPinger
{
    assert(_pinger != nil);
    if (_isStarted) {
        [self stopPinger:@"请求超时！\n" terminal:NO];
    }
    [_pinger start];
    _isStarted = YES;
    
    _count -= 1;
    if (_count <= 0) {
        [_timer invalidate];
    }
}

- (void)stopPinger:(NSString *)reason terminal:(BOOL)terminal
{
    assert(_pinger != nil);
    
    if (!_isStarted){
        return;
    }
    
    [_pinger stop];
    _isStarted = NO;
    
    [self updateResult:reason];
    
    if (terminal) {
        [_timer invalidate];
    }
}

- (void)updateResult:(NSString *)Info
{
    NSString *str = [[NSString alloc] initWithString:Info];
    [_result setText:[_result.text stringByAppendingString:str]];
}

#pragma mark - Simple Ping Delegate
- (void)simplePing:(SimplePing *)pinger didStartWithAddress:(NSData *)address
{
    NSLog(@"发送数据");
    [_pinger sendPingWithData:nil];
}

- (void)simplePing:(SimplePing *)pinger didFailWithError:(NSError *)error
{
    NSLog(@"失败错误为：%@", error);
    [self stopPinger:@"发起Ping请求失败\n" terminal:YES];
}

- (void)simplePing:(SimplePing *)pinger didSendPacket:(NSData *)packet
{
    _startDate = [NSDate date];
    NSLog(@"数据包发送成功");
}

- (void)simplePing:(SimplePing *)pinger didFailToSendPacket:(NSData *)packet error:(NSError *)error
{
    NSLog(@"数据包包发送失败");
    [self stopPinger:@"请求包发送失败\n" terminal:NO];
}

- (void)simplePing:(SimplePing *)pinger didReceivePingResponsePacket:(NSData *)packet
{
    NSTimeInterval interval = [[NSDate date] timeIntervalSinceDate:_startDate];
    NSLog(@"服务器已在 %0.2lf ms 内响应", interval*1000);
    NSString *result = [[NSString alloc] initWithFormat:@"服务器已在 %0.2lf ms 内响应\n",interval*1000];
    [self stopPinger:result terminal:NO];
}

- (void)simplePing:(SimplePing *)pinger didReceiveUnexpectedPacket:(NSData *)packet
{
    NSLog(@"收到意外的数据包");
    [self stopPinger:@"收到意外的数据包\n" terminal:NO];
}
@end