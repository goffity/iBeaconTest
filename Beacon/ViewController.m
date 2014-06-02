//
//  ViewController.m
//  Beacon
//
//  Created by Narongwate Sangsakul on 4/29/2557 BE.
//  Copyright (c) 2557 Narongwate Sangsakul. All rights reserved.
//

#import "ViewController.h"
#import <SystemConfiguration/CaptiveNetwork.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // Create a NSUUID object
    NSUUID *uuid = [[NSUUID alloc] initWithUUIDString:@"52362C17-76E1-404B-AFC6-95DE3B372CA1"];
    
    // Initialize the Beacon Region
    self.myBeaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:uuid
                                                                  major:1
                                                                  minor:1
                                                             identifier:@"com.goffity.test.ibeacon"];
    
    CFArrayRef myArray = CNCopySupportedInterfaces();
    NSLog(@"SSID array: %@",myArray);
    CFDictionaryRef myDict = CNCopyCurrentNetworkInfo(CFArrayGetValueAtIndex(myArray, 0));
    NSLog(@"SSID dict: %@",myDict);
//    NSLog(@"SSID: %@",CFDictionaryGetValue(myDict, kCNNetworkInfoKeySSID));
    NSString *networkName = CFDictionaryGetValue(myDict, kCNNetworkInfoKeySSID);
    NSLog(@"SSID: %@",networkName);
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)buttonClicked:(id)sender {
    // Get the beacon data to advertise
    self.myBeaconData = [self.myBeaconRegion peripheralDataWithMeasuredPower:nil];
    
    // Start the peripheral manager
    self.peripheralManager = [[CBPeripheralManager alloc] initWithDelegate:self
                                                                     queue:nil
                                                                   options:nil];
}

-(void)peripheralManagerDidUpdateState:(CBPeripheralManager*)peripheral
{
    if (peripheral.state == CBPeripheralManagerStatePoweredOn)
    {
        // Bluetooth is on
        
        // Update our status label
        self.statusLabel.text = @"Broadcasting...";
        
        // Start broadcasting
        [self.peripheralManager startAdvertising:self.myBeaconData];
    }
    else if (peripheral.state == CBPeripheralManagerStatePoweredOff)
    {
        // Update our status label
        self.statusLabel.text = @"Stopped";
        
        // Bluetooth isn't on. Stop broadcasting
        [self.peripheralManager stopAdvertising];
    }
    else if (peripheral.state == CBPeripheralManagerStateUnsupported)
    {
        self.statusLabel.text = @"Unsupported";
    }
}

@end
