//
//  ShippingAddressDetail.swift
//  AllianceIOS
//
//  Created by dawei on 15/11/8.
//
//

import UIKit

class ShippingAddressDetail: UITableViewController {

    @IBOutlet var SAD: UITableView!
    var TitleName=["收货人","身份证","手机号","邮政编码","省份","城市","地区","详细地址"]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.backBarButtonItem=UIBarButtonItem(title: "", style: UIBarButtonItemStyle.Plain, target: nil, action: nil)
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
        return 3
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if(section==0){
            return 8
        }
        return 1
    }
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if(indexPath.row==7){
            return 120
        }
        return 50
    }
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5
    }
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 5
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell=UITableViewCell()
        if(indexPath.section==0){
        let title=UILabel(frame: CGRectMake(15,15,100,20))
        title.textColor=UIColor(red: 111/255, green: 111/255, blue: 111/255, alpha: 1.0)
        title.text=TitleName[indexPath.row]
        title.font=UIFont.systemFontOfSize(15)
        cell.addSubview(title)
        let content=UITextField(frame: CGRectMake(150,0,self.view.frame.width-150,50))
        cell.addSubview(content)
        }else if(indexPath.section==1){
            let title=UILabel(frame: CGRectMake(20,15,self.view.frame.width,20))
            title.text="删除该收货地址"
            title.textColor=UIColor(red: 200/255, green: 100/255, blue: 100/255, alpha: 1.0)
            title.font=UIFont.systemFontOfSize(15)
            cell.addSubview(title)
        }else{
            let title=UILabel(frame: CGRectMake(20,15,self.view.frame.width,20))
            title.text="设为默认收货地址"
            title.textColor=UIColor(red: 200/255, green: 100/255, blue: 100/255, alpha: 1.0)
            title.font=UIFont.systemFontOfSize(15)
            cell.addSubview(title)
        }
        return cell
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
