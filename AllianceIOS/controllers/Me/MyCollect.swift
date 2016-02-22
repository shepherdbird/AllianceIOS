//
//  MyCollect.swift
//  AllianceIOS
//
//  Created by dawei on 16/1/16.
//
//
import UIKit
import SwiftHTTP
import JSONJoy
class MyCollect: UITableViewController ,UITextFieldDelegate{
    var timer:NSTimer!
    let textFeild=UITextField()
    let keyBaordView=UIView()
    let back=UIView()
    var pivot=0
    var Index:Int=0
    var RRow:String=""
    
    var activityIndicatorView: UIActivityIndicatorView!
    var PersonInfoInstance:PersonInfo?
    var MessageList:ChatMessageList?
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
        self.tableView.separatorStyle=UITableViewCellSeparatorStyle.None
        let center=UILabel(frame: CGRectMake(0,0,50,50))
        center.text="朋友圈"
        center.font=UIFont.systemFontOfSize(20)
        center.textColor=UIColor.whiteColor()
        self.navigationItem.titleView=center
        self.navigationItem.backBarButtonItem=UIBarButtonItem(title: "", style: UIBarButtonItemStyle.Plain, target: nil, action: nil)
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
            self.connect1()
            
        }
        addRefreshView()
        addTimer()
        
        back.frame=self.view.frame
        keyBaordView.frame=CGRectMake(0, self.view.frame.height-117, self.view.frame.width, 50)
        print(self.view.frame.height)
        keyBaordView.backgroundColor=UIColor(red: 160/255, green: 160/255, blue: 160/255, alpha: 1.0)
        textFeild.frame=CGRectMake(20, 5, self.view.frame.width-40, 40)
        textFeild.delegate = self
        textFeild.placeholder = "评论："
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
        print("聊吧最新")
        do {
            let params:Dictionary<String,AnyObject>=["phone":Phone]
            let new=try HTTP.POST(URL+"/users/view", parameters: params)
            new.start { response in
                if let err = response.error {
                    print("error: \(err.localizedDescription)")
                    return //also notify app of failure as needed
                }
                print("opt finished: \(response.description)")
                self.PersonInfoInstance = PersonInfo(JSONDecoder(response.data))
            }
        } catch let error {
            print("got an error creating the request: \(error)")
        }
        
    }
    func connect1(){
        print("聊吧最新")
        do {
            let params:Dictionary<String,AnyObject>=["phone":Phone]
            let new=try HTTP.POST(URL+"/messages/getmycollect", parameters: params)
            new.start { response in
                if let err = response.error {
                    print("error: \(err.localizedDescription)")
                    return //also notify app of failure as needed
                }
                print("opt finished: \(response.description)")
                self.MessageList = ChatMessageList(JSONDecoder(response.data))
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
        if(self.MessageList!._meta.currentPage>=self.MessageList!._meta.pageCount){
            self.tableView.refreshFooter.loadMoreEnabled=false
            return
        }
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)){
            do {
                let params:Dictionary<String,AnyObject>=["phone":Phone]
                let opt=try HTTP.POST((self.MessageList!._links.next?.href)!, parameters: params)
                opt.start { response in
                    if let err = response.error {
                        print("error: \(err.localizedDescription)")
                        return //also notify app of failure as needed
                    }
                    print("opt finished: \(response.description)")
                    //print("data is: \(response.data)") access the response of the data with response.data
                    var lin:ChatMessageList?
                    lin = ChatMessageList(JSONDecoder(response.data))
                    for var i=(self.MessageList!.items.count-1);i>=0;i-- {
                        lin?.items.insert(self.MessageList!.items[i], atIndex: 0)
                    }
                    self.MessageList!=lin!
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
            self.connect1()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        if((MessageList) != nil){
            if(PersonInfoInstance != nil){
                return MessageList!.items.count+1
            }
        }
        return 0
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        var row=1
        if(section==0){
            return 1
        }else{
            if(self.MessageList!.items[section-1].zans.count != 0){
                row=row+1
            }
        }
        return row+self.MessageList!.items[section-1].replys.count+1
    }
    
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if((MessageList) != nil){
            if(section==self.MessageList!.items.count){
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
        if((MessageList) != nil && self.PersonInfoInstance != nil){
            if(indexPath.section==0){
                return self.view.frame.width/2
            }
            var F=1
            if(self.MessageList!.items[indexPath.section-1].zans.count != 0){
                F=2
                if(indexPath.row==1){
                    let zanlabel=UILabel(frame: CGRectMake(60,40,self.view.frame.width-80,30))
                    zanlabel.text="  "+self.MessageList!.items[indexPath.section-1].zans[0].nickname
                    zanlabel.font=UIFont.systemFontOfSize(14)
                    zanlabel.numberOfLines=0
                    
                    for(var i=1;i<=self.MessageList!.items[indexPath.section-1].zans.count-1;i++) {
                        zanlabel.text!=zanlabel.text!+self.MessageList!.items[indexPath.section-1].zans[i].nickname
                    }
                    let boundingRect2=GetBounds(self.view.frame.width-80, height: 1000, font: zanlabel.font, str: zanlabel.text!)
                    return boundingRect2.height+10
                }
                
            }
            if(indexPath.row==F+self.MessageList!.items[indexPath.section-1].replys.count){
                return 25
            }
            var H:CGFloat=0
            if(indexPath.row==0){
                let content=UILabel(frame: CGRectMake(60,50,self.view.frame.width-80,30))
                content.text=MessageList!.items[indexPath.section-1].content
                content.font=UIFont.systemFontOfSize(16)
                content.numberOfLines=0
                let boundingRect2=GetBounds(self.view.frame.width-80, height: 1000, font: content.font, str: content.text!)
                if(self.MessageList!.items[indexPath.section-1].pictures==""){
                    H=50+boundingRect2.height+10+30
                }else{
                    let width=(self.view.frame.width-140)/3+10
                    let picture=self.MessageList!.items[indexPath.section-1].pictures.componentsSeparatedByString(" ")
                    H=CGFloat((picture.count-1)/3+1)*width+50+boundingRect2.height+10+30
                }
                return H
                
            }else{
                var boundingRect:CGRect
                //let index=indexPath.row-1
                let content=UILabel(frame: CGRectMake(20,15,300,20))
                if(self.MessageList!.items[indexPath.section-1].replys[indexPath.row-F].toid=="0"){
                    let name=UILabel(frame: CGRectMake(20,10,60,15))
                    name.text=self.MessageList!.items[indexPath.section-1].replys[indexPath.row-F].fromnickname
                    name.font=UIFont.systemFontOfSize(14)
                    name.textColor=UIColor(red: 45/255, green: 100/255, blue: 180/255, alpha: 1.0)
                    boundingRect=GetBounds(100, height: 100, font: name.font, str: name.text!)
                    name.frame=CGRectMake(60,5,boundingRect.width,boundingRect.height)
                    content.text=": "+self.MessageList!.items[indexPath.section-1].replys[indexPath.row-F].content
                    content.font=UIFont.systemFontOfSize(14)
                    content.numberOfLines=0
                    boundingRect=GetBounds(self.view.frame.width-80-name.frame.width, height: 1000, font: content.font, str: content.text!)
                    content.frame=CGRectMake(60+name.frame.width,5,boundingRect.width,boundingRect.height)
                    return boundingRect.height+5
                }else{
                    content.text=self.MessageList!.items[indexPath.section-1].replys[indexPath.row-F].fromnickname+"回复"+self.MessageList!.items[indexPath.section-1].replys[indexPath.row-F].tonickname+": "+self.MessageList!.items[indexPath.section-1].replys[indexPath.row-F].content
                    let name1=UILabel(frame: CGRectMake(20,10,60,17))
                    name1.text=self.MessageList!.items[indexPath.section-1].replys[indexPath.row-F].fromnickname
                    name1.font=UIFont.systemFontOfSize(14)
                    name1.textColor=UIColor(red: 45/255, green: 100/255, blue: 180/255, alpha: 1.0)
                    boundingRect=GetBounds(100, height: 100, font: name1.font, str: name1.text!)
                    name1.frame=CGRectMake(60,5,boundingRect.width,boundingRect.height)
                    let huifu=UILabel(frame: CGRectMake(20,15,300,20))
                    huifu.text="回复"
                    huifu.font=UIFont.systemFontOfSize(14)
                    huifu.numberOfLines=0
                    boundingRect=GetBounds(200, height: 300, font: huifu.font, str: huifu.text!)
                    huifu.frame=CGRectMake(60+name1.frame.width,10,boundingRect.width,boundingRect.height)
                    let name2=UILabel(frame: CGRectMake(20,10,60,17))
                    name2.text=self.MessageList!.items[indexPath.section-1].replys[indexPath.row-F].tonickname
                    name2.font=UIFont.systemFontOfSize(14)
                    name2.textColor=UIColor(red: 45/255, green: 100/255, blue: 180/255, alpha: 1.0)
                    boundingRect=GetBounds(100, height: 100, font: name2.font, str: name2.text!)
                    name2.frame=CGRectMake(huifu.frame.maxX,5,boundingRect.width,boundingRect.height)
                    content.text=": "+MessageList!.items[indexPath.section-1].replys[indexPath.row-F].content
                    content.font=UIFont.systemFontOfSize(14)
                    content.numberOfLines=0
                    boundingRect=GetBounds(self.view.frame.width-20-name2.frame.maxX, height: 1000, font: content.font, str: content.text!)
                    content.frame=CGRectMake(name2.frame.maxX,10,boundingRect.width,boundingRect.height)
                    return boundingRect.height+5
                }
            }
        }
        return 0
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if(indexPath.section==0){
            return MeCell()
        }
        if(indexPath.row==0){
            return First(indexPath.section-1)
        }
        return Second(indexPath.section-1,row: indexPath.row)
    }
    func MeCell()->UITableViewCell{
        let cell=UITableViewCell()
        var boundingRect:CGRect
        let back=UIImageView(frame: CGRectMake(0,-1, self.view.frame.width, self.view.frame.width/2+1))
        back.image=UIImage(named: "我的背景.png")
        cell.addSubview(back)
        let avator=UIImageView(frame: CGRectMake(self.view.frame.width/32*13,self.view.frame.width/16,self.view.frame.width/16*3 , self.view.frame.width/16*3))
        avator.sd_setImageWithURL(NSURL(string: self.PersonInfoInstance!.thumb)!, placeholderImage: UIImage(named: "avator.jpg"))
        avator.clipsToBounds=true
        avator.layer.cornerRadius=self.view.frame.width/32*3
        cell.addSubview(avator)
        let name=UILabel(frame: CGRectMake(self.view.frame.width/16*7-20,self.view.frame.width/4+10,200,20))
        name.textColor=UIColor.whiteColor()
        name.text=self.PersonInfoInstance!.nickname
        name.font=UIFont.systemFontOfSize(18)
        //name.textColor=UIColor(red: 45/255, green: 100/255, blue: 180/255, alpha: 1.0)
        boundingRect=GetBounds(300, height: 100, font: name.font, str: name.text!)
        name.frame=CGRectMake(self.view.frame.width/2-boundingRect.width/2,self.view.frame.width/4+10,boundingRect.width,boundingRect.height)
        cell.addSubview(name)
        let friend=UILabel(frame: CGRectMake(self.view.frame.width/4,self.view.frame.width/4+40,200,20))
        friend.textColor=UIColor.whiteColor()
        friend.text="人脉好友 "+self.PersonInfoInstance!.friendcount
        friend.font=UIFont.systemFontOfSize(15)
        boundingRect=GetBounds(300, height: 100, font: friend.font, str: friend.text!)
        friend.frame=CGRectMake(self.view.frame.width/2-boundingRect.width-5,name.frame.maxY+5,boundingRect.width,boundingRect.height)
        cell.addSubview(friend)
        let fans=UILabel(frame: CGRectMake(self.view.frame.width/2,self.view.frame.width/4+40,200,20))
        fans.textColor=UIColor.whiteColor()
        fans.text="粉丝 "+self.PersonInfoInstance!.concerncount
        fans.font=UIFont.systemFontOfSize(15)
        boundingRect=GetBounds(300, height: 100, font: fans.font, str: fans.text!)
        fans.frame=CGRectMake(self.view.frame.width/2+5,name.frame.maxY+5,boundingRect.width,boundingRect.height)
        cell.addSubview(fans)
        let signature=UILabel(frame: CGRectMake(fans.frame.maxY+5,self.view.frame.width/4+60,self.view.frame.width/2,15))
        signature.textColor=UIColor.whiteColor()
        signature.text="个性签名："+self.PersonInfoInstance!.signature
        signature.font=UIFont.systemFontOfSize(14)
        boundingRect=GetBounds(self.view.frame.width/3*2, height: 100, font: signature.font, str: signature.text!)
        signature.frame=CGRectMake(self.view.frame.width/2-boundingRect.width/2,fans.frame.maxY+5,boundingRect.width,boundingRect.height)
        cell.addSubview(signature)
        
        return cell
    }
    func First(row:Int)->UITableViewCell{
        let cell=UITableViewCell()
        var boundingRect:CGRect
        let avator=UIImageView(frame: CGRectMake(10, 10, 40, 40))
        avator.clipsToBounds=true
        avator.layer.cornerRadius=20
        avator.sd_setImageWithURL(NSURL(string: MessageList!.items[row].thumb)!, placeholderImage: UIImage(named: "avator.jpg"))
        cell.addSubview(avator)
        let name=UILabel(frame: CGRectMake(60,15,60,17))
        name.text=MessageList!.items[row].nickname
        name.font=UIFont.systemFontOfSize(17)
        name.textColor=UIColor(red: 45/255, green: 100/255, blue: 180/255, alpha: 1.0)
        boundingRect=GetBounds(100, height: 100, font: name.font, str: name.text!)
        name.frame=CGRectMake(60,20,boundingRect.width,boundingRect.height)
        cell.addSubview(name)
        let time=UILabel(frame: CGRectMake(65+boundingRect.width,25,200,17))
        let lin=MessageList!.items[row].created_at
        time.text=String(NSDate(timeIntervalSince1970: Double(lin)!))
        time.text=TimeAgo(Int64(lin)!)
        time.font=UIFont.systemFontOfSize(15)
        time.textColor=UIColor(red: 186/255, green: 186/255, blue: 186/255, alpha: 1.0)
        boundingRect=GetBounds(300, height: 100, font: name.font, str: time.text!)
        time.frame=CGRectMake(65+name.frame.width,20,boundingRect.width,boundingRect.height)
        cell.addSubview(time)
        
        let content=UILabel(frame: CGRectMake(60,50,self.view.frame.width-80,30))
        content.text=MessageList!.items[row].content
        content.font=UIFont.systemFontOfSize(16)
        content.numberOfLines=0
        content.textColor=UIColor(red: 111/255, green: 111/255, blue: 111/255, alpha: 1.0)
        boundingRect=GetBounds(self.view.frame.width-80, height: 1000, font: content.font, str: content.text!)
        content.frame=CGRectMake(60,50,boundingRect.width,boundingRect.height)
        cell.addSubview(content)
        var Y=content.frame.maxY
        if(MessageList!.items[row].pictures != ""){
            let picture=MessageList!.items[row].pictures.componentsSeparatedByString(" ")
            let width=(self.view.frame.width-140)/3+10
            for i in 0...(picture.count-1){
                let img=UIImageView(frame: CGRectMake(60+width*CGFloat(i%3), content.frame.maxY+width*CGFloat(i/3)+5, width-10, width-10))
                img.sd_setImageWithURL(NSURL(string: picture[i]),placeholderImage: UIImage(named: "avator.jpg"))
                cell.addSubview(img)
            }
            Y=Y+CGFloat((picture.count-1)/3+1)*width
        }
        Y=Y+10
        let zanbtn=UIButton(frame: CGRectMake(60, Y, 60, 20))
        zanbtn.addTarget(self, action: Selector("Like:"), forControlEvents: UIControlEvents.TouchUpInside)
        let zanicon=UIImageView(frame: CGRectMake(0, 0, 20, 20))
        let likeCount=UILabel(frame: CGRectMake(25,2,48,15))
        likeCount.font=UIFont.systemFontOfSize(15)
        if MessageList!.items[row].iszaned=="1" {
            zanicon.image=UIImage(named: "喜欢6.png")
            zanbtn.tag=4+2*row
            likeCount.text="取消赞"
        }else{
            zanicon.image=UIImage(named: "喜欢5.png")
            zanbtn.tag=5+2*row
            likeCount.text="赞"
        }
        zanbtn.addSubview(zanicon)
        zanbtn.addSubview(likeCount)
        cell.addSubview(zanbtn)
        
        let commentbtn=UIButton(frame: CGRectMake(135, Y, 60, 20))
        commentbtn.tag=10000+row
        commentbtn.addTarget(self, action: Selector("Comment:"), forControlEvents: UIControlEvents.TouchUpInside)
        let commenticon=UIImageView(frame: CGRectMake(0, 0, 20, 20))
        let commentCount=UILabel(frame: CGRectMake(25,2,33,15))
        commentCount.font=UIFont.systemFontOfSize(15)
        commenticon.image=UIImage(named: "评论5.png")
        commentbtn.addSubview(commenticon)
        commentCount.text="评论"
        commentbtn.addSubview(commentCount)
        cell.addSubview(commentbtn)
        
        let collectbtn=UIButton(frame: CGRectMake(210, Y, 60, 20))
        collectbtn.addTarget(self, action: Selector("Collect:"), forControlEvents: UIControlEvents.TouchUpInside)
        let collecticon=UIImageView(frame: CGRectMake(0, 0, 23, 23))
        let collectCount=UILabel(frame: CGRectMake(25,2,63,15))
        collectCount.font=UIFont.systemFontOfSize(15)
        if MessageList!.items[row].iscollected=="1" {
            collecticon.image=UIImage(named: "收藏2.png")
            collectbtn.tag=10004+2*row
            collectCount.text="取消收藏"
        }else{
            collecticon.image=UIImage(named: "收藏1.png")
            collectbtn.tag=10005+2*row
            collectCount.text="收藏"
        }
        collectbtn.addSubview(collecticon)
        collectbtn.addSubview(collectCount)
        cell.addSubview(collectbtn)
        
        if(self.MessageList!.items[row].ismy==1){
            let delete=UIButton(frame: CGRectMake(self.view.frame.width-50,Y,33,15))
            delete.setTitle("删除", forState: UIControlState.Normal)
            delete.tag=20000+row
            delete.addTarget(self, action: Selector("Delete:"), forControlEvents: UIControlEvents.TouchUpInside)
            delete.setTitleColor(UIColor(red: 45/255, green: 100/255, blue: 180/255, alpha: 1.0), forState: UIControlState.Normal)
            delete.titleLabel?.font=UIFont.systemFontOfSize(15)
            cell.addSubview(delete)
        }
        
        return cell
        
    }
    func Second(section:Int,row:Int)->UITableViewCell{
        let cell=UITableViewCell()
        var H:CGFloat=0
        var F=1
        if(self.MessageList!.items[section].zans.count != 0){
            F=2
        }
        if(row==1 && self.MessageList!.items[section].zans.count != 0){
            let zanicon=UIImageView(frame: CGRectMake(70, 5, 14, 14))
            zanicon.image=UIImage(named: "喜欢3.png")
            
            let zanlabel=UILabel(frame: CGRectMake(60,40,self.view.frame.width-80,30))
            zanlabel.text="  "+self.MessageList!.items[section].zans[0].nickname
            zanlabel.textColor=UIColor(red: 45/255, green: 100/255, blue: 180/255, alpha: 1.0)
            zanlabel.font=UIFont.systemFontOfSize(14)
            zanlabel.numberOfLines=0
            for(var i=1;i<=self.MessageList!.items[section].zans.count-1;i++) {
                zanlabel.text!=zanlabel.text!+","+self.MessageList!.items[section].zans[i].nickname
            }
            let boundingRect2=GetBounds(self.view.frame.width-80, height: 1000, font: zanlabel.font, str: zanlabel.text!)
            zanlabel.frame=CGRectMake(80, 5, boundingRect2.width, boundingRect2.height)
            
            H=boundingRect2.height+10
            let view1=UIView(frame: CGRectMake(60,0,self.view.frame.width-80,H))
            view1.backgroundColor=UIColor(red: 241/255, green: 241/255, blue: 241/255, alpha: 1.0)
            cell.addSubview(view1)
            cell.addSubview(zanlabel)
            cell.addSubview(zanicon)
            return cell
        }
        if(row==self.MessageList!.items[section].replys.count+F){
            let view1=UIView(frame: CGRectMake(0,13,self.view.frame.width,1))
            view1.backgroundColor=UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1.0)
            cell.addSubview(view1)
            return cell
        }
        var boundingRect:CGRect
        let content=UILabel(frame: CGRectMake(20,15,300,20))
        if(self.MessageList!.items[section].replys[row-F].toid=="0"){
            let name=UILabel(frame: CGRectMake(60,5,60,15))
            name.text=self.MessageList!.items[section].replys[row-F].fromnickname
            name.font=UIFont.systemFontOfSize(14)
            name.textColor=UIColor(red: 45/255, green: 100/255, blue: 180/255, alpha: 1.0)
            boundingRect=GetBounds(100, height: 100, font: name.font, str: name.text!)
            name.frame=CGRectMake(70,0,boundingRect.width,boundingRect.height)
            
            content.text=": "+self.MessageList!.items[section].replys[row-F].content
            content.font=UIFont.systemFontOfSize(14)
            content.numberOfLines=0
            boundingRect=GetBounds(self.view.frame.width-90-name.frame.width, height: 1000, font: content.font, str: content.text!)
            content.frame=CGRectMake(70+name.frame.width,0,boundingRect.width,boundingRect.height)
            H=boundingRect.height+5
            let view1=UIView(frame: CGRectMake(60,0,self.view.frame.width-80,H))
            view1.backgroundColor=UIColor(red: 241/255, green: 241/255, blue: 241/255, alpha: 1.0)
            cell.addSubview(view1)
            cell.addSubview(name)
            cell.addSubview(content)
        }else{
            content.text=self.MessageList!.items[section].replys[row-F].fromnickname+"回复"+self.MessageList!.items[section].replys[row-F].tonickname+": "+self.MessageList!.items[section].replys[row-F].content
            let name1=UILabel(frame: CGRectMake(20,10,60,17))
            name1.text=self.MessageList!.items[section].replys[row-F].fromnickname
            name1.font=UIFont.systemFontOfSize(14)
            name1.textColor=UIColor(red: 45/255, green: 100/255, blue: 180/255, alpha: 1.0)
            boundingRect=GetBounds(100, height: 100, font: name1.font, str: name1.text!)
            name1.frame=CGRectMake(70,0,boundingRect.width,boundingRect.height)
            
            let huifu=UILabel(frame: CGRectMake(20,15,300,20))
            huifu.text="回复"
            huifu.font=UIFont.systemFontOfSize(14)
            huifu.numberOfLines=0
            boundingRect=GetBounds(200, height: 300, font: huifu.font, str: huifu.text!)
            huifu.frame=CGRectMake(70+name1.frame.width,0,boundingRect.width,boundingRect.height)
            
            let name2=UILabel(frame: CGRectMake(20,10,60,17))
            name2.text=self.MessageList!.items[section].replys[row-F].tonickname
            name2.font=UIFont.systemFontOfSize(14)
            name2.textColor=UIColor(red: 45/255, green: 100/255, blue: 180/255, alpha: 1.0)
            boundingRect=GetBounds(100, height: 100, font: name2.font, str: name2.text!)
            name2.frame=CGRectMake(huifu.frame.maxX,0,boundingRect.width,boundingRect.height)
            
            content.text=": "+self.MessageList!.items[section].replys[row-F].content
            content.font=UIFont.systemFontOfSize(14)
            content.numberOfLines=0
            boundingRect=GetBounds(self.view.frame.width-20-name2.frame.maxX, height: 1000, font: content.font, str: content.text!)
            content.frame=CGRectMake(name2.frame.maxX,0,boundingRect.width,boundingRect.height)
            H=boundingRect.height+5
            let view1=UIView(frame: CGRectMake(60,0,self.view.frame.width-80,H))
            view1.backgroundColor=UIColor(red: 241/255, green: 241/255, blue: 241/255, alpha: 1.0)
            cell.addSubview(view1)
            cell.addSubview(name1)
            cell.addSubview(huifu)
            cell.addSubview(name2)
            cell.addSubview(content)
        }
        
        return cell
        
        
    }
    func Delete(sender:UIButton){
        do {
            let params:Dictionary<String,AnyObject>=["phone":Phone,"messageid":MessageList!.items[sender.tag-20000].id]
            let new=try HTTP.POST(URL+"/messages/delete", parameters: params)
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
    func Collect(sender:UIButton){
        if(sender.tag%2==0){
            do {
                let params:Dictionary<String,AnyObject>=["phone":Phone,"messageid":MessageList!.items[sender.tag/2-5002].id]
                let new=try HTTP.POST(URL+"/messages/cancelcollect", parameters: params)
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
        }else{
            do {
                let params:Dictionary<String,AnyObject>=["phone":Phone,"messageid":MessageList!.items[(sender.tag-10005)/2].id]
                let new=try HTTP.POST(URL+"/messages/collect", parameters: params)
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
    func Like(sender:UIButton){
        if(sender.tag%2==0){
            do {
                let params:Dictionary<String,AnyObject>=["phone":Phone,"messageid":MessageList!.items[sender.tag/2-2].id]
                let new=try HTTP.POST(URL+"/messages/cancelzan", parameters: params)
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
        }else{
            do {
                let params:Dictionary<String,AnyObject>=["phone":Phone,"messageid":MessageList!.items[(sender.tag-5)/2].id]
                let new=try HTTP.POST(URL+"/messages/zan", parameters: params)
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
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
        var F=1
        if(self.MessageList!.items[indexPath.section-1].zans.count != 0){
            F=2
        }
        if(indexPath.row-F>=0 && indexPath.row != F+self.MessageList!.items[indexPath.section-1].replys.count){
            self.view.addSubview(back)
            self.view.addSubview(keyBaordView)
            self.Index=indexPath.section-1
            self.RRow=self.MessageList!.items[indexPath.section-1].replys[indexPath.row-F].fromphone
            print("弹出评论框")
            pivot=1
            textFeild.placeholder="回复"+self.MessageList!.items[indexPath.section-1].replys[indexPath.row-F].fromnickname+"："
            
            textFeild.becomeFirstResponder()
        }
        
        
    }
    func Comment(sender:UIButton){
        self.view.addSubview(back)
        self.view.addSubview(keyBaordView)
        self.Index=sender.tag-10000
        print("弹出评论框")
        pivot=1
        textFeild.becomeFirstResponder()
    }
    func textFieldShouldReturn(textField:UITextField) -> Bool
    {
        //收起键盘
        textFeild.resignFirstResponder()
        back.removeFromSuperview()
        keyBaordView.removeFromSuperview()
        pivot=0
        do {
            let params:Dictionary<String,AnyObject>=["messageid":self.MessageList!.items[Index].id,"fphone":Phone,"tphone":self.RRow,"content":textFeild.text!]
            let new=try HTTP.POST(URL+"/messages/reply", parameters: params)
            new.start { response in
                if let err = response.error {
                    print("error: \(err.localizedDescription)")
                    return //also notify app of failure as needed
                }
                print("opt finished: \(response.description)")
                self.Fg = Flag(JSONDecoder(response.data))
                self.RRow=""
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
        back.removeFromSuperview()
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
            print(sender.locationInView(self.view).y,keyBaordView.frame.minY)
            if sender.locationInView(self.view).y < keyBaordView.frame.minY{
                textFeild.resignFirstResponder()
                back.removeFromSuperview()
                keyBaordView.removeFromSuperview()
                pivot=0
            }
        }
        
    }
    func addTimer() {
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "nextImage", userInfo: nil, repeats: true)
    }
    func nextImage() {
        if(RefreshFriendStatus==1){
            self.RefreshData()
            RefreshFriendStatus=0
        }
        
    }
}