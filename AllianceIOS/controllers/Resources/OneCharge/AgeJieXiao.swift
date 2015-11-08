//
//  AgeJieXiao.swift
//  AllianceIOS
//
//  Created by dawei on 15/11/5.
//
//

import UIKit

class AgeJieXiao: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.backBarButtonItem=UIBarButtonItem(title: "", style: UIBarButtonItemStyle.Plain, target: nil, action: nil)
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
            return 2
        }
        return 1
    }
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if(indexPath.section==0){
            return 50
        }else{
            if(indexPath.row==0){
                return 30
            }
            return 120
        }
    }
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if(indexPath.section==0){
            return FirstCell()
        }else{
            if(indexPath.row==0){
                return SecondTitleCell()
            }
            return SecondContentCell()
        }
    }
    func FirstCell()->UITableViewCell{
        let cell=UITableViewCell()
        let lb=UILabel(frame: CGRectMake(20,15,200,30))
        lb.text="第4567期 正在揭晓..."
        lb.font=UIFont.systemFontOfSize(15)
        cell.accessoryType=UITableViewCellAccessoryType.DisclosureIndicator
        cell.addSubview(lb)
        return cell
    }
    func SecondTitleCell()->UITableViewCell{
        let cell=UITableViewCell()
        let lb=UILabel(frame: CGRectMake(20,8,self.view.frame.width,20))
        lb.text="第4566期 揭晓时间：2015-10-09 17:54:00"
        lb.font=UIFont.systemFontOfSize(15)
        cell.accessoryType=UITableViewCellAccessoryType.DisclosureIndicator
        cell.addSubview(lb)
        return cell
    }
    func SecondContentCell()->UITableViewCell{
        let cell=UITableViewCell()
        let avator=UIImageView(frame: CGRectMake(20, 20, 40, 40))
        avator.image=UIImage(named: "avator.jpg")
        let username=UILabel(frame: CGRectMake(80,20,200,20))
        username.text="获奖者：用户昵称"
        username.font=UIFont.systemFontOfSize(13)
        let id=UILabel(frame: CGRectMake(80,40,200,20))
        id.text="用户ID：59996354"
        id.font=UIFont.systemFontOfSize(13)
        let number=UILabel(frame: CGRectMake(80,60,200,20))
        number.text="幸运号码：10004564"
        number.font=UIFont.systemFontOfSize(13)
        let term=UILabel(frame: CGRectMake(80,80,200,20))
        term.text="本期参与：500人次"
        term.font=UIFont.systemFontOfSize(13)
        cell.addSubview(avator)
        cell.addSubview(username)
        cell.addSubview(id)
        cell.addSubview(number)
        cell.addSubview(term)
        return cell
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //self.detail.deselectRowAtIndexPath(indexPath, animated: true)
        if(indexPath.section==0){
            let anotherView:UIViewController=self.storyboard!.instantiateViewControllerWithIdentifier("NewestDetail");
            self.navigationController?.pushViewController(anotherView, animated: true)
        }else{
            let anotherView:UIViewController=self.storyboard!.instantiateViewControllerWithIdentifier("NewestGoneDetail");
            self.navigationController?.pushViewController(anotherView, animated: true)
        }
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
