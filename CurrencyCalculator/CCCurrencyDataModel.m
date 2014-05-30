//
//  CurrencyDataModel.m
//  CurrencyCalculator
//
//  Created by Amol Chaudhari on 5/19/14.
//  Copyright (c) 2014 Amol Chaudhari. All rights reserved.
//

#import "CCCurrencyDataModel.h"

@interface CCCurrencyDataModel () {

}


@end

@implementation CCCurrencyDataModel
@synthesize recentUkPounds=_recentUkPounds;
@synthesize recentEuEuro=_recentEuEuro;
@synthesize recentBrazilReals=_recentBrazilReals;
@synthesize recentJapanYen=_recentJapanYen;
@synthesize allRecentCurrencyData=_allRecentCurrencyData;

#pragma mark Singleton accessor
+(CCCurrencyDataModel*)sharedModel {

    static CCCurrencyDataModel *_sharedInstance = nil;
    static dispatch_once_t oncePredicate;
    
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[CCCurrencyDataModel alloc] init];
    });
    return _sharedInstance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.allRecentCurrencyData = [[NSMutableDictionary alloc]init];
    }
    return self;
}


#pragma mark Setters
-(void)setRecentUkPounds:(float)recentUkPounds {
    if (_recentUkPounds != recentUkPounds) {
        _recentUkPounds=recentUkPounds;
        NSNumber *numberFormat = [NSNumber numberWithFloat:recentUkPounds];
        [self.allRecentCurrencyData setValue:numberFormat forKey:@"recentUkPounds"];
    }
}

-(void)setRecentJapanYen:(float)recentJapanYen {
    if (_recentJapanYen != recentJapanYen) {
        _recentJapanYen=recentJapanYen;
        
        NSNumber *numberFormat = [NSNumber numberWithFloat:_recentJapanYen];
        [self.allRecentCurrencyData setValue:numberFormat forKey:@"recentJapanYen"];
    }
}

-(void)setRecentEuEuro:(float)recentEuEuro {
    if (_recentEuEuro != recentEuEuro) {
        _recentEuEuro=recentEuEuro;
        NSNumber *numberFormat = [NSNumber numberWithFloat:_recentEuEuro];
        [self.allRecentCurrencyData setValue:numberFormat forKey:@"recentEuEuro"];
        }


}

-(void)setRecentBrazilReals:(float)recentBrazilReals {
    if (_recentBrazilReals != recentBrazilReals) {
        _recentBrazilReals=recentBrazilReals;
        NSNumber *numberFormat = [NSNumber numberWithFloat:_recentBrazilReals];
        [self.allRecentCurrencyData setValue:numberFormat forKey:@"recentBrazilReals"];
    }
}

#pragma mark override
+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key
{
    NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
    
    if ([key isEqualToString:@"allRecentCurrencyData"]) {
        NSArray *affectingKeys = @[@"recentBrazilReals", @"recentEuEuro",@"recentUkPounds",@"recentJapanYen"];
        keyPaths = [keyPaths setByAddingObjectsFromArray:affectingKeys];
    }
    return keyPaths;
}



@end
