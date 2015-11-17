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
        self.navigationItem.backBarButtonItem=UIBarButtonItem(title: "", style: UIBarButtonItemStyle.Plain, target: nil, action: nil)
        let width=self.view.frame.width
        //求职信息
        let jobInfo=UIButton(frame: CGRectMake(0, 0, width/3, width/3))
        jobInfo.tag=1
        jobInfo.addTarget(self, action:Selector("ButtonAction:"), forControlEvents: UIControlEvents.TouchUpInside)
        let jobInfoIco=UIImageView(frame: CGRectMake(width/9, width/12, width/9, width/9))
        jobInfoIco.image=UIImage(named: "求职信息.png")
        let jobInfoLabel=UILabel(frame: CGRectMake(width/12, width/36*7, width/6, width/12))
        jobInfoLabel.text="求职信息"
        jobInfoLabel.textColor=UIColor(red: 111/255, green: 111/255, blue: 111/255, alpha: 1)
        jobInfoLabel.adjustsFontSizeToFitWidth=true
        self.view.addSubview(jobInfo)
        self.view.addSubview(jobInfoIco)
        self.view.addSubview(jobInfoLabel)
        //特色推荐
        let specRecommand=UIButton(frame: CGRectMake(width/3, 0, width/3, width/3))
        specRecommand.tag=2
        specRecommand.addTarget(self, action:Selector("ButtonAction:"), forControlEvents: UIControlEvents.TouchUpInside)
        let SRIco=UIImageView(frame: CGRectMake(width/3+width/9, width/12, width/9, width/9))
        SRIco.image=UIImage(named: "特色推荐.png")
        let SRLabel=UILabel(frame: CGRectMake(width/3+width/12, width/36*7, width/6, width/12))
        SRLabel.text="特色推荐"
        SRLabel.textColor=UIColor(red: 111/255, green: 111/255, blue: 111/255, alpha: 1)
        SRLabel.adjustsFontSizeToFitWidth=true
        self.view.addSubview(specRecommand)
        self.view.addSubview(SRIco)
        self.view.addSubview(SRLabel)
        //爱好交友
        let hobby=UIButton(frame: CGRectMake(width/3*2, 0, width/3, width/3))
        hobby.tag=3
        hobby.addTarget(self, action:Selector("ButtonAction:"), forControlEvents: UIControlEvents.TouchUpInside)
        let hobbyIco=UIImageView(frame: CGRectMake(width/3*2+width/9, width/12, width/9, width/9))
        hobbyIco.image=UIImage(named: "爱好交友.png")
        let hobbyLabel=UILabel(frame: CGRectMake(width/3*2+width/12, width/36*7, width/6, width/12))
        hobbyLabel.text="爱好交友"
        hobbyLabel.textColor=UIColor(red: 111/255, green: 111/255, blue: 111/255, alpha: 1)
        hobbyLabel.adjustsFontSizeToFitWidth=true
        self.view.addSubview(hobby)
        self.view.addSubview(hobbyIco)
        self.view.addSubview(hobbyLabel)
        //其他
        let other=UIButton(frame: CGRectMake(0, width/3, width/3, width/3))
        other.tag=4
        other.addTarget(self, action:Selector("ButtonAction:"), forControlEvents: UIControlEvents.TouchUpInside)
        let otherIco=UIImageView(frame: CGRectMake(width/9, width/12+width/3, width/9, width/9))
        otherIco.image=UIImage(named: "其他.png")
        let otherLabel=UILabel(frame: CGRectMake(width/8, width/36*7+width/3, width/12, width/12))
        otherLabel.text="其他"
        otherLabel.textColor=UIColor(red: 111/255, green: 111/255, blue: 111/255, alpha: 1)
        otherLabel.adjustsFontSizeToFitWidth=true
        self.view.addSubview(other)
        self.view.addSubview(otherIco)
        self.view.addSubview(otherLabel)
        
        // Do any additional setup after loading the view.
    }
    func ButtonAction(sender:UIButton){
        switch sender.tag {
        case 1:
            let anotherView:UIViewController=self.storyboard!.instantiateViewControllerWithIdentifier("JobInfo");
            self.navigationController?.pushViewController(anotherView, animated: true)
        case 2:
            let anotherView:UIViewController=self.storyboard!.instantiateViewControllerWithIdentifier("Speciality");
            self.navigationController?.pushViewController(anotherView, animated: true)
        case 3:
            let anotherView:UIViewController=self.storyboard!.instantiateViewControllerWithIdentifier("Hobby");
            self.navigationController?.pushViewController(anotherView, animated: true)
            
        default:
            break
        }
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
