//
//  MyCollectefore.swift
//  AllianceIOS
//
//  Created by dawei on 16/1/16.
//
//

import UIKit
import SwiftHTTP
import JSONJoy
class MyCollectbefore: UIViewController {
    
    var activityIndicatorView: UIActivityIndicatorView!
    var view1=UIView()
    let sns=MyCollect()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let center=UILabel(frame: CGRectMake(0,0,50,50))
        center.text="朋友圈"
        center.font=UIFont.systemFontOfSize(20)
        center.textColor=UIColor.whiteColor()
        self.navigationItem.titleView=center
        self.view.backgroundColor=UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        //        About.HerPhone=self.HerPhone
        //        About.view.frame=CGRectMake(0, 0, self.view.frame.width, self.view.frame.width/2)
        //        self.addChildViewController(About)
        //        self.view.addSubview(About.view)
        sns.view.frame=CGRectMake(0, 0, self.view.frame.width, self.view.frame.height)
        self.addChildViewController(sns)
        self.view.addSubview(sns.view)
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
