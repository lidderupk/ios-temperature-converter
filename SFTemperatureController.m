//
//  SFTemperatureController.m
//  TemperatureConverter
//
//  Created by Upkar Lidder on 2014-01-20.
//  Copyright (c) 2014 8indaas. All rights reserved.
//

#import "SFTemperatureController.h"
#import "SVProgressHUD.h"

@interface SFTemperatureController ()
@property (nonatomic, strong) NSNumber *currentTemperature;
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
    // Do any additional setup after loading the view from its nib.
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
    
    NSMutableString *url = [[NSMutableString alloc]initWithString:@"http://api.openweathermap.org/data/2.5/weather?lat=37.78&lon=-122.40&units=imperial"];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:12];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        
        NSInteger responseCode = [(NSHTTPURLResponse *)response statusCode];
        if (!connectionError && responseCode == 200){
            NSDictionary *object = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            
            NSDictionary *main = [object objectForKey:@"main"];
            self.currentTemperature = [main objectForKey:@"temp"];
            NSLog(@"%@",[self.currentTemperature class]);
            self.inputValueTextField.text = [self.currentTemperature stringValue];
            NSLog(@"%@", object);
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
@end
