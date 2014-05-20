//
//  NetworkingFactory.h
//  CurrencyCalculator
//
//  Created by Amol Chaudhari on 5/19/14.
//  Copyright (c) 2014 Amol Chaudhari. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ConnectionHandler.h"
@interface ConnectionFactory : NSObject

+(ConnectionHandler *)createConnectionWithCurrencyType:(CurrencyType)currencyType;

@end
