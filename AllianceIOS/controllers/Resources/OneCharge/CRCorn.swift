//
//  CRCorn.swift
//  AllianceIOS
//
//  Created by dawei on 15/11/29.
//
//

import UIKit
import SwiftHTTP
import JSONJoy

class CRCorn: UITableViewController {
    
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
            self.connect(URL+"/grabcornrecords/list")
            
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
                self.connect(URL+"/grabcornrecords/list")
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
        if(GrabCommodity!.items[indexPath.row].islotteried==1){
            return 200
        }
        return 140
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        return GotCell(indexPath.row)
    }
    func GotCell(row:Int)->UITableViewCell{
        let cell=UITableViewCell()
        let avator=UIImageView(frame: CGRectMake(40, 40, 60, 60))
        let title=UILabel(frame: CGRectMake(120,20,self.view.frame.width-120,30))
        let count=UILabel(frame: CGRectMake(120,50,self.view.frame.width-120,20))
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
            back.backgroundColor=UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1.0)
            let nickname=UILabel(frame: CGRectMake(135,130,200,15))
            nickname.text="获奖者："+GrabCommodity!.items[row].nickname!
            nickname.font=UIFont.systemFontOfSize(15)
            let term2=UILabel(frame: CGRectMake(135,150,200,15))
            term2.text="本期参与："+String(GrabCommodity!.items[row].winnercount!)+"人次"
            term2.font=UIFont.systemFontOfSize(15)
            let number=UILabel(frame: CGRectMake(135,170,200,15))
            number.text="幸运号码："+String(GrabCommodity!.items[row].winnernumber!)
            number.font=UIFont.systemFontOfSize(15)
            cell.addSubview(back)
            cell.addSubview(nickname)
            cell.addSubview(term2)
            cell.addSubview(number)
        }
        return cell
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
        if(GrabCommodity!.items[indexPath.row].islotteried==1){
            let another=GoneDetail()
            another.Id=Int(GrabCommodity!.items[indexPath.row].grabcornid!)!
            another.Through="corn"
            self.navigationController?.pushViewController(another, animated: true)
        }else{
            let anotherView=TenChargeDetailController()
            //anotherView.tableView=UITableView(frame: self.view.frame, style: UITableViewStyle.Grouped)
            //anotherView.GrabCommodityId=Int(GrabCommodity!.items[indexPath.row].grabcornid!!)
            anotherView.GrabcornId=Int(GrabCommodity!.items[indexPath.row].grabcornid!)!
            self.navigationController?.pushViewController(anotherView, animated: true)
        }
    }
    
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
