//
//  HotestMessage.swift
//  AllianceIOS
//
//  Created by dawei on 15/12/12.
//
//

import UIKit
import SwiftHTTP
import JSONJoy

class HotestMessage: UITableViewController {

    var Index:Int=0
    var activityIndicatorView: UIActivityIndicatorView!
    var ChatMessageListInstance:ChatMessageList?
        {
        didSet{
            activityIndicatorView.stopAnimating()
            self.activityIndicatorView.hidden=true
            self.tableView.backgroundView=nil
            //self.tableView.reloadData()
            dispatch_async(dispatch_get_main_queue()){
                self.tableView.reloadData()
                self.tableView.refreshFooter.endRefresh()
                self.tableView.refreshHeader.endRefresh()
            }
        }
    }
    var alert:UIAlertController?
    var Fg:Flag?
        {
        didSet{
            let reqAction=UIAlertAction(title: "确定", style: UIAlertActionStyle.Default) { (action:UIAlertAction) -> Void in
                //self.navigationController?.popViewControllerAnimated(true)
                self.RefreshData()
            }
            alert=UIAlertController(title: "", message: Fg?.msg, preferredStyle: UIAlertControllerStyle.Alert)
            alert!.addAction(reqAction)
            self.presentViewController(alert!, animated: true, completion: nil)
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
        print("聊吧最热")
        do {
            let params:Dictionary<String,AnyObject>=["phone":Phone]
            let new=try HTTP.POST(URL+"/tbmessages/hot", parameters: params)
            new.start { response in
                if let err = response.error {
                    print("error: \(err.localizedDescription)")
                    return //also notify app of failure as needed
                }
                print("opt finished: \(response.description)")
                self.ChatMessageListInstance = ChatMessageList(JSONDecoder(response.data))
            }
        } catch let error {
            print("got an error creating the request: \(error)")
        }
        
    }
    func addRefreshView(){
        self.tableView.refreshHeader=self.tableView.addRefreshHeaderWithHandler{
            self.RefreshData()
        }
        
        self.tableView.refreshFooter=self.tableView.addRefreshFooterWithHandler{
            self.loadMoredata()
        }
    }
    func loadMoredata(){
        if(self.ChatMessageListInstance!._meta.currentPage>=self.ChatMessageListInstance!._meta.pageCount){
            self.tableView.refreshFooter.loadMoreEnabled=false
            return
        }
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)){
            do {
                let params:Dictionary<String,AnyObject>=["phone":Phone]
                let opt=try HTTP.POST((self.ChatMessageListInstance!._links.next?.href)!, parameters: params)
                opt.start { response in
                    if let err = response.error {
                        print("error: \(err.localizedDescription)")
                        return //also notify app of failure as needed
                    }
                    print("opt finished: \(response.description)")
                    //print("data is: \(response.data)") access the response of the data with response.data
                    var lin:ChatMessageList?
                    lin = ChatMessageList(JSONDecoder(response.data))
                    for var i=(self.ChatMessageListInstance!.items.count-1);i>=0;i-- {
                        lin?.items.insert(self.ChatMessageListInstance!.items[i], atIndex: 0)
                    }
                    self.ChatMessageListInstance!=lin!
                    //print("content is: \(self.addinfo!._links)")
                    
                }
            } catch let error {
                print("got an error creating the request: \(error)")
            }
        }
    }
    
    func RefreshData() {
        self.tableView.refreshFooter.loadMoreEnabled=true
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
        if((ChatMessageListInstance) != nil){
            return ChatMessageListInstance!.items.count
        }
        return 0
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 2
    }
    
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if((ChatMessageListInstance) != nil){
            if(section==self.ChatMessageListInstance!.items.count-1){
                return 200
            }
            return 15
        }
        return 15
    }
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if((ChatMessageListInstance) != nil){
            if(indexPath.row==0){
                let boundingRect:CGRect
                let title=UILabel(frame: CGRectMake(60,50,self.view.frame.width-120,20))
                title.text=ChatMessageListInstance!.items[indexPath.section].title
                title.font=UIFont.systemFontOfSize(18)
                title.numberOfLines=0
                boundingRect=GetBounds(self.view.frame.width-80, height: 300, font: title.font, str: title.text!)
                
                let content=UILabel(frame: CGRectMake(60,70,self.view.frame.width-80,30))
                content.text=ChatMessageListInstance!.items[indexPath.section].content
                content.font=UIFont.systemFontOfSize(16)
                content.numberOfLines=0
                let boundingRect2=GetBounds(self.view.frame.width-80, height: 1000, font: content.font, str: content.text!)
                if(self.ChatMessageListInstance!.items[indexPath.section].pictures==""){
                    return 50+boundingRect.height+boundingRect2.height+10
                }else{
                    let width=(self.view.frame.width-140)/3
                    let picture=self.ChatMessageListInstance!.items[indexPath.section].pictures.componentsSeparatedByString(" ")
                    return CGFloat((picture.count-1)/3+1)*width+50+boundingRect.height+boundingRect2.height+10
                }
            }
            return 40
        }
        return 0
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if(indexPath.row==0){
            return First(indexPath.section)
        }
        return Second(indexPath.section)
    }
    func First(row:Int)->UITableViewCell{
        let cell=UITableViewCell()
        var boundingRect:CGRect
        let avator=UIImageView(frame: CGRectMake(10, 10, 40, 40))
        avator.clipsToBounds=true
        avator.layer.cornerRadius=20
        avator.sd_setImageWithURL(NSURL(string: ChatMessageListInstance!.items[row].thumb)!, placeholderImage: UIImage(named: "avator.jpg"))
        cell.addSubview(avator)
        let avatorBtn=UIButton(frame: CGRectMake(10, 10, 40, 40))
        avatorBtn.addTarget(self, action: Selector("Avator:"), forControlEvents: UIControlEvents.TouchUpInside)
        avatorBtn.tag=110000+row
        cell.addSubview(avatorBtn)
        let name=UILabel(frame: CGRectMake(60,20,60,17))
        name.text=ChatMessageListInstance!.items[row].nickname
        name.font=UIFont.systemFontOfSize(17)
        name.textColor=UIColor(red: 45/255, green: 100/255, blue: 180/255, alpha: 1.0)
        boundingRect=GetBounds(100, height: 100, font: name.font, str: name.text!)
        name.frame=CGRectMake(60,20,boundingRect.width,boundingRect.height)
        cell.addSubview(name)
        let time=UILabel(frame: CGRectMake(65+boundingRect.width,25,200,17))
        let lin=ChatMessageListInstance!.items[row].created_at
        time.text=String(NSDate(timeIntervalSince1970: Double(lin)!))
        time.text=TimeAgo(Int64(lin)!)
        time.font=UIFont.systemFontOfSize(15)
        time.textColor=UIColor(red: 186/255, green: 186/255, blue: 186/255, alpha: 1.0)
        boundingRect=GetBounds(100, height: 100, font: name.font, str: time.text!)
        time.frame=CGRectMake(65+name.frame.width,20,boundingRect.width,boundingRect.height)
        cell.addSubview(time)
        
        let title=UILabel(frame: CGRectMake(60,50,self.view.frame.width-120,20))
        title.text=ChatMessageListInstance!.items[row].title
        title.font=UIFont.systemFontOfSize(18)
        title.numberOfLines=0
        boundingRect=GetBounds(self.view.frame.width-80, height: 300, font: title.font, str: title.text!)
        title.frame=CGRectMake(60,50,boundingRect.width,boundingRect.height)
        cell.addSubview(title)
        let content=UILabel(frame: CGRectMake(60,70,self.view.frame.width-80,30))
        content.text=ChatMessageListInstance!.items[row].content
        content.font=UIFont.systemFontOfSize(16)
        content.numberOfLines=0
        content.textColor=UIColor(red: 111/255, green: 111/255, blue: 111/255, alpha: 1.0)
        boundingRect=GetBounds(self.view.frame.width-80, height: 1000, font: content.font, str: content.text!)
        content.frame=CGRectMake(60,50+title.frame.height,boundingRect.width,boundingRect.height)
        cell.addSubview(content)
        if(ChatMessageListInstance!.items[row].pictures != ""){
            let picture=ChatMessageListInstance!.items[row].pictures.componentsSeparatedByString(" ")
            let width=(self.view.frame.width-140)/3+10
            for i in 0...(picture.count-1){
                let img=UIImageView(frame: CGRectMake(60+width*CGFloat(i%3), content.frame.maxY+width*CGFloat(i/3), width-10, width-10))
                img.sd_setImageWithURL(NSURL(string: picture[i]),placeholderImage: UIImage(named: "avator.jpg"))
                cell.addSubview(img)
            }
        }
        return cell
        
    }
    func Second(row:Int)->UITableViewCell{
        let cell=UITableViewCell()
        if ChatMessageListInstance!.items[row].isconcerned=="1" {
            let focus=UILabel(frame: CGRectMake(20,12,60,15))
            focus.textColor=UIColor(red: 186/255, green: 186/255, blue: 186/255, alpha: 1.0)
            focus.text="已关注"
            focus.font=UIFont.systemFontOfSize(15)
            cell.addSubview(focus)
        }else{
            let focusBtn=UIButton(frame: CGRectMake(20,10,70,20))
            focusBtn.tag=10000+row
            focusBtn.addTarget(self, action: Selector("Concern:"), forControlEvents: UIControlEvents.TouchUpInside)
            let focusIcon=UIImageView(frame: CGRectMake(0, 0, 20, 20))
            focusIcon.image=UIImage(named: "关注图标.png")
            focusBtn.addSubview(focusIcon)
            let focuslabel=UILabel(frame: CGRectMake(20,2,50,15))
            focuslabel.text="关注TA"
            focuslabel.font=UIFont.systemFontOfSize(15)
            focuslabel.textColor=UIColor(red: 230/255, green: 120/255, blue: 40/255, alpha: 1.0)
            focusBtn.addSubview(focuslabel)
            cell.addSubview(focusBtn)
        }
        let like=UIButton(frame: CGRectMake(self.view.frame.width/3*2, 10, 20, 20))
        like.addTarget(self, action: Selector("Like:"), forControlEvents: UIControlEvents.TouchUpInside)
        if ChatMessageListInstance!.items[row].isliked=="1" {
            like.setBackgroundImage(UIImage(named: "喜欢1.png"), forState: UIControlState.Normal)
            like.tag=4+2*row
        }else{
            like.setBackgroundImage(UIImage(named: "喜欢3.png"), forState: UIControlState.Normal)
            like.tag=5+2*row
        }
        cell.addSubview(like)
        let likeCount=UILabel(frame: CGRectMake(self.view.frame.width/3*2+25,12,50,15))
        likeCount.textColor=UIColor(red: 186/255, green: 186/255, blue: 186/255, alpha: 1.0)
        likeCount.text=ChatMessageListInstance!.items[row].likecount
        likeCount.font=UIFont.systemFontOfSize(14)
        cell.addSubview(likeCount)
        
        let comment=UIImageView(frame: CGRectMake(self.view.frame.width/3*2+60, 10, 20, 20))
        comment.image=UIImage(named: "评论3.png")
        cell.addSubview(comment)
        let commentCount=UILabel(frame: CGRectMake(self.view.frame.width/3*2+85,12,50,15))
        commentCount.textColor=UIColor(red: 186/255, green: 186/255, blue: 186/255, alpha: 1.0)
        commentCount.text=ChatMessageListInstance!.items[row].replycount
        commentCount.font=UIFont.systemFontOfSize(14)
        cell.addSubview(commentCount)
        return cell
    }
    func Concern(sender:UIButton){
        do {
            let params:Dictionary<String,AnyObject>=["myphone":Phone,"concernphone":ChatMessageListInstance!.items[sender.tag-10000].phone]
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
                    self.Fg = Flag(JSONDecoder(response.data))
                }
                
            } catch let error {
                print("got an error creating the request: \(error)")
            }
//            like.setBackgroundImage(UIImage(named: "喜欢3.png"), forState: UIControlState.Normal)
//            like.tag=sender.tag+1
            //self.RefreshData()
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
                    self.Fg = Flag(JSONDecoder(response.data))
                }
                
            } catch let error {
                print("got an error creating the request: \(error)")
            }
//            like.setBackgroundImage(UIImage(named: "喜欢1.png"), forState: UIControlState.Normal)
//            like.tag=sender.tag-1
        }
        //self.RefreshData()
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let anotherView=MessageView()
        anotherView.TbMessageId=Int(self.ChatMessageListInstance!.items[indexPath.section].id)!
        print("messageid: "+self.ChatMessageListInstance!.items[indexPath.section].id)
        self.navigationController?.pushViewController(anotherView, animated: true)
        
    }
    func Avator(sender:UIButton){
        if(ChatMessageListInstance!.items[sender.tag-110000].phone==Phone){
            let anotherView=MyTopicCenter()
            anotherView.HerPhone=Int(Phone)!
            self.navigationController?.pushViewController(anotherView, animated: true)
        }else{
            let anotherView=OtherCenter()
            anotherView.HerPhone=Int(ChatMessageListInstance!.items[sender.tag-110000].phone)!
            anotherView.Name=self.ChatMessageListInstance!.items[sender.tag-110000].nickname
            self.navigationController?.pushViewController(anotherView, animated: true)
        }
        
    }

}
