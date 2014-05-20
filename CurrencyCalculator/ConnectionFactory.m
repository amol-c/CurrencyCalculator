//
//  NetworkingFactory.m
//  CurrencyCalculator
//
//  Created by Amol Chaudhari on 5/19/14.
//  Copyright (c) 2014 Amol Chaudhari. All rights reserved.
//

#import "ConnectionFactory.h"

@implementation ConnectionFactory

#pragma mark Factory Method

+(ConnectionHandler *)createConnectionWithCurrencyType:(CurrencyType)currencyType{
    
    ConnectionHandler *connectionHandler = [[ConnectionHandler alloc]initWithCurrencyType:currencyType];
    return connectionHandler;
}

@end
