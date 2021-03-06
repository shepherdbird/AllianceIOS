//
//  JobInfoDetailController.swift
//  AllianceIOS
//
//  Created by dawei on 15/10/31.
//
//

import UIKit
import SwiftHTTP

class JobInfoDetailController: UITableViewController {
    
    @IBOutlet var detail: UITableView!
    
    var Username:String="用户昵称"
    var thumb:String="用户头像"
    var Key=["工作性质","学历","参加工作时间","目前状况","联系电话","留言"]
    var Value=["全职","本科","2015-08","单身","18268028693","本人性格热情开朗,待人友好,为人诚实谦虚。工作勤奋,认真负责,能吃苦耐劳,尽职尽责。"]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.rowHeight=UITableViewAutomaticDimension
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
        return 8
    }
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if(indexPath.row==0){
            return 80
        }else if(indexPath.row==7){
            return 200
        }
        return 50
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:UITableViewCell=UITableViewCell()
        let avator:UIImageView!
        let username:UILabel!
        let addfriend:UIButton!
        let key:UILabel!
        let value:UILabel!
        switch indexPath.row{
        case 0:
            avator=UIImageView(frame: CGRectMake(15, 15, 50, 50))
            //avator.image=UIImage(named: "avator.jpg")
            avator.sd_setImageWithURL(NSURL(string: (self.thumb)), placeholderImage: UIImage(named: "avator.jpg"))
            avator.clipsToBounds=true
            avator.layer.cornerRadius=avator.bounds.width*0.5
            username=UILabel(frame: CGRectMake(80,35,40,30))
            username.text=self.Username
            username.textColor=UIColor(red: 111/255, green: 111/255, blue: 111/255, alpha: 1.0)
            username.font=UIFont.systemFontOfSize(18)
            username.sizeToFit()
            cell.addSubview(avator)
            cell.addSubview(username)
            cell.userInteractionEnabled=false
        case 7:
            addfriend=UIButton(frame: CGRectMake(20,140,cell.frame.width-20,25))
            addfriend.setTitle("加为好友", forState: UIControlState.Normal)
            addfriend.backgroundColor=UIColor.redColor()
            addfriend.tintColor=UIColor.whiteColor()
            cell.addSubview(addfriend)
        default:
            key=UILabel(frame: CGRectMake(15,15,80,20))
            key.text=Key[indexPath.row-1]
            key.textColor=UIColor(red: 111/255, green: 111/255, blue: 111/255, alpha: 0.44)
            key.font=UIFont.systemFontOfSize(15)
            key.sizeToFit()
            cell.addSubview(key)
            value=UILabel(frame: CGRectMake(110,15,cell.frame.width-60,20))
            print(cell.frame.width)
            value.text=Value[indexPath.row-1]
            value.numberOfLines=0
            value.textColor=UIColor(red: 111/255, green: 111/255, blue: 111/255, alpha: 1.0)
            value.font=UIFont.systemFontOfSize(15)
            value.sizeToFit()
            cell.addSubview(value)
            cell.userInteractionEnabled=false
        }

        // Configure the cell...

        return cell
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.detail.deselectRowAtIndexPath(indexPath, animated: true)
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
