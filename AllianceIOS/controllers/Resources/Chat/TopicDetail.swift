//
//  TopicDetail.swift
//  AllianceIOS
//
//  Created by dawei on 15/11/16.
//
//

import UIKit

class TopicDetail: UITableViewController {

    @IBOutlet var TD: UITableView!
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
        return 2
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if(section==0){
            return 1
        }
        return 3
    }
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if(indexPath.section==0){
            return 100
        }else if(indexPath.row==0){
            return 30
        }else{
            return 60
        }
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if(indexPath.section==0){
            return FirstCell()
        }else if(indexPath.row==0){
            let cell=UITableViewCell()
            let commentIcon=UIImageView(frame: CGRectMake(10, 10, 15, 15))
            commentIcon.image=UIImage(named: "评论2.png")
            cell.addSubview(commentIcon)
            let commentCount=UILabel(frame: CGRectMake(30,10,50,15))
            commentCount.text="233"
            commentCount.font=UIFont.systemFontOfSize(12)
            cell.addSubview(commentCount)
            let ZanIcon=UIImageView(frame: CGRectMake(self.view.frame.width-50, 10, 15, 15))
            ZanIcon.image=UIImage(named: "喜欢1.png")
            cell.addSubview(ZanIcon)
            let ZanCount=UILabel(frame: CGRectMake(self.view.frame.width-30,10,30,15))
            ZanCount.text="589"
            ZanCount.font=UIFont.systemFontOfSize(12)
            cell.addSubview(ZanCount)
            return cell
        }else{
            let cell=UITableViewCell()
            let avator=UIImageView(frame: CGRectMake(20, 15, 30, 30))
            avator.image=UIImage(named: "avator.jpg")
            avator.clipsToBounds=true
            avator.layer.cornerRadius=15
            cell.addSubview(avator)
            let name=UILabel(frame: CGRectMake(50,15,30,10))
            name.text="贝贝"
            name.font=UIFont.systemFontOfSize(13)
            cell.addSubview(name)
            let time=UILabel(frame: CGRectMake(50,30,150,10))
            time.text="11-20 00:30"
            time.font=UIFont.systemFontOfSize(10)
            time.textColor=UIColor(red: 111/255, green: 111/255, blue: 111/255, alpha: 0.44)
            cell.addSubview(time)
            let comment=UILabel(frame: CGRectMake(50,45,self.view.frame.width-60,10))
            comment.text="早点休息啦～"
            comment.font=UIFont.systemFontOfSize(12)
            comment.textColor=UIColor(red: 111/255, green: 111/255, blue: 111/255, alpha: 1.0)
            cell.addSubview(comment)
            return cell
        }
    }
    func FirstCell()->UITableViewCell{
        let cell=UITableViewCell()
        let avator=UIImageView(frame: CGRectMake(20, 5, 30, 30))
        avator.clipsToBounds=true
        avator.layer.cornerRadius=15
        avator.image=UIImage(named: "avator.jpg")
        cell.addSubview(avator)
        let name=UILabel(frame: CGRectMake(55,10,60,15))
        name.text="王思琪"
        name.font=UIFont.systemFontOfSize(15)
        name.textColor=UIColor(red: 186/255, green: 186/255, blue: 186/255, alpha: 0.77)
        cell.addSubview(name)
        let time=UILabel(frame: CGRectMake(110,10,60,15))
        time.text="3分钟前"
        time.font=UIFont.systemFontOfSize(13)
        time.textColor=UIColor(red: 186/255, green: 186/255, blue: 186/255, alpha: 0.77)
        cell.addSubview(time)
        
        let title=UILabel(frame: CGRectMake(20,40,self.view.frame.width-40,25))
        title.text="周末又过去啦～～"
        title.font=UIFont.systemFontOfSize(17)
        //title.textColor=UIColor(red: 186/255, green: 186/255, blue: 186/255, alpha: 0.77)
        cell.addSubview(title)
        let content=UILabel(frame: CGRectMake(20,65,self.view.frame.width-10,30))
        content.text="一想到明天要上班了就好不开心啊～～～你们呢"
        content.font=UIFont.systemFontOfSize(15)
        content.numberOfLines=0
        content.textColor=UIColor(red: 111/255, green: 111/255, blue: 111/255, alpha: 1.0)
        cell.addSubview(content)
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
