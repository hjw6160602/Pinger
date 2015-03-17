//
//  PingUrl.h
//  Ping
//
//  Created by MAC on 15/3/12.
//  Copyright (c) 2015年 SaiDiCaprio. All rights reserved.
//

#import <Foundation/Foundation.h>
#include "NSString+URLEncoding.h"

@protocol responseDelegate
@optional
- (void) onResponseResult:(NSString*)errorID Data:(NSData*) Data;
- (void) onResponseXml:(NSString*) XmlString;
@end

@interface PingUrl : NSObject

@property (strong, nonatomic) NSMutableURLRequest* request;
@property (strong,nonatomic) NSTimer* myTimer;
@property(assign,nonatomic) BOOL isOvertime;
@property(assign,nonatomic) int returnInt;

- (void) Ping:(NSString *)strURL;
@end
