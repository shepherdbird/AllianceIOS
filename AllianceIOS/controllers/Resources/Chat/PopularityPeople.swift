//
//  PopularityPeople.swift
//  AllianceIOS
//
//  Created by dawei on 15/12/12.
//
//

import UIKit
import SwiftHTTP
import JSONJoy

class PopularityPeople: UITableViewController {

    var Index:Int=0
    var activityIndicatorView: UIActivityIndicatorView!
    var ChatPoPularityListInstance:ChatPopularityList?
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
        print("聊吧人气")
        do {
            let params:Dictionary<String,AnyObject>=["phone":Phone]
            let new=try HTTP.POST(URL+"/tbusers/hot", parameters: params)
            new.start { response in
                if let err = response.error {
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
    func addRefreshView(){
        self.tableView.refreshHeader=self.tableView.addRefreshHeaderWithHandler{
            self.RefreshData()
        }
        
        self.tableView.refreshFooter=self.tableView.addRefreshFooterWithHandler{
            self.loadMoredata()
        }
    }
    func loadMoredata(){
        if(self.ChatPoPularityListInstance!._meta.currentPage>=self.ChatPoPularityListInstance!._meta.pageCount){
            self.tableView.refreshFooter.loadMoreEnabled=false
            return
        }
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)){
            do {
                let params:Dictionary<String,AnyObject>=["phone":Phone]
                let opt=try HTTP.POST((self.ChatPoPularityListInstance!._links.next?.href)!, parameters: params)
                opt.start { response in
                    if let err = response.error {
                        print("error: \(err.localizedDescription)")
                        return //also notify app of failure as needed
                    }
                    print("opt finished: \(response.description)")
                    //print("data is: \(response.data)") access the response of the data with response.data
                    var lin:ChatPopularityList?
                    lin = ChatPopularityList(JSONDecoder(response.data))
                    for var i=(self.ChatPoPularityListInstance!.items.count-1);i>=0;i-- {
                        lin?.items.insert(self.ChatPoPularityListInstance!.items[i], atIndex: 0)
                    }
                    self.ChatPoPularityListInstance!=lin!
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
        if((ChatPoPularityListInstance) != nil){
            return ChatPoPularityListInstance!.items.count
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
        if((self.ChatPoPularityListInstance) != nil){
            return 80
        }
        return 0
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return popularity(indexPath.section)
    }
    func popularity(rake:Int)->UITableViewCell{
        let cell=UITableViewCell()
        var boundingRect:CGRect
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
        avator.sd_setImageWithURL(NSURL(string: ChatPoPularityListInstance!.items[rake].thumb)!, placeholderImage: UIImage(named: "avator.jpg"))
        avator.clipsToBounds=true
        avator.layer.cornerRadius=20
        cell.addSubview(avator)
        let name=UILabel(frame: CGRectMake(110,20,200,15))
        name.text=ChatPoPularityListInstance!.items[rake].nickname
        name.font=UIFont.systemFontOfSize(18)
        boundingRect=GetBounds(self.view.frame.width-190, height: 20, font: name.font, str: name.text!)
        name.frame=CGRectMake(110,20,boundingRect.width,boundingRect.height)
        cell.addSubview(name)
        let fans=UILabel(frame: CGRectMake(110,40,250,15))
        fans.text="聊吧粉丝："+ChatPoPularityListInstance!.items[rake].concerncount
        fans.font=UIFont.systemFontOfSize(15)
        fans.textColor=UIColor(red: 186/255, green: 186/255, blue: 186/255, alpha: 0.77)
        boundingRect=GetBounds(self.view.frame.width-190, height: 20, font: fans.font, str: fans.text!)
        fans.frame=CGRectMake(110,40,boundingRect.width,boundingRect.height)
        cell.addSubview(fans)
        
        if(ChatPoPularityListInstance!.items[rake].isconcerned=="1"){
            let focus=UIButton(frame: CGRectMake(self.view.frame.width-90,25,80,30))
            focus.tag=rake
            focus.setTitle("取消关注", forState: UIControlState.Normal)
            focus.addTarget(self, action: Selector("Cancel:"), forControlEvents: UIControlEvents.TouchUpInside)
            focus.layer.borderColor=UIColor(red: 186/255, green: 186/255, blue: 186/255, alpha: 0.77).CGColor
            focus.setTitleColor(UIColor(red: 186/255, green: 186/255, blue: 186/255, alpha: 0.77), forState: UIControlState.Normal)
            focus.layer.borderWidth=1
            focus.clipsToBounds=true
            focus.layer.cornerRadius=3
            focus.titleLabel?.font=UIFont.systemFontOfSize(15)
            cell.addSubview(focus)
        }else{
            let focus=UIButton(frame: CGRectMake(self.view.frame.width-90,25,80,30))
            focus.tag=rake
            focus.setTitle("关注TA", forState: UIControlState.Normal)
            focus.addTarget(self, action: Selector("Concern:"), forControlEvents: UIControlEvents.TouchUpInside)
            focus.layer.borderColor=UIColor(red: 246/255, green: 140/255, blue: 50/255, alpha: 1.0).CGColor
            focus.setTitleColor(UIColor(red: 246/255, green: 140/255, blue: 50/255, alpha: 1.0), forState: UIControlState.Normal)
            focus.layer.borderWidth=1
            focus.clipsToBounds=true
            focus.layer.cornerRadius=3
            focus.titleLabel?.font=UIFont.systemFontOfSize(15)
            cell.addSubview(focus)
        }
        return cell
    }
    func Concern(sender:UIButton){
        do {
            let params:Dictionary<String,AnyObject>=["myphone":Phone,"concernphone":ChatPoPularityListInstance!.items[sender.tag].phone]
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
    func Cancel(sender:UIButton){
        do {
            let params:Dictionary<String,AnyObject>=["myphone":Phone,"concernphone":ChatPoPularityListInstance!.items[sender.tag].phone]
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
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let anotherView=OtherCenter()
        anotherView.HerPhone=Int(self.ChatPoPularityListInstance!.items[indexPath.section].phone)!
        anotherView.Name=self.ChatPoPularityListInstance!.items[indexPath.section].nickname
        self.navigationController?.pushViewController(anotherView, animated: true)
    }
}
