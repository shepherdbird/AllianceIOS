//
//  NewestListController.swift
//  AllianceIOS
//
//  Created by dawei on 15/11/3.
//
//

import UIKit

class NewestListController: UITableViewController {
    
    @IBOutlet var NewestListController: UITableView!

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
        return 1
    }
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return self.NewestListController.frame.width*1.5
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return NewestListCell()
    }
    func NewestListCell()->UITableViewCell{
        let cell=UITableViewCell()
        let halfwidth=Float(self.view.frame.width)/2
        for i in 0...1{
            let btn=UIButton(frame: CGRectMake(CGFloat(Float(i%2)*halfwidth), CGFloat(Float(i/2)*halfwidth), CGFloat(halfwidth), CGFloat(halfwidth*1.5)))
            let pic=UIImageView(frame: CGRectMake(CGFloat(Float(i%2)*halfwidth)+CGFloat(halfwidth/4),CGFloat(Float(i/2)*halfwidth)+20, CGFloat(halfwidth/2), CGFloat(halfwidth/2)))
            pic.image=UIImage(named: "电饭煲.jpg")
            let name=UILabel(frame: CGRectMake(CGFloat(Float(i%2)*halfwidth)+15, CGFloat(Float(i/2)*halfwidth)+CGFloat(halfwidth/2)+20, CGFloat(halfwidth)-15, 20))
            name.text="不锈钢保温密封盒"
            name.font=UIFont.systemFontOfSize(15)
            let timeIcon=UIImageView(frame: CGRectMake(CGFloat(Float(i%2)*halfwidth)+15, CGFloat(halfwidth/2)+40, 20, 20))
            timeIcon.image=UIImage(named: "即将揭晓图标.png")
            let jijiang=UILabel(frame: CGRectMake(CGFloat(Float(i%2)*halfwidth)+35,CGFloat(halfwidth/2)+40,60, 20))
            jijiang.text="即将揭晓"
            jijiang.font=UIFont.systemFontOfSize(11)
            jijiang.textColor=UIColor(red: 220/255, green: 100/255, blue: 100/255, alpha: 1.0)
            let remain=UILabel(frame: CGRectMake(CGFloat(Float(i%2)*halfwidth)+20, CGFloat(halfwidth/2)+55,CGFloat(halfwidth/2), 50))
            remain.text="04:46:56"
            remain.font=UIFont.systemFontOfSize(18)
            remain.textColor=UIColor(red: 220/255, green: 100/255, blue: 100/255, alpha: 1.0)
            cell.addSubview(btn)
            cell.addSubview(pic)
            cell.addSubview(name)
            cell.addSubview(timeIcon)
            cell.addSubview(jijiang)
            cell.addSubview(remain)
        }
        for i in 2...3{
            let btn=UIButton(frame: CGRectMake(CGFloat(Float(i%2)*halfwidth), CGFloat(Float(i/2)*halfwidth), CGFloat(halfwidth), CGFloat(halfwidth*1.5)))
            let pic=UIImageView(frame: CGRectMake(CGFloat(Float(i%2)*halfwidth)+CGFloat(halfwidth/4),CGFloat(Float(i/2)*halfwidth)+20, CGFloat(halfwidth/2), CGFloat(halfwidth/2)))
            pic.image=UIImage(named: "电饭煲.jpg")
            let name=UILabel(frame: CGRectMake(CGFloat(Float(i%2)*halfwidth)+15, CGFloat(Float(i/2)*halfwidth)+CGFloat(halfwidth/2)+20, CGFloat(halfwidth)-15, 20))
            name.text="不锈钢保温密封盒"
            name.font=UIFont.systemFontOfSize(15)
            let owner=UILabel(frame: CGRectMake(CGFloat(Float(i%2)*halfwidth)+15, CGFloat(Float(i/2)*halfwidth)+CGFloat(halfwidth/2)+40, CGFloat(halfwidth)-15, 20))
            owner.text="获得者：马云"
            owner.font=UIFont.systemFontOfSize(12)
            let count=UILabel(frame: CGRectMake(CGFloat(Float(i%2)*halfwidth)+15, CGFloat(Float(i/2)*halfwidth)+CGFloat(halfwidth/2)+60, CGFloat(halfwidth)-15, 20))
            count.text="参与人次：10"
            count.font=UIFont.systemFontOfSize(12)
            let number=UILabel(frame: CGRectMake(CGFloat(Float(i%2)*halfwidth)+15, CGFloat(Float(i/2)*halfwidth)+CGFloat(halfwidth/2)+80, CGFloat(halfwidth)-15, 20))
            number.text="幸运号码：100090"
            number.font=UIFont.systemFontOfSize(12)
            let time=UILabel(frame: CGRectMake(CGFloat(Float(i%2)*halfwidth)+15, CGFloat(Float(i/2)*halfwidth)+CGFloat(halfwidth/2)+100, CGFloat(halfwidth)-15, 20))
            time.text="揭晓时间：今天01:04"
            time.font=UIFont.systemFontOfSize(12)
            cell.addSubview(btn)
            cell.addSubview(pic)
            cell.addSubview(name)
            cell.addSubview(owner)
            cell.addSubview(count)
            cell.addSubview(number)
            cell.addSubview(time)
        }
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
