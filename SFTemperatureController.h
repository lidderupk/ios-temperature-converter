//
//  SFTemperatureController.h
//  TemperatureConverter
//
//  Created by Upkar Lidder on 2014-01-20.
//  Copyright (c) 2014 8indaas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface SFTemperatureController : UIViewController <CLLocationManagerDelegate>
{
CLLocationManager *locationManager;
}

@property (weak, nonatomic) IBOutlet UISegmentedControl *convertFromSegment;
@property (weak, nonatomic) IBOutlet UITextField *inputValueTextField;
@property (weak, nonatomic) IBOutlet UIButton *currentLocationButton;
@property (weak, nonatomic) IBOutlet UILabel *outputLabel;


- (IBAction)getCurrentLocationTemp:(id)sender;
@end
