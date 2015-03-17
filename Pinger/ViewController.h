//
//  ViewController.h
//  Pinger
//
//  Created by MAC on 15/3/12.
//  Copyright (c) 2015年 SaiDiCaprio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SimplePing.h"
#define PING_TIMES 5
#define PING_TIME_INTERVAL 2

@interface ViewController : UIViewController <SimplePingDelegate>
{
    SimplePing *_pinger;
    NSDate *_startDate; // If the Pinger is started
    BOOL _isStarted;
    NSTimer *_timer;
    NSInteger _count; // The count of sent packets.
}

@property (weak, nonatomic) IBOutlet UITextField *address;
@property (weak, nonatomic) IBOutlet UIButton *btn;
@property (weak, nonatomic) IBOutlet UITextView *result;

- (IBAction)ping:(id)sender;

@end

