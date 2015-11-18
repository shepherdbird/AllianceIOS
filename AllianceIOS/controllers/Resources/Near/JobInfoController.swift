//
//  JobInfoController.swift
//  AllianceIOS
//
//  Created by dawei on 15/10/25.
//
//

//import UIKit
import SwiftHTTP
import JSONJoy
import SDWebImage
import WEPopover
import UIKit

class JobInfoController: UITableViewController {
    
    var activityIndicatorView: UIActivityIndicatorView!
    //@IBOutlet var JobInfoController: UITableView!
    
    private var texts = ["Edit", "Delete", "Report"]
    var popover: WEPopoverController!
//    public var popoverOptions: [PopoverOption] = [
//        .Type(.Down),
//        .BlackOverlayColor(UIColor(white: 0.0, alpha: 0.6)),
//        .CornerRadius(0)
//    ]
    
    var flag:Int?{
        didSet
        {
            self.goto()
        }
    }
    
    var info:Info?
        {
    //我们需要在age属性发生变化后，更新一下nickName这个属性
        didSet
        {
            activityIndicatorView.stopAnimating()
            self.activityIndicatorView.hidden=true
            self.tableView.backgroundView=nil
            self.tableView.reloadData()
        }
    }
    
    struct Item : JSONJoy {
        var objID: String?
        var userID: String?
        var jobproperty: String?
        var title:String?
        var degree: String?
        var work_at: String?
        var status: String?
        var hidephone: String?
        var content: String?
        var professionid: String?
        var created_at: String?
        var phone: String?
        var nickname: String?
        var thumb: String?
        var profession: String?
        init(_ decoder: JSONDecoder) {
            objID = decoder["id"].string
            userID=decoder["userid"].string
            jobproperty=decoder["jobproperty"].string
            title=decoder["title"].string
            degree=decoder["degree"].string
            work_at=decoder["work_at"].string
            status=decoder["status"].string
            hidephone=decoder["hidephone"].string
            content=decoder["content"].string
            professionid=decoder["professionid"].string
            created_at=decoder["created_at"].string
            phone=decoder["phone"].string
            nickname=decoder["nickname"].string
            thumb=decoder["thumb"].string
            profession=decoder["profession"].string
        }
    }
    
    struct Link : JSONJoy {
        var href:String?
        init(_ decoder: JSONDecoder) {
            href = decoder["href"].string
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
    
   
    var alert:UIAlertController!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.backBarButtonItem=UIBarButtonItem(title: "", style: UIBarButtonItemStyle.Plain, target: nil, action: nil)
        self.navigationItem.rightBarButtonItem=UIBarButtonItem(image: UIImage(named: "发帖按钮.png"), style: UIBarButtonItemStyle.Plain, target: self, action: Selector("mine"))
        //self.navigationItem.rightBarButtonItem?.tintColor=UIColor.redColor()
//        self.JobInfoController.dataSource=self
//        self.JobInfoController.delegate=self
//        self.JobInfoController.registerClass(JobInfoTitleCell.self, forCellReuseIdentifier: "JobInfoTitleCell")
//        self.JobInfoController.registerClass(JobInfoContentCell.self, forCellReuseIdentifier: "JobInfoContentCell")
//        self.JobInfoController.allowsSelection=true
//        self.JobInfoController.separatorStyle=UITableViewCellSeparatorStyle.SingleLine
//        self.JobInfoController.backgroundColor=UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
    
        self.tableView.dataSource=self
        self.tableView.delegate=self
        
        self.tableView.registerClass(JobInfoTitleCell.self, forCellReuseIdentifier: "JobInfoTitleCell")
        self.tableView.registerClass(JobInfoContentCell.self, forCellReuseIdentifier: "JobInfoContentCell")
        self.tableView.allowsSelection=true
        self.tableView.separatorStyle=UITableViewCellSeparatorStyle.SingleLine
        self.tableView.backgroundColor=UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
        
        let reqAction=UIAlertAction(title: "我要求职", style: UIAlertActionStyle.Default) { (action:UIAlertAction) -> Void in
            let anotherView:UIViewController=self.storyboard!.instantiateViewControllerWithIdentifier("JobInfoReq");
            self.navigationController?.pushViewController(anotherView, animated: true)
            //print("我要求职")
        }
        let myreqAction=UIAlertAction(title: "我的帖子", style: UIAlertActionStyle.Default) { (action:UIAlertAction) -> Void in
            let anotherView:UIViewController=self.storyboard!.instantiateViewControllerWithIdentifier("JobInfoMy");
            self.navigationController?.pushViewController(anotherView, animated: true)
            //print("我要求职")
        }
        alert=UIAlertController(title: "", message: "", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(reqAction)
        alert.addAction(myreqAction)
        
        
        let view1=UIView(frame: CGRectMake(0, 0, self.tableView.frame.size.width, self.tableView.frame.size.height))
        view1.backgroundColor=UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)

        
        activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.White)
       
            activityIndicatorView.frame = CGRectMake(self.tableView.frame.size.width/2-100, -30, 200, 200)
      
            activityIndicatorView.hidesWhenStopped = true
      
            activityIndicatorView.color = UIColor.blackColor()
        view1.addSubview(activityIndicatorView)
        self.tableView.backgroundView=view1
       activityIndicatorView.startAnimating()
        //self.navigationItem.
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)){
            self.connect()
        }
       
    }
    func connect(){
        
        print("ccccc")
        do {
            let opt=try HTTP.GET("http://183.129.190.82:50001/v1/applyjobs/search")
            
            opt.start { response in
                if let err = response.error {
                    print("error: \(err.localizedDescription)")
                    return //also notify app of failure as needed
                }
                print("opt finished: \(response.description)")
                //print("data is: \(response.data)") access the response of the data with response.data
                self.info = Info(JSONDecoder(response.data))
                print("content is: \(self.info!.items[0].content)")
                
            }
        } catch let error {
            print("got an error creating the request: \(error)")
        }

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
            let cell = tableView.dequeueReusableCellWithIdentifier("JobInfoTitleCell", forIndexPath: indexPath) as! JobInfoTitleCell
            cell.username.text=self.info?.items[indexPath.section].nickname
            if((self.info?.items[indexPath.section].jobproperty)=="1"){
                cell.kind.text="全职"
            }else{
                cell.kind.text="兼职"
            }
            cell.job.text=self.info?.items[indexPath.section].profession
        
            let dateOfRecord=NSDate(timeIntervalSince1970:(self.info!.items[indexPath.section].created_at! as NSString).doubleValue)
            cell.time.text=String(dateOfRecord)
            cell.avator.sd_setImageWithURL(NSURL(string: (self.info?.items[indexPath.section].thumb)!), placeholderImage: UIImage(named: "avator.jpg"))
            return cell
        }
        
        let cell = tableView.dequeueReusableCellWithIdentifier("JobInfoContentCell", forIndexPath: indexPath) as! JobInfoContentCell
        cell.title.text=self.info?.items[indexPath.section].title
        
        
        let deg:String="学历："+"本科\n"
        let work:String="参加工作时间："+"2013-07\n"
        let sts:String="目前状况："+(self.info?.items[indexPath.section].status)!
        let cont:String="\n留言："+(self.info?.items[indexPath.section].content)!
        cell.content.text=deg+work+sts+cont
        return cell

        
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
        //self.performSegueWithIdentifier("detail", sender: nil)
        
//        let anotherView:JobInfoDetailController=self.storyboard!.instantiateViewControllerWithIdentifier("JobInfoDetail");
        let anotherView:JobInfoDetailController=JobInfoDetailController()
        anotherView.Username=(self.info?.items[indexPath.section].nickname)!
        anotherView.thumb=(self.info?.items[indexPath.section].thumb)!
        
        var jobp=String()
        if((self.info?.items[indexPath.section].jobproperty)=="1"){
           jobp="全职,"
        }else{
            jobp="兼职,"
        }
        
        let deg:String="本科,"
        let work:String="2013-07,"
        let sts:String=(self.info?.items[indexPath.section].status)!
        let phone:String=","+(self.info?.items[indexPath.section].phone)!
        let cont:String=","+(self.info?.items[indexPath.section].content)!
        let content:String=jobp+deg+work+sts+phone+cont
        
        print(content.componentsSeparatedByString(",").description)
        anotherView.Value=content.componentsSeparatedByString(",")
        
        self.navigationController?.pushViewController(anotherView, animated: true)
    }

    func mine(){
        print("hello")
        //self.presentViewController(alert, animated: true, completion: nil)
        let my:JobMenuViewController=JobMenuViewController()
        
        let pop=WEPopoverController(contentViewController: my)
        self.popover=pop
        my.popover=self.popover
        my.Job=self
        self.popover.popoverContentSize=CGSizeMake(100,85)
        self.popover.presentPopoverFromBarButtonItem(self.navigationItem.rightBarButtonItem, permittedArrowDirections: UIPopoverArrowDirection.Up, animated: true)
    }
    
    func goto(){
        if(flag==0){
            let anotherView:UIViewController=self.storyboard!.instantiateViewControllerWithIdentifier("JobInfoReq");
            anotherView.title="发表求职"
            self.navigationController?.pushViewController(anotherView, animated: true)
        }else{
            let anotherView:JobInfoMyController=JobInfoMyController()
            anotherView.title="我的帖子"
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


