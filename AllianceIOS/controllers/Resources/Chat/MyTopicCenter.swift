//
//  MyTopicCenter.swift
//  AllianceIOS
//
//  Created by dawei on 15/11/16.
//
//

import UIKit
import SwiftHTTP
import JSONJoy

class MyTopicCenter: UITableViewController {

    var activityIndicatorView: UIActivityIndicatorView!
    var view1=UIView()
    var HerPhone=0
    var LiaoBaFansInstance:LiaobaFans?
    var LiaoBaUserInstance:LiaoBaUser?
        {
        didSet{
            activityIndicatorView.stopAnimating()
            self.activityIndicatorView.hidden=true
            self.tableView.backgroundView=nil
            dispatch_async(dispatch_get_main_queue()){
                self.tableView.reloadData()
                self.tableView.refreshHeader.endRefresh()
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView=UITableView(frame: self.view.frame, style: UITableViewStyle.Grouped)
        view1=UIView(frame: CGRectMake(0, 0, self.tableView.frame.size.width, self.tableView.frame.size.height))
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
        print("聊吧主界面")
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
            let param:Dictionary<String,AnyObject>=["phone":Phone]
            let fans=try HTTP.POST(URL+"/tbusers/myfans", parameters: param)
            fans.start { response in
                if let err = response.error {
                    print("error: \(err.localizedDescription)")
                    return //also notify app of failure as needed
                }
                print("opt finished: \(response.description)")
                self.LiaoBaFansInstance = LiaobaFans(JSONDecoder(response.data))
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
            return 2
        }
        return 0
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if(section==1){
            return 3
        }
        return 2
    }
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if(indexPath.section==0 && indexPath.row==0){
            return self.view.frame.width/2
        }
        return 50
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if(indexPath.section==0){
            if(indexPath.row==0){
                return FirstCell()
            }
            return SecondCell()
        }else{
            var content=["我的关注","我的话题","我的点赞"]
            let cell=UITableViewCell()
            cell.accessoryType=UITableViewCellAccessoryType.DisclosureIndicator
            let title=UILabel(frame: CGRectMake(20,20,150,15))
            title.text=content[indexPath.row]
            cell.addSubview(title)
            return cell
        }
    }
    func FirstCell()->UITableViewCell{
        let cell=UITableViewCell()
        var boundingRect:CGRect
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
        
        return cell
    }
    func SecondCell()->UITableViewCell{
        let cell=UITableViewCell()
        
        if((LiaoBaFansInstance) != nil){
            cell.accessoryType=UITableViewCellAccessoryType.DisclosureIndicator
            if(LiaoBaFansInstance!.items.count>0){
                for i in 0...((LiaoBaFansInstance!.items.count-1)%4) {
                    let avator=UIImageView(frame: CGRectMake(20+60*CGFloat(i), 5, 40, 40))
                    avator.sd_setImageWithURL(NSURL(string: LiaoBaFansInstance!.items[i].thumb)!, placeholderImage: UIImage(named: "avator.jpg"))
                    avator.clipsToBounds=true
                    avator.layer.cornerRadius=20
                    let avatorBtn=UIButton(frame: CGRectMake(20+60*CGFloat(i), 5, 40, 40))
                    avatorBtn.addTarget(self, action: Selector("Detail:"), forControlEvents: UIControlEvents.TouchUpInside)
                    avatorBtn.tag=100000+i
                    cell.addSubview(avator)
                    cell.addSubview(avatorBtn)
                }
            }
            let like=UIImageView(frame: CGRectMake(self.view.frame.width-100, 15, 15, 15))
            like.image=UIImage(named: "喜欢1.png")
            cell.addSubview(like)
            let fans=UILabel(frame: CGRectMake(self.view.frame.width-80,15,75,17))
            fans.text="新的粉丝"
            fans.textColor=UIColor(red: 186/255, green: 186/255, blue: 186/255, alpha: 0.77)
            fans.font=UIFont.systemFontOfSize(13)
            cell.addSubview(fans)
        }else{
            let reminder=UILabel(frame: CGRectMake(20,15,300,20))
            reminder.text="你还没有粉丝-_-"
            reminder.font=UIFont.systemFontOfSize(17)
            reminder.textColor=UIColor(red: 186/255, green: 186/255, blue: 186/255, alpha: 1.0)
            cell.addSubview(reminder)
        }
        
        
        return cell
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
        if(indexPath.section==1){
            switch indexPath.row{
            case 0:
                let anotherView=Focus()
                anotherView.HerPhone=Int(HerPhone)
                self.navigationController?.pushViewController(anotherView, animated: true)
            case 1:
                let anotherView=MyTopicList()
                self.navigationController?.pushViewController(anotherView, animated: true)
            case 2:
                let anotherView=MyZan()
                self.navigationController?.pushViewController(anotherView, animated: true)
            default:
                break
            }
        }else{
            if(indexPath.row==1 && (LiaoBaFansInstance) != nil){
                let anotherView=MyFans()
                self.navigationController?.pushViewController(anotherView, animated: true)
            }
        }
    }
    func Detail(sender:UIButton){
        let anotherView=OtherCenter()
        anotherView.HerPhone=Int(self.LiaoBaFansInstance!.items[sender.tag-100000].phone)!
        anotherView.Name=self.LiaoBaFansInstance!.items[sender.tag-100000].nickname
        self.navigationController?.pushViewController(anotherView, animated: true)
    }

}
