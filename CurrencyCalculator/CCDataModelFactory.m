//
//  CCDataModelFactory.m
//  CurrencyCalculator
//
//  Created by Amol Chaudhari on 5/29/14.
//  Copyright (c) 2014 Amol Chaudhari. All rights reserved.
//

#import "CCDataModelFactory.h"
#import "CCCurrencyDataModel.h"

@implementation CCDataModelFactory


+(id<CCDataModelProtocol>)sharedDataModel {
    id<CCDataModelProtocol> sharedModel = [CCCurrencyDataModel sharedModel];
    return sharedModel;
}


@end
