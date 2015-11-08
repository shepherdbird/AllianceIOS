//
//  ChangeGender.swift
//  AllianceIOS
//
//  Created by dawei on 15/11/8.
//
//

import UIKit

class ChangeGender: UITableViewController {

    @IBOutlet var CG: UITableView!
    var SelectBoy:UIImageView!
    var SelectGirl:UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem=UIBarButtonItem(title:"保存", style: UIBarButtonItemStyle.Plain, target: self, action: Selector("Save"))
        self.navigationItem.rightBarButtonItem?.tintColor=UIColor(red: 220/255, green: 100/255, blue: 100/255, alpha: 1.0)
        
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
        return 2
    }
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell=UITableViewCell()
        let gender=UILabel(frame: CGRectMake(15,15,20,20))
        if(indexPath.row==0){
            gender.text="男"
            SelectBoy=UIImageView(frame: CGRectMake(self.view.frame.width-40, 15, 25, 17))
            SelectBoy.image=UIImage(named: "勾选按钮.png")
            cell.addSubview(SelectBoy)
            SelectBoy.hidden=true
        }else{
            gender.text="女"
            SelectGirl=UIImageView(frame: CGRectMake(self.view.frame.width-40, 15, 25, 17))
            SelectGirl.image=UIImage(named: "勾选按钮.png")
            cell.addSubview(SelectGirl)
            
        }
        gender.font=UIFont.systemFontOfSize(15)
        cell.addSubview(gender)
        
        return cell
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        CG.deselectRowAtIndexPath(indexPath, animated: true)
        if(indexPath.row==0){
            SelectBoy.hidden=false
            SelectGirl.hidden=true
        }else{
            SelectBoy.hidden=true
            SelectGirl.hidden=false
        }
    }
    func Save(){
        self.navigationController?.popViewControllerAnimated(true)
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
