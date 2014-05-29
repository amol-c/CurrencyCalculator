//
//  CCDataModelProtocol.h
//  CurrencyCalculator
//
//  Created by Amol Chaudhari on 5/29/14.
//  Copyright (c) 2014 Amol Chaudhari. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CCDataModelProtocol <NSObject>

@property(nonatomic)float recentUkPounds;
@property(nonatomic)float recentEuEuro;
@property(nonatomic)float recentJapanYen;
@property(nonatomic)float recentBrazilReals;

@property(nonatomic,strong)NSMutableDictionary *allRecentCurrencyData;

@end
