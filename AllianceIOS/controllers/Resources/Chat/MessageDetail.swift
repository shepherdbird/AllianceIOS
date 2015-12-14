//
//  MessageDetail.swift
//  AllianceIOS
//
//  Created by dawei on 15/12/13.
//
//

import UIKit
import SwiftHTTP
import JSONJoy

class MessageDetail: UITableViewController ,UITextFieldDelegate{

    let textFeild=UITextField()
    let keyBaordView=UIView()
    var pivot=0
    var selected=0
    var TbMessageId:Int = 0
        {
        didSet{
            print(TbMessageId)
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)){
                self.connect()
                //self.connect1()
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
            alert=UIAlertController(title: "评论成功", message: Fg?.msg, preferredStyle: UIAlertControllerStyle.Alert)
            if(Fg?.flag==0){
                alert?.title="评论失败"
            }
            alert!.addAction(reqAction)
            self.presentViewController(alert!, animated: true, completion: nil)
        }
    }
    var activityIndicatorView: UIActivityIndicatorView!
    
    var ChatMessageInstance:ChatMessage?
        {
        didSet{
            if((self.ReplyMoreInstance) != nil){
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
    }
    var ReplyMoreInstance:ReplyMore?
        {
        didSet{
            if((self.ChatMessageInstance) != nil){
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
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView=UITableView(frame: self.view.frame, style: UITableViewStyle.Grouped)
        self.tableView.separatorStyle=UITableViewCellSeparatorStyle.None
        let view1=UIView(frame: CGRectMake(0, 0, self.tableView.frame.size.width, self.tableView.frame.size.height))
        view1.backgroundColor=UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        print("detail id: "+String(TbMessageId))
        
        activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.White)
        
        activityIndicatorView.frame = CGRectMake(self.tableView.frame.size.width/2-100, -30, 200, 200)
        
        activityIndicatorView.hidesWhenStopped = true
        
        activityIndicatorView.color = UIColor.blackColor()
        view1.addSubview(activityIndicatorView)
        self.tableView.backgroundView=view1
        activityIndicatorView.startAnimating()
        
        addRefreshView()
        keyBaordView.frame=CGRectMake(0, self.view.frame.height-97, self.view.frame.width, 50)
        keyBaordView.backgroundColor=UIColor(red: 160/255, green: 160/255, blue: 160/255, alpha: 1.0)
        textFeild.frame=CGRectMake(20, 5, self.view.frame.width-40, 40)
        textFeild.delegate = self
        textFeild.placeholder = "回复："
        textFeild.returnKeyType = UIReturnKeyType.Send
        textFeild.borderStyle=UITextBorderStyle.RoundedRect
        textFeild.enablesReturnKeyAutomatically  = true
        //textFeild.backgroundColor=UIColor.blueColor()
        keyBaordView.addSubview(textFeild)
        //keyBaordView.backgroundColor=UIColor.redColor()
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action:"handleTouches:")
        tapGestureRecognizer.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tapGestureRecognizer)
        
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector:"keyBoardWillShow:", name:UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector:"keyBoardWillHide:", name:UIKeyboardWillHideNotification, object: nil)
    }
    func connect(){
        print("聊吧状态详情")
        do {
            let params:Dictionary<String,AnyObject>=["phone":Phone,"tbmessageid":TbMessageId]
            let new=try HTTP.POST(URL+"/tbmessages/view", parameters: params)
            print("haha before")
            new.start { response in
                if let err = response.error {
                    print("error: \(err.localizedDescription)")
                    return //also notify app of failure as needed
                }
                print("haha")
                print("opt finished: \(response.description)")
                self.ChatMessageInstance = ChatMessage(JSONDecoder(response.data))
            }
            let params1:Dictionary<String,AnyObject>=["tbmessageid":TbMessageId]
            let new1=try HTTP.POST(URL+"/tbmessages/morereplys", parameters: params1)
            new1.start { response in
                if let err = response.error {
                    print("error: \(err.localizedDescription)")
                    return //also notify app of failure as needed
                }
                print("opt finished: \(response.description)")
                self.ReplyMoreInstance = ReplyMore(JSONDecoder(response.data))
            }
        } catch let error {
            print("got an error creating the request: \(error)")
        }
        
    }
    func connect1(){
        print("聊吧状态回复")
        do {
            let params:Dictionary<String,AnyObject>=["tbmessageid":TbMessageId]
            let new=try HTTP.POST(URL+"/tbmessages/morereplys", parameters: params)
            new.start { response in
                if let err = response.error {
                    print("error: \(err.localizedDescription)")
                    return //also notify app of failure as needed
                }
                print("opt finished: \(response.description)")
                self.ReplyMoreInstance = ReplyMore(JSONDecoder(response.data))
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
        if(self.ReplyMoreInstance!._meta.currentPage>=self.ReplyMoreInstance!._meta.pageCount){
            self.tableView.refreshFooter.loadMoreEnabled=false
            return
        }
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)){
            do {
                let params:Dictionary<String,AnyObject>=["tbmessageid":self.TbMessageId]
                let opt=try HTTP.POST((self.ReplyMoreInstance!._links.next?.href)!, parameters: params)
                opt.start { response in
                    if let err = response.error {
                        print("error: \(err.localizedDescription)")
                        return //also notify app of failure as needed
                    }
                    print("opt finished: \(response.description)")
                    //print("data is: \(response.data)") access the response of the data with response.data
                    var lin:ReplyMore?
                    lin = ReplyMore(JSONDecoder(response.data))
                    for var i=(self.ReplyMoreInstance!.items.count-1);i>=0;i-- {
                        lin?.items.insert(self.ReplyMoreInstance!.items[i], atIndex: 0)
                    }
                    self.ReplyMoreInstance!=lin!
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
        if((ReplyMoreInstance) != nil){
            return 2
        }
        return 0
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if((ReplyMoreInstance) != nil){
            if(section==0){
                return 1
            }else{
                return (ReplyMoreInstance?.items.count)!+1
            }
        }
        return 0
    }
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if((ReplyMoreInstance) != nil){
            if(section==0){
                return 15
            }else{
                return 200
            }
        }
        return 15
    }
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if((ReplyMoreInstance) != nil && (ChatMessageInstance) != nil){
            if(indexPath.section==0){
                let boundingRect:CGRect
                let title=UILabel(frame: CGRectMake(60,50,self.view.frame.width-120,20))
                title.text=ChatMessageInstance!.title
                title.font=UIFont.systemFontOfSize(18)
                title.numberOfLines=0
                boundingRect=GetBounds(self.view.frame.width-80, height: 300, font: title.font, str: title.text!)
                
                let content=UILabel(frame: CGRectMake(60,70,self.view.frame.width-80,30))
                content.text=ChatMessageInstance!.content
                content.font=UIFont.systemFontOfSize(16)
                content.numberOfLines=0
                let boundingRect2=GetBounds(self.view.frame.width-80, height: 1000, font: content.font, str: content.text!)
                if(self.ChatMessageInstance!.pictures==""){
                    return 50+boundingRect.height+boundingRect2.height+10
                }else{
                    let width=(self.view.frame.width-140)/3
                    let picture=self.ChatMessageInstance!.pictures.componentsSeparatedByString(" ")
                    return CGFloat((picture.count-1)/3+1)*width+50+boundingRect.height+boundingRect2.height+10
                }
            }else if(indexPath.row==0){
                return 40
            }else{
                var boundingRect:CGRect
                let index=indexPath.row-1
                let content=UILabel(frame: CGRectMake(20,15,300,20))
                if(self.ReplyMoreInstance!.items[index].toid=="0"){
                    let name=UILabel(frame: CGRectMake(20,10,60,17))
                    name.text=self.ReplyMoreInstance!.items[index].fromnickname
                    name.font=UIFont.systemFontOfSize(17)
                    name.textColor=UIColor(red: 45/255, green: 100/255, blue: 180/255, alpha: 1.0)
                    boundingRect=GetBounds(100, height: 100, font: name.font, str: name.text!)
                    name.frame=CGRectMake(20,10,boundingRect.width,boundingRect.height)
                    content.text=": "+self.ReplyMoreInstance!.items[index].content
                    content.font=UIFont.systemFontOfSize(17)
                    content.numberOfLines=0
                    boundingRect=GetBounds(self.view.frame.width-40-name.frame.width, height: 1000, font: content.font, str: content.text!)
                    content.frame=CGRectMake(20+name.frame.width,10,boundingRect.width,boundingRect.height)
                    return boundingRect.height+10
                }else{
                    content.text=self.ReplyMoreInstance!.items[index].fromnickname+"回复"+self.ReplyMoreInstance!.items[index].tonickname+": "+self.ReplyMoreInstance!.items[index].content
                    let name1=UILabel(frame: CGRectMake(20,10,60,17))
                    name1.text=self.ReplyMoreInstance!.items[index].fromnickname
                    name1.font=UIFont.systemFontOfSize(17)
                    name1.textColor=UIColor(red: 45/255, green: 100/255, blue: 180/255, alpha: 1.0)
                    boundingRect=GetBounds(100, height: 100, font: name1.font, str: name1.text!)
                    name1.frame=CGRectMake(20,10,boundingRect.width,boundingRect.height)
                    let huifu=UILabel(frame: CGRectMake(20,15,300,20))
                    huifu.text="回复"
                    huifu.font=UIFont.systemFontOfSize(17)
                    huifu.numberOfLines=0
                    boundingRect=GetBounds(200, height: 300, font: huifu.font, str: huifu.text!)
                    huifu.frame=CGRectMake(20+name1.frame.width,10,boundingRect.width,boundingRect.height)
                    let name2=UILabel(frame: CGRectMake(20,10,60,17))
                    name2.text=self.ReplyMoreInstance!.items[index].tonickname
                    name2.font=UIFont.systemFontOfSize(17)
                    name2.textColor=UIColor(red: 45/255, green: 100/255, blue: 180/255, alpha: 1.0)
                    boundingRect=GetBounds(100, height: 100, font: name2.font, str: name2.text!)
                    name2.frame=CGRectMake(huifu.frame.maxX,10,boundingRect.width,boundingRect.height)
                    content.text=": "+self.ReplyMoreInstance!.items[index].content
                    content.font=UIFont.systemFontOfSize(17)
                    content.numberOfLines=0
                    boundingRect=GetBounds(self.view.frame.width-20-name2.frame.maxX, height: 1000, font: content.font, str: content.text!)
                    content.frame=CGRectMake(name2.frame.maxX,10,boundingRect.width,boundingRect.height)
                    return boundingRect.height+10
                }
            }
        }
        return 0
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if(indexPath.section==0){
            return First()
        }
        if(indexPath.row==0){
            return SecondTitle()
        }
        return SecondContent(indexPath.row-1)
    }
    func First()->UITableViewCell{
        let cell=UITableViewCell()
        var boundingRect:CGRect
        let avator=UIImageView(frame: CGRectMake(10, 10, 40, 40))
        avator.clipsToBounds=true
        avator.layer.cornerRadius=20
        avator.sd_setImageWithURL(NSURL(string: ChatMessageInstance!.thumb)!, placeholderImage: UIImage(named: "avator.jpg"))
        cell.addSubview(avator)
        let name=UILabel(frame: CGRectMake(60,22,60,15))
        name.text=ChatMessageInstance!.nickname
        name.font=UIFont.systemFontOfSize(17)
        name.textColor=UIColor(red: 45/255, green: 100/255, blue: 180/255, alpha: 1.0)
        boundingRect=GetBounds(100, height: 100, font: name.font, str: name.text!)
        name.frame=CGRectMake(60,22,boundingRect.width,boundingRect.height)
        cell.addSubview(name)
        let time=UILabel(frame: CGRectMake(150,25,200,15))
        let lin=ChatMessageInstance!.created_at
        time.text=String(NSDate(timeIntervalSince1970: Double(lin)!))
        time.text=TimeAgo(Int64(lin)!)
        time.font=UIFont.systemFontOfSize(15)
        time.textColor=UIColor(red: 186/255, green: 186/255, blue: 186/255, alpha: 1.0)
        boundingRect=GetBounds(100, height: 100, font: name.font, str: time.text!)
        time.frame=CGRectMake(65+name.frame.width,22,boundingRect.width,boundingRect.height)
        cell.addSubview(time)
        
        let title=UILabel(frame: CGRectMake(60,50,self.view.frame.width-120,20))
        title.text=ChatMessageInstance!.title
        title.font=UIFont.systemFontOfSize(18)
        title.numberOfLines=0
        boundingRect=GetBounds(self.view.frame.width-80, height: 300, font: title.font, str: title.text!)
        title.frame=CGRectMake(60,50,boundingRect.width,boundingRect.height)
        cell.addSubview(title)
        let content=UILabel(frame: CGRectMake(60,70,self.view.frame.width-80,30))
        content.text=ChatMessageInstance!.content
        content.font=UIFont.systemFontOfSize(16)
        content.numberOfLines=0
        content.textColor=UIColor(red: 111/255, green: 111/255, blue: 111/255, alpha: 1.0)
        boundingRect=GetBounds(self.view.frame.width-80, height: 1000, font: content.font, str: content.text!)
        content.frame=CGRectMake(60,50+title.frame.height,boundingRect.width,boundingRect.height)
        cell.addSubview(content)
        if(ChatMessageInstance!.pictures != ""){
            let picture=ChatMessageInstance!.pictures.componentsSeparatedByString(" ")
            let width=(self.view.frame.width-140)/3+10
            for i in 0...(picture.count-1){
                let img=UIImageView(frame: CGRectMake(60+width*CGFloat(i%3), content.frame.maxY+width*CGFloat(i/3), width-10, width-10))
                img.sd_setImageWithURL(NSURL(string: picture[i]),placeholderImage: UIImage(named: "avator.jpg"))
                cell.addSubview(img)
            }
        }
        return cell
        
    }
    func SecondTitle()->UITableViewCell{
        let cell=UITableViewCell()
        let comment=UIImageView(frame: CGRectMake(20, 13, 20, 20))
        comment.image=UIImage(named: "评论3.png")
        cell.addSubview(comment)
        let commentCount=UILabel(frame: CGRectMake(45,13,50,15))
        commentCount.textColor=UIColor(red: 186/255, green: 186/255, blue: 186/255, alpha: 1.0)
        commentCount.text=ChatMessageInstance!.replycount
        commentCount.font=UIFont.systemFontOfSize(16)
        cell.addSubview(commentCount)
        let like=UIButton(frame: CGRectMake(self.view.frame.width-70, 13, 20, 20))
        //like.addTarget(self, action: Selector("Like:"), forControlEvents: UIControlEvents.TouchUpInside)
        if ChatMessageInstance!.isliked=="1" {
            like.setBackgroundImage(UIImage(named: "喜欢1.png"), forState: UIControlState.Normal)
            like.tag=4
        }else{
            like.setBackgroundImage(UIImage(named: "喜欢3.png"), forState: UIControlState.Normal)
            like.tag=5
        }
        cell.addSubview(like)
        let likeCount=UILabel(frame: CGRectMake(self.view.frame.width-45,13,45,20))
        likeCount.textColor=UIColor(red: 186/255, green: 186/255, blue: 186/255, alpha: 1.0)
        likeCount.text=ChatMessageInstance!.likecount
        likeCount.font=UIFont.systemFontOfSize(14)
        cell.addSubview(likeCount)
        return cell
    }
    func SecondContent(index:Int)->UITableViewCell{
        let cell=UITableViewCell()
        var boundingRect:CGRect
        let content=UILabel(frame: CGRectMake(20,15,300,20))
        if(self.ReplyMoreInstance!.items[index].toid=="0"){
            let name=UILabel(frame: CGRectMake(20,5,60,17))
            name.text=self.ReplyMoreInstance!.items[index].fromnickname
            name.font=UIFont.systemFontOfSize(17)
            name.textColor=UIColor(red: 45/255, green: 100/255, blue: 180/255, alpha: 1.0)
            boundingRect=GetBounds(100, height: 100, font: name.font, str: name.text!)
            name.frame=CGRectMake(20,5,boundingRect.width,boundingRect.height)
            cell.addSubview(name)
            content.text=": "+self.ReplyMoreInstance!.items[index].content
            content.font=UIFont.systemFontOfSize(17)
            content.numberOfLines=0
            boundingRect=GetBounds(self.view.frame.width-40-name.frame.width, height: 1000, font: content.font, str: content.text!)
            content.frame=CGRectMake(20+name.frame.width,5,boundingRect.width,boundingRect.height)
            cell.addSubview(content)
        }else{
            content.text=self.ReplyMoreInstance!.items[index].fromnickname+"回复"+self.ReplyMoreInstance!.items[index].tonickname+": "+self.ReplyMoreInstance!.items[index].content
            let name1=UILabel(frame: CGRectMake(20,10,60,17))
            name1.text=self.ReplyMoreInstance!.items[index].fromnickname
            name1.font=UIFont.systemFontOfSize(17)
            name1.textColor=UIColor(red: 45/255, green: 100/255, blue: 180/255, alpha: 1.0)
            boundingRect=GetBounds(100, height: 100, font: name1.font, str: name1.text!)
            name1.frame=CGRectMake(20,5,boundingRect.width,boundingRect.height)
            cell.addSubview(name1)
            let huifu=UILabel(frame: CGRectMake(20,15,300,20))
            huifu.text="回复"
            huifu.font=UIFont.systemFontOfSize(17)
            huifu.numberOfLines=0
            boundingRect=GetBounds(200, height: 300, font: huifu.font, str: huifu.text!)
            huifu.frame=CGRectMake(20+name1.frame.width,5,boundingRect.width,boundingRect.height)
            cell.addSubview(huifu)
            let name2=UILabel(frame: CGRectMake(20,10,60,17))
            name2.text=self.ReplyMoreInstance!.items[index].tonickname
            name2.font=UIFont.systemFontOfSize(17)
            name2.textColor=UIColor(red: 45/255, green: 100/255, blue: 180/255, alpha: 1.0)
            boundingRect=GetBounds(100, height: 100, font: name2.font, str: name2.text!)
            name2.frame=CGRectMake(huifu.frame.maxX,5,boundingRect.width,boundingRect.height)
            cell.addSubview(name2)
            content.text=": "+self.ReplyMoreInstance!.items[index].content
            content.font=UIFont.systemFontOfSize(17)
            content.numberOfLines=0
            boundingRect=GetBounds(self.view.frame.width-20-name2.frame.maxX, height: 1000, font: content.font, str: content.text!)
            content.frame=CGRectMake(name2.frame.maxX,5,boundingRect.width,boundingRect.height)
            cell.addSubview(content)
        }
        return cell
        
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
        if(indexPath.row>0){
            //textFeild.removeFromSuperview()
            self.view.addSubview(keyBaordView)
            //self.view.addSubview(textFeild)
            pivot=1
            selected=indexPath.row-1
            textFeild.placeholder="回复"+self.ReplyMoreInstance!.items[selected].fromnickname+"："
            textFeild.becomeFirstResponder()
            //self.view.addSubview(keyBaordView)
            //keyBoardWillShow(NSNotification())
        }
        
    }
    func textFieldShouldReturn(textField:UITextField) -> Bool
    {
        //收起键盘
        textFeild.resignFirstResponder()
        //textFeild.removeFromSuperview()
        keyBaordView.removeFromSuperview()
        pivot=0
        do {
            let params:Dictionary<String,AnyObject>=["tbmessageid":TbMessageId,"fphone":Phone,"tphone":ReplyMoreInstance!.items[selected].fromphone,"content":textFeild.text!]
            let new=try HTTP.POST(URL+"/tbmessages/reply", parameters: params)
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
        textFeild.text=""
        //打印出文本框中的值
        print(textField.text!)
        return true;
    }
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        textFeild.resignFirstResponder()
        //textFeild.removeFromSuperview()
        keyBaordView.removeFromSuperview()
        pivot=0
    }
    func keyBoardWillShow(note:NSNotification)
    {
        let userInfo  = note.userInfo as! NSDictionary
        let  keyBoardBounds = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
        let duration = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as! NSNumber).doubleValue
        _ = self.view.convertRect(keyBoardBounds, toView:nil)
        _ = keyBaordView.frame
        let deltaY = keyBoardBounds.size.height
        let animations:(() -> Void) = {
            self.keyBaordView.transform = CGAffineTransformMakeTranslation(0,-deltaY)
        }
        if duration > 0 {
            let options = UIViewAnimationOptions(rawValue: UInt((userInfo[UIKeyboardAnimationCurveUserInfoKey] as! NSNumber).integerValue << 16))
            UIView.animateWithDuration(duration, delay: 0, options:options, animations: animations, completion: nil)
        }else{
            animations()
        }
    }
    func keyBoardWillHide(note:NSNotification)
    {
        let userInfo  = note.userInfo as! NSDictionary
        let duration = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as! NSNumber).doubleValue
        let animations:(() -> Void) = {
            self.keyBaordView.transform = CGAffineTransformIdentity
        }
        if duration > 0 {
            let options = UIViewAnimationOptions(rawValue: UInt((userInfo[UIKeyboardAnimationCurveUserInfoKey] as! NSNumber).integerValue << 16))
            UIView.animateWithDuration(duration, delay: 0, options:options, animations: animations, completion: nil)
        }else{
            
            animations()
        }
    }
    func handleTouches(sender:UITapGestureRecognizer){
        if(pivot==1){
            if sender.locationInView(self.view).y < self.view.bounds.height - 300{
                textFeild.resignFirstResponder()
                //textFeild.removeFromSuperview()
                keyBaordView.removeFromSuperview()
                pivot=0
            }
        }
        
    }

}
