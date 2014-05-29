//
//  CCDataModelFactory.h
//  CurrencyCalculator
//
//  Created by Amol Chaudhari on 5/29/14.
//  Copyright (c) 2014 Amol Chaudhari. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCDataModelProtocol.h"

//Decouples CCCurencyDataModel from the Controller and uses Dependency injection to change the models behaviour for any future changes. Currently, CCCurrency utilizes KVO to update UI Changes. Multiple behaviour can be added to same model, incase, need to use Notifications or Delegates.

@interface CCDataModelFactory : NSObject

+(id<CCDataModelProtocol>)sharedDataModel;

@end
