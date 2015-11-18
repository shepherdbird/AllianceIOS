//
//  JobInfoMyController.swift
//  AllianceIOS
//
//  Created by dawei on 15/11/1.
//
//

import UIKit
import SwiftHTTP
import JSONJoy
//import SDWebImage

class JobInfoMyController: UITableViewController {
    
    @IBOutlet var JobInfoMy: UITableView!

    var activityIndicatorView: UIActivityIndicatorView!
    
    var info:JobInfoController.Info?
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

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.backBarButtonItem=UIBarButtonItem(title: "", style: UIBarButtonItemStyle.Plain, target: nil, action: nil)
        self.navigationItem.rightBarButtonItem=UIBarButtonItem(image: UIImage(named: "删除按钮1.png"), style: UIBarButtonItemStyle.Plain, target: self, action: Selector("deletePost"))
        //self.navigationItem.rightBarButtonItem?.tintColor=UIColor.redColor()
        self.tableView.dataSource=self
        self.tableView.delegate=self
        self.tableView.registerClass(JobInfoTitleCell.self, forCellReuseIdentifier: "JobInfoTitleCell")
        self.tableView.registerClass(JobInfoContentCell.self, forCellReuseIdentifier: "JobInfoContentCell")
        self.tableView.allowsSelection=true
        self.tableView.separatorStyle=UITableViewCellSeparatorStyle.SingleLine
        self.tableView.backgroundColor=UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 0.77)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
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
            let opt=try HTTP.GET("http://183.129.190.82:50001/v1/applyjobs/search",parameters: ["phone":"1"])
            
            opt.start { response in
                if let err = response.error {
                    print("error: \(err.localizedDescription)")
                    return //also notify app of failure as needed
                }
                print("opt finished: \(response.description)")
                //print("data is: \(response.data)") access the response of the data with response.data
                self.info = JobInfoController.Info(JSONDecoder(response.data))
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
    func deletePost(){
        print("delete my posts")
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
