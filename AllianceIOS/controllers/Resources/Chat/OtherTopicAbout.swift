//
//  OtherTopicAbout.swift
//  AllianceIOS
//
//  Created by dawei on 15/12/15.
//
//

import UIKit
import SwiftHTTP
import JSONJoy

class OtherTopicAbout: UITableViewController {

    var HerPhone=0
    var H=0
    var activityIndicatorView: UIActivityIndicatorView!
    var LiaoBaUserInstance:LiaoBaUser?
        {
        didSet{
            activityIndicatorView.stopAnimating()
            self.activityIndicatorView.hidden=true
            self.tableView.backgroundView=nil
            //self.tableView.reloadData()
            dispatch_async(dispatch_get_main_queue()){
                self.tableView.reloadData()
                self.tableView.refreshHeader.endRefresh()
            }
        }
    }
    var alert:UIAlertController?
    var Fg:Flag?
        {
        didSet{
            self.RefreshData()
//            let reqAction=UIAlertAction(title: "确定", style: UIAlertActionStyle.Default) { (action:UIAlertAction) -> Void in
//                //self.navigationController?.popViewControllerAnimated(true)
//                self.RefreshData()
//            }
//            alert=UIAlertController(title: "", message: Fg?.msg, preferredStyle: UIAlertControllerStyle.Alert)
//            alert!.addAction(reqAction)
//            self.presentViewController(alert!, animated: true, completion: nil)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView=UITableView(frame: self.view.frame, style: UITableViewStyle.Grouped)
        let view1=UIView(frame: CGRectMake(0, 0, self.tableView.frame.size.width, self.tableView.frame.size.height))
        view1.backgroundColor=UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        
        
        activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.White)
        
        activityIndicatorView.frame = CGRectMake(self.tableView.frame.size.width/2-100, -30, 200, 200)
        
        activityIndicatorView.hidesWhenStopped = true
        
        activityIndicatorView.color = UIColor.blackColor()
        view1.addSubview(activityIndicatorView)
        self.tableView.backgroundView=view1
        activityIndicatorView.startAnimating()
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)){
            self.connect()
            
        }
        addRefreshView()
    }
    func connect(){
        do {
            let params:Dictionary<String,AnyObject>=["phone":Phone,"herphone":HerPhone]
            let new=try HTTP.POST(URL+"/tbusers/view", parameters: params)
            new.start { response in
                if let err = response.error {
                    print("error: \(err.localizedDescription)")
                    return //also notify app of failure as needed
                }
                print("opt finished: \(response.description)")
                self.LiaoBaUserInstance = LiaoBaUser(JSONDecoder(response.data))
            }
            
        } catch let error {
            print("got an error creating the request: \(error)")
        }
        
    }
    func addRefreshView(){
        self.tableView.refreshHeader=self.tableView.addRefreshHeaderWithHandler{
            self.RefreshData()
        }
    }
    
    func RefreshData() {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)){
            self.connect()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        if((LiaoBaUserInstance) != nil){
            return 1
        }
        return 0
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return self.view.frame.width/2
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var boundingRect:CGRect
        let cell=UITableViewCell()
        let back=UIImageView(frame: CGRectMake(0,-1, self.view.frame.width, self.view.frame.width/2+1))
        back.image=UIImage(named: "我的背景.png")
        cell.addSubview(back)
        let avator=UIImageView(frame: CGRectMake(self.view.frame.width/32*13,self.view.frame.width/16,self.view.frame.width/16*3 , self.view.frame.width/16*3))
        avator.sd_setImageWithURL(NSURL(string: LiaoBaUserInstance!.thumb)!, placeholderImage: UIImage(named: "avator.jpg"))
        avator.clipsToBounds=true
        avator.layer.cornerRadius=self.view.frame.width/32*3
        cell.addSubview(avator)
        let name=UILabel(frame: CGRectMake(self.view.frame.width/16*7-20,self.view.frame.width/4+10,200,20))
        name.textColor=UIColor.whiteColor()
        name.text=LiaoBaUserInstance!.nickname
        name.font=UIFont.systemFontOfSize(18)
        //name.textColor=UIColor(red: 45/255, green: 100/255, blue: 180/255, alpha: 1.0)
        boundingRect=GetBounds(300, height: 100, font: name.font, str: name.text!)
        name.frame=CGRectMake(self.view.frame.width/2-boundingRect.width/2,self.view.frame.width/4+10,boundingRect.width,boundingRect.height)
        cell.addSubview(name)
        let friend=UILabel(frame: CGRectMake(self.view.frame.width/4,self.view.frame.width/4+40,200,20))
        friend.textColor=UIColor.whiteColor()
        friend.text="人脉好友 "+LiaoBaUserInstance!.friendcount
        friend.font=UIFont.systemFontOfSize(15)
        boundingRect=GetBounds(300, height: 100, font: friend.font, str: friend.text!)
        friend.frame=CGRectMake(self.view.frame.width/2-boundingRect.width-5,name.frame.maxY+5,boundingRect.width,boundingRect.height)
        cell.addSubview(friend)
        let fans=UILabel(frame: CGRectMake(self.view.frame.width/2,self.view.frame.width/4+40,200,20))
        fans.textColor=UIColor.whiteColor()
        fans.text="聊吧粉丝 "+LiaoBaUserInstance!.concerncount
        fans.font=UIFont.systemFontOfSize(15)
        boundingRect=GetBounds(300, height: 100, font: fans.font, str: fans.text!)
        fans.frame=CGRectMake(self.view.frame.width/2+5,name.frame.maxY+5,boundingRect.width,boundingRect.height)
        cell.addSubview(fans)
        let signature=UILabel(frame: CGRectMake(fans.frame.maxY+5,self.view.frame.width/4+60,self.view.frame.width/2,15))
        signature.textColor=UIColor.whiteColor()
        signature.text="个性签名："+LiaoBaUserInstance!.signature
        signature.font=UIFont.systemFontOfSize(14)
        boundingRect=GetBounds(self.view.frame.width/3*2, height: 100, font: signature.font, str: signature.text!)
        signature.frame=CGRectMake(self.view.frame.width/2-boundingRect.width/2,fans.frame.maxY+5,boundingRect.width,boundingRect.height)
        cell.addSubview(signature)
        if(LiaoBaUserInstance!.isconcerned=="0"){
            let concern = UIButton(frame: CGRectMake(self.view.frame.width-50,name.frame.maxY,40,40))
            concern.clipsToBounds=true
            concern.layer.cornerRadius=20
            concern.setBackgroundImage(UIImage(named: "关注2.png"), forState: UIControlState.Normal)
            concern.addTarget(self, action: Selector("Concern"), forControlEvents: UIControlEvents.TouchUpInside)
            cell.addSubview(concern)
            let l=UILabel(frame: CGRectMake(self.view.frame.width-45,concern.frame.maxY+5,30,15))
            l.text="关注"
            l.font=UIFont.systemFontOfSize(15)
            cell.addSubview(l)
        }else{
            let concern = UIButton(frame: CGRectMake(self.view.frame.width-50,name.frame.maxY,40,40))
            concern.clipsToBounds=true
            concern.layer.cornerRadius=20
            concern.setBackgroundImage(UIImage(named: "取消关注.png"), forState: UIControlState.Normal)
            concern.addTarget(self, action: Selector("Cancel"), forControlEvents: UIControlEvents.TouchUpInside)
            cell.addSubview(concern)
            let l=UILabel(frame: CGRectMake(self.view.frame.width-45,concern.frame.maxY+5,30,15))
            l.text="取消"
            l.font=UIFont.systemFontOfSize(15)
            cell.addSubview(l)
        }
        return cell
    }
    func Concern(){
        do {
            let params:Dictionary<String,AnyObject>=["myphone":Phone,"concernphone":HerPhone]
            let new=try HTTP.POST(URL+"/concerns/add", parameters: params)
            new.start { response in
                if let err = response.error {
                    print("error: \(err.localizedDescription)")
                    return //also notify app of failure as needed
                }
                print("opt finished: \(response.description)")
                self.Fg = Flag(JSONDecoder(response.data))
            }
            
        } catch let error {
            print("got an error creating the request: \(error)")
        }
    }
    func Cancel(){
        do {
            let params:Dictionary<String,AnyObject>=["myphone":Phone,"concernphone":self.HerPhone]
            let new=try HTTP.POST(URL+"/concerns/delete", parameters: params)
            new.start { response in
                if let err = response.error {
                    print("error: \(err.localizedDescription)")
                    return //also notify app of failure as needed
                }
                print("opt finished: \(response.description)")
                self.Fg = Flag(JSONDecoder(response.data))
            }
            
        } catch let error {
            print("got an error creating the request: \(error)")
        }
    }

}
