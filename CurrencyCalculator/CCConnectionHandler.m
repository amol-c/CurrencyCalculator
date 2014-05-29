//
//  ConnectionHandler.m
//  CurrencyCalculator
//
//  Created by Amol Chaudhari on 5/19/14.
//  Copyright (c) 2014 Amol Chaudhari. All rights reserved.
//

#import "CCConnectionHandler.h"
#import "CCDataModelProtocol.h"
#import "CCDataModelFactory.h"
#import "CCConstants.h"

@interface CCConnectionHandler ()
@property(nonatomic,readwrite)CurrencyType currencyType;
@end

@implementation CCConnectionHandler {
}

-(id)initWithCurrencyType:(CurrencyType)currencyType{
   
    if (self=[super init]) {
        _currencyType=currencyType;
        [self willRefreshDataWithQuantity:1];
    }
    return self;
}

#pragma mark - Public Method
-(NSString *)willConstructUrlFromQuantity:(int)quantity {
    
    NSString *processedUrlString;
    

    switch (_currencyType) {
            case JapanYenMode:
            processedUrlString = [CCBaseUrl stringByAppendingString:@"USD&to=JPY&q="];
            break;
            case EuroMode:
            processedUrlString = [CCBaseUrl stringByAppendingString:@"USD&to=eur&q="];
            break;
            case BrazilRealMode:
            processedUrlString = [CCBaseUrl stringByAppendingString:@"USD&to=brl&q="];
            break;
        default:
            processedUrlString = [CCBaseUrl stringByAppendingString:@"gbp&to=eur&q="];
            break;
    }
    processedUrlString = [NSString stringWithFormat:@"%@%d",processedUrlString,quantity];
    return processedUrlString;
}

#pragma mark - Network call
-(void)willRefreshDataWithQuantity:(int)quantity {
    NSURLSession *session = [NSURLSession sharedSession];
    __weak typeof(self) weakSelf = self;
     NSString *urlString = [self willConstructUrlFromQuantity:quantity];
    
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
                    [strongSelf willProcessData:data];
                }

                
            }] resume];

}

#pragma mark Utility
-(void)willProcessData:(NSData*)data {
    NSError *error;
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
  //  float rate = [[json objectForKey:@"rate"] floatValue];
    float value = [[json objectForKey:@"v"] floatValue];
    
    id <CCDataModelProtocol> currencyDataModel = [CCDataModelFactory sharedDataModel];
    
    switch (_currencyType) {
        case EuroMode:
            currencyDataModel.recentEuEuro = value;
            break;
        case JapanYenMode:
            currencyDataModel.recentJapanYen = value;
            break;
        case BrazilRealMode:
            currencyDataModel.recentBrazilReals = value;
            break;
        default:
            currencyDataModel.recentUkPounds = value; //Uk Pounds is default
            break;
    }
    
}

@end
