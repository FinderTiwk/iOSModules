//
//  Demo4ViewController.swift
//  XKSCommonSDK
//
//  Created by _Finder丶Tiwk on 16/2/25.
//  Copyright © 2016年 _Finder丶Tiwk. All rights reserved.
//

import UIKit

class Demo4ViewController: UIViewController {
    
    private var qrCodeView:QRCodeView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.clearColor()

        qrCodeView = QRCodeView(frame: view.frame)
        qrCodeView!.maskInsets = UIEdgeInsets(top: 300, left: 100, bottom: 100, right: 100)
        qrCodeView!.animationType = 1
        qrCodeView!.scanBlock = {(result:String!) -> Void in
            XKSAlertWindow.showWithType(XKSAlertType.SUCCESS, message: "扫描到内容:\(result)", action: {
                    self.qrCodeView!.startScan()
                }
                ,cancle: {
                    self.qrCodeView!.stopScan()
                })
        }
        view.addSubview(qrCodeView!)
        qrCodeView!.startScan()
    }
}
