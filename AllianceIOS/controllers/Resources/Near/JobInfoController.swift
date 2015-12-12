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
//import SDWebImage
import WEPopover
import UIKit
import Foundation

class JobInfoController: UITableViewController {
    
    var activityIndicatorView: UIActivityIndicatorView!
    //@IBOutlet var JobInfoController: UITableView!
    var deg = ["初中及初中以下", "高中", "大专", "本科", "硕士", "博士"]
    
    var popover: WEPopover.WEPopoverController!
    
    var flag:Int?{
        didSet
        {
            self.goto()
        }
    }
    
    var Iscreate:Flag?{
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
    
    //职业
    struct ZhiItem : JSONJoy {
        var objID: Int?
        var profession: String?
        init(_ decoder: JSONDecoder) {
            objID = decoder["id"].integer
            profession=decoder["profession"].string
        }
    }
    
    struct ZhiInfo: JSONJoy {
        var items: Array<ZhiItem>!
        
        init(_ decoder: JSONDecoder) {
            //we check if the array is valid then alloc our array and loop through it, creating the new address objects.
            if let it = decoder.array {
                items = Array<ZhiItem>()
                for itemDecoder in it {
                    items.append(ZhiItem(itemDecoder))
                }
            }
        }
    }
    
   // var zhi: Array<String> = []
    var zhiinfo:ZhiInfo?
        {
        didSet
        {
           // zhi=Array<String>()
            if(self.allflag==0){
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)){
                    self.getall()
                }
            }else{
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)){
                    self.getbypa()
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
    
    var my=JobZhiyViewController()
        {
        //我们需要在age属性发生变化后，更新一下nickName这个属性
        didSet
        {
            print("ssss")
        }
    }

    
    var pulltimes:Int=0
    var allflag:Int=0
    var prop:Int?
    var zhi:Int?
   
    var alert:UIAlertController!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.backBarButtonItem=UIBarButtonItem(title: "", style: UIBarButtonItemStyle.Plain, target: nil, action: nil)
        self.navigationItem.rightBarButtonItem=UIBarButtonItem(image: UIImage(named: "发帖按钮.png"), style: UIBarButtonItemStyle.Plain, target: self, action: Selector("mine"))

    
        self.tableView.dataSource=self
        self.tableView.delegate=self
        
        self.tableView.registerClass(JobInfoTitleCell.self, forCellReuseIdentifier: "JobInfoTitleCell")
        self.tableView.registerClass(JobInfoContentCell.self, forCellReuseIdentifier: "JobInfoContentCell")
        self.tableView.allowsSelection=true
        self.tableView.separatorStyle=UITableViewCellSeparatorStyle.SingleLine
        self.tableView.backgroundColor=UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
        self.tableView.sectionFooterHeight=1
        addtitle(0)
        //求职信息
        self.tableView.userInteractionEnabled=true
        self.automaticallyAdjustsScrollViewInsets=false
        addactivity()
       addRefreshView()
    }
    
    func addtitle(direct:Int){
        let jobInfo=UIButton(frame: CGRectMake(0, 0, 80, 50))
        jobInfo.tag=1
        jobInfo.addTarget(self, action:Selector("ButtonAction:"), forControlEvents: UIControlEvents.TouchUpInside)
        let jobInfoIco=UIImageView(frame: CGRectMake(72, 22, 11, 6))
        if(direct==0){
            jobInfoIco.image=UIImage(named: "xiala.png")
        }else{
            jobInfoIco.image=UIImage(named: "xialaf.png")
        }
        let jobInfoLabel=UILabel(frame: CGRectMake(0, 0, 70,50))
        jobInfoLabel.text="求职信息"
        jobInfoLabel.textColor=UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        jobInfoLabel.adjustsFontSizeToFitWidth=true
        //        self.view.addSubview(jobInfo)
        //        self.view.addSubview(jobInfoIco)
        // self.navigationController?.navigationBar.center.x addSubview(jobInfo)
        jobInfo.addSubview(jobInfoLabel)
        jobInfo.addSubview(jobInfoIco)
        self.navigationItem.titleView=jobInfo

    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        print("sasacs")
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
            self.getzhiye()
        }

    }
    
    func getzhiye(){
        do {
            let opt=try HTTP.GET("http://183.129.190.82:50001/v1/professions/list")
            
            opt.start { response in
                if let err = response.error {
                    print("error: \(err.localizedDescription)")
                    return //also notify app of failure as needed
                }
                print("opt finished: \(response.description)")
                //print("data is: \(response.data)") access the response of the data with response.data
                self.zhiinfo = ZhiInfo(JSONDecoder(response.data))
              //  print("content is: \(self.info!.items[0].content)")
                
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
                    self.addinfo = JobInfoController.Info(JSONDecoder(response.data))
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
            self.getall()
            }else{
                self.getbypa()
            }
        }
    }

    
    func getall(){
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
    
    func getbypa(){
        print("返回来了")
        print(allflag)
        self.pulltimes=0
        do {
            var professionid:Int!=0
            var opt:HTTP?
            if(zhi==0){
                allflag=0
                opt=try HTTP.POST("http://183.129.190.82:50001/v1/applyjobs/search")
            }
            else{
                professionid=self.zhiinfo?.items[zhi!-1].objID
                opt=try HTTP.POST("http://183.129.190.82:50001/v1/applyjobs/search",parameters: ["professionid":professionid])
            }
            
            opt!.start { response in
                if let err = response.error {
                    print("error: \(err.localizedDescription)")
                    return //also notify app of failure as needed
                }
                print("opt finished: \(response.URL)")
                //print("data is: \(response.data)") access the response of the data with response.data
                self.info = Info(JSONDecoder(response.data))
              //  print("content is: \(self.info!.items[0].content)")
                
            }
        } catch let error {
            print("got an error creating the request: \(error)")
        }
        
    }

    
    override func viewWillAppear(animated: Bool){
        self.info=nil
        self.addinfo=nil
        addactivity()
        print(self.zhi)
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
        return 7
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
        
        let degnum=Int((self.info?.items[indexPath.section].degree)!)
        let deg:String="学历："+self.deg[degnum!]+"\n"
        let work:String="参加工作时间："+(self.info?.items[indexPath.section].work_at)!
        let sts:String="\n目前状况："+(self.info?.items[indexPath.section].status)!
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
        
        let degnum=Int((self.info?.items[indexPath.section].degree)!)
        let deg:String=self.deg[degnum!]+","
        let work:String=(self.info?.items[indexPath.section].work_at)!+","
        let sts:String=(self.info?.items[indexPath.section].status)!
        let phone:String=","+(self.info?.items[indexPath.section].phone)!
        let cont:String=","+(self.info?.items[indexPath.section].content)!
        let content:String=jobp+deg+work+sts+phone+cont
        
        print(content.componentsSeparatedByString(",").description)
        anotherView.Value=content.componentsSeparatedByString(",")
        
        self.navigationController?.pushViewController(anotherView, animated: true)
    }
    
    func ButtonAction(sender:UIButton){
        switch sender.tag {
        case 1:
//            let myStoryBoard = UIStoryboard(name: "Main", bundle: nil)
//            let anotherView=myStoryBoard.instantiateViewControllerWithIdentifier("JobInfoSearch") as! JobsearchViewController
//            
//            //anotherView.title="发表求职"
//           // self.navigationController?.modalPresentationStyle=UIModalPresentationStyle.FormSheet
//            anotherView.Jobinfo=self
//            
//            self.navigationController?.pushViewController(anotherView, animated: true)
//           
            //self.navigationController?.presentViewController(anotherView, animated: true, completion: nil)
            
            
            let pop=WEPopoverController.init(contentViewController: my)
            self.popover=pop
            my.popover=self.popover
            my.info=self.zhiinfo
            my.flag=1
            my.Jobinfo=self
            my.tableView.scrollEnabled=false
            //my.Job=self
            my.tableView.layer.cornerRadius = 4;
            
            //self.popover.popoverContentSize=CGSizeMake(100,85)
            let count=CGFloat((self.zhiinfo?.items.count)!+1)
            my.preferredContentSize=CGSizeMake(self.tableView.frame.width/2,43*count)
            
            var rect=self.navigationItem.titleView?.frame
            rect=rect?.offsetBy(dx: -((rect?.origin.x)!), dy: 0)
            self.popover.presentPopoverFromRect(rect!, inView: self.navigationItem.titleView, permittedArrowDirections: UIPopoverArrowDirection.Up, animated: true, completion: nil)
            addtitle(1)
            
            //self.popover.presentPopoverFromBarButtonItem(self.navigationItem.rightBarButtonItem, permittedArrowDirections: UIPopoverArrowDirection.Up, animated: true)
        default:
            break
        }
    }


    func mine(){
        print("hello")
        //self.presentViewController(alert, animated: true, completion: nil)
        let my=JobMenuViewController()
        let pop=WEPopoverController.init(contentViewController: my)
        self.popover=pop
        my.popover=self.popover
        my.Job=self
        my.tableView.layer.cornerRadius = 4;
        //self.popover.popoverContentSize=CGSizeMake(100,85)
        my.preferredContentSize=CGSizeMake(100,85)
        self.popover.presentPopoverFromBarButtonItem(self.navigationItem.rightBarButtonItem, permittedArrowDirections: UIPopoverArrowDirection.Up, animated: true)
        //self.popover.presentPopoverFromRect(CGRectMake(0, 0, 30, 20), inView: nil, permittedArrowDirections: UIPopoverArrowDirection.Up, animated: true)
    }
    
    func goto(){
        if(flag==0){
            let anotherView=self.storyboard!.instantiateViewControllerWithIdentifier("JobInfoReq") as! JobInfoReqController
            anotherView.title="发表求职"
            anotherView.Jobinfo=self
            anotherView.zhiinfo=self.zhiinfo
            self.navigationController?.pushViewController(anotherView, animated: true)
        }else{
            let anotherView=self.storyboard!.instantiateViewControllerWithIdentifier("JobInfoMy")
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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if(segue.identifier=="JobInfoSearch"){
            print("转场")
        }
    }


}


