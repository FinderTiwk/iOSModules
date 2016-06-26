//
//  BluetoothListViewcontroller.m
//  XKSCommonSDK
//
//  Created by _Finder丶Tiwk on 16/1/25.
//  Copyright © 2016年 _Finder丶Tiwk. All rights reserved.
//

#import <CoreBluetooth/CoreBluetooth.h>
#import "BluetoothListViewcontroller.h"
#import "UIImage+Xkeshi.h"

@interface BluetoothListViewcontroller ()<UITableViewDelegate,UITableViewDataSource,CBCentralManagerDelegate>

@property (nonatomic,weak)   UITableView        *tableView;
@property (nonatomic,strong) CBCentralManager   *bluetoothManager;
@property (nonatomic,strong) NSMutableArray     *bluetoothArray;

@end

@implementation BluetoothListViewcontroller


#pragma mark - Accessor
- (NSMutableArray *)bluetoothArray{
    if (!_bluetoothArray) {
        _bluetoothArray = [NSMutableArray array];
    }
    return _bluetoothArray;
}

#pragma mark - ViewLifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    _bluetoothManager = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    self.view.backgroundColor = [UIColor whiteColor];
    CGSize size               = self.view.frame.size;
    CGFloat height            = size.height;
    CGFloat width             = size.width;
    
    UILabel *titlelabel = [[UILabel alloc] initWithFrame:CGRectMake(0,0,width,60)];
    titlelabel.text            = @"连接蓝牙设备";
    titlelabel .textAlignment  = NSTextAlignmentCenter;
    titlelabel.backgroundColor = [UIColor clearColor];
    [titlelabel setTextColor:[UIColor whiteColor]];
    [self.view addSubview:titlelabel];
    
    UIButton *closeBtn       = [UIButton buttonWithType:UIButtonTypeCustom];
    closeBtn.frame           = CGRectMake(10, 20, 40, 40);
    closeBtn.backgroundColor = [UIColor clearColor];
    [closeBtn setImage:[UIImage xks_imageNamed:@"sg_back_button" fromBundle:XKSCommonSDKBundleName] forState:UIControlStateNormal];
    [closeBtn setImage:[UIImage xks_imageNamed:@"sg_back_button_highlight" fromBundle:XKSCommonSDKBundleName] forState:UIControlStateHighlighted];
    [closeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(closeAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:closeBtn];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 70, width, height-60)];
    _tableView = tableView;
    
    tableView.delegate           = self;
    tableView.dataSource         = self;
    tableView.tableFooterView    = [[UIView alloc] init];
    tableView.estimatedRowHeight = 50.f;
    tableView.rowHeight          = UITableViewAutomaticDimension;
    
    [self.view addSubview:tableView];
}

#pragma mark - Actions
- (void)closeAction:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        if (self.cancelBlock) {
            self.cancelBlock();
        }
    }];
}

#pragma mark - UITableViewDelegate & UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.bluetoothArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"bluetoothCellID";
    UITableViewCell *cell   = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    CBPeripheral *peripheral     = self.bluetoothArray[indexPath.row];
    cell.textLabel.text          = peripheral.name;
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self dismissViewControllerAnimated:YES completion:^{
        if (self.selectBlock) {
            CBPeripheral *peripheral = self.bluetoothArray[indexPath.row];
            self.selectBlock(peripheral.identifier.UUIDString);
        }
    }];
}

#pragma mark  - CBCentralManagerDelegate
- (void)centralManagerDidUpdateState:(CBCentralManager *)central{
    if (central.state == CBCentralManagerStatePoweredOn) {
        [self.bluetoothManager scanForPeripheralsWithServices:nil options:nil];
    }
}

- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary<NSString *,id> *)advertisementData RSSI:(NSNumber *)RSSI{
    if (peripheral.name && peripheral.name.length > 0) {
        if (![self.bluetoothArray containsObject:peripheral]) {
            [self.bluetoothArray addObject:peripheral];
            [_tableView reloadData];
        }
    }
}

@end
