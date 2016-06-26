//
//  HomeViewController.swift
//  XKSCommonSDK
//
//  Created by _Finder丶Tiwk on 16/2/25.
//  Copyright © 2016年 _Finder丶Tiwk. All rights reserved.
//

import UIKit

class HomeViewController: UITableViewController {
    
    private var printPaperBillNotiObj:AnyObject = NSNull()
    
    override func viewDidLoad() {
        let systemObj            = XKSSystemObj.shareXKSSystemObj()
        systemObj.encryptType    = XKSEncryptType.MD5
        systemObj.shopId         = "customShopID"
        systemObj.deviceNumber   = "AKASFJASDJFNLSKFKSLFSFJSKLFLS"
        systemObj.appKey         = "appKey"
        systemObj.signaterEnable = true
        systemObj.md5Secret      = "helloword"
        systemObj.enviroment     = XKSSDKEnvironment.Debug
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(printPaperBillNotiObj);
    }
    
    override func viewWillAppear(animated: Bool) {
        navigationController?.navigationBarHidden = false
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        // 设备绑定
        if indexPath.row == 0 {
            let controller = XKSDeviceBindingViewController(displayController: self)
            controller.bindingWithBlock({ (dic:[NSObject:AnyObject]!) -> Void in
                print("")
            })
        }
        
        if indexPath.row == 2 {
            let obj            = XKSSystemObj.shareXKSSystemObj()
            obj.encryptType    = XKSEncryptType.MD5
            obj.appKey         = "appKey"
            obj.signaterEnable = true
            obj.md5Secret      = "helloword"
            obj.enviroment     = XKSSDKEnvironment.Debug
        
            
            let requestDic = ["key1":"hello","key2":"world","key3":"3"]
//            let dic = XKSEncryptor.signWithRequestParams(requestDic, uri: "/api/login")
            let dic = XKSEncryptor.signWithRequestParams(requestDic, uri: "/api/login", strategy: XKSEncryptStrategy.A)
            print(dic)
        }
        
        // 二维码扫描
        if indexPath.row == 3 {
            let controller = Demo4ViewController()
            navigationController?.pushViewController(controller, animated: true)
        }
        
        
        // 电子签名
        if indexPath.row == 4 {
            let controler = SignatureViewController()
            controler.showBackButton = true
            controler.dismissBlock = {
                self.dismissViewControllerAnimated(true, completion: nil)
            }
            
            controler.submitBlock = {(image:UIImage!) -> Void in
                XKSAlertWindow.showWithType(XKSAlertType.SUCCESS, message: "签名上传成功")
                self.dismissViewControllerAnimated(true, completion: nil)
            }
            presentViewController(controler, animated: true, completion: nil)
        }
        
        // 蓝牙选择列表
        if indexPath.row == 5 {
            let controler = BluetoothListViewcontroller()
            controler.selectBlock = {(identifier:String!) -> Void in
                XKSAlertWindow.showWithType(XKSAlertType.SUCCESS, message: "当前选中的蓝牙设备为: \(identifier)")
            }
            let size = UIScreen.mainScreen().bounds.size
            controler.preferredContentSize   = CGSize(width: size.width/2, height: size.height/2)
            controler.modalPresentationStyle = UIModalPresentationStyle.FormSheet
            controler.modalTransitionStyle   = UIModalTransitionStyle.CoverVertical
            presentViewController(controler, animated: true, completion: nil)
        }
        
        if indexPath.row == 6 {
            let controller = XKSBillViewController()
            
            
            
            controller.dismissBlock = {
                self.navigationController?.popViewControllerAnimated(true)
            }
            //传入打印纸质账单需要的参数
            controller.printDic = nil;
            controller.submitBlock = {(mobileStr:String!) -> Void in
                self.navigationController?.popViewControllerAnimated(true)
                XKSAlertWindow.showWithType(XKSAlertType.SUCCESS, message: "要打印的电子账单手机号: \(mobileStr)")
            }
            //处理纸质账单通知
            printPaperBillNotiObj = NSNotificationCenter.defaultCenter().addObserverForName(kXKSBillView_PrintPaperBill_Notification, object: nil, queue: nil, usingBlock: { (noti:NSNotification) in
                XKSAlertWindow.showWithType(XKSAlertType.SUCCESS, message: "要打印的纸质账单信息: \(noti.object)")
            })
            
            navigationController?.pushViewController(controller, animated: true)
        }
    }
}
