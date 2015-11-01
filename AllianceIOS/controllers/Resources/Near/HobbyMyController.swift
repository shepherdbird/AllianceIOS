//
//  HobbyMyController.swift
//  AllianceIOS
//
//  Created by dawei on 15/11/1.
//
//

import UIKit

class HobbyMyController: UITableViewController {

    @IBOutlet var HobbyMyController: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.backBarButtonItem=UIBarButtonItem(title: "", style: UIBarButtonItemStyle.Plain, target: nil, action: nil)
        self.navigationItem.rightBarButtonItem=UIBarButtonItem(image: UIImage(named: "删除按钮1.png"), style: UIBarButtonItemStyle.Plain, target: self, action: Selector("DeletePost"))
        //self.navigationItem.rightBarButtonItem?.tintColor=UIColor.redColor()
        self.HobbyMyController.dataSource=self
        self.HobbyMyController.delegate=self
        self.HobbyMyController.registerClass(HobbyCell.self, forCellReuseIdentifier: "HobbyCell")
        self.HobbyMyController.allowsSelection=true
        self.HobbyMyController.separatorStyle=UITableViewCellSeparatorStyle.SingleLine
        //self.HobbyController.backgroundColor=UIColor(red: 250/255, green: 250/255, blue: 250/255, alpha: 0.3)
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
        return 100
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("HobbyCell", forIndexPath: indexPath) as! HobbyCell
        let edit=UIButton(frame: CGRectMake(HobbyMyController.frame.width-50,70,40,25))
        edit.setTitle("编辑", forState: UIControlState.Normal)
        edit.titleLabel?.font=UIFont.systemFontOfSize(13)
        edit.setTitleColor(UIColor(red: 220/255, green: 100/255, blue: 100/255, alpha: 1.0), forState: UIControlState.Normal)
        edit.addTarget(self, action: Selector("edit"), forControlEvents: UIControlEvents.TouchUpInside)
        cell.addSubview(edit)
        return cell
        
        
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.HobbyMyController.deselectRowAtIndexPath(indexPath, animated: true)
        //self.performSegueWithIdentifier("detail", sender: nil)
        let anotherView:UIViewController=self.storyboard!.instantiateViewControllerWithIdentifier("HobbyDetail");
        self.navigationController?.pushViewController(anotherView, animated: true)
    }
    
    func DeletePost(){
        print("你在执行删除我的交友帖")
    }
    func edit(){
        let anotherView:UIViewController=self.storyboard!.instantiateViewControllerWithIdentifier("HobbyReq");
        self.navigationController?.pushViewController(anotherView, animated: true)
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
