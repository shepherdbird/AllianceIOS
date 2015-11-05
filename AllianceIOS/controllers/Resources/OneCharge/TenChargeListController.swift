//
//  TenChargeListController.swift
//  AllianceIOS
//
//  Created by dawei on 15/11/3.
//
//

import UIKit

class TenChargeListController: UITableViewController {
    
    @IBOutlet var TenChargeListController: UITableView!
    

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
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return self.TenChargeListController.frame.width*1.5
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
            return TenchargeListCell()
    }
    func TenchargeListCell()->UITableViewCell{
        let cell=UITableViewCell()
        let halfwidth=Float(self.view.frame.width)/2
        for i in 0...5{
            let btn=UIButton(frame: CGRectMake(CGFloat(Float(i%2)*halfwidth), CGFloat(Float(i/2)*halfwidth), CGFloat(halfwidth), CGFloat(halfwidth)))
            btn.addTarget(self, action: Selector("Detail"), forControlEvents: UIControlEvents.TouchUpInside)
            let pic=UIImageView(frame: CGRectMake(CGFloat(Float(i%2)*halfwidth)+CGFloat(halfwidth/4),CGFloat(Float(i/2)*halfwidth)+20, CGFloat(halfwidth/2), CGFloat(halfwidth/2)))
            pic.image=UIImage(named: "coin.png")
            let name=UILabel(frame: CGRectMake(CGFloat(Float(i%2)*halfwidth)+15, CGFloat(Float(i/2)*halfwidth)+CGFloat(halfwidth/2)+20, CGFloat(halfwidth)-15, 20))
            name.text="第44期 500金币"
            name.font=UIFont.systemFontOfSize(15)
            let progress=UIProgressView(frame: CGRectMake(CGFloat(Float(i%2)*halfwidth)+15, CGFloat(Float(i/2)*halfwidth)+CGFloat(halfwidth/2)+60, CGFloat(halfwidth)-15, 10))
            progress.progress=Float(Int(arc4random())%101)/100.0
            progress.progressTintColor=UIColor(red: 255/255, green: 150/255, blue: 0/255, alpha: 1.0)
            progress.transform=CGAffineTransformMakeScale(1.0, 3.0)
            progress.trackTintColor=UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1.0)
            progress.clipsToBounds=true
            progress.layer.cornerRadius=2
            let process=UILabel(frame: CGRectMake(CGFloat(Float(i%2)*halfwidth)+15, CGFloat(Float(i/2)*halfwidth)+CGFloat(halfwidth/2)+40, CGFloat(halfwidth)-15, 20))
            process.font=UIFont.systemFontOfSize(11)
            process.text="开奖进度       "+String(Int(progress.progress*100))+"%"
            process.textColor=UIColor(red: 111/255, green: 111/255, blue: 111/255, alpha: 1.0)
            let total=UILabel(frame: CGRectMake(CGFloat(Float(i%2)*halfwidth)+15, CGFloat(Float(i/2)*halfwidth)+CGFloat(halfwidth/2)+65, CGFloat(halfwidth)-30, 20))
            total.text="总需：80人次         "
            total.font=UIFont.systemFontOfSize(11)
            total.textColor=UIColor(red: 111/255, green: 111/255, blue: 111/255, alpha: 1.0)
            let remain=UILabel(frame: CGRectMake(CGFloat(Float(i%2+1)*halfwidth)-40, CGFloat(Float(i/2)*halfwidth)+CGFloat(halfwidth/2)+65, 40, 20))
            remain.text="剩余"+String(arc4random()%80)
            remain.font=UIFont.systemFontOfSize(11)
            remain.textColor=UIColor(red: 220/255, green: 100/255, blue: 100/255, alpha: 1.0)
            cell.addSubview(btn)
            cell.addSubview(pic)
            cell.addSubview(name)
            cell.addSubview(total)
            cell.addSubview(progress)
            cell.addSubview(process)
            cell.addSubview(remain)
        }
        return cell
    }
    func Detail(){
        let anotherView:UIViewController=self.storyboard!.instantiateViewControllerWithIdentifier("TenChargeDetail");
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
