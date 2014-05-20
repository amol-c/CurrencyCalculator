//
//  ConnectionHandler.m
//  CurrencyCalculator
//
//  Created by Amol Chaudhari on 5/19/14.
//  Copyright (c) 2014 Amol Chaudhari. All rights reserved.
//

#import "ConnectionHandler.h"
#import "CurrencyDataModel.h"

#define kbaseUrl @"http://rate-exchange.appspot.com/currency?from="

@interface ConnectionHandler ()
@property(nonatomic,readwrite)CurrencyType currencyType;
@end

@implementation ConnectionHandler {
}

-(id)initWithCurrencyType:(CurrencyType)currencyType{
   
    if (self=[super init]) {
        _currencyType=currencyType;
        [self refreshDataWithQuantity:1];
    }
    return self;
}

#pragma mark - Public Method
-(NSString *)constructUrlFromQuantity:(int)quantity {
    
    NSString *processedUrlString;
    

    switch (_currencyType) {
            case JapanYen:
            processedUrlString = [kbaseUrl stringByAppendingString:@"USD&to=JPY&q="];
            break;
            case Euro:
            processedUrlString = [kbaseUrl stringByAppendingString:@"USD&to=eur&q="];
            break;
            case BrazilReal:
            processedUrlString = [kbaseUrl stringByAppendingString:@"USD&to=brl&q="];
            break;
        default:
            processedUrlString = [kbaseUrl stringByAppendingString:@"gbp&to=eur&q="];
            break;
    }
    processedUrlString = [NSString stringWithFormat:@"%@%d",processedUrlString,quantity];
    return processedUrlString;
}

#pragma mark - Network call
-(void)refreshDataWithQuantity:(int)quantity {
    NSURLSession *session = [NSURLSession sharedSession];
    __weak typeof(self) weakSelf = self;
     NSString *urlString = [self constructUrlFromQuantity:quantity];
    
    [[session dataTaskWithURL:[NSURL URLWithString:urlString]
            completionHandler:^(NSData *data,
                                NSURLResponse *response,
                                NSError *error) {
                typeof(weakSelf) strongSelf = weakSelf;
                if (!strongSelf) {
                    return ;
                }
                // handle response
                if (!error) {
                    [strongSelf processData:data];
                }

                
            }] resume];

}

#pragma mark Utility
-(void)processData:(NSData*)data {
    NSError *error;
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
  //  float rate = [[json objectForKey:@"rate"] floatValue];
    float value = [[json objectForKey:@"v"] floatValue];
    
    CurrencyDataModel *currencyDataModel = [CurrencyDataModel sharedModel];
    
    switch (_currencyType) {
        case Euro:
            currencyDataModel.recentEuEuro = value;
            break;
        case JapanYen:
            currencyDataModel.recentJapanYen = value;
            break;
        case BrazilReal:
            currencyDataModel.recentBrazilReals = value;
            break;
        default:
            currencyDataModel.recentUkPounds = value; //Uk Pounds is default
            break;
    }
    
}

@end
