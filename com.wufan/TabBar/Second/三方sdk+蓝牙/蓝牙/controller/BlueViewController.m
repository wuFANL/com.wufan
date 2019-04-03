//
//  BlueViewController.m
//  com.wufan
//
//  Created by appleadmin on 2019/4/1.
//  Copyright © 2019年 wufan. All rights reserved.
//

#import "BlueViewController.h"
#import <CoreBluetooth/CoreBluetooth.h>
@interface BlueViewController ()
@property(nonatomic,strong)CBCentralManager *centralManager;

@end

@implementation BlueViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    _centralManager=[[CBCentralManager alloc]initWithDelegate:self queue:nil];
    
    // Do any additional setup after loading the view.
}
-(CBCentralManager *)centralManager{
    if (!_centralManager) {
//        __weak __typeof(&*self)weakself=self;
        _centralManager=[[CBCentralManager alloc]initWithDelegate:self queue:nil];
    }
    return _centralManager;
}


- (void)centralManagerDidUpdateState:(CBCentralManager *)central{
    switch (central.state) {
        case CBCentralManagerStateUnknown:
            NSLog(@">>>CBCentralManagerStateUnknown");
            break;
        case CBCentralManagerStateResetting:
            NSLog(@">>>CBCentralManagerStateResetting");
            break;
        case CBCentralManagerStateUnsupported:
            NSLog(@">>>CBCentralManagerStateUnsupported");
            break;
        case CBCentralManagerStateUnauthorized:
            NSLog(@">>>CBCentralManagerStateUnauthorized");
            break;
        case CBCentralManagerStatePoweredOff:
            NSLog(@">>>CBCentralManagerStatePoweredOff");
            break;
        case CBCentralManagerStatePoweredOn:
        {
            NSLog(@">>>CBCentralManagerStatePoweredOn");
            // 开始扫描周围的外设。
            /*
             -- 两个参数为Nil表示默认扫描所有可见蓝牙设备。
             -- 注意：第一个参数是用来扫描有指定服务的外设。然后有些外设的服务是相同的，比如都有FFF5服务，那么都会发现；而有些外设的服务是不可见的，就会扫描不到设备。
             -- 成功扫描到外设后调用didDiscoverPeripheral
             */
            [self.centralManager scanForPeripheralsWithServices:nil options:nil];
        }
            break;
        default:
            break;
    }
}
#pragma mark 发现外设
- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary*)advertisementData RSSI:(NSNumber *)RSSI{
    
    NSLog(@"advertisement data is :%@",advertisementData);
    NSString* identifer = [peripheral.identifier UUIDString];
  NSLog(@"Find device identifer:%@", identifer);
    
    NSLog(@"Find device:%@", [peripheral name]);
//    if (![_deviceDic objectForKey:[peripheral name]]) {
//        NSLog(@"Find device:%@", [peripheral name]);
//        if (peripheral!=nil) {
//            if ([peripheral name]!=nil) {
//                if ([[peripheral name] hasPrefix:@"根据设备名过滤"]) {
//                    [_deviceDic setObject:peripheral forKey:[peripheral name]];
//                    // 停止扫描, 看需求决定要不要加
//                    //                    [_centralManager stopScan];
//                    // 将设备信息传到外面的页面(VC), 构成扫描到的设备列表
//                    if ([self.delegate respondsToSelector:@selector(dataWithBluetoothDic:)]) {
//                        [self.delegate dataWithBluetoothDic:_deviceDic];
//                    }
//                }
//            }
//        }
//    }
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
