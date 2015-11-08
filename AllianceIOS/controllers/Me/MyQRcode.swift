//
//  MyQRcode.swift
//  AllianceIOS
//
//  Created by dawei on 15/11/8.
//
//

import UIKit

class MyQRcode: UITableViewController {

    @IBOutlet var MQ: UITableView!
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
        return 2
    }
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if(indexPath.row==0){
            return 80
        }
        return self.view.frame.width
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell=UITableViewCell()
        if(indexPath.row==0){
            let avator=UIImageView(frame: CGRectMake(20, 10, 60, 60))
            avator.image=UIImage(named: "avator.jpg")
            avator.clipsToBounds=true
            avator.layer.cornerRadius=30
            cell.addSubview(avator)
            let name=UILabel(frame: CGRectMake(85,25,150,20))
            name.text="飞翔DE鸟"
            name.font=UIFont.systemFontOfSize(18)
            cell.addSubview(name)
            let area=UILabel(frame: CGRectMake(85,50,150,15))
            area.text="地区：上海"
            area.textColor=UIColor(red: 111/255, green: 111/255, blue: 111/255, alpha: 1.0)
            area.font=UIFont.systemFontOfSize(12)
            cell.addSubview(area)
        }else{
            let qr=UIImageView(frame: CGRectMake(self.view.frame.width/5, 50, self.view.frame.width/5*3, self.view.frame.width/5*3))
            qr.image=UIImage(named: "QRCode.jpg")
            cell.addSubview(qr)
            let recommand=UILabel(frame: CGRectMake(self.view.frame.width/2-70,self.view.frame.width/5*3+100,150,20))
            recommand.textColor=UIColor(red: 111/255, green: 111/255, blue: 111/255, alpha: 1.0)
            recommand.text="扫一扫添加我的好友吧"
            recommand.font=UIFont.systemFontOfSize(13)
            cell.addSubview(recommand)
        }
        cell.userInteractionEnabled=false
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
