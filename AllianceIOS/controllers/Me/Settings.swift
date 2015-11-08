//
//  Settings.swift
//  AllianceIOS
//
//  Created by dawei on 15/11/7.
//
//

import UIKit

class Settings: UITableViewController {

    @IBOutlet var St: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

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
        return 2
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if(section==1){
            return 3
        }
        return 1
    }
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if(indexPath.section==0){
            let cell=UITableViewCell()
            let name=UILabel(frame: CGRectMake(20,15,100,25))
            name.text="账号相关"
            name.font=UIFont.systemFontOfSize(15)
            cell.addSubview(name)
            cell.accessoryType=UITableViewCellAccessoryType.DisclosureIndicator
            return cell
        }else{
            switch indexPath.row{
            case 0:
                let cell=UITableViewCell()
                let name=UILabel(frame: CGRectMake(20,15,100,25))
                name.text="清理缓存"
                name.font=UIFont.systemFontOfSize(15)
                cell.addSubview(name)
                cell.accessoryType=UITableViewCellAccessoryType.DisclosureIndicator
                return cell
            case 1:
                let cell=UITableViewCell()
                let name=UILabel(frame: CGRectMake(20,15,100,25))
                name.text="意见反馈"
                name.font=UIFont.systemFontOfSize(15)
                cell.addSubview(name)
                cell.accessoryType=UITableViewCellAccessoryType.DisclosureIndicator
                return cell
            default:
                let cell=UITableViewCell()
                let name=UILabel(frame: CGRectMake(20,15,100,25))
                name.text="关于我们"
                name.font=UIFont.systemFontOfSize(15)
                cell.addSubview(name)
                cell.accessoryType=UITableViewCellAccessoryType.DisclosureIndicator
                return cell
            }
        }
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.St.deselectRowAtIndexPath(indexPath, animated: true)
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
