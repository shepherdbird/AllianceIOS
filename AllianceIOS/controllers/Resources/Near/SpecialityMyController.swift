//
//  SpecialityMyController.swift
//  AllianceIOS
//
//  Created by dawei on 15/11/1.
//
//

import UIKit

class SpecialityMyController: UITableViewController {

    @IBOutlet var SpecialMyController: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.backBarButtonItem=UIBarButtonItem(title: "", style: UIBarButtonItemStyle.Plain, target: nil, action: nil)
        self.navigationItem.rightBarButtonItem=UIBarButtonItem(image: UIImage(named: "删除按钮1.png"), style: UIBarButtonItemStyle.Plain, target: self, action: Selector("DeletePost"))
        //self.navigationItem.rightBarButtonItem?.tintColor=UIColor.redColor()
        self.SpecialMyController.dataSource=self
        self.SpecialMyController.delegate=self
        self.SpecialMyController.registerClass(SpecialityTitleCell.self, forCellReuseIdentifier: "SpecialityTitleCell")
        self.SpecialMyController.registerClass(SpecialityContentCell.self, forCellReuseIdentifier: "SpecialityContentCell")
        self.SpecialMyController.allowsSelection=true
        self.SpecialMyController.separatorStyle=UITableViewCellSeparatorStyle.SingleLine
        self.SpecialMyController.backgroundColor=UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 0.77)
        
        //self.navigationItem.
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
        return 3
        
    }
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if(indexPath.row==0){
            return 50
        }else if(indexPath.row==2){
            return 40
        }
        return 150
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if(indexPath.row==0){
            let cell = tableView.dequeueReusableCellWithIdentifier("SpecialityTitleCell", forIndexPath: indexPath) as! SpecialityTitleCell
            return cell
        }else if(indexPath.row==2){
            print("this is 2")
            print(SpecialMyController.frame.width)
            let cell=UITableViewCell()
            let edit=UIButton(frame: CGRectMake(SpecialMyController.frame.width-50,5,40,25))
            edit.setTitle("编辑", forState: UIControlState.Normal)
            edit.setTitleColor(UIColor(red: 220/255, green: 100/255, blue: 100/255, alpha: 1.0), forState: UIControlState.Normal)
            edit.addTarget(self, action: Selector("edit"), forControlEvents: UIControlEvents.TouchUpInside)
            cell.addSubview(edit)
            return cell
            
        }
        let cell = tableView.dequeueReusableCellWithIdentifier("SpecialityContentCell", forIndexPath: indexPath) as! SpecialityContentCell
        return cell
        
        
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.SpecialMyController.deselectRowAtIndexPath(indexPath, animated: true)
        //self.performSegueWithIdentifier("detail", sender: nil)
        let anotherView:UIViewController=self.storyboard!.instantiateViewControllerWithIdentifier("SpecialityDetail");
        self.navigationController?.pushViewController(anotherView, animated: true)
    }
    
    func DeletePost(){
        print("右上角删除按钮被点击")
    }
    func edit(){
        let anotherView:UIViewController=self.storyboard!.instantiateViewControllerWithIdentifier("SpecialityReq");
        self.navigationController?.pushViewController(anotherView, animated: true)
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
