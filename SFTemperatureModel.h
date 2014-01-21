//
//  SFTemperatureModel.h
//  TemperatureConverter
//
//  Created by Upkar Lidder on 2014-01-20.
//  Copyright (c) 2014 8indaas. All rights reserved.
//

#import <Foundation/Foundation.h>


enum TEMPERATURE_TYPE{
    CELCIUS,
    FAHRENHEIT,
};


@interface SFTemperatureModel : NSObject
@property (readwrite, assign) float value;
@property (nonatomic, assign) enum TEMPERATURE_TYPE temperatureType;

- (SFTemperatureModel*) initWithTemperature:(enum TEMPERATURE_TYPE)tempType value:(float)valueIn;
- (SFTemperatureModel*) convertTemperature:(enum TEMPERATURE_TYPE)to;

@end
