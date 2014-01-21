# Temperature Converter for your city !

Temperature converter is a simple app for ios that converts Celsius to Fahrenheit and vice versa.
It is built in ObjectiveC using MVC paradigm and uses XCTest framework for [unit tests](https://github.com/8indaas/ios-temperature-converter/tree/master/TemperatureConverterTests).

![Logo](http://i.imgur.com/regQR1g.png)

The Temperature converter was built as part of the [Ios CodePath iOS Mobile Bootcamp](http://thecodepath.com/iosbootcamp). This simple converter takes as input the unit the user wants to convert to and the value. The user can then tap anywhere on the screen or use the Done button on the top right corner of the screen to see the results in the other unit.<br/>

<img src="http://i.imgur.com/6VLemGv.png" height="545" />
&nbsp;&nbsp;
<img src="http://i.imgur.com/kbfbx1Z.png" height="545" />
<br/>

In addition to manually entering the temperature, the user can use the "Use current location" button to pre fill the input box with the current temperature for their city. The app gets the temperature in Celsius or Fahrenheit based on the "Conver From:" choice from the [openweathermap API](http://bugs.openweathermap.org/projects/api/wiki/Api_2_5_weather). The app also gets the weather icon from the [openweathermap icon service](http://bugs.openweathermap.org/projects/api/wiki/Weather_Condition_Codes) and loads it asynchronously onto the screen. The location is obtained from the ios location service.

<img src="http://i.imgur.com/SeXsTJr.png" height="545" />

## Tools used
* XCode 5
* XCTest Framework to test various controllers and views
* OpenWeatherMap API
* AFINetworking Libraries
* SVProgressHUD library to update the user
* App icons from [iconfinder](https://www.iconfinder.com/icons/48742/calculator_icon#size=128)

##Concepts Learned
App Delegate
Interface Builder
UIViewController and viewDidLoad
CLLocationManagerDelegate to use iOS location services
UITextField delegate to implement the done button

## Possible Improvements
* Add a settings page for the user to set default temperature type
* Better layout and graphics (including splash page)

## License

* [Apache Version 2.0](http://www.apache.org/licenses/LICENSE-2.0.html)

## Contributing

Please fork this repository and contribute back using
[pull requests](https://github.com/8indaas/ios-temperature-converter/pulls).

Any contributions, large or small, major features, bug fixes, additional
language translations, unit/integration tests are welcomed and appreciated
but will be thoroughly reviewed and discussed.
