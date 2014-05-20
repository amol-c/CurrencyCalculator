//
//  ConnectionHandler.h
//  CurrencyCalculator
//
//  Created by Amol Chaudhari on 5/19/14.
//  Copyright (c) 2014 Amol Chaudhari. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, CurrencyType) {
    UKPounds,
    Euro,
    JapanYen,
    BrazilReal
};

@interface ConnectionHandler : NSObject
@property(nonatomic,readonly)CurrencyType currencyType;

-(id)initWithCurrencyType:(CurrencyType)currencyType;
-(void)refreshDataWithQuantity:(int)quantity;

@end
