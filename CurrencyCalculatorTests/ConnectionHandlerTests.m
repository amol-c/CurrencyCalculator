//
//  ConnectionHandlerTests.m
//  CurrencyCalculator
//
//  Created by Amol Chaudhari on 5/20/14.
//  Copyright (c) 2014 Amol Chaudhari. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "XCTestCase+AsyncTesting.h"
#import "ConnectionFactory.h"
#import "CurrencyDataModel.h"

@interface ConnectionHandlerTests : XCTestCase

@end

@implementation ConnectionHandlerTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    CurrencyDataModel *currencyDataModel = [CurrencyDataModel sharedModel];
    [currencyDataModel addObserver:self forKeyPath:@"allRecentCurrencyData" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)tearDown
{
    CurrencyDataModel *currencyDataModel = [CurrencyDataModel sharedModel];
    [currencyDataModel removeObserver:self forKeyPath:@"allRecentCurrencyData"];
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

-(void)testConnectionHandlerForUKPounds {
    
    __unused
    ConnectionHandler *connectionHandler = [ConnectionFactory createConnectionWithCurrencyType:UKPounds];
    [self waitForStatus:XCTAsyncTestCaseStatusSucceeded timeout:10];
}

-(void)testConnectionHandlerForEuro {
    
    __unused
    ConnectionHandler *connectionHandler = [ConnectionFactory createConnectionWithCurrencyType:Euro];
    [self waitForStatus:XCTAsyncTestCaseStatusSucceeded timeout:10];
}

-(void)testConnectionHandlerForJapanYen {
    
    __unused
    ConnectionHandler *connectionHandler = [ConnectionFactory createConnectionWithCurrencyType:JapanYen];
    [self waitForStatus:XCTAsyncTestCaseStatusSucceeded timeout:10];
}

-(void)testConnectionHandlerForBrazilReals {
    
    __unused
    ConnectionHandler *connectionHandler = [ConnectionFactory createConnectionWithCurrencyType:BrazilReal];
    [self waitForStatus:XCTAsyncTestCaseStatusSucceeded timeout:10];
}

#pragma mark KVO
-(void)observeValueForKeyPath:(NSString *)keyPath
                     ofObject:(id)object
                       change:(NSDictionary *)change
                      context:(void *)context {
    
    if ([keyPath isEqualToString:@"allRecentCurrencyData"]) {
        NSMutableDictionary *changeCurrency = [change objectForKey:NSKeyValueChangeNewKey];
        float floatValue;
        
        if ([changeCurrency objectForKey:@"recentJapanYen"]) {
            floatValue  = [[changeCurrency objectForKey:@"recentJapanYen"] floatValue];
            XCTAssert(floatValue > 90.0f, @"JapanYen received and is correct");
            [self notify:XCTAsyncTestCaseStatusSucceeded];
        }
        
        if([changeCurrency objectForKey:@"recentUkPounds"]){
            floatValue = [[changeCurrency objectForKey:@"recentUkPounds"] floatValue];
            XCTAssert(floatValue > 1.0f, @"UKPounds received and is correct");
            [self notify:XCTAsyncTestCaseStatusSucceeded];
        }
        if([changeCurrency objectForKey:@"recentEuEuro"]){
            floatValue = [[changeCurrency objectForKey:@"recentEuEuro"] floatValue];
            XCTAssert(floatValue > 0.5f, @"Euro received and is correct");
            [self notify:XCTAsyncTestCaseStatusSucceeded];
        }
        if([changeCurrency objectForKey:@"recentBrazilReals"]){
            floatValue = [[changeCurrency objectForKey:@"recentBrazilReals"] floatValue];
            XCTAssert(floatValue > 2.0f, @"Brazil Reals received and is correct");
            [self notify:XCTAsyncTestCaseStatusSucceeded];
        }
        

    }
}



@end
