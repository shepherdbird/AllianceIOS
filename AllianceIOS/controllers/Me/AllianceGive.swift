//
//  AllianceGive.swift
//  AllianceIOS
//
//  Created by dawei on 15/11/6.
//
//

import UIKit

class AllianceGive: UIViewController {

    @IBOutlet var AG: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let bg=UIImageView(frame: CGRectMake(0, 60, AG.frame.width, AG.frame.width/4*3))
        bg.image=UIImage(named: "联盟奖励背景.png")
        AG.addSubview(bg)
        let explain=UILabel(frame: CGRectMake(AG.frame.width/2-75,40+60,150,40))
        explain.text="未提取的联盟奖励(元)"
        //explain.numberOfLines=0
        explain.textColor=UIColor.whiteColor()
        explain.font=UIFont.systemFontOfSize(15)
        AG.addSubview(explain)
        let money=UILabel(frame: CGRectMake(AG.frame.width/2-120,AG.frame.width/4+60,300,60))
        money.text="600.00"
        money.textColor=UIColor.whiteColor()
        money.font=UIFont.systemFontOfSize(72)
        AG.addSubview(money)
        let alert=UILabel(frame: CGRectMake(AG.frame.width/2-80,AG.frame.width/4+100+60,150,20))
        alert.text="!联盟奖励只能提取一次"
        alert.textColor=UIColor(red: 111/255, green: 111/255, blue: 111/255, alpha: 0.44)
        alert.font=UIFont.systemFontOfSize(13)
        AG.addSubview(alert)
        let AlreadyGet=UILabel(frame: CGRectMake(10,AG.frame.width/4*3+10+60,40,15))
        AlreadyGet.text="已提取"
        AlreadyGet.textColor=UIColor(red: 111/255, green: 111/255, blue: 111/255, alpha: 0.44)
        AlreadyGet.font=UIFont.systemFontOfSize(13)
        AG.addSubview(AlreadyGet)
        let AlreadyGetMoney=UILabel(frame: CGRectMake(10,AG.frame.width/4*3+25+60,60,30))
        AlreadyGetMoney.text="0"
        AlreadyGetMoney.textColor=UIColor(red: 200/255, green: 0/255, blue: 0/255, alpha: 1.0)
        AlreadyGetMoney.font=UIFont.systemFontOfSize(20)
        AG.addSubview(AlreadyGetMoney)
        let CanGet=UILabel(frame: CGRectMake(AG.frame.width/2+10,AG.frame.width/4*3+10+60,40,20))
        CanGet.text="可提取"
        CanGet.textColor=UIColor(red: 111/255, green: 111/255, blue: 111/255, alpha: 0.44)
        CanGet.font=UIFont.systemFontOfSize(13)
        AG.addSubview(CanGet)
        let CanGetmoney=UILabel(frame: CGRectMake(AG.frame.width/2+10,AG.frame.width/4*3+25+60,100,40))
        CanGetmoney.text="600.00"
        CanGetmoney.textColor=UIColor(red: 200/255, green: 0/255, blue: 0/255, alpha: 1.0)
        CanGetmoney.font=UIFont.systemFontOfSize(20)
        AG.addSubview(CanGetmoney)
        //提取按钮
        let extract=UIButton(frame: CGRectMake(10,AG.frame.width+30,AG.frame.width-20,50))
        extract.setTitle("提取", forState: UIControlState.Normal)
        extract.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        extract.titleLabel?.font=UIFont.systemFontOfSize(18)
        extract.clipsToBounds=true
        extract.layer.cornerRadius=5
        extract.backgroundColor=UIColor(red: 200/255, green: 0, blue: 0, alpha: 1.0)
        AG.addSubview(extract)
        
        let invite=UILabel(frame: CGRectMake(10,AG.frame.width+90,300,30))
        invite.text="快去邀请好友提升收益吧！"
        //invite.textColor=UIColor(red: 200/255, green: 0/255, blue: 0/255, alpha: 1.0)
        invite.font=UIFont.systemFontOfSize(14)
        AG.addSubview(invite)
        
        let inviteBtn=UIButton(frame: CGRectMake(AG.frame.width-100,AG.frame.width+90,90,30))
        inviteBtn.backgroundColor=UIColor.blackColor()
        inviteBtn.setTitle("邀请好友", forState: UIControlState.Normal)
        //inviteBtn.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
