//
//  Focus.swift
//  AllianceIOS
//
//  Created by dawei on 15/11/16.
//
//

import UIKit

class Focus: UITableViewController {

    @IBOutlet var F: UITableView!
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
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 10
    }
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let avator=UIImageView(frame: CGRectMake(15, 15, 30, 30))
        avator.image=UIImage(named: "avator.jpg")
        avator.clipsToBounds=true
        avator.layer.cornerRadius=15
        cell.addSubview(avator)
        let name=UILabel(frame: CGRectMake(50,15,150,15))
        name.text="用户名啦"
        name.font=UIFont.systemFontOfSize(16)
        cell.addSubview(name)
        let fans=UILabel(frame: CGRectMake(50,40,200,10))
        fans.text="聊吧粉丝：2658"
        fans.font=UIFont.systemFontOfSize(14)
        fans.textColor=UIColor(red: 186/255, green: 186/255, blue: 186/255, alpha: 0.77)
        cell.addSubview(fans)
        let focus=UIButton(frame: CGRectMake(self.view.frame.width-80,18,70,25))
        focus.setTitle("取消关注", forState: UIControlState.Normal)
        focus.layer.borderWidth=1
        focus.clipsToBounds=true
        focus.layer.cornerRadius=3
        focus.layer.borderColor=UIColor(red: 244/255, green: 154/255, blue: 85/255, alpha: 1.0).CGColor
        focus.titleLabel?.font=UIFont.systemFontOfSize(15)
        focus.setTitleColor(UIColor(red: 244/255, green: 154/255, blue: 85/255, alpha: 1.0), forState: UIControlState.Normal)
        cell.addSubview(focus)
        return cell
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
