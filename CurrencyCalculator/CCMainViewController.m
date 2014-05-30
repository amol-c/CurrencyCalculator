//
//  ViewController.m
//  CurrencyCalculator
//
//  Created by Amol Chaudhari on 5/19/14.
//  Copyright (c) 2014 Amol Chaudhari. All rights reserved.
//

#import "CCMainViewController.h"
#import "CCDataModelProtocol.h"
#import "CCDataModelFactory.h"
#import "CCConnectionFactory.h"


static void * MainViewControllerContext = &MainViewControllerContext;


@interface CCMainViewController ()<UITextFieldDelegate> {
    NSMutableArray *_connectionHandlerArray;
}
@property(nonatomic)NSString* dataValue;
@property(nonatomic,weak)IBOutlet UILabel *recentUKPoundsLabel;
@property(nonatomic,weak)IBOutlet UILabel *recentEuropeEuroLabel;
@property(nonatomic,weak)IBOutlet UILabel *recentJapanYenLabel;
@property(nonatomic,weak)IBOutlet UILabel *recentBrazilRealLabel;



@property (nonatomic,weak)IBOutlet UITextField *numberOfDollars;

-(IBAction)willRefreshData:(id)sender;

@end

@implementation CCMainViewController



#pragma mark - View Lifecycle Events
- (void)viewDidLoad
{
    [super viewDidLoad];
    _connectionHandlerArray = [[NSMutableArray alloc]init];
	// Do any additional setup after loading the view, typically from a nib.
    id<CCConnectionProtocol> connectionHandler = [CCConnectionFactory createConnectionWithCurrencyType:UKPoundsModeDefault];
    [_connectionHandlerArray addObject:connectionHandler];
    
    connectionHandler = [CCConnectionFactory createConnectionWithCurrencyType:EuroMode];
    [_connectionHandlerArray addObject:connectionHandler];
    connectionHandler = [CCConnectionFactory createConnectionWithCurrencyType:JapanYenMode];
    [_connectionHandlerArray addObject:connectionHandler];
    connectionHandler = [CCConnectionFactory createConnectionWithCurrencyType:BrazilRealMode];
    [_connectionHandlerArray addObject:connectionHandler];

    
    NSObject <CCDataModelProtocol> *currencyDataModel = [CCDataModelFactory sharedDataModel];
    //You cannot call addObserver on a property declared on a protocol
    [currencyDataModel addObserver:self forKeyPath:NSStringFromSelector(@selector(allRecentCurrencyData)) options:NSKeyValueObservingOptionNew context:MainViewControllerContext];
    
    [_numberOfDollars setDelegate:self]; //To dismiss the key board
}


-(void)dealloc {
    NSObject <CCDataModelProtocol> *currencyDataModel = [CCDataModelFactory sharedDataModel];
    [currencyDataModel removeObserver:self forKeyPath:NSStringFromSelector(@selector(allRecentCurrencyData))context:MainViewControllerContext];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark KVO
-(void)observeValueForKeyPath:(NSString *)keyPath
                     ofObject:(id)object
                       change:(NSDictionary *)change
                      context:(void *)context {
    
    if ([keyPath isEqualToString:NSStringFromSelector(@selector(allRecentCurrencyData))]) {
        NSMutableDictionary *changeCurrency = [change objectForKey:NSKeyValueChangeNewKey];
        NSString *stringValue;
      
        if ([changeCurrency objectForKey:@"recentJapanYen"]) {
            stringValue  = [[changeCurrency objectForKey:@"recentJapanYen"] stringValue];
            dispatch_async(dispatch_get_main_queue(), ^(void){
                //Run UI Updates
                [_recentJapanYenLabel setText:stringValue] ;
            });

        }
        
        if([changeCurrency objectForKey:@"recentUkPounds"]){
            stringValue = [[changeCurrency objectForKey:@"recentUkPounds"] stringValue];
            dispatch_async(dispatch_get_main_queue(), ^(void){
                //Run UI Updates
                [_recentUKPoundsLabel setText:stringValue] ;
            });
        }
        if([changeCurrency objectForKey:@"recentEuEuro"]){
            stringValue = [[changeCurrency objectForKey:@"recentEuEuro"] stringValue];
            dispatch_async(dispatch_get_main_queue(), ^(void){
                //Run UI Updates
                [_recentEuropeEuroLabel setText:stringValue] ;
            });

        }
         if([changeCurrency objectForKey:@"recentBrazilReals"]){
            stringValue = [[changeCurrency objectForKey:@"recentBrazilReals"] stringValue];
            dispatch_async(dispatch_get_main_queue(), ^(void){
                //Run UI Updates
                [_recentBrazilRealLabel setText:stringValue] ;
            });

        }

    }
}


#pragma mark - Events
-(IBAction)willRefreshData:(id)sender {
    int intValue =[_numberOfDollars.text intValue];
    if (intValue) {
        for (id<CCConnectionProtocol> eachHandler in _connectionHandlerArray) {
            [eachHandler willRefreshDataWithQuantity:[_numberOfDollars.text intValue]];
        }
    }else {
        [_recentBrazilRealLabel setText:@"0"] ;
        [_recentEuropeEuroLabel setText:@"0"] ;
        [_recentUKPoundsLabel setText:@"0"] ;
        [_recentJapanYenLabel setText:@"0"] ;

    }
    [_numberOfDollars resignFirstResponder];
}

#pragma mark UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}


@end
