//
//  SFTemperatureModel.m
//  TemperatureConverter
//
//  Created by Upkar Lidder on 2014-01-20.
//  Copyright (c) 2014 8indaas. All rights reserved.
//

#import "SFTemperatureModel.h"

@implementation SFTemperatureModel

- (SFTemperatureModel*) initWithTemperature:(enum TEMPERATURE_TYPE)tempType value:(float)valueIn{
    self = [super init];
    if(self)
    {
        self.temperatureType = tempType;
        self.value = valueIn;
    }
    return self;
}

- (SFTemperatureModel*) convertTemperature:(enum TEMPERATURE_TYPE)to{
    
    enum TEMPERATURE_TYPE from = self.temperatureType;
    float valueIn = self.value;

    
    SFTemperatureModel *result = [[SFTemperatureModel alloc]initWithTemperature:from value:valueIn];
    
    switch (from) {
        case CELCIUS:
        {
            if(to == FAHRENHEIT){
                float out = ((valueIn*9)/5)+32;
                result.value = ceil(2.0f*out)/2.0f;
                result.temperatureType = FAHRENHEIT;
            }
            break;
        }
        case FAHRENHEIT:
        {
            if(to == CELCIUS){
                float out = ((valueIn - 32))*5/9;
                result.value = ceil(2.0f*out)/2.0f;
                result.temperatureType = CELCIUS;
            }
            break;
        }
        default:
            break;
    }
    return result;
}

@end
