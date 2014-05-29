//
//  CurrencyDataModel.h
//  CurrencyCalculator
//
//  Created by Amol Chaudhari on 5/19/14.
//  Copyright (c) 2014 Amol Chaudhari. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCDataModelProtocol.h"
//This is a Singleton.

@interface CCCurrencyDataModel : NSObject <CCDataModelProtocol>

//Access data through sharedModel.
+(CCCurrencyDataModel*)sharedModel;

//Implements usage of KVO on allRecentCurrencyData to get all the changes

@end
