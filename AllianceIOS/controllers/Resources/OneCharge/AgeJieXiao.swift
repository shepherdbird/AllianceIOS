//
//  AgeJieXiao.swift
//  AllianceIOS
//
//  Created by dawei on 15/11/5.
//
//

import UIKit
import SwiftHTTP
import JSONJoy

class AgeJieXiao: UITableViewController {

    var activityIndicatorView: UIActivityIndicatorView!
    var Kind:String=""
    var Url:String=""
    var Through="corn"
    var Ago:GrabcornsList?
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
        self.navigationItem.backBarButtonItem=UIBarButtonItem(title: "", style: UIBarButtonItemStyle.Plain, target: nil, action: nil)
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
            self.connect(self.Url)
        }
        addRefreshView()
    }
    func connect(url:String){
        //print("获取十夺金列表")
        do {
            let params:Dictionary<String,AnyObject>=["phone":Phone,"kind":Kind]
            let opt=try HTTP.POST(url, parameters: params)
            opt.start { response in
                if let err = response.error {
                    print("error: \(err.localizedDescription)")
                    return //also notify app of failure as needed
                }
                print("opt finished: \(response.description)")
                self.Ago = GrabcornsList(JSONDecoder(response.data))
                //print(self.TenCharge!._meta.totalCount)
            }
        } catch let error {
            print("got an error creating the request: \(error)")
        }
        
    }
    func addRefreshView(){
        self.tableView.refreshHeader=self.tableView.addRefreshHeaderWithHandler{
            self.refreshData()
        }
        
        self.tableView.refreshFooter=self.tableView.addRefreshFooterWithHandler{
            self.loadMoredata()
        }
    }
    func loadMoredata(){
        if(self.Ago!._meta.currentPage==self.Ago!._meta.pageCount){
            self.tableView.refreshFooter.loadMoreEnabled=false
            return
        }
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)){
            do {
                let opt=try HTTP.GET((self.Ago!._links.next?.href)!)
                opt.start { response in
                    if let err = response.error {
                        print("error: \(err.localizedDescription)")
                        return //also notify app of failure as needed
                    }
                    print("opt finished: \(response.description)")
                    //print("data is: \(response.data)") access the response of the data with response.data
                    var lin:GrabcornsList?
                    lin = GrabcornsList(JSONDecoder(response.data))
                    for var i=(self.Ago!.items.count-1);i>=0;i-- {
                        lin?.items.insert(self.Ago!.items[i], atIndex: 0)
                    }
                    self.Ago!=lin!
                    //print("content is: \(self.addinfo!._links)")
                    
                }
            } catch let error {
                print("got an error creating the request: \(error)")
            }
        }
    }
    
    func refreshData() {
        self.tableView.refreshFooter.loadMoreEnabled=true
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)){
            self.connect(self.Url)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        if((Ago) != nil){
            return Ago!.items.count-1
        }
        return 0
    }
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.1
    }
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 15
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 2
    }
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
            if(indexPath.row==0){
                return 40
            }
            return 120
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if(indexPath.row==0){
            return FirstCell(indexPath.section)
        }else{
            return SecondCell(indexPath.section)
        }
    }
    func FirstCell(index:Int)->UITableViewCell{
        let cell=UITableViewCell()
        let lb=UILabel(frame: CGRectMake(20,8,self.view.frame.width,20))
        lb.text="第4566期 揭晓时间：2015-10-09 17:54:00"
        lb.text="第"+Ago!.items[index+1].version+"期 揭晓时间："+String(NSDate(timeIntervalSince1970: Double(Ago!.items[index+1].end_at)!))
        lb.font=UIFont.systemFontOfSize(15)
        cell.accessoryType=UITableViewCellAccessoryType.DisclosureIndicator
        cell.addSubview(lb)
        return cell
    }
    func SecondCell(index:Int)->UITableViewCell{
        let cell=UITableViewCell()
        let avator=UIImageView(frame: CGRectMake(20, 20, 50, 50))
        let username=UILabel(frame: CGRectMake(80,20,200,20))
        let id=UILabel(frame: CGRectMake(80,45,200,20))
        let number=UILabel(frame: CGRectMake(80,70,200,20))
        let term=UILabel(frame: CGRectMake(80,95,200,20))
        if((Ago!.items[index+1].thumb) != nil){
            avator.sd_setImageWithURL(NSURL(string: Ago!.items[index+1].thumb)!, placeholderImage: UIImage(named: "avator.jpg"))
            username.text="获奖者："+Ago!.items[index+1].nickname
            id.text="用户ID："+String(Ago!.items[index+1].winneruserid)
            number.text="幸运号码："+String(Ago!.items[index+1].winnernumber)
            term.text="本期参与："+Ago!.items[index+1].count+"人次"
        }
        
        avator.clipsToBounds=true
        avator.layer.cornerRadius=25
        
        
        username.font=UIFont.systemFontOfSize(15)
        
        
        id.font=UIFont.systemFontOfSize(15)
        
        
        number.font=UIFont.systemFontOfSize(15)
        
        
        term.font=UIFont.systemFontOfSize(15)
        cell.addSubview(avator)
        cell.addSubview(username)
        cell.addSubview(id)
        cell.addSubview(number)
        cell.addSubview(term)
        return cell
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let another=GoneDetail()
        another.Id=Ago!.items[indexPath.section+1].id
        another.Through=self.Through
        self.navigationController?.pushViewController(another, animated: true)
//        if(indexPath.section==0){
//            let anotherView:UIViewController=self.storyboard!.instantiateViewControllerWithIdentifier("NewestDetail");
//            self.navigationController?.pushViewController(anotherView, animated: true)
//        }else{
            //let anotherView:UIViewController=self.storyboard!.instantiateViewControllerWithIdentifier("NewestGoneDetail");
//        let anotherView=TenChargeDetailController()
//        //anotherView.tableView=UITableView(frame: self.view.frame, style: UITableViewStyle.Grouped)
//        //anotherView.GrabcornId=Int(Ago!.items[index+1].id)
//        anotherView.GrabcornId=Ago!.items[indexPath.section+1].id
//            self.navigationController?.pushViewController(anotherView, animated: true)
////        }
    }
}
