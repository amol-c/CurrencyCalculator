//
//  CCConnectionProtocol.h
//  CurrencyCalculator
//
//  Created by Amol Chaudhari on 5/29/14.
//  Copyright (c) 2014 Amol Chaudhari. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, CurrencyType) {
    UKPoundsModeDefault,
    EuroMode,
    JapanYenMode,
    BrazilRealMode
};

@protocol CCConnectionProtocol <NSObject>

@property(nonatomic,readonly)CurrencyType currencyType;

-(id)initWithCurrencyType:(CurrencyType)currencyType;
-(void)willRefreshDataWithQuantity:(int)quantity;

@end
