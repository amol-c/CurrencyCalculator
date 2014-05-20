//
//  CurrencyDataModel.h
//  CurrencyCalculator
//
//  Created by Amol Chaudhari on 5/19/14.
//  Copyright (c) 2014 Amol Chaudhari. All rights reserved.
//

#import <Foundation/Foundation.h>

//This is a Singleton.

@interface CurrencyDataModel : NSObject

@property(nonatomic)float recentUkPounds;
@property(nonatomic)float recentEuEuro;
@property(nonatomic)float recentJapanYen;
@property(nonatomic)float recentBrazilReals;

//Use KVO on allRecentCurrencyData to get all the changes
@property(nonatomic,strong)NSMutableDictionary *allRecentCurrencyData;


//Access data through sharedModel.
+(CurrencyDataModel*)sharedModel;
@end
