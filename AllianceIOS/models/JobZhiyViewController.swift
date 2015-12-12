//
//  JobproViewController.swift
//  AllianceIOS
//
//  Created by xufei on 15/11/19.
//
//

import UIKit
import SwiftHTTP
import JSONJoy
import WEPopover

class JobZhiyViewController: UITableViewController {
    
    var zhi: Array<String> = []
    var info:JobInfoController.ZhiInfo?
    var activityIndicatorView: UIActivityIndicatorView!
    
    var popover:WEPopoverController?
    
    var selected:String?
    var selectedIndex:Int? = nil
    var Jobreq:JobInfoReqController?
    var Jobinfo:JobInfoController?
    var flag:Int?
    override func viewDidLoad() {
        super.viewDidLoad()
        print(zhi)
        if let game = selected {
            selectedIndex = zhi.indexOf(game)
        }
        
        var footrect=CGRect()
        footrect.size.height=46
        let footview=UIView.init(frame: footrect)
        self.tableView.tableFooterView=footview
        
//        let view1=UIView(frame: CGRectMake(0, 0, self.tableView.frame.size.width, self.tableView.frame.size.height))
//        view1.backgroundColor=UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
//        
//        
//        activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.White)
//        
//        activityIndicatorView.frame = CGRectMake(self.tableView.frame.size.width/2-100, -30, 200, 200)
//        
//        activityIndicatorView.hidesWhenStopped = true
//        
//        activityIndicatorView.color = UIColor.blackColor()
//        view1.addSubview(activityIndicatorView)
//        self.tableView.backgroundView=view1
//        activityIndicatorView.startAnimating()
//        //self.navigationItem.
//        // Uncomment the following line to preserve selection between presentations
//        // self.clearsSelectionOnViewWillAppear = false
//        
//        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
//        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
//        
//        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)){
//            self.connect()
//        }

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
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
            return ((self.info?.items.count)!+1)
        }else{
            return 0
        }
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .Default, reuseIdentifier: nil)
        
        if(flag==1){
            if(indexPath.row==0){
                cell.textLabel?.text="全部"
            }else{
                cell.textLabel?.text = info?.items[indexPath.row-1].profession
            }
            cell.backgroundColor=UIColor(red: 80/255, green: 80/255, blue: 80/255, alpha: 1)
            cell.textLabel?.textColor=UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
            return cell
        }
        cell.textLabel?.text = info?.items[indexPath.row].profession
        if indexPath.row == selectedIndex {
            cell.accessoryType = .Checkmark
        } else {
            cell.accessoryType = .None
        }
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
        if let index = selectedIndex {
            let cell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: index, inSection: 0))
            cell?.accessoryType = .None
        }
        
        selectedIndex = indexPath.row
        
        if(flag==0){
            Jobreq?.Zhiye.text = self.info?.items[indexPath.row].profession
        
            //update the checkmark for the current row
            let cell = tableView.cellForRowAtIndexPath(indexPath)
            cell?.accessoryType = .Checkmark
            Jobreq?.tableView.reloadData()
            self.navigationController?.popViewControllerAnimated(true)
        }else{
            //Jobsearch?.Zhi.text = self.info?.items[indexPath.row].profession
            
            //update the checkmark for the current row
            //let cell = tableView.cellForRowAtIndexPath(indexPath)
           // cell?.accessoryType = .Checkmark
            //Jobsearch?.tableView.reloadData()
            Jobinfo!.zhi=indexPath.row
            Jobinfo?.allflag=1
            Jobinfo?.viewWillAppear(true)
            self.popover?.dismissPopoverAnimated(true)
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
