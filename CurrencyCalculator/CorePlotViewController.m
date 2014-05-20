//
//  CorePlotViewController.m
//  CurrencyCalculator
//
//  Created by Amol Chaudhari on 5/19/14.
//  Copyright (c) 2014 Amol Chaudhari. All rights reserved.
//

#import "CorePlotViewController.h"
#import "CurrencyDataModel.h"

#define UKPound @"GBP"
#define JapanYen @"JPY"
#define Euro @"EUR"
#define Brazil @"BRL"

CGFloat const CPDBarWidth = 0.25f;
CGFloat const CPDBarInitialX = 0.25f;

@interface CorePlotViewController ()<CPTBarPlotDataSource, CPTBarPlotDelegate>
@property (nonatomic, strong) IBOutlet CPTGraphHostingView *hostView;
@property (nonatomic, strong) CPTBarPlot *ukPounds;
@property (nonatomic, strong) CPTBarPlot *japanYen;
@property (nonatomic, strong) CPTBarPlot *europeEuro;
@property (nonatomic, strong) CPTBarPlot *brazilReals;

@property (nonatomic, strong) CPTPlotSpaceAnnotation *priceAnnotation;


-(void)initPlot;
-(void)configureGraph;
-(void)configurePlots;
-(void)configureAxes;

@end

@implementation CorePlotViewController

#pragma mark - View LifeCycle Events

-(void)viewDidLoad {
    [super viewDidLoad];
    [self initPlot];
    
    CurrencyDataModel *currencyDataModel = [CurrencyDataModel sharedModel];
    [currencyDataModel addObserver:self forKeyPath:@"allRecentCurrencyData" options:NSKeyValueObservingOptionNew context:nil];

}


#pragma mark - KVO
-(void)observeValueForKeyPath:(NSString *)keyPath
                     ofObject:(id)object
                       change:(NSDictionary *)change
                      context:(void *)context {
    
    if ([keyPath isEqualToString:@"allRecentCurrencyData"]) {
        dispatch_async(dispatch_get_main_queue(), ^(void){
            //Run UI Updates
            [self initPlot]; //Reinitialize graph
        });
        
    }
}


#pragma mark - Chart behavior
-(void)initPlot {
    self.hostView.allowPinchScaling = NO;
    [self configureGraph];
    [self configurePlots];
    [self configureAxes];
}

-(void)configureGraph {
	// 1 - Create the graph
	CPTGraph *graph = [[CPTXYGraph alloc] initWithFrame:self.hostView.bounds];
	graph.plotAreaFrame.masksToBorder = NO;
	self.hostView.hostedGraph = graph;
	// 2 - Configure the graph
	[graph applyTheme:[CPTTheme themeNamed:kCPTPlainBlackTheme]];
	graph.paddingBottom = 30.0f;
	graph.paddingLeft  = 30.0f;
	graph.paddingTop    = -1.0f;
	graph.paddingRight  = -5.0f;
	// 3 - Set up styles
	CPTMutableTextStyle *titleStyle = [CPTMutableTextStyle textStyle];
	titleStyle.color = [CPTColor whiteColor];
	titleStyle.fontName = @"Helvetica-Bold";
	titleStyle.fontSize = 16.0f;
	// 4 - Set up title
	NSString *title = @"Currency Rates";
	graph.title = title;
	graph.titleTextStyle = titleStyle;
	graph.titlePlotAreaFrameAnchor = CPTRectAnchorTop;
	graph.titleDisplacement = CGPointMake(0.0f, -16.0f);
	// 5 - Set up plot space
	CGFloat xMin = 0.0f;
	//CGFloat xMax = [[[CPDStockPriceStore sharedInstance] datesInWeek] count];
    CGFloat xMax = 3.0f;
	CGFloat yMin = 0.0f;
    CurrencyDataModel *currencyDataModel = [CurrencyDataModel sharedModel];
	CGFloat yMax = currencyDataModel.recentBrazilReals*1.5;  // should determine dynamically based on max price
	CPTXYPlotSpace *plotSpace = (CPTXYPlotSpace *) graph.defaultPlotSpace;
	plotSpace.xRange = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat(xMin) length:CPTDecimalFromFloat(xMax)];
	plotSpace.yRange = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat(yMin) length:CPTDecimalFromFloat(yMax)];
 //   plotSpace.yScaleType = CPTScaleTypeLog;

}

-(void)configurePlots {
	// 1 - Set up the three plots
	self.ukPounds = [CPTBarPlot tubularBarPlotWithColor:[CPTColor redColor] horizontalBars:NO];
	self.ukPounds.identifier = @"GBP";
	self.japanYen = [CPTBarPlot tubularBarPlotWithColor:[CPTColor greenColor] horizontalBars:NO];
	self.japanYen.identifier = @"JPY";
	self.europeEuro = [CPTBarPlot tubularBarPlotWithColor:[CPTColor blueColor] horizontalBars:NO];
	self.europeEuro.identifier = @"EUR";
    self.brazilReals = [CPTBarPlot tubularBarPlotWithColor:[CPTColor yellowColor] horizontalBars:NO];
	self.brazilReals.identifier = @"BRL";

	// 2 - Set up line style
	CPTMutableLineStyle *barLineStyle = [[CPTMutableLineStyle alloc] init];
	barLineStyle.lineColor = [CPTColor lightGrayColor];
	barLineStyle.lineWidth = 0.5;
	// 3 - Add plots to graph
	CPTGraph *graph = self.hostView.hostedGraph;
	CGFloat barX = CPDBarInitialX;
	NSArray *plots = [NSArray arrayWithObjects:self.ukPounds, self.japanYen, self.europeEuro,self.brazilReals, nil];
	for (CPTBarPlot *plot in plots) {
		plot.dataSource = self;
		plot.delegate = self;
		plot.barWidth = CPTDecimalFromDouble(CPDBarWidth);
		plot.barOffset = CPTDecimalFromDouble(barX);
		plot.lineStyle = barLineStyle;
		[graph addPlot:plot toPlotSpace:graph.defaultPlotSpace];
		barX += CPDBarWidth+0.5f; //For spacing
	}
}

-(void)configureAxes {
	// 1 - Configure styles
	CPTMutableTextStyle *axisTitleStyle = [CPTMutableTextStyle textStyle];
	axisTitleStyle.color = [CPTColor whiteColor];
	axisTitleStyle.fontName = @"Helvetica-Bold";
	axisTitleStyle.fontSize = 12.0f;
	CPTMutableLineStyle *axisLineStyle = [CPTMutableLineStyle lineStyle];
	axisLineStyle.lineWidth = 2.0f;
	axisLineStyle.lineColor = [[CPTColor whiteColor] colorWithAlphaComponent:1];
	// 2 - Get the graph's axis set
	CPTXYAxisSet *axisSet = (CPTXYAxisSet *) self.hostView.hostedGraph.axisSet;
	// 3 - Configure the x-axis
	axisSet.xAxis.labelingPolicy = CPTAxisLabelingPolicyNone;
	axisSet.xAxis.title = @"Currency";
	axisSet.xAxis.titleTextStyle = axisTitleStyle;
	axisSet.xAxis.titleOffset = 10.0f;
	axisSet.xAxis.axisLineStyle = axisLineStyle;
	// 4 - Configure the y-axis
	axisSet.yAxis.labelingPolicy = CPTAxisLabelingPolicyNone;
	axisSet.yAxis.title = @"Price";
	axisSet.yAxis.titleTextStyle = axisTitleStyle;
	axisSet.yAxis.titleOffset = 5.0f;
	axisSet.yAxis.axisLineStyle = axisLineStyle;
}


#pragma mark - CPTPlotDataSource methods
-(NSUInteger)numberOfRecordsForPlot:(CPTPlot *)plot {
    return 1;
}

-(NSNumber *)numberForPlot:(CPTPlot *)plot field:(NSUInteger)fieldEnum recordIndex:(NSUInteger)index {
   
    if ((fieldEnum == CPTBarPlotFieldBarTip) && (index < 4)) {
        CurrencyDataModel *currencyDataModel = [CurrencyDataModel sharedModel];
        if ([plot.identifier isEqual:UKPound] == YES) {
            return [NSDecimalNumber numberWithFloat:currencyDataModel.recentUkPounds];

        } else if ([plot.identifier isEqual:JapanYen] == YES) {
            return [NSDecimalNumber numberWithFloat:currencyDataModel.recentJapanYen];

        } else if ([plot.identifier isEqual:Euro] == YES) {
            return [NSDecimalNumber numberWithUnsignedInteger:currencyDataModel.recentEuEuro];

        } else if ([plot.identifier isEqual:Brazil] == YES) {
            return [NSDecimalNumber numberWithUnsignedInteger:currencyDataModel.recentBrazilReals];
        }

    }
	return [NSDecimalNumber numberWithUnsignedInteger:index];
}

#pragma mark - CPTBarPlotDelegate methods
-(void)barPlot:(CPTBarPlot *)plot barWasSelectedAtRecordIndex:(NSUInteger)index {
   
}


-(void)dealloc {
    CurrencyDataModel *currencyDataModel = [CurrencyDataModel sharedModel];
    [currencyDataModel removeObserver:self forKeyPath:@"allRecentCurrencyData"];
}


@end