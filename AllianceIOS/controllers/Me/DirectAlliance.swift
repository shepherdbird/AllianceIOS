//
//  DirectAlliance.swift
//  AllianceIOS
//
//  Created by dawei on 15/11/6.
//
//

import UIKit

class DirectAlliance: UITableViewController {
    
    @IBOutlet var DA: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        //DA.style=UITableViewStyle.Grouped
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
        if(section==0){
            return 1
        }
        return 3
    }
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 25
    }
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60
    }
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if(section==0){
            return "已添加"
        }
        return "未添加"
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if(indexPath.section==0){
            return firstcell(1)
        }else{
            return firstcell(0)
        }
    }
    func firstcell(flag_add:Int)->UITableViewCell{
        let cell=UITableViewCell()
        let avator=UIImageView(frame: CGRectMake(20, 10, 40, 40))
        avator.image=UIImage(named: "avator.jpg")
        avator.clipsToBounds=true
        avator.layer.cornerRadius=20
        let name=UILabel(frame: CGRectMake(65,10,150,20))
        name.text="飞翔DE鸟"
        name.font=UIFont.systemFontOfSize(15)
        let id=UILabel(frame: CGRectMake(65,30,150,30))
        id.text="ID:333256"
        id.font=UIFont.systemFontOfSize(12)
        id.textColor=UIColor(red: 186/255, green: 186/255, blue: 186/255, alpha: 0.77)
        cell.addSubview(avator)
        cell.addSubview(name)
        cell.addSubview(id)
        if(flag_add==1){
            let add=UILabel(frame: CGRectMake(self.view.frame.width-60,20,60,25))
            add.text="已添加"
            add.font=UIFont.systemFontOfSize(15)
            add.textColor=UIColor(red: 111/255, green: 111/255, blue: 111/255, alpha: 0.44)
            cell.addSubview(add)
        }else{
            let add=UIButton(frame: CGRectMake(self.view.frame.width-60,15,50,30))
            add.setBackgroundImage(UIImage(named: "添加按钮.png"), forState: UIControlState.Normal)
            add.setTitle("添加", forState: UIControlState.Normal)
            add.titleLabel?.font=UIFont.systemFontOfSize(15)
            add.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
            add.clipsToBounds=true
            add.layer.cornerRadius=3
            cell.addSubview(add)
        }
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
