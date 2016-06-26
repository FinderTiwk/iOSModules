//
//  Demo2ViewController.swift
//  XKSCommonSDK
//
//  Created by _Finder丶Tiwk on 16/2/25.
//  Copyright © 2016年 _Finder丶Tiwk. All rights reserved.
//

import UIKit

class Demo2ViewController: UIViewController {

    @IBOutlet weak var textField: UITextView!
    private let animationKey           = "scaleAnimation"
    private var alertType:XKSAlertType = XKSAlertType.SUCCESS
    
    func scaleAnimation() -> CABasicAnimation {
        
        let animation            = CABasicAnimation(keyPath: "transform.scale")
        animation.fromValue      = NSNumber(float: 0.93)
        animation.toValue        = NSNumber(float: 0.93)
        animation.duration       = 0.2
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
        animation.autoreverses   = false
        return animation
    }
    
    @IBAction func changeAlertType(sender: UISegmentedControl) {
        let index = sender.selectedSegmentIndex
        if index == 0 {
            alertType = XKSAlertType.SUCCESS
        }else if index == 1 {
            alertType = XKSAlertType.WARNING
        }else{
            alertType = XKSAlertType.FAILURE
        }
    }
    
    
    @IBAction func clickAction1(sender: UIButton) {
        sender.layer.addAnimation(scaleAnimation(), forKey: animationKey)
        let alertMsg = textField.text
        XKSAlertWindow.showWithType(alertType, message: alertMsg)
    }
    
    @IBAction func clickAction2(sender: UIButton) {
        sender.layer.addAnimation(scaleAnimation(), forKey: animationKey)
        let alertMsg = textField.text
        
        XKSAlertWindow.showWithType(alertType, message: alertMsg, action: { () -> Void in
                print("点击了右边的按钮")
            }, t1: "朕知道了", cancle: { () -> Void in
                print("点击了左边的按钮")
            }, t2: "不约")
    }
    
}
