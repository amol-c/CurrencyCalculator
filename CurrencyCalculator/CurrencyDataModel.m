//
//  CurrencyDataModel.m
//  CurrencyCalculator
//
//  Created by Amol Chaudhari on 5/19/14.
//  Copyright (c) 2014 Amol Chaudhari. All rights reserved.
//

#import "CurrencyDataModel.h"

@interface CurrencyDataModel ()


@end

@implementation CurrencyDataModel

#pragma mark Singleton accessor
+(CurrencyDataModel*)sharedModel {

    static CurrencyDataModel *_sharedInstance = nil;
    static dispatch_once_t oncePredicate;
    
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[CurrencyDataModel alloc] init];
    });
    return _sharedInstance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _allRecentCurrencyData = [[NSMutableDictionary alloc]init];
    }
    return self;
}


#pragma mark Setters
-(void)setRecentUkPounds:(float)recentUkPounds {
    //if (_recentUkPounds != recentUkPounds) {
        _recentUkPounds=recentUkPounds;
        NSNumber *numberFormat = [NSNumber numberWithFloat:recentUkPounds];
    
        [self willChangeValueForKey:@"allRecentCurrencyData"];
        [self.allRecentCurrencyData setValue:numberFormat forKey:@"recentUkPounds"];
        [self didChangeValueForKey:@"allRecentCurrencyData"];
   // }
}

-(void)setRecentJapanYen:(float)recentJapanYen {
   // if (_recentJapanYen != recentJapanYen) {
        _recentJapanYen=recentJapanYen;
        NSNumber *numberFormat = [NSNumber numberWithFloat:_recentJapanYen];
    
        [self willChangeValueForKey:@"allRecentCurrencyData"];
        [self.allRecentCurrencyData setValue:numberFormat forKey:@"recentJapanYen"];
        [self didChangeValueForKey:@"allRecentCurrencyData"];

   // }
}

-(void)setRecentEuEuro:(float)recentEuEuro {
  //  if (_recentEuEuro != recentEuEuro) {
        _recentEuEuro=recentEuEuro;
        NSNumber *numberFormat = [NSNumber numberWithFloat:_recentEuEuro];
    
        [self willChangeValueForKey:@"allRecentCurrencyData"];
        [self.allRecentCurrencyData setValue:numberFormat forKey:@"recentEuEuro"];
        [self didChangeValueForKey:@"allRecentCurrencyData"];

  //  }
}

-(void)setRecentBrazilReals:(float)recentBrazilReals {
    //if (_recentBrazilReals != recentBrazilReals) {
        _recentBrazilReals=recentBrazilReals;
        NSNumber *numberFormat = [NSNumber numberWithFloat:_recentBrazilReals];
        
        [self willChangeValueForKey:@"allRecentCurrencyData"];
        [self.allRecentCurrencyData setValue:numberFormat forKey:@"recentBrazilReals"];
        [self didChangeValueForKey:@"allRecentCurrencyData"];

  //  }

}

@end
