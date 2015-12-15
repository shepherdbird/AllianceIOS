//
//  MyTopicList.swift
//  AllianceIOS
//
//  Created by dawei on 15/11/16.
//
//

import UIKit
import SwiftHTTP
import JSONJoy

class MyTopicList: UITableViewController {

    var activityIndicatorView: UIActivityIndicatorView!
    var view1=UIView()
    var MyTopicList:ChatMessageList?
        {
        didSet{
            activityIndicatorView.stopAnimating()
            self.activityIndicatorView.hidden=true
            self.tableView.backgroundView=nil
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
        let center=UILabel(frame: CGRectMake(0,0,50,50))
        center.text="我的话题"
        center.font=UIFont.systemFontOfSize(20)
        center.textColor=UIColor.whiteColor()
        self.navigationItem.titleView=center
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
        print("聊吧-我的话题")
        do {
            let params:Dictionary<String,AnyObject>=["phone":Phone]
            let new=try HTTP.POST(URL+"/tbmessages/me", parameters: params)
            new.start { response in
                if let err = response.error {
                    print("error: \(err.localizedDescription)")
                    return //also notify app of failure as needed
                }
                print("opt finished: \(response.description)")
                self.MyTopicList = ChatMessageList(JSONDecoder(response.data))
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
        if(self.MyTopicList!._meta.currentPage>=self.MyTopicList!._meta.pageCount){
            self.tableView.refreshFooter.loadMoreEnabled=false
            return
        }
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)){
            do {
                let params:Dictionary<String,AnyObject>=["phone":Phone]
                let opt=try HTTP.POST((self.MyTopicList!._links.next?.href)!, parameters: params)
                opt.start { response in
                    if let err = response.error {
                        print("error: \(err.localizedDescription)")
                        return //also notify app of failure as needed
                    }
                    print("opt finished: \(response.description)")
                    //print("data is: \(response.data)") access the response of the data with response.data
                    var lin:ChatMessageList?
                    lin = ChatMessageList(JSONDecoder(response.data))
                    for var i=(self.MyTopicList!.items.count-1);i>=0;i-- {
                        lin?.items.insert(self.MyTopicList!.items[i], atIndex: 0)
                    }
                    self.MyTopicList!=lin!
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
        if((MyTopicList) != nil){
            return MyTopicList!.items.count
        }
        return 0
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if((MyTopicList) != nil){
            if(section==self.MyTopicList!.items.count-1){
                return 200
            }
            return 0.01
        }
        return 0.01
    }
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if((MyTopicList) != nil){
            if(indexPath.row==0){
                let boundingRect:CGRect
                let title=UILabel(frame: CGRectMake(60,50,self.view.frame.width-120,20))
                title.text=MyTopicList!.items[indexPath.section].title
                title.font=UIFont.systemFontOfSize(18)
                title.numberOfLines=0
                boundingRect=GetBounds(self.view.frame.width-80, height: 300, font: title.font, str: title.text!)
                
                let content=UILabel(frame: CGRectMake(60,70,self.view.frame.width-80,30))
                content.text=MyTopicList!.items[indexPath.section].content
                content.font=UIFont.systemFontOfSize(16)
                content.numberOfLines=0
                let boundingRect2=GetBounds(self.view.frame.width-80, height: 1000, font: content.font, str: content.text!)
                if(self.MyTopicList!.items[indexPath.section].pictures==""){
                    return 50+boundingRect.height+boundingRect2.height+30
                }else{
                    let width=(self.view.frame.width-140)/3
                    let picture=self.MyTopicList!.items[indexPath.section].pictures.componentsSeparatedByString(" ")
                    return CGFloat((picture.count-1)/3+1)*width+50+boundingRect.height+boundingRect2.height+30
                }
            }
            return 40
        }
        return 0
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell=UITableViewCell()
        var boundingRect:CGRect
        let avator=UIImageView(frame: CGRectMake(10, 10, 40, 40))
        avator.clipsToBounds=true
        avator.layer.cornerRadius=20
        avator.sd_setImageWithURL(NSURL(string: MyTopicList!.items[indexPath.row].thumb)!, placeholderImage: UIImage(named: "avator.jpg"))
        cell.addSubview(avator)
        let name=UILabel(frame: CGRectMake(60,20,60,17))
        name.text=MyTopicList!.items[indexPath.section].nickname
        name.font=UIFont.systemFontOfSize(17)
        name.textColor=UIColor(red: 45/255, green: 100/255, blue: 180/255, alpha: 1.0)
        boundingRect=GetBounds(300, height: 100, font: name.font, str: name.text!)
        name.frame=CGRectMake(60,20,boundingRect.width,boundingRect.height)
        cell.addSubview(name)
        let time=UILabel(frame: CGRectMake(90,10,200,15))
        //time.text=String(NSDate(timeIntervalSince1970: Double(MyTopicList!.items[indexPath.section].created_at)!))
        let lin=MyTopicList!.items[indexPath.section].created_at
        //time.text=String(NSDate(timeIntervalSince1970: Double(lin)!))
        time.text=TimeAgo(Int64(lin)!)
        time.font=UIFont.systemFontOfSize(15)
        time.textColor=UIColor(red: 186/255, green: 186/255, blue: 186/255, alpha: 1.0)
        boundingRect=GetBounds(300, height: 100, font: name.font, str: time.text!)
        time.frame=CGRectMake(65+name.frame.width,20,boundingRect.width,boundingRect.height)
        cell.addSubview(time)
        let title=UILabel(frame: CGRectMake(5,40,self.view.frame.width-40,25))
        title.text=MyTopicList!.items[indexPath.section].title
        title.font=UIFont.systemFontOfSize(18)
        title.numberOfLines=0
        boundingRect=GetBounds(self.view.frame.width-80, height: 300, font: title.font, str: title.text!)
        title.frame=CGRectMake(60,name.frame.maxY,boundingRect.width,boundingRect.height)
        cell.addSubview(title)
        let content=UILabel(frame: CGRectMake(5,65,self.view.frame.width-10,30))
        content.text=MyTopicList!.items[indexPath.section].content
        content.font=UIFont.systemFontOfSize(16)
        content.numberOfLines=0
        content.textColor=UIColor(red: 111/255, green: 111/255, blue: 111/255, alpha: 1.0)
        boundingRect=GetBounds(self.view.frame.width-80, height: 1000, font: content.font, str: content.text!)
        content.frame=CGRectMake(60,title.frame.maxY,boundingRect.width,boundingRect.height)
        cell.addSubview(content)
        var Y=content.frame.maxY
        if(MyTopicList!.items[indexPath.section].pictures != ""){
            let picture=MyTopicList!.items[indexPath.section].pictures.componentsSeparatedByString(" ")
            let width=(self.view.frame.width-140)/3+10
            for i in 0...(picture.count-1){
                let img=UIImageView(frame: CGRectMake(60+width*CGFloat(i%3), content.frame.maxY+width*CGFloat(i/3), width-10, width-10))
                img.sd_setImageWithURL(NSURL(string: picture[i]),placeholderImage: UIImage(named: "avator.jpg"))
                cell.addSubview(img)
                if(i==picture.count-1){
                    Y=img.frame.maxY
                }
            }
        }
        let focus=UIButton(frame: CGRectMake(10,Y+10,35,20))
        focus.setTitleColor(UIColor(red: 45/255, green: 100/255, blue: 180/255, alpha: 1.0), forState: UIControlState.Normal)
        focus.setTitle("删除", forState: UIControlState.Normal)
        focus.titleLabel?.font=UIFont.systemFontOfSize(15)
        focus.tag=1000+indexPath.section
        focus.addTarget(self, action: Selector("Delete:"), forControlEvents: UIControlEvents.TouchUpInside)
        cell.addSubview(focus)
        let like=UIImageView(frame: CGRectMake(self.view.frame.width/3*2, Y+10, 20, 20))
        like.image=UIImage(named: "喜欢1.png")
        cell.addSubview(like)
        let likeCount=UILabel(frame: CGRectMake(self.view.frame.width/3*2+22,Y+10,60,20))
        likeCount.textColor=UIColor(red: 186/255, green: 186/255, blue: 186/255, alpha: 0.77)
        likeCount.text=MyTopicList!.items[indexPath.section].likecount
        likeCount.font=UIFont.systemFontOfSize(14)
        cell.addSubview(likeCount)
        let comment=UIImageView(frame: CGRectMake(self.view.frame.width/3*2+60, Y+10, 20, 20))
        comment.image=UIImage(named: "评论3.png")
        cell.addSubview(comment)
        let commentCount=UILabel(frame: CGRectMake(self.view.frame.width/3*2+82,Y+10,60,20))
        commentCount.textColor=UIColor(red: 186/255, green: 186/255, blue: 186/255, alpha: 0.77)
        commentCount.text=MyTopicList!.items[indexPath.section].replycount
        commentCount.font=UIFont.systemFontOfSize(14)
        cell.addSubview(commentCount)
        return cell
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    func Delete(sender:UIButton){
        do {
            let params:Dictionary<String,AnyObject>=["phone":Phone,"tbmessageid":MyTopicList!.items[sender.tag-1000].id]
            let new=try HTTP.POST(URL+"/tbmessages/delete", parameters: params)
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
