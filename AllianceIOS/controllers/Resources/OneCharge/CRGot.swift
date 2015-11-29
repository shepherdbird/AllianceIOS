//
//  CRGot.swift
//  AllianceIOS
//
//  Created by dawei on 15/11/29.
//
//

import UIKit
import SwiftHTTP
import JSONJoy

class CRGot: UITableViewController {

    var Index:Int=0
    var activityIndicatorView: UIActivityIndicatorView!
    var GrabCommodity:GrabCommodityRecord?
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
            self.connect(URL+"/grabcornrecords/win")
            
        }
        addRefreshView()
    }
    func connect(url:String){
        print("夺宝记录列表")
        do {
            let params:Dictionary<String,AnyObject>=["phone":Phone]
            let opt=try HTTP.POST(url, parameters: params)
            opt.start { response in
                if let err = response.error {
                    print("error: \(err.localizedDescription)")
                    return //also notify app of failure as needed
                }
                print("opt finished: \(response.description)")
                self.GrabCommodity = GrabCommodityRecord(JSONDecoder(response.data))
                //print(self.TenCharge!._meta.totalCount)
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
        if(self.GrabCommodity!._meta.currentPage==self.GrabCommodity!._meta.pageCount){
            self.tableView.refreshFooter.loadMoreEnabled=false
            return
        }
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)){
            do {
                let params:Dictionary<String,AnyObject>=["phone":Phone]
                let opt=try HTTP.POST((self.GrabCommodity!._links.next?.href)!, parameters: params)
                opt.start { response in
                    if let err = response.error {
                        print("error: \(err.localizedDescription)")
                        return //also notify app of failure as needed
                    }
                    print("opt finished: \(response.description)")
                    //print("data is: \(response.data)") access the response of the data with response.data
                    var lin:GrabCommodityRecord?
                    lin = GrabCommodityRecord(JSONDecoder(response.data))
                    for var i=(self.GrabCommodity!.items.count-1);i>=0;i-- {
                        lin?.items.insert(self.GrabCommodity!.items[i], atIndex: 0)
                    }
                    self.GrabCommodity!=lin!
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
            self.connect(URL+"/grabcornrecords/win")
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if((GrabCommodity) != nil){
            return GrabCommodity!.items.count
        }
        return 0
    }
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 200
    }
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 250
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        return GotCell(indexPath.row)
    }
    func GotCell(row:Int)->UITableViewCell{
        let cell=UITableViewCell()
        let avator=UIImageView(frame: CGRectMake(40, 40, 60, 60))
        let title=UILabel(frame: CGRectMake(120,20,self.view.frame.width-130,30))
        let count=UILabel(frame: CGRectMake(120,50,self.view.frame.width-130,20))
        let term=UILabel(frame: CGRectMake(120,70,200,20))
        let time=UILabel(frame: CGRectMake(120,90,self.view.frame.width-150,20))
        if((GrabCommodity!.items[row].picture) != nil){
            avator.sd_setImageWithURL(NSURL(string: GrabCommodity!.items[row].picture)!, placeholderImage: UIImage(named: "avator.jpg"))
            title.text="第"+GrabCommodity!.items[row].version+"期 "+GrabCommodity!.items[row].title
            count.text="总需："+String(GrabCommodity!.items[row].needed)+"人次"
            time.text="揭晓时间："+String(NSDate(timeIntervalSince1970: Double(GrabCommodity!.items[row].end_at)!))
            term.text="本期参与："+String(GrabCommodity!.items[row].count)+"人次"
        }
        title.font=UIFont.systemFontOfSize(18)
        count.font=UIFont.systemFontOfSize(15)
        time.font=UIFont.systemFontOfSize(15)
        term.font=UIFont.systemFontOfSize(15)
        cell.addSubview(avator)
        cell.addSubview(title)
        cell.addSubview(count)
        cell.addSubview(time)
        cell.addSubview(term)
        if(GrabCommodity!.items[row].islotteried==1){
            let back=UIImageView(frame: CGRectMake(120, 120, self.view.frame.width-130, 70))
            //back.backgroundColor=UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1.0)
            back.image=UIImage(named: "获奖用户底框.png")
            let nickname=UILabel(frame: CGRectMake(135,130,200,15))
            nickname.text=GrabCommodity!.items[row].nickname!+" 恭喜您获得本次奖品！"
            nickname.font=UIFont.systemFontOfSize(15)
            let term2=UILabel(frame: CGRectMake(135,150,200,15))
            term2.text="本期参与："+String(GrabCommodity!.items[row].count!)+"人次"
            term2.font=UIFont.systemFontOfSize(15)
            let number=UILabel(frame: CGRectMake(135,170,200,15))
            number.text="幸运号码："+String(GrabCommodity!.items[row].winnernumber!)
            number.font=UIFont.systemFontOfSize(15)
            cell.addSubview(back)
            cell.addSubview(nickname)
            cell.addSubview(term2)
            cell.addSubview(number)
        }
        if(GrabCommodity!.items[row].isgot!=="0"){
            let extract=UIButton(frame: CGRectMake(120,200,self.view.frame.width/3,40))
            extract.setBackgroundImage(UIImage(named: "申请提取按钮.png"), forState: UIControlState.Normal)
            extract.setTitle("申请提取", forState: UIControlState.Normal)
            extract.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
            extract.titleLabel?.font=UIFont.systemFontOfSize(18)
            extract.tag=1000+row
            extract.addTarget(self, action: Selector("Extract:"), forControlEvents: UIControlEvents.TouchUpInside)
            cell.addSubview(extract)
        }else{
            let extract=UIButton(frame: CGRectMake(120,200,self.view.frame.width/3,40))
            extract.setBackgroundImage(UIImage(named: "已领取按钮.png"), forState: UIControlState.Normal)
            extract.setTitle("已领取", forState: UIControlState.Normal)
            extract.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
            extract.titleLabel?.font=UIFont.systemFontOfSize(18)
            cell.addSubview(extract)
        }
        return cell
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    func Extract(sender:UIButton){
        do {
            let params:Dictionary<String,AnyObject>=["phone":Phone,"grabcornid":GrabCommodity!.items[sender.tag-1000].grabcornid!]
            print(GrabCommodity!.items[sender.tag-1000].id)
            let opt=try HTTP.POST(URL+"/grabcorns/getcorns", parameters: params)
            opt.start { response in
                if let err = response.error {
                    print("error: \(err.localizedDescription)")
                    return //also notify app of failure as needed
                }
                print("opt finished: \(response.description)")
                //print("data is: \(response.data)") access the response of the data with response.data
                let Fg = Flag(JSONDecoder(response.data))
                var alert:UIAlertController?
                        let reqAction=UIAlertAction(title: "确定", style: UIAlertActionStyle.Default) { (action:UIAlertAction) -> Void in
                            print("")
                        }
                        alert=UIAlertController(title: "提取成功", message: Fg.msg, preferredStyle: UIAlertControllerStyle.Alert)
                        if(Fg.flag==0){
                            alert?.title="提取失败"
                        }
                        alert!.addAction(reqAction)
                        self.presentViewController(alert!, animated: true, completion: nil)
                
                
            }
        } catch let error {
            print("got an error creating the request: \(error)")
        }
    }


}
