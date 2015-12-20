//
//  OtherCenter.swift
//  AllianceIOS
//
//  Created by dawei on 15/12/15.
//
//

import UIKit
import SwiftHTTP
import JSONJoy

class OtherCenter: UIViewController {

    var activityIndicatorView: UIActivityIndicatorView!
    var view1=UIView()
    var HerPhone=0
    var Name=""
    let status=OtherTopicList()
    let About=OtherTopicAbout()
    override func viewDidLoad() {
        super.viewDidLoad()

        let center=UILabel(frame: CGRectMake(0,0,50,50))
        center.text=Name+"的聊吧"
        center.font=UIFont.systemFontOfSize(20)
        center.textColor=UIColor.whiteColor()
        self.navigationItem.titleView=center
        About.HerPhone=self.HerPhone
        About.view.frame=CGRectMake(0, 0, self.view.frame.width, self.view.frame.width/2)
        self.addChildViewController(About)
        self.view.addSubview(About.view)
        status.HerPhone=self.HerPhone
        status.view.frame=CGRectMake(0, self.view.frame.width/2, self.view.frame.width, self.view.frame.height)
        self.addChildViewController(status)
        self.view.addSubview(status.view)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
