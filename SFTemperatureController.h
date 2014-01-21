//
//  SFTemperatureController.h
//  TemperatureConverter
//
//  Created by Upkar Lidder on 2014-01-20.
//  Copyright (c) 2014 8indaas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface SFTemperatureController : UIViewController <CLLocationManagerDelegate, UITextFieldDelegate>
{
CLLocationManager *locationManager;
}

@property (weak, nonatomic) IBOutlet UISegmentedControl *convertFromSegment;
@property (weak, nonatomic) IBOutlet UITextField *inputValueTextField;
@property (weak, nonatomic) IBOutlet UIButton *currentLocationButton;
@property (weak, nonatomic) IBOutlet UILabel *outputLabel;
@property (weak, nonatomic) IBOutlet UIImageView *weatherImage;
@property (weak, nonatomic) IBOutlet UILabel *cityNameLabel;


- (IBAction)getCurrentLocationTemp:(id)sender;
- (IBAction) onDoneButton:(id)sender;
- (IBAction)converFromSegementValueChanged:(id)sender;

@end
