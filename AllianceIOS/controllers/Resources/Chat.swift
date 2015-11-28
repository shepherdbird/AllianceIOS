//
//  Chat.swift
//  AllianceIOS
//
//  Created by dawei on 15/11/13.
//
//

import UIKit
import SwiftHTTP
import JSONJoy

class Chat: UITableViewController {
    
    @IBOutlet var C: UITableView!
    var index=0
    var alert:UIAlertController!
    var phone="2"
    var activityIndicatorView: UIActivityIndicatorView!
    var view1=UIView()
    var ChatPoPularityListInstance:ChatPopularityList?
    var ChatMessageListInstance:ChatMessageList?
        {
        didSet{
            activityIndicatorView.stopAnimating()
            self.activityIndicatorView.hidden=true
            self.tableView.backgroundView=nil
            self.tableView.reloadData()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.backBarButtonItem=UIBarButtonItem(title: "", style: UIBarButtonItemStyle.Plain, target: nil, action: nil)
        self.navigationItem.rightBarButtonItem=UIBarButtonItem(image: UIImage(named: "发帖按钮.png"), style: UIBarButtonItemStyle.Plain, target: self, action: Selector("mine"))
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        let reqAction=UIAlertAction(title: "发表话题", style: UIAlertActionStyle.Default) { (action:UIAlertAction) -> Void in
            let anotherView:UIViewController=self.storyboard!.instantiateViewControllerWithIdentifier("SendTopic");
            self.navigationController?.pushViewController(anotherView, animated: true)
            //print("我要求职")
        }
        let myreqAction=UIAlertAction(title: "我的聊吧", style: UIAlertActionStyle.Default) { (action:UIAlertAction) -> Void in
            let anotherView:UIViewController=self.storyboard!.instantiateViewControllerWithIdentifier("MyTopicCenter");
            self.navigationController?.pushViewController(anotherView, animated: true)
            //print("我要求职")
        }
        alert=UIAlertController(title: "", message: "", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(reqAction)
        alert.addAction(myreqAction)
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
    }
    func mine(){
        self.presentViewController(alert, animated: true, completion: nil)
    }
    func connect(){
        print("聊吧主界面")
        do {
            let params:Dictionary<String,AnyObject>=["phone":phone]
            var new=try HTTP.POST(URL+"/tbmessages/new", parameters: params)
            if index==1 {
                new=try HTTP.POST(URL+"/tbmessages/hot", parameters: params)
            }else if( index==3){
                new=try HTTP.POST(URL+"/tbmessages/myconcerns", parameters: params)
            }
            new.start { response in
                if let err = response.error {
                    print(1)
                    print("error: \(err.localizedDescription)")
                    return //also notify app of failure as needed
                }
                print("opt finished: \(response.description)")
                self.ChatMessageListInstance = ChatMessageList(JSONDecoder(response.data))
            }
            let hot=try HTTP.POST(URL+"/tbusers/hot", parameters: params)
            hot.start { response in
                if let err = response.error {
                    print(1)
                    print("error: \(err.localizedDescription)")
                    return //also notify app of failure as needed
                }
                print("opt finished: \(response.description)")
                self.ChatPoPularityListInstance=ChatPopularityList(JSONDecoder(response.data))
                
            }
            
        } catch let error {
            print("got an error creating the request: \(error)")
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        if((ChatMessageListInstance) != nil){
            return 2
        }
        return 0
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if(section==0){
            return 1
        }
        if(index==2){
            return ChatPoPularityListInstance!.items.count
        }
        return (ChatMessageListInstance?.items.count)!
    }
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.1
    }
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 5
    }
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if(indexPath.section==0){
            return 50
        }
        if(index==2){
            return 80
        }
        return 120
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if(indexPath.section==0){
            return FirstCell(index)
        }
        if(index==2){
            return popularity(indexPath.row)
        }
        return Common(index,row: indexPath.row)
    }
    func FirstCell(index:Int)->UITableViewCell{
        let cell=UITableViewCell()
        let title=["最新","热门","人气","关注"]
        for i in 0...3{
            let btn=UIButton(frame: CGRectMake(self.view.frame.width/4*CGFloat(Float(i)),0,self.view.frame.width/4,50))
            btn.setTitle(title[i], forState: UIControlState.Normal)
            btn.tag=i
            btn.titleLabel?.font=UIFont.systemFontOfSize(18)
            btn.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
            btn.addTarget(self, action: Selector("ButtonAction:"), forControlEvents: UIControlEvents.TouchUpInside)
            if(index==i){
                btn.setTitleColor(UIColor(red: 200/255, green: 100/255, blue: 100/255, alpha: 1.0), forState: UIControlState.Normal)
            }
            cell.addSubview(btn)
        }
        return cell
    }
    func ButtonAction(sender:UIButton){
        index=sender.tag
        self.tableView.backgroundView=view1
        activityIndicatorView.startAnimating()
        activityIndicatorView.hidden=false
        connect()
        C.reloadData()
    }
    func Common(index:Int,row:Int)->UITableViewCell{
        let cell=UITableViewCell()
        let avator=UIImageView(frame: CGRectMake(5, 5, 30, 30))
        avator.clipsToBounds=true
        avator.layer.cornerRadius=15
        if let Ndata=NSData(contentsOfURL:NSURL(string: (ChatMessageListInstance?.items[row].thumb)!)!){
            avator.image=UIImage(data: Ndata)
        }
        cell.addSubview(avator)
        let name=UILabel(frame: CGRectMake(40,10,60,15))
        name.text=ChatMessageListInstance!.items[row].nickname
        name.font=UIFont.systemFontOfSize(15)
        name.textColor=UIColor(red: 186/255, green: 186/255, blue: 186/255, alpha: 0.77)
        cell.addSubview(name)
        let time=UILabel(frame: CGRectMake(90,10,200,15))
        let lin=ChatMessageListInstance!.items[row].created_at
        time.text=String(NSDate(timeIntervalSince1970: Double(lin)!))
        time.font=UIFont.systemFontOfSize(13)
        time.textColor=UIColor(red: 186/255, green: 186/255, blue: 186/255, alpha: 0.77)
        cell.addSubview(time)
        
        let type=UIImageView(frame: CGRectMake(10, 40, 20, 20))
        type.clipsToBounds=true
        type.layer.cornerRadius=2
        if(index==0){
            type.image=UIImage(named: "组-1.png")
        }else if(index==1){
            type.image=UIImage(named: "热图标.png")
        }
        
        cell.addSubview(type)
        let title=UILabel(frame: CGRectMake(35,40,self.view.frame.width-40,22))
        title.text=ChatMessageListInstance!.items[row].content
        title.font=UIFont.systemFontOfSize(17)
        //title.textColor=UIColor(red: 186/255, green: 186/255, blue: 186/255, alpha: 0.77)
        cell.addSubview(title)
        let content=UILabel(frame: CGRectMake(5,65,self.view.frame.width-10,30))
        content.text=ChatMessageListInstance!.items[row].content
        content.font=UIFont.systemFontOfSize(15)
        content.numberOfLines=0
        content.textColor=UIColor(red: 111/255, green: 111/255, blue: 111/255, alpha: 1.0)
        cell.addSubview(content)
        if ChatMessageListInstance!.items[row].isconcerned=="1" {
            let focus=UILabel(frame: CGRectMake(10,100,60,15))
            focus.textColor=UIColor(red: 186/255, green: 186/255, blue: 186/255, alpha: 0.77)
            focus.text="已关注"
            focus.font=UIFont.systemFontOfSize(13)
            cell.addSubview(focus)
        }else{
            let focusIcon=UIImageView(frame: CGRectMake(10, 100, 15, 15))
            focusIcon.image=UIImage(named: "关注图标.png")
            cell.addSubview(focusIcon)
            let focusBtn=UIButton(frame: CGRectMake(30,100,50,15))
            focusBtn.setTitle("关注TA", forState: UIControlState.Normal)
            focusBtn.titleLabel?.font=UIFont.systemFontOfSize(13)
            focusBtn.setTitleColor(UIColor(red: 230/255, green: 120/255, blue: 40/255, alpha: 1.0), forState: UIControlState.Normal)
            cell.addSubview(focusBtn)
        }
        let like=UIButton(frame: CGRectMake(self.view.frame.width/3*2, 100, 15, 15))
        like.addTarget(self, action: Selector("Like:"), forControlEvents: UIControlEvents.TouchUpInside)
        if ChatMessageListInstance!.items[row].isliked=="1" {
            like.setBackgroundImage(UIImage(named: "喜欢1.png"), forState: UIControlState.Normal)
            like.tag=4+2*row
        }else{
            like.setBackgroundImage(UIImage(named: "喜欢3.png"), forState: UIControlState.Normal)
            like.tag=5+2*row
        }
        cell.addSubview(like)
        let likeCount=UILabel(frame: CGRectMake(self.view.frame.width/3*2+20,100,50,15))
        likeCount.textColor=UIColor(red: 186/255, green: 186/255, blue: 186/255, alpha: 0.77)
        likeCount.text=ChatMessageListInstance!.items[row].likecount
        likeCount.font=UIFont.systemFontOfSize(12)
        cell.addSubview(likeCount)
        
        let comment=UIImageView(frame: CGRectMake(self.view.frame.width/3*2+60, 100, 15, 15))
        comment.image=UIImage(named: "评论3.png")
        cell.addSubview(comment)
        let commentCount=UILabel(frame: CGRectMake(self.view.frame.width/3*2+80,100,50,15))
        commentCount.textColor=UIColor(red: 186/255, green: 186/255, blue: 186/255, alpha: 0.77)
        commentCount.text=ChatMessageListInstance!.items[row].replycount
        commentCount.font=UIFont.systemFontOfSize(12)
        cell.addSubview(commentCount)
        return cell
        
    }
    func popularity(rake:Int)->UITableViewCell{
        let cell=UITableViewCell()
        var image=["1.png","2.png","3.png"]
        if(rake<3){
            let rakeImage=UIImageView(frame: CGRectMake(20, 25, 30, 30))
            rakeImage.image=UIImage(named: image[rake])
            cell.addSubview(rakeImage)
        }else{
            let rakeImage=UIImageView(frame: CGRectMake(20, 25, 30, 30))
            rakeImage.image=UIImage(named: "组-7.png")
            cell.addSubview(rakeImage)
            let rakenum=UILabel(frame: CGRectMake(30,35,10,10))
            rakenum.text=String(rake+1)
            rakenum.font=UIFont.systemFontOfSize(15)
            cell.addSubview(rakenum)
        }
        let avator=UIImageView(frame: CGRectMake(60, 20, 40, 40))
        if let Ndata=NSData(contentsOfURL: NSURL(string: ChatPoPularityListInstance!.items[rake].phone)!){
            avator.image=UIImage(data: Ndata)
        }
        avator.clipsToBounds=true
        avator.layer.cornerRadius=20
        cell.addSubview(avator)
        let name=UILabel(frame: CGRectMake(110,20,200,15))
        name.text=ChatPoPularityListInstance!.items[rake].nickname
        name.font=UIFont.systemFontOfSize(18)
        cell.addSubview(name)
        let fans=UILabel(frame: CGRectMake(110,40,250,15))
        fans.text="聊吧粉丝："+ChatPoPularityListInstance!.items[rake].concerncount
        fans.font=UIFont.systemFontOfSize(15)
        fans.textColor=UIColor(red: 186/255, green: 186/255, blue: 186/255, alpha: 0.77)
        cell.addSubview(fans)
        let focus=UIButton(frame: CGRectMake(self.view.frame.width-70,25,55,30))
        if(ChatPoPularityListInstance!.items[rake].isconcerned=="1"){
            focus.setTitle("已关注", forState: UIControlState.Normal)
            focus.layer.borderColor=UIColor(red: 186/255, green: 186/255, blue: 186/255, alpha: 0.77).CGColor
            focus.setTitleColor(UIColor(red: 186/255, green: 186/255, blue: 186/255, alpha: 0.77), forState: UIControlState.Normal)
        }else{
            focus.setTitle("关注TA", forState: UIControlState.Normal)
            focus.layer.borderColor=UIColor(red: 246/255, green: 140/255, blue: 50/255, alpha: 1.0).CGColor
            focus.setTitleColor(UIColor(red: 246/255, green: 140/255, blue: 50/255, alpha: 1.0), forState: UIControlState.Normal)
        }
        
        focus.layer.borderWidth=1
        focus.clipsToBounds=true
        focus.layer.cornerRadius=3
        focus.titleLabel?.font=UIFont.systemFontOfSize(15)
        cell.addSubview(focus)
        return cell
        
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        C.deselectRowAtIndexPath(indexPath, animated: true)
        if(index==2){
            let anotherView:UIViewController=self.storyboard!.instantiateViewControllerWithIdentifier("MyTopicCenter");
            self.navigationController?.pushViewController(anotherView, animated: true)
        }else{
            let anotherView:UIViewController=self.storyboard!.instantiateViewControllerWithIdentifier("TopicDetail");
            self.navigationController?.pushViewController(anotherView, animated: true)
        }
    }
    func Like(sender:UIButton){
        let like=self.view.viewWithTag(sender.tag) as! UIButton
        if(sender.tag%2==0){
            do {
                let params:Dictionary<String,AnyObject>=["phone":Phone,"tbmessageid":ChatMessageListInstance!.items[sender.tag/2-2].id]
                let new=try HTTP.POST(URL+"/tbmessages/cancellike", parameters: params)
                new.start { response in
                    if let err = response.error {
                        print("error: \(err.localizedDescription)")
                        return //also notify app of failure as needed
                    }
                    print("opt finished: \(response.description)")
                    let flag = Flag(JSONDecoder(response.data))
                    if(flag.flag==1){
                        print("取消点赞成功")
                        self.ChatMessageListInstance!.items[sender.tag/2-2].isliked="0"
                    }
                }
                
            } catch let error {
                print("got an error creating the request: \(error)")
            }
            like.setBackgroundImage(UIImage(named: "喜欢3.png"), forState: UIControlState.Normal)
            like.tag=sender.tag+1
        }else{
            do {
                let params:Dictionary<String,AnyObject>=["phone":Phone,"tbmessageid":ChatMessageListInstance!.items[(sender.tag-5)/2].id]
                let new=try HTTP.POST(URL+"/tbmessages/like", parameters: params)
                new.start { response in
                    if let err = response.error {
                        print("error: \(err.localizedDescription)")
                        return //also notify app of failure as needed
                    }
                    print("opt finished: \(response.description)")
                    let flag = Flag(JSONDecoder(response.data))
                    if(flag.flag==1){
                        print("点赞成功")
                        self.ChatMessageListInstance!.items[(sender.tag-5)/2].isliked="1"
                    }
                }
                
            } catch let error {
                print("got an error creating the request: \(error)")
            }
            like.setBackgroundImage(UIImage(named: "喜欢1.png"), forState: UIControlState.Normal)
            like.tag=sender.tag-1
        }
        self.tableView.reloadData()
    }

}
