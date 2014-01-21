//
//  TemperatureConverterTests.m
//  TemperatureConverterTests
//
//  Created by Upkar Lidder on 2014-01-20.
//  Copyright (c) 2014 8indaas. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "SFTemperatureModel.h"

@interface TemperatureConverterTests : XCTestCase

@end

@implementation TemperatureConverterTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testConvertC2FMethod
{
    SFTemperatureModel *tempModel = [[SFTemperatureModel alloc]initWithTemperature:CELCIUS value:100];
    
    SFTemperatureModel *returnTemp = [tempModel convertTemperature:FAHRENHEIT];
    
    XCTAssertNotNil(returnTemp, @"");
    XCTAssertTrue(returnTemp.value == 212, @"");
    XCTAssertTrue(returnTemp.temperatureType == FAHRENHEIT, @"");
}


- (void)testConvertF2CMethod
{
    SFTemperatureModel *tempModel = [[SFTemperatureModel alloc]initWithTemperature:CELCIUS value:734];
    
    SFTemperatureModel *returnTemp = [tempModel convertTemperature:FAHRENHEIT];
    
    XCTAssertNotNil(returnTemp, @"");
    NSLog(@"%f", returnTemp.value);
    XCTAssertTrue(returnTemp.value == 1353.5, @"");
    XCTAssertTrue(returnTemp.temperatureType == FAHRENHEIT, @"");
}

- (void)testConvertC2CMethod
{
    SFTemperatureModel *tempModel = [[SFTemperatureModel alloc]initWithTemperature:CELCIUS value:734];
    
    SFTemperatureModel *returnTemp = [tempModel convertTemperature:CELCIUS];
    
    XCTAssertNotNil(returnTemp, @"");
    XCTAssertTrue(returnTemp.value == 734, @"");
    XCTAssertTrue(returnTemp.temperatureType == CELCIUS, @"");
}

- (void)testConvertF2FMethod
{
    SFTemperatureModel *tempModel = [[SFTemperatureModel alloc]initWithTemperature:FAHRENHEIT value:734];
    
    SFTemperatureModel *returnTemp = [tempModel convertTemperature:FAHRENHEIT];
    
    XCTAssertNotNil(returnTemp, @"");
    XCTAssertTrue(returnTemp.value == 734, @"");
    XCTAssertTrue(returnTemp.temperatureType == FAHRENHEIT, @"");
}

@end
