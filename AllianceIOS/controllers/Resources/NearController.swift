//
//  NearController.swift
//  AllianceIOS
//
//  Created by dawei on 15/10/19.
//
//

import UIKit

class NearController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let jobInfo=UIButton(frame: CGRectMake(0, 63, self.view.frame.width/3, self.view.frame.width/3))
        jobInfo.backgroundColor=UIColor.blueColor()
        let specRecommand=UIButton(frame: CGRectMake(self.view.frame.width/3, 63, self.view.frame.width/3, self.view.frame.width/3))
        specRecommand.backgroundColor=UIColor.redColor()
        let hobby=UIButton(frame: CGRectMake(self.view.frame.width/3*2, 63, self.view.frame.width/3, self.view.frame.width/3))
        hobby.backgroundColor=UIColor.greenColor()
        let car=UIButton(frame: CGRectMake(0, 63+self.view.frame.width/3, self.view.frame.width/3, self.view.frame.width/3))
        car.backgroundColor=UIColor.darkGrayColor()
        let other=UIButton(frame: CGRectMake(self.view.frame.width/3, 63+self.view.frame.width/3, self.view.frame.width/3, self.view.frame.width/3))
        other.backgroundColor=UIColor.yellowColor()
        self.view.addSubview(jobInfo)
        self.view.addSubview(specRecommand)
        self.view.addSubview(hobby)
        self.view.addSubview(car)
        self.view.addSubview(other)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
