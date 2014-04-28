//
//  ViewController.h
//  Beacon
//
//  Created by Narongwate Sangsakul on 4/29/2557 BE.
//  Copyright (c) 2557 Narongwate Sangsakul. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <CoreBluetooth/CoreBluetooth.h>


@interface ViewController : UIViewController<CBPeripheralManagerDelegate>

@property (strong, nonatomic) IBOutlet UILabel *statusLabel;

@property (strong, nonatomic) CLBeaconRegion *myBeaconRegion;
@property (strong, nonatomic) NSDictionary *myBeaconData;
@property (strong, nonatomic) CBPeripheralManager *peripheralManager;


@end
