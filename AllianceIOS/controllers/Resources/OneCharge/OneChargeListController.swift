//
//  OneChargeListController.swift
//  AllianceIOS
//
//  Created by dawei on 15/11/3.
//
//

import UIKit
import SwiftHTTP
import JSONJoy

class OneChargeListController: UITableViewController {
    
    @IBOutlet var OneChargeListController: UITableView!
    var activityIndicatorView: UIActivityIndicatorView!
    var OneCharge:GrabCommodityList?
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
            self.connect(URL+"/grabcommodities/search")
        }
        addRefreshView()
    }

    func connect(url:String){
        print("获取一元夺宝列表")
        do {
            let params:Dictionary<String,AnyObject>=["type":0]
            let opt=try HTTP.POST(url, parameters: params)
            opt.start { response in
                if let err = response.error {
                    print("error: \(err.localizedDescription)")
                    return //also notify app of failure as needed
                }
                print("opt finished: \(response.description)")
                self.OneCharge = GrabCommodityList(JSONDecoder(response.data))
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
        if(self.OneCharge!._meta.currentPage==self.OneCharge!._meta.pageCount){
            self.tableView.refreshFooter.loadMoreEnabled=false
            return
        }
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)){
            do {
                let opt=try HTTP.GET((self.OneCharge!._links.next?.href)!)
                opt.start { response in
                    if let err = response.error {
                        print("error: \(err.localizedDescription)")
                        return //also notify app of failure as needed
                    }
                    print("opt finished: \(response.description)")
                    //print("data is: \(response.data)") access the response of the data with response.data
                    var lin:GrabCommodityList?
                    lin = GrabCommodityList(JSONDecoder(response.data))
                    for var i=(self.OneCharge!.items.count-1);i>=0;i-- {
                        lin?.items.insert(self.OneCharge!.items[i], atIndex: 0)
                    }
                    self.OneCharge!=lin!
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
                self.connect(URL+"/grabcommodities/search")
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        if((OneCharge) != nil){
            return 1
        }
        return 0
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.1
    }
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return CGFloat(((OneCharge?.items.count)!+1)/2)*self.view.frame.width/2
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return OnechargeListCell()
    }
    func OnechargeListCell()->UITableViewCell{
        let cell=UITableViewCell()
        let halfwidth=Float(self.view.frame.width)/2
        for i in 0...((OneCharge?.items.count)!-1){
            let btn=UIButton(frame: CGRectMake(CGFloat(Float(i%2)*halfwidth), CGFloat(Float(i/2)*halfwidth), CGFloat(halfwidth), CGFloat(halfwidth)))
            btn.tag=i
            btn.addTarget(self, action: Selector("Detail:"), forControlEvents: UIControlEvents.TouchUpInside)
            let pic=UIImageView(frame: CGRectMake(CGFloat(Float(i%2)*halfwidth)+CGFloat(halfwidth/4),CGFloat(Float(i/2)*halfwidth)+20, CGFloat(halfwidth/2), CGFloat(halfwidth/2)))
//            if let Ndata=NSData(contentsOfURL: NSURL(string: OneCharge!.items[i].picture)!){
//                pic.image=UIImage(data: Ndata)
//            }
            //pic.image=UIImage(data: NSData(contentsOfURL: NSURL(string: OneCharge!.items[i].picture)!)!)
            pic.sd_setImageWithURL(NSURL(string: OneCharge!.items[i].picture)!, placeholderImage: UIImage(named: "avator.jpg"))
            let name=UILabel(frame: CGRectMake(CGFloat(Float(i%2)*halfwidth)+15, CGFloat(Float(i/2)*halfwidth)+CGFloat(halfwidth/2)+20, CGFloat(halfwidth)-15, 20))
            name.text=OneCharge!.items[i].title
            name.font=UIFont.systemFontOfSize(15)
            let progress=UIProgressView(frame: CGRectMake(CGFloat(Float(i%2)*halfwidth)+15, CGFloat(Float(i/2)*halfwidth)+CGFloat(halfwidth/2)+60, CGFloat(halfwidth)-15, 10))
            progress.progress=1-Float(OneCharge!.items[i].remain)/Float(OneCharge!.items[i].needed)
            progress.progressTintColor=UIColor(red: 255/255, green: 150/255, blue: 0/255, alpha: 1.0)
            progress.transform=CGAffineTransformMakeScale(1.0, 3.0)
            progress.trackTintColor=UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1.0)
            progress.clipsToBounds=true
            progress.layer.cornerRadius=2
            let process=UILabel(frame: CGRectMake(CGFloat(Float(i%2)*halfwidth)+15, CGFloat(Float(i/2)*halfwidth)+CGFloat(halfwidth/2)+40, CGFloat(halfwidth)-15, 20))
            process.font=UIFont.systemFontOfSize(11)
            process.text="开奖进度       "+String(Int(progress.progress*100))+"%"
            process.textColor=UIColor(red: 111/255, green: 111/255, blue: 111/255, alpha: 1.0)
            let total=UILabel(frame: CGRectMake(CGFloat(Float(i%2)*halfwidth)+15, CGFloat(Float(i/2)*halfwidth)+CGFloat(halfwidth/2)+65, CGFloat(halfwidth)-30, 20))
            total.text="总需："+String(OneCharge!.items[i].needed)+"人次"
            total.font=UIFont.systemFontOfSize(11)
            total.textColor=UIColor(red: 111/255, green: 111/255, blue: 111/255, alpha: 1.0)
            let remain=UILabel(frame: CGRectMake(CGFloat(Float(i%2+1)*halfwidth)-80, CGFloat(Float(i/2)*halfwidth)+CGFloat(halfwidth/2)+65, 80, 20))
            remain.text="剩余"+String(OneCharge!.items[i].remain)
            remain.font=UIFont.systemFontOfSize(11)
            remain.textColor=UIColor(red: 220/255, green: 100/255, blue: 100/255, alpha: 1.0)
            cell.addSubview(btn)
            cell.addSubview(pic)
            cell.addSubview(name)
            cell.addSubview(total)
            cell.addSubview(progress)
            cell.addSubview(process)
            cell.addSubview(remain)
        }
        return cell
    }
    func Detail(sender:UIButton){
        let anotherView=OneChargeDetailController()
        //anotherView.tableView=UITableView(frame: self.view.frame, style: UITableViewStyle.Grouped)
        anotherView.GrabCommodityId=(OneCharge?.items[sender.tag].id)!
        self.navigationController?.pushViewController(anotherView, animated: true)
    }

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
