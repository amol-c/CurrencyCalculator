//
//  NetworkingFactory.m
//  CurrencyCalculator
//
//  Created by Amol Chaudhari on 5/19/14.
//  Copyright (c) 2014 Amol Chaudhari. All rights reserved.
//

#import "CCConnectionFactory.h"
#import "CCConnectionHandler.h"

@implementation CCConnectionFactory

#pragma mark Factory Method

+(id<CCConnectionProtocol>)createConnectionWithCurrencyType:(CurrencyType)currencyType{
    
    id<CCConnectionProtocol> connectionHandler = [[CCConnectionHandler alloc]initWithCurrencyType:currencyType];
    return connectionHandler;
}

@end
