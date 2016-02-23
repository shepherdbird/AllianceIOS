//
//  AllianceGive.swift
//  AllianceIOS
//
//  Created by dawei on 15/11/6.
//
//

import UIKit

class AllianceGive: UIViewController {

    
    var Money="0"
    override func viewDidLoad() {
        super.viewDidLoad()
        var boundingRect:CGRect
        let AG=self.view
        self.view.backgroundColor=UIColor.whiteColor()
        self.navigationItem.rightBarButtonItem=UIBarButtonItem(title:"规则说明", style: UIBarButtonItemStyle.Plain, target: self, action: Selector("Save"))
        self.navigationItem.rightBarButtonItem?.tintColor=UIColor(red: 220/255, green: 100/255, blue: 100/255, alpha: 1.0)
        let center=UILabel(frame: CGRectMake(0,0,50,50))
        center.text="联盟奖励"
        center.font=UIFont.systemFontOfSize(20)
        center.textColor=UIColor.whiteColor()
        self.navigationItem.titleView=center
        self.navigationItem.backBarButtonItem?.title=""
        let bg=UIImageView(frame: CGRectMake(0, 0, AG.frame.width, AG.frame.width/2))
        bg.image=UIImage(named: "联盟奖励背景.png")
        AG.addSubview(bg)
        let explain=UILabel(frame: CGRectMake(AG.frame.width/2-75,40+60,150,40))
        explain.text="未提取的联盟奖励(元)"
        
        explain.textColor=UIColor.whiteColor()
        explain.font=UIFont.systemFontOfSize(18)
        boundingRect=GetBounds(300, height: 100, font: explain.font, str: explain.text!)
        explain.frame=CGRectMake(self.view.frame.width/2-boundingRect.width/2,25,boundingRect.width,boundingRect.height)
        AG.addSubview(explain)
        let money=UILabel(frame: CGRectMake(AG.frame.width/2-120,AG.frame.width/4+60,300,60))
        money.text=String(Money)
        money.textColor=UIColor.whiteColor()
        money.font=UIFont.systemFontOfSize(36)
        boundingRect=GetBounds(300, height: 100, font: money.font, str: money.text!)
        money.frame=CGRectMake(self.view.frame.width/2-boundingRect.width/2,self.view.frame.width/4-boundingRect.height/2,boundingRect.width,boundingRect.height)
        AG.addSubview(money)
        let alert=UILabel(frame: CGRectMake(AG.frame.width/2-80,AG.frame.width/4+100+60,150,20))
        alert.text="联盟奖励只能提取一次"
        alert.textColor=UIColor.whiteColor()
        alert.font=UIFont.systemFontOfSize(15)
        boundingRect=GetBounds(300, height: 100, font: alert.font, str: alert.text!)
        alert.frame=CGRectMake(self.view.frame.width/2-boundingRect.width/2,self.view.frame.width/2-40,boundingRect.width,boundingRect.height)
        AG.addSubview(alert)
        //提取按钮
        let extract=UIButton(frame: CGRectMake(10,AG.frame.width/2+10,AG.frame.width-20,50))
        extract.setTitle("申请提取", forState: UIControlState.Normal)
        extract.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        extract.titleLabel?.font=UIFont.systemFontOfSize(20)
        extract.clipsToBounds=true
        extract.layer.cornerRadius=5
        extract.backgroundColor=UIColor(red: 200/255, green: 0, blue: 0, alpha: 1.0)
        AG.addSubview(extract)
        
        let invite=UILabel(frame: CGRectMake(10,AG.frame.width/2+70,300,30))
        invite.text="快去邀请好友提升收益吧！"
        //invite.textColor=UIColor(red: 200/255, green: 0/255, blue: 0/255, alpha: 1.0)
        invite.font=UIFont.systemFontOfSize(15)
        AG.addSubview(invite)
        
        let inviteBtn=UIButton(frame: CGRectMake(AG.frame.width-100,AG.frame.width/2+70,90,30))
        inviteBtn.backgroundColor=UIColor.grayColor()
        inviteBtn.setTitle("邀请好友", forState: UIControlState.Normal)
        //inviteBtn.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        inviteBtn.titleLabel?.font=UIFont.systemFontOfSize(15)
        inviteBtn.clipsToBounds=true
        inviteBtn.layer.cornerRadius=3
        //inviteBtn.backgroundColor=UIColor(red: 200/255, green: 0, blue: 0, alpha: 1.0)
        AG.addSubview(inviteBtn)
        //AG.backgroundColor=UIColor(red: 186/255, green: 186/255, blue: 186/255, alpha: 0.44)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func Save(){
        
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
