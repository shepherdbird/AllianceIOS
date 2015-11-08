//
//  ShippingAddress.swift
//  AllianceIOS
//
//  Created by dawei on 15/11/8.
//
//

import UIKit

class ShippingAddress: UITableViewController {

    @IBOutlet var SA: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.backBarButtonItem=UIBarButtonItem(title: "", style: UIBarButtonItemStyle.Plain, target: nil, action: nil)
        self.navigationItem.rightBarButtonItem=UIBarButtonItem(title:"新增", style: UIBarButtonItemStyle.Plain, target: self, action: Selector("Add"))
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
        return 1
    }
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5
    }
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 5
    }
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return FirstCell()
    }
    func FirstCell()->UITableViewCell{
        let cell=UITableViewCell()
        let name=UILabel(frame: CGRectMake(20,10,150,30))
        name.text="牧羊少年"
        name.font=UIFont.systemFontOfSize(20)
        cell.addSubview(name)
        let number=UILabel(frame: CGRectMake(self.view.frame.width-200,10,200,30))
        number.text="13312578948"
        number.font=UIFont.systemFontOfSize(20)
        cell.addSubview(number)
        let address=UILabel(frame: CGRectMake(20,40,self.view.frame.width-70,40))
        address.text="中华人民共和国浙江省杭州市西湖区浙大路38号浙江大学玉泉校区2舍"
        address.font=UIFont.systemFontOfSize(12)
        address.textColor=UIColor(red: 111/255, green: 111/255, blue: 111/255, alpha: 1.0)
        address.numberOfLines=0
        cell.addSubview(address)
        let select=UIButton(frame: CGRectMake(self.view.frame.width-30,30,15,15))
        select.setBackgroundImage(UIImage(named: "选择按钮.png"), forState: UIControlState.Normal)
        select.clipsToBounds=true
        select.layer.cornerRadius=7.5
        cell.addSubview(select)
        return cell
    }
    func Add(){
        let anotherView:UIViewController=self.storyboard!.instantiateViewControllerWithIdentifier("ShippingAddressAdd");
        self.navigationController?.pushViewController(anotherView, animated: true)
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        SA.deselectRowAtIndexPath(indexPath, animated: true)
        let anotherView:UIViewController=self.storyboard!.instantiateViewControllerWithIdentifier("ShippingAddressDetail");
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
