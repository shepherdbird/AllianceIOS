//
//  Focus.swift
//  AllianceIOS
//
//  Created by dawei on 15/11/16.
//
//

import UIKit
import SwiftHTTP
import JSONJoy

class Focus: UITableViewController {

    var activityIndicatorView: UIActivityIndicatorView!
    var view1=UIView()
    var HerPhone=0
    var LiaoBaMyConcerns:LiaobaFans?
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
        center.text="我的关注"
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
        print("聊吧-我的关注")
        do {
            let param:Dictionary<String,AnyObject>=["phone":HerPhone]
            let concerns=try HTTP.POST(URL+"/tbusers/myconcerns", parameters: param)
            concerns.start { response in
                if let err = response.error {
                    print("error: \(err.localizedDescription)")
                    return //also notify app of failure as needed
                }
                print("opt finished: \(response.description)")
                self.LiaoBaMyConcerns = LiaobaFans(JSONDecoder(response.data))
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
        if(self.LiaoBaMyConcerns!._meta.currentPage>=self.LiaoBaMyConcerns!._meta.pageCount){
            self.tableView.refreshFooter.loadMoreEnabled=false
            return
        }
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)){
            do {
                let params:Dictionary<String,AnyObject>=["phone":self.HerPhone]
                let opt=try HTTP.POST((self.LiaoBaMyConcerns!._links.next?.href)!, parameters: params)
                opt.start { response in
                    if let err = response.error {
                        print("error: \(err.localizedDescription)")
                        return //also notify app of failure as needed
                    }
                    print("opt finished: \(response.description)")
                    //print("data is: \(response.data)") access the response of the data with response.data
                    var lin:LiaobaFans?
                    lin = LiaobaFans(JSONDecoder(response.data))
                    for var i=(self.LiaoBaMyConcerns!.items.count-1);i>=0;i-- {
                        lin?.items.insert(self.LiaoBaMyConcerns!.items[i], atIndex: 0)
                    }
                    self.LiaoBaMyConcerns!=lin!
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
        if((LiaoBaMyConcerns) != nil){
            return 1
        }
        return 0
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return LiaoBaMyConcerns!.items.count
    }
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60
    }
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        var boundingRect:CGRect
        let avator=UIImageView(frame: CGRectMake(10, 10, 40, 40))
        avator.sd_setImageWithURL(NSURL(string: LiaoBaMyConcerns!.items[indexPath.row].thumb)!, placeholderImage: UIImage(named: "avator.jpg"))
        avator.clipsToBounds=true
        avator.layer.cornerRadius=20
        cell.addSubview(avator)
        let name=UILabel(frame: CGRectMake(50,15,150,15))
        name.text=LiaoBaMyConcerns!.items[indexPath.row].nickname
        name.font=UIFont.systemFontOfSize(18)
        boundingRect=GetBounds(self.view.frame.width-140, height: 20, font: name.font, str: name.text!)
        name.frame=CGRectMake(50,15,boundingRect.width,boundingRect.height)
        cell.addSubview(name)
        let fans=UILabel(frame: CGRectMake(50,35,200,10))
        fans.text="聊吧粉丝："+LiaoBaMyConcerns!.items[indexPath.row].concerncount
        fans.font=UIFont.systemFontOfSize(15)
        fans.textColor=UIColor(red: 186/255, green: 186/255, blue: 186/255, alpha: 0.77)
        boundingRect=GetBounds(250, height: 20, font: fans.font, str: fans.text!)
        fans.frame=CGRectMake(50,35,boundingRect.width,boundingRect.height)
        cell.addSubview(fans)
        let focus=UIButton(frame: CGRectMake(self.view.frame.width-80,15,70,30))
        focus.setTitle("取消关注", forState: UIControlState.Normal)
        focus.layer.borderWidth=1
        focus.clipsToBounds=true
        focus.layer.cornerRadius=3
        focus.tag=indexPath.row
        focus.addTarget(self, action: Selector("Cancel:"), forControlEvents: UIControlEvents.TouchUpInside)
        focus.layer.borderColor=UIColor(red: 244/255, green: 154/255, blue: 85/255, alpha: 1.0).CGColor
        focus.titleLabel?.font=UIFont.systemFontOfSize(15)
        focus.setTitleColor(UIColor(red: 244/255, green: 154/255, blue: 85/255, alpha: 1.0), forState: UIControlState.Normal)
        cell.addSubview(focus)
        return cell
    }
    func Cancel(sender:UIButton){
        do {
            let params:Dictionary<String,AnyObject>=["myphone":Phone,"concernphone":(LiaoBaMyConcerns?.items[sender.tag].phone)!]
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
        anotherView.HerPhone=Int(self.LiaoBaMyConcerns!.items[indexPath.row].phone)!
        anotherView.Name=self.LiaoBaMyConcerns!.items[indexPath.row].nickname
        self.navigationController?.pushViewController(anotherView, animated: true)
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
