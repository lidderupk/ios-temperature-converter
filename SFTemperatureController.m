//
//  SFTemperatureController.m
//  TemperatureConverter
//
//  Created by Upkar Lidder on 2014-01-20.
//  Copyright (c) 2014 8indaas. All rights reserved.
//

#import "SFTemperatureController.h"
#import "SFTemperatureModel.h"
#import "SVProgressHUD.h"
#import "UIImageview+AFNetworking.h"

@interface SFTemperatureController ()

@property (nonatomic, strong) NSNumber *currentTemperature;
@property (nonatomic, strong) SFTemperatureModel *temperature;

@end

@implementation SFTemperatureController{
    float latitude;
    float longitude;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        locationManager = [[CLLocationManager alloc] init];
        locationManager.delegate = self;
        locationManager.distanceFilter = kCLDistanceFilterNone;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        [locationManager startUpdatingLocation];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.inputValueTextField.delegate = self;
    self.inputValueTextField.text = @"0";
    self.outputLabel.text = @"0";
    [self.convertFromSegment setSelectedSegmentIndex:0];
    self.temperature = [[SFTemperatureModel alloc]initWithTemperature:CELCIUS value:0];
    [self updateTemperature];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    NSLog(@"OldLocation %f %f", oldLocation.coordinate.latitude, oldLocation.coordinate.longitude);
    NSLog(@"NewLocation %f %f", newLocation.coordinate.latitude, newLocation.coordinate.longitude);
    latitude = newLocation.coordinate.latitude;
    longitude = newLocation.coordinate.longitude;
}

- (void) getCurrentTemperature{
    
    NSMutableString *url = nil;
    
    if(self.convertFromSegment.selectedSegmentIndex == 0)
        url =     [[NSMutableString alloc]initWithString:@"http://api.openweathermap.org/data/2.5/weather?lat=37.78&lon=-122.40&units=metric"];
    else
        url =     [[NSMutableString alloc]initWithString:@"http://api.openweathermap.org/data/2.5/weather?lat=37.78&lon=-122.40&units=imperial"];
    
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:12];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        
        NSInteger responseCode = [(NSHTTPURLResponse *)response statusCode];
        if (!connectionError && responseCode == 200){
            NSDictionary *object = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            
            NSDictionary *main = [object objectForKey:@"main"];
            NSString *cityName =  [object objectForKey:@"name"];
            self.temperature.name = cityName;
            self.currentTemperature = [main objectForKey:@"temp"];
            NSLog(@"%@",[self.currentTemperature class]);
            self.inputValueTextField.text = [self.currentTemperature stringValue];
            
            NSArray *weathers = [object objectForKey:@"weather"];
            NSDictionary *weather = weathers[0];
            NSString *icon = [weather objectForKey:@"icon"];
            self.temperature.iconURL = [[NSString alloc]initWithFormat:@"%@%@", @"http://openweathermap.org/img/w/",icon];
            NSLog(@"%@", object);
            
            [self updateTemperature];
        }
        else{
            //show error message
            NSLog(@"connectionError=%@", connectionError);
            NSLog(@"responseCode=%d", responseCode);
            [SVProgressHUD showErrorWithStatus:@"Oops, unable to load movies, check your internet!"];
        }
    }];
}


- (IBAction)getCurrentLocationTemp:(id)sender {
    [self getCurrentTemperature];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == self.inputValueTextField) {
        [textField resignFirstResponder];
        return NO;
    }
    return YES;
}

- (IBAction)onDoneButton:(id)sender {
    [self.view endEditing:YES];
    if(self.inputValueTextField.text.length < 1){
        self.inputValueTextField.text = @"0";
    }
    
    self.temperature.iconURL = nil;
    self.temperature.name = @"";
    [self updateTemperature];
    NSLog(@"%@", @"done button called");
}

- (IBAction)converFromSegementValueChanged:(id)sender {
    [self updateTemperature];
}

- (void) updateTemperature{
    //update temperature
    NSInteger index = self.convertFromSegment.selectedSegmentIndex;
    self.temperature.value = [self.inputValueTextField.text floatValue];
    SFTemperatureModel *newTemperature = nil;
    
    if(index == 0){
        self.temperature.temperatureType = CELCIUS;
        newTemperature = [self.temperature convertTemperature:FAHRENHEIT];
        self.outputLabel.text = [[NSString alloc]initWithFormat:@"%.02f %@", newTemperature.value, @"F"];
        
    }
    else{
        self.temperature.temperatureType = FAHRENHEIT;
        newTemperature = [self.temperature convertTemperature:CELCIUS];
        self.outputLabel.text = [[NSString alloc]initWithFormat:@"%.02f %@", newTemperature.value, @"C"];
    }
    
    NSURL *url = [NSURL URLWithString:self.temperature.iconURL];
    [self.weatherImage setImageWithURL:url];
    self.cityNameLabel.text = self.temperature.name;
    
    [locationManager stopUpdatingLocation];
}

- (BOOL) textFieldShouldBeginEditing:(UITextField *)textField{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(onDoneButton:)];
    return YES;
}



@end
