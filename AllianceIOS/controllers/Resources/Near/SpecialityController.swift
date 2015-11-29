//
//  SpecialityController.swift
//  AllianceIOS
//
//  Created by dawei on 15/11/1.
//
//

import UIKit
import SwiftHTTP
import JSONJoy
import WEPopover

class SpecialityController: UITableViewController {
    
    @IBOutlet weak var Search: UISearchBar!

    @IBOutlet var SpecialityController: UITableView!
    
    var popover: WEPopover.WEPopoverController!

    
    struct Item : JSONJoy {
        var objID: String?
        var userID: String?
        var kindid: String?
        var title:String?
        var location: String?
        var sellerphone: String?
        var reason: String?
        var pictures: String?
        var longitude: String?
        var latitude: String?
        var created_at: String?
        var phone: String?
        var nickname: String?
        var thumb: String?
        var kind: String?
        var comments: Array<Comments>!
        init(_ decoder: JSONDecoder) {
            objID = decoder["id"].string
            userID=decoder["userid"].string
            kindid=decoder["kindid"].string
            title=decoder["title"].string
            location=decoder["location"].string
            sellerphone=decoder["sellerphone"].string
            reason=decoder["reason"].string
            pictures=decoder["pictures"].string
            longitude=decoder["longitude"].string
            latitude=decoder["latitude"].string
            created_at=decoder["created_at"].string
            phone=decoder["phone"].string
            nickname=decoder["nickname"].string
            thumb=decoder["thumb"].string
            kind=decoder["kind"].string
            
            if let it = decoder["comments"].array {
                comments = Array<Comments>()
                for itemDecoder in it {
                    comments.append(Comments(itemDecoder))
                }
            }
        }
    }
    
    struct Comments: JSONJoy {
        var objID: String?
        var userID: String?
        var recommendationid: String?
        var content:String?
        var created_at: String?
        var phone: String?
        var nickname: String?
        var thumb: String?
        init(_ decoder: JSONDecoder) {
            objID = decoder["id"].string
            userID=decoder["userid"].string
            recommendationid=decoder["recommendationid"].string
            content=decoder["content"].string
            created_at=decoder["created_at"].string
            phone=decoder["phone"].string
            nickname=decoder["nickname"].string
            thumb=decoder["thumb"].string
        }
    }
    
    struct Url : JSONJoy {
        var href:String?
        init(_ decoder: JSONDecoder) {
            href = decoder["href"].string
        }
    }
    
    struct Link : JSONJoy {
        var prev:Url?
        var next:Url?
        init(_ decoder: JSONDecoder) {
            prev = Url(decoder["prev"])
            next = Url(decoder["next"])
        }
    }
    
    struct Meta : JSONJoy {
        var totalCount: Int?
        var pageCount: Int?
        var currentPage: Int?
        var perPage: Int?
        init(_ decoder: JSONDecoder) {
            totalCount = decoder["totalCount"].integer
            pageCount = decoder["pageCount"].integer
            currentPage = decoder["currentPage"].integer
            perPage = decoder["perPage"].integer
        }
        
    }
    
    struct Info: JSONJoy {
        var items: Array<Item>!
        var _links : Link!
        var _meta : Meta!
        init(_ decoder: JSONDecoder) {
            //we check if the array is valid then alloc our array and loop through it, creating the new address objects.
            if let it = decoder["items"].array {
                items = Array<Item>()
                for itemDecoder in it {
                    items.append(Item(itemDecoder))
                }
            }
            
            _links = Link(decoder["_links"])
            _meta = Meta(decoder["_meta"])
        }
    }

    var activityIndicatorView: UIActivityIndicatorView!
    var info:Info?
        {
        //我们需要在age属性发生变化后，更新一下nickName这个属性
        didSet
        {
            self.activityIndicatorView.stopAnimating()
            self.activityIndicatorView.hidden=true
            self.tableView.backgroundView=nil
            dispatch_async(dispatch_get_main_queue()){
                
                self.tableView.reloadData()
                self.tableView.refreshFooter.endRefresh()
                self.tableView.refreshHeader.endRefresh()
                if(self.pulltimes==0){
                    self.addinfo=self.info
                    //self.pulltimes=1
                }
                
            }
        }
    }
    
    var addinfo:Info?
        {
        //我们需要在age属性发生变化后，更新一下nickName这个属性
        didSet
        {
            dispatch_async(dispatch_get_main_queue()){
                if (self.pulltimes == 0){
                    self.pulltimes=1
                }else{
                    for(var i=0;i<self.addinfo?.items.count;i++)
                    {
                        self.info?.items.append((self.addinfo?.items[i])!)
                    }
                }
            }
            
        }
    }

    
    var pulltimes:Int=0
    var allflag:Int=0
    
    
    var alert:UIAlertController!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.backBarButtonItem=UIBarButtonItem(title: "", style: UIBarButtonItemStyle.Plain, target: nil, action: nil)
        self.navigationItem.rightBarButtonItem=UIBarButtonItem(image: UIImage(named: "发帖按钮.png"), style: UIBarButtonItemStyle.Plain, target: self, action: Selector("mine"))
        //self.navigationItem.rightBarButtonItem?.tintColor=UIColor.redColor()
        self.tableView.dataSource=self
        self.tableView.delegate=self
        self.tableView.registerClass(SpecialityTitleCell.self, forCellReuseIdentifier: "SpecialityTitleCell")
        self.tableView.registerClass(SpecialityContentCell.self, forCellReuseIdentifier: "SpecialityContentCell")
        self.tableView.allowsSelection=true
        self.tableView.separatorStyle=UITableViewCellSeparatorStyle.SingleLine
        self.tableView.backgroundColor=UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
        
        let SendAction=UIAlertAction(title: "发布帖子", style: UIAlertActionStyle.Default) { (action:UIAlertAction) -> Void in
            let anotherView:UIViewController=self.storyboard!.instantiateViewControllerWithIdentifier("SpecialityReq");
            self.navigationController?.pushViewController(anotherView, animated: true)
            //print("我要求职")
        }
        let MySendAction=UIAlertAction(title: "我的帖子", style: UIAlertActionStyle.Default) { (action:UIAlertAction) -> Void in
            let anotherView:UIViewController=self.storyboard!.instantiateViewControllerWithIdentifier("SpecialityMy");
            self.navigationController?.pushViewController(anotherView, animated: true)
            //print("我要求职")
        }
        alert=UIAlertController(title: "", message: "", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(SendAction)
        alert.addAction(MySendAction)
        
        
        self.automaticallyAdjustsScrollViewInsets=false
        addactivity()
        addRefreshView()
    }
    
    
    func addactivity(){  //第一步缓存
        let view1=UIView(frame: CGRectMake(0, 0, self.tableView.frame.size.width, self.tableView.frame.size.height))
        view1.backgroundColor=UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
        
        
        activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.White)
        
        activityIndicatorView.frame = CGRectMake(self.tableView.frame.size.width/2-100, -30, 200, 200)
        
        activityIndicatorView.hidesWhenStopped = true
        
        activityIndicatorView.color = UIColor.blackColor()
        view1.addSubview(activityIndicatorView)
        self.tableView.backgroundView=view1
        activityIndicatorView.startAnimating()
        
        if(allflag==0){
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)){
                self.connect()
            }
        }else{
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)){
                //self.connect1()
            }
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
        if(self.addinfo?._meta.currentPage==self.addinfo?._meta.pageCount){
            self.tableView.refreshFooter.loadMoreEnabled=false
            return
        }
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)){
            do {
                let opt=try HTTP.GET((self.addinfo?._links.next?.href)!)
                
                opt.start { response in
                    if let err = response.error {
                        print("error: \(err.localizedDescription)")
                        return //also notify app of failure as needed
                    }
                    print("opt finished: \(response.description)")
                    //print("data is: \(response.data)") access the response of the data with response.data
                    self.addinfo = Info(JSONDecoder(response.data))
                    print("content is: \(self.addinfo!._links)")
                    
                }
            } catch let error {
                print("got an error creating the request: \(error)")
            }
        }
    }
    
    func refreshData() {
        self.pulltimes=0
        self.tableView.refreshFooter.loadMoreEnabled=true
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)){
            if(self.allflag==0){
                self.connect()
            }else{
               // self.connect1()
            }
        }
    }
    
    
    func connect(){
        print("ccccc")
        do {
            let opt=try HTTP.GET("http://183.129.190.82:50001/v1/recommendations/search")
            
            opt.start { response in
                if let err = response.error {
                    print("error: \(err.localizedDescription)")
                    return //also notify app of failure as needed
                }
                print("opt finished: \(response.description)")
                //print("data is: \(response.data)") access the response of the data with response.data
                self.info = Info(JSONDecoder(response.data))
                print("content is: \(self.info!.items[0])")
                
            }
        } catch let error {
            print("got an error creating the request: \(error)")
        }
        
    }
    

    
    
    override func viewWillAppear(animated: Bool){
        self.info=nil
        self.addinfo=nil
        addactivity()
        print("appesr")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        if((self.info?.items.count) != nil){
            return (self.info?.items.count)!
        }else{
            return 0
        }

    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 2
        
    }
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if(indexPath.row==0){
            return 50
        }
        return 150
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if(indexPath.row==0){
            let cell = tableView.dequeueReusableCellWithIdentifier("SpecialityTitleCell", forIndexPath: indexPath) as! SpecialityTitleCell
            cell.username.text=self.info?.items[indexPath.section].nickname
            cell.location.text=self.info?.items[indexPath.section].location
            cell.kind.text=self.info?.items[indexPath.section].kind
            cell.avator.sd_setImageWithURL(NSURL(string: (self.info?.items[indexPath.section].thumb)!), placeholderImage: UIImage(named: "avator.jpg"))
            let dateOfRecord=NSDate(timeIntervalSince1970:(self.info!.items[indexPath.section].created_at! as NSString).doubleValue)
            cell.time.text=String(dateOfRecord)
            cell.messageCount.text=String(self.info?.items[indexPath.section].comments.count)
            return cell
        }
        let cell = tableView.dequeueReusableCellWithIdentifier("SpecialityContentCell", forIndexPath: indexPath) as! SpecialityContentCell
        cell.title.text=self.info?.items[indexPath.section].title
        cell.content.text=self.info?.items[indexPath.section].reason
       
        cell.imageurls=self.info?.items[indexPath.section].pictures
        if((cell.imageurls?.isEmpty) != nil){
            cell.addpic()
        }
        return cell
        
        
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
        //self.performSegueWithIdentifier("detail", sender: nil)
        let anotherView=self.storyboard!.instantiateViewControllerWithIdentifier("SpecialityDetail") as! SpecialityDetailController
        let kind = (self.info?.items[indexPath.section].kind)!+","
        let location = (self.info?.items[indexPath.section].location)!+","
        let phone=(self.info?.items[indexPath.section].phone)!+","
        let reason=self.info?.items[indexPath.section].reason
        let content=kind+location+phone+reason!
        anotherView.Value=content.componentsSeparatedByString(",")
        anotherView.nickname=self.info?.items[indexPath.section].nickname
        anotherView.thumb=self.info?.items[indexPath.section].thumb
        anotherView.imageurls=self.info?.items[indexPath.section].pictures
        anotherView.comments=(self.info?.items[indexPath.section].comments)!
        anotherView.reid=self.info?.items[indexPath.section].objID
        self.navigationController?.pushViewController(anotherView, animated: true)
    }
    
    func mine(){
        print("hello")
        //self.presentViewController(alert, animated: true, completion: nil)
        let my=SpecialityMenuViewController()
        let pop=WEPopoverController.init(contentViewController: my)
        self.popover=pop
        my.popover=self.popover
        my.Spec=self
        //self.popover.popoverContentSize=CGSizeMake(100,85)
        my.preferredContentSize=CGSizeMake(100,85)
        self.popover.presentPopoverFromBarButtonItem(self.navigationItem.rightBarButtonItem, permittedArrowDirections: UIPopoverArrowDirection.Up, animated: true)
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
