//
//  NetworkingFactory.h
//  CurrencyCalculator
//
//  Created by Amol Chaudhari on 5/19/14.
//  Copyright (c) 2014 Amol Chaudhari. All rights reserved.
//


//ConnectionFactory decoupling the ConnectionHandler and the caller. Also, implements Dependency injection using protocols instead of concrete class to accomodate any future changes to the api.

#import <Foundation/Foundation.h>
#import "CCConnectionProtocol.h"
@interface CCConnectionFactory : NSObject

+(id<CCConnectionProtocol>)createConnectionWithCurrencyType:(CurrencyType)currencyType;

@end
