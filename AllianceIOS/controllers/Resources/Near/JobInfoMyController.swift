//
//  JobInfoMyController.swift
//  AllianceIOS
//
//  Created by dawei on 15/11/1.
//
//

import UIKit

class JobInfoMyController: UITableViewController {
    
    @IBOutlet var JobInfoMy: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.backBarButtonItem=UIBarButtonItem(title: "", style: UIBarButtonItemStyle.Plain, target: nil, action: nil)
        self.navigationItem.rightBarButtonItem=UIBarButtonItem(image: UIImage(named: "删除按钮1.png"), style: UIBarButtonItemStyle.Plain, target: self, action: Selector("deletePost"))
        //self.navigationItem.rightBarButtonItem?.tintColor=UIColor.redColor()
        self.JobInfoMy.dataSource=self
        self.JobInfoMy.delegate=self
        self.JobInfoMy.registerClass(JobInfoTitleCell.self, forCellReuseIdentifier: "JobInfoTitleCell")
        self.JobInfoMy.registerClass(JobInfoContentCell.self, forCellReuseIdentifier: "JobInfoContentCell")
        self.JobInfoMy.allowsSelection=true
        self.JobInfoMy.separatorStyle=UITableViewCellSeparatorStyle.SingleLine
        self.JobInfoMy.backgroundColor=UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 0.77)
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
        return 3
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
            return cell
        }
        let cell = tableView.dequeueReusableCellWithIdentifier("JobInfoContentCell", forIndexPath: indexPath) as! JobInfoContentCell
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
