External Libraries :
CorePlot
AsyncXCTestingKit


Project Design : 


Please refer to "CurrencyCalculatorArchitecture" for the general architecture. 

MainViewController is the initialViewController. Its using KVO on "CurrencyDataModel" which is a Singleton to update its View.

CorePlotViewController is a childController for MainViewController. It uses KVO as well on "CurrencyDataModel". It is responsible for drawing the bar graph and utilizes CorePlot.

ConnectionFactory is a factory to decouple the creation of multiple connectionHandlers for UKPounds, Euro, Yen and BrazilReals. It sets the individual float value for "recentUkPounds","recentEuEuro","recentJapanYen","recentBrazilReals" which inturn updates the "allRecentCurrencyData". 

Tests: 

CurrencyHandlerTests is the unit test which tests the working of the Model updates and Network calls.




Instructions to run:

Incase there are any compiler errors, please check the path under Library Search Paths under Buildsettings. Make sure its pointing to the right places.