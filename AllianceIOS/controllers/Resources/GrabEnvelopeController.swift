//
//  GrabEnvelopeController.swift
//  AllianceIOS
//
//  Created by dawei on 15/10/21.
//
//

import UIKit

class GrabEnvelopeController: UIViewController {
    var gray:UIView!
    var close:UIButton!
    var picture:UIImageView!
    var Grabtitle:UILabel!
    var share:UIButton!
    var first1:UILabel!
    var first2:UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        let width=self.view.frame.width
        //背景图
        let BackGround=UIImageView(frame: CGRectMake(0, 0, self.view.frame.width, self.view.frame.height))
        BackGround.image=UIImage(named: "形状-55.png")
        self.view.addSubview(BackGround)
        //抢红包按钮
        let StartGrab=UIButton(frame: CGRectMake(width/8, width*1.23, width/4*3, width/7))
        StartGrab.setBackgroundImage(UIImage(named: "开始抢红包按钮.png"), forState: UIControlState.Normal)
        StartGrab.setTitle("开始抢红包", forState: UIControlState.Normal)
        StartGrab.setTitleColor(UIColor.redColor(), forState: UIControlState.Normal)
        StartGrab.titleLabel?.font=UIFont.systemFontOfSize(25)
        StartGrab.addTarget(self, action: Selector("Grab"), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(StartGrab)
        initBroadCast()
        // Do any additional setup after loading the view.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func Grab(){
        let width=self.view.frame.width
        //半透明
        gray=UIView(frame: CGRectMake(0, 0, width, self.view.frame.height))
        gray.backgroundColor=UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        self.view.addSubview(gray)
        //关闭按钮
        close=UIButton(frame: CGRectMake(width*0.8, width*0.5, width/12, width/12))
        close.setBackgroundImage(UIImage(named: "红包关闭按钮.png"), forState: UIControlState.Normal)
        close.addTarget(self, action: Selector("Cancel"), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(close)
        //弹出图片
        picture=UIImageView(frame: CGRectMake(width*0.1, width*0.6, width*0.8, width*0.8))
        picture.image=UIImage(named: "红包弹出窗.png")
        self.view.addSubview(picture)
        //分享按钮
        share=UIButton(frame: CGRectMake(width*0.2, width*1.18, width*0.6, width*0.1))
        share.setTitleColor(UIColor.redColor(), forState: UIControlState.Normal)
        share.setTitle("分享给好友再抢一次", forState: UIControlState.Normal)
        self.view.addSubview(share)
        //标题
        switch arc4random()%3 {
        case 0:
            Grabtitle=UILabel(frame: CGRectMake(width*0.25, width*0.65, width*0.6, width*0.1))
            Grabtitle.text="很遗憾您没有抢到红包!"
            first1=UILabel(frame: CGRectMake(width*0.3, width*0.85, width*0.4, width*0.06))
            first1.text="叫上您的亲朋好友、"
            first2=UILabel(frame: CGRectMake(width*0.35, width*0.9, width*0.3, width*0.06))
            first2.text="再来抽一次吧！"
        case 1:
            Grabtitle=UILabel(frame: CGRectMake(width*0.33, width*0.65, width*0.33, width*0.1))
            Grabtitle.text="恭喜您！抢到5元"
            first1=UILabel(frame: CGRectMake(width*0.45, width*0.85, width*0.1, width*0.11))
            first1.text="5"
            first1.textColor=UIColor.redColor()
            first1.font=UIFont.systemFontOfSize(55)
            first2=UILabel(frame: CGRectMake(width*0.55, width*0.9, width*0.05, width*0.05))
            first2.text="元"
            first2.textColor=UIColor.redColor()
        case 2:
            Grabtitle=UILabel(frame: CGRectMake(width*0.25, width*0.65, width*0.6, width*0.1))
            Grabtitle.text="恭喜您！抢到5个夺宝币"
            first1=UILabel(frame: CGRectMake(width*0.45, width*0.85, width*0.1, width*0.11))
            first1.text="5"
            first1.textColor=UIColor.redColor()
            first1.font=UIFont.systemFontOfSize(55)
            first2=UILabel(frame: CGRectMake(width*0.55, width*0.9, width*0.1, width*0.05))
            first2.text="夺宝币"
            first2.textColor=UIColor.redColor()
        default:
            break
        }
        Grabtitle.adjustsFontSizeToFitWidth=true
        Grabtitle.textColor=UIColor(red: 111/255, green: 111/255, blue: 111/255, alpha: 1.0)
        self.view.addSubview(Grabtitle)
        
        first1.adjustsFontSizeToFitWidth=true
        
        if first1.text=="叫上您的亲朋好友、" {
            first1.textColor=UIColor(red: 111/255, green: 111/255, blue: 111/255, alpha: 0.44)
        }
        self.view.addSubview(first1)
        first2.adjustsFontSizeToFitWidth=true
        if first2.text=="再来抽一次吧！" {
            first2.textColor=UIColor(red: 111/255, green: 111/255, blue: 111/255, alpha: 0.44)
        }
        self.view.addSubview(first2)
        
    }
    func Cancel(){
        close.removeFromSuperview()
        gray.removeFromSuperview()
        picture.removeFromSuperview()
        Grabtitle.removeFromSuperview()
        first1.removeFromSuperview()
        first2.removeFromSuperview()
        share.removeFromSuperview()
        
    }
    func initBroadCast(){
        let width=self.view.frame.width
        let bg=UIView(frame: CGRectMake(0, width*1.4, width, width/4))
        bg.backgroundColor=UIColor(red: 0, green: 0, blue: 0, alpha: 0.1)
        self.view.addSubview(bg)
        for i in 0...4 {
            let speakerImage=UIImage(named: "小喇叭图标.png")
            let speaker=UIImageView(frame: CGRectMake(width*0.3, width*1.4+20*CGFloat(i)+10,(speakerImage?.size.width)!, speakerImage!.size.height))
            speaker.image=speakerImage
            let content=UILabel(frame: CGRectMake(width*0.3+speakerImage!.size.width+5, width*1.4+20*CGFloat(i)+10, width/2, speakerImage!.size.height))
            content.text="恭喜ksj抢到5元红包"
            content.textColor=UIColor.whiteColor()
            content.font=UIFont.systemFontOfSize(10)
            self.view.addSubview(speaker)
            self.view.addSubview(content)
        }
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
