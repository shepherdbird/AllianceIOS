//
//  ChargeRecord.swift
//  AllianceIOS
//
//  Created by dawei on 15/11/8.
//
//

import UIKit

class ChargeRecord: UITableViewController {

    @IBOutlet var CR: UITableView!
    var index:Int=0
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
        return 1
    }
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell=UITableViewCell()
        let title=["夺宝列表","夺金列表","中奖列表"]
        for i in 0...2 {
            print(i)
            let DuoBao=UIButton(frame: CGRectMake(self.view.frame.width/3*CGFloat(i),0,self.view.frame.width/3,50))
            DuoBao.setTitle(title[i], forState: UIControlState.Normal)
            DuoBao.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
            DuoBao.layer.borderWidth=CGFloat(1.0)
            DuoBao.layer.borderColor=UIColor(red: 186/255, green: 186/255, blue: 186/255, alpha: 0.73).CGColor
            DuoBao.tag=i
            DuoBao.addTarget(self, action: Selector("ButtonAction:"), forControlEvents: UIControlEvents.TouchUpInside)
            if(i==index){
                DuoBao.setTitleColor(UIColor(red: 200/255, green: 100/255, blue: 100/255, alpha: 1.0), forState: UIControlState.Normal)
            }
            DuoBao.titleLabel?.font=UIFont.systemFontOfSize(17)
            cell.addSubview(DuoBao)
        }
        return cell
    }
    func ButtonAction(sender:UIButton){
        index=sender.tag
        CR.reloadData()
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
