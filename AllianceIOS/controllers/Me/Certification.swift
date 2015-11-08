//
//  Certification.swift
//  AllianceIOS
//
//  Created by dawei on 15/11/8.
//
//

import UIKit

class Certification: UITableViewController {

    @IBOutlet var C: UITableView!
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
        return 2
    }
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell=UITableViewCell()
        if(indexPath.section==0){
            if(indexPath.row==0){
                let name=UILabel(frame: CGRectMake(10,15,50,20))
                name.text="姓名"
                name.font=UIFont.systemFontOfSize(15)
                name.textColor=UIColor(red: 111/255, green: 111/255, blue: 111/255, alpha: 1.0)
                cell.addSubview(name)
                let nameInput=UITextField(frame: CGRectMake(150,0,self.view.frame.width-150,50))
                cell.addSubview(nameInput)
            }else{
                let id=UILabel(frame: CGRectMake(10,15,150,20))
                id.text="身份证号码"
                id.font=UIFont.systemFontOfSize(15)
                id.textColor=UIColor(red: 111/255, green: 111/255, blue: 111/255, alpha: 1.0)
                cell.addSubview(id)
                let nameInput=UITextField(frame: CGRectMake(150,0,self.view.frame.width-150,50))
                cell.addSubview(nameInput)
            }
        }else{
            if(indexPath.row==0){
            let reminder=UILabel(frame: CGRectMake(10,15,250,20))
            reminder.text="一经绑定不得修改"
            reminder.font=UIFont.systemFontOfSize(15)
            reminder.textColor=UIColor(red: 111/255, green: 111/255, blue: 111/255, alpha: 1.0)
            cell.addSubview(reminder)
            }else{
                let BangDing=UIButton(frame: CGRectMake(20,5,self.view.frame.width-40,40))
                BangDing.setBackgroundImage(UIImage(named: "安全退出按钮.png"), forState: UIControlState.Normal)
                BangDing.setTitle("绑定", forState: UIControlState.Normal)
                BangDing.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
                BangDing.titleLabel?.font=UIFont.systemFontOfSize(18)
                cell.addSubview(BangDing)
            }
        }
        return cell
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
