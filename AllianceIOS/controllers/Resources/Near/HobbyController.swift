//
//  HobbyController.swift
//  AllianceIOS
//
//  Created by dawei on 15/11/1.
//
//

import UIKit
import SwiftHTTP
import JSONJoy
import WEPopover

class HobbyController: UITableViewController {

    @IBOutlet var HobbyController: UITableView!
    
    @IBOutlet weak var Search: UISearchBar!
    
    var popover: WEPopover.WEPopoverController!
    
    struct Item : JSONJoy {
        var objID: String?
        var userID: String?
        var picture: String?
        var sex:String?
        var age: String?
        var hobbyid: String?
        var hobby: String?
        var content: String?
        var created_at: String?
        var phone: String?
        var nickname: String?
        var thumb: String?
        init(_ decoder: JSONDecoder) {
            objID = decoder["id"].string
            userID=decoder["userid"].string
            picture=decoder["picture"].string
            sex=decoder["sex"].string
            age=decoder["age"].string
            hobbyid=decoder["hobbyid"].string
            hobby=decoder["hobby"].string
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
    
    var hobbykinds:HobbyGlobal.Hobby?
        {
        didSet
        {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)){
                self.connect()
            }
            
        }

    }
    
    var pulltimes:Int=0

    var alert:UIAlertController!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.backBarButtonItem=UIBarButtonItem(title: "", style: UIBarButtonItemStyle.Plain, target: nil, action: nil)
        self.navigationItem.rightBarButtonItem=UIBarButtonItem(image: UIImage(named: "发帖按钮.png"), style: UIBarButtonItemStyle.Plain, target: self, action: Selector("mine"))
        //self.navigationItem.rightBarButtonItem?.tintColor=UIColor.redColor()
        self.tableView.dataSource=self
        self.tableView.delegate=self
        self.tableView.registerClass(HobbyCell.self, forCellReuseIdentifier: "HobbyCell")
        self.tableView.allowsSelection=true
        self.tableView.separatorStyle=UITableViewCellSeparatorStyle.SingleLine
        //self.HobbyController.backgroundColor=UIColor(red: 250/255, green: 250/255, blue: 250/255, alpha: 0.3)
        
        let SendAction=UIAlertAction(title: "我要交友", style: UIAlertActionStyle.Default) { (action:UIAlertAction) -> Void in
            let anotherView:UIViewController=self.storyboard!.instantiateViewControllerWithIdentifier("HobbyReq");
            self.navigationController?.pushViewController(anotherView, animated: true)
            //print("我要求职")
        }
        let MySendAction=UIAlertAction(title: "我的交友", style: UIAlertActionStyle.Default) { (action:UIAlertAction) -> Void in
            let anotherView:UIViewController=self.storyboard!.instantiateViewControllerWithIdentifier("HobbyMy");
            self.navigationController?.pushViewController(anotherView, animated: true)
            //print("我要求职")
        }
        alert=UIAlertController(title: "", message: "", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(SendAction)
        alert.addAction(MySendAction)
        //self.tableView.showsVerticalScrollIndicator
        //self.navigationItem.
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        addactivity()
        addRefreshView()
    }
    
    override func viewWillAppear(animated: Bool){
        self.info=nil
        self.addinfo=nil
        self.hobbykinds=nil
        addactivity()
        print("appesr")
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
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)){
            self.gethobby()
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
                self.connect()
        }
    }
    
    
    func gethobby(){
        do {
            let opt=try HTTP.GET("http://183.129.190.82:50001/v1/hobbies/list")
            
            opt.start { response in
                if let err = response.error {
                    print("error: \(err.localizedDescription)")
                    return //also notify app of failure as needed
                }
                print("opt finished: \(response.description)")
                //print("data is: \(response.data)") access the response of the data with response.data
                self.hobbykinds = HobbyGlobal.Hobby(JSONDecoder(response.data))
               // print("content is: \(self.info!.items[0].content)")
                
            }
        } catch let error {
            print("got an error creating the request: \(error)")
        }
    }
    
    func connect(){
        print("ccccc")
        do {
            let opt=try HTTP.GET("http://183.129.190.82:50001/v1/daters/search")
            
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
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if((self.info?.items.count) != nil){
            return (self.info?.items.count)!
        }else{
            return 0
        }

        
    }
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
    }
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("HobbyCell", forIndexPath: indexPath) as! HobbyCell
        cell.avator.sd_setImageWithURL(NSURL(string: (self.info?.items[indexPath.row].picture)!), placeholderImage: UIImage(named: "avator.jpg"))
        cell.age.text=self.info?.items[indexPath.row].age
        cell.username.text=self.info?.items[indexPath.row].nickname
        cell.distance.text="0.05km"
        cell.time.text=self.info?.items[indexPath.row].created_at
        cell.interest.text="兴趣分组："+(self.info?.items[indexPath.row].hobby)!+"\n留言："+(self.info?.items[indexPath.row].content)!
        
        if(Int((self.info?.items[indexPath.row].sex)!)!%2==1){
            cell.gender.image=UIImage(named: "标签男.png")
        }else{
            cell.gender.image=UIImage(named: "标签女.png")
        }

        
        return cell
        
        
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.HobbyController.deselectRowAtIndexPath(indexPath, animated: true)
        //self.performSegueWithIdentifier("detail", sender: nil)
        let anotherView:UIViewController=self.storyboard!.instantiateViewControllerWithIdentifier("HobbyDetail");
        self.navigationController?.pushViewController(anotherView, animated: true)
    }
    
    func mine(){
        print("爱好交友右上角按钮被点击")
        let my=HobbyMenuViewController()
        let pop=WEPopoverController.init(contentViewController: my)
        self.popover=pop
        my.popover=self.popover
        my.Spec=self
        my.aihao=self.hobbykinds
        my.tableView.layer.cornerRadius = 4;
        //self.popover.popoverContentSize=CGSizeMake(100,85)
        my.preferredContentSize=CGSizeMake(100,85)
        self.popover.presentPopoverFromBarButtonItem(self.navigationItem.rightBarButtonItem, permittedArrowDirections: UIPopoverArrowDirection.Up, animated: true)
        //self.presentViewController(alert, animated: true, completion: nil)
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
