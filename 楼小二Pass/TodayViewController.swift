//
//  TodayViewController.swift
//  楼小二Pass
//
//  Created by Chih-Hao on 2017/8/8.
//  Copyright © 2017年 Chih-Hao. All rights reserved.
//

import UIKit
import NotificationCenter
import EFQRCode
class TodayViewController: UIViewController, NCWidgetProviding {
    @IBOutlet weak var img: UIImageView!
        
    @IBAction func btnClicked(_ sender: Any) {
        refresh ()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

            
            self.preferredContentSize = CGSize(width:self.view.frame.size.width, height:250)
            
            if #available(iOSApplicationExtension 10.0, *) {
                self.extensionContext?.widgetLargestAvailableDisplayMode = .expanded
            }
        }
        
        
        @available(iOS 10.0, *)
        @available(iOSApplicationExtension 10.0, *)
        func widgetActiveDisplayModeDidChange(_ activeDisplayMode: NCWidgetDisplayMode, withMaximumSize maxSize: CGSize) {
            if activeDisplayMode == .expanded {
                self.preferredContentSize = CGSize(width: self.view.frame.size.width, height: CGFloat(2.5)*100)
            }else if activeDisplayMode == .compact{
                self.preferredContentSize = CGSize(width: maxSize.width, height: 250)
            }
        
        
        refresh ()
        // Do any additional setup after loading the view from its nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.
        
        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        refresh ()
        completionHandler(NCUpdateResult.newData)
    }
    
    
    
    func getNow() -> String{
        
        var now = Date()
        
        let dformatter = DateFormatter()
        
        //当前时间的时间戳
        let timeInterval:TimeInterval = now.timeIntervalSince1970 * 1000
        let timeStamp = Int(timeInterval)
//        print("当前时间的时间戳：\(timeStamp)")
//        print(String(timeStamp)+"999")
        return String(timeStamp)
        
        
    }
    
    
    func refresh (){
        var pass = "52746|18616022533|"+getNow()+"|310110B006"
        
//        print(pass)
        if let tryImage = EFQRCode.generate(
            content: pass,
            magnification: EFIntSize(width: 9, height: 9),
            watermark: EFWatermark(image: UIImage(named: "WWF")?.toCGImage(), mode: .scaleAspectFill, isColorful: false)
            ) {
            img.image =  UIImage(cgImage: tryImage)
        } else {
            print("Create QRCode image failed!")
        }
    }
    
}
