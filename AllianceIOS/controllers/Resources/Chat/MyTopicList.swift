//
//  MyTopicList.swift
//  AllianceIOS
//
//  Created by dawei on 15/11/16.
//
//

import UIKit

class MyTopicList: UITableViewController {

    @IBOutlet var MTL: UITableView!
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
        return 5
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 5
    }
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5
    }
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 120
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
            let cell=UITableViewCell()
            let avator=UIImageView(frame: CGRectMake(5, 5, 30, 30))
            avator.clipsToBounds=true
            avator.layer.cornerRadius=15
            avator.image=UIImage(named: "avator.jpg")
            cell.addSubview(avator)
            let name=UILabel(frame: CGRectMake(40,10,60,15))
            name.text="王思琪"
            name.font=UIFont.systemFontOfSize(15)
            name.textColor=UIColor(red: 186/255, green: 186/255, blue: 186/255, alpha: 0.77)
            cell.addSubview(name)
            let time=UILabel(frame: CGRectMake(90,10,60,15))
            time.text="3分钟前"
            time.font=UIFont.systemFontOfSize(13)
            time.textColor=UIColor(red: 186/255, green: 186/255, blue: 186/255, alpha: 0.77)
            cell.addSubview(time)
            let title=UILabel(frame: CGRectMake(5,40,self.view.frame.width-40,25))
            title.text="周末又过去啦～～"
            title.font=UIFont.systemFontOfSize(17)
            //title.textColor=UIColor(red: 186/255, green: 186/255, blue: 186/255, alpha: 0.77)
            cell.addSubview(title)
            let content=UILabel(frame: CGRectMake(5,65,self.view.frame.width-10,30))
            content.text="一想到明天要上班了就好不开心啊～～～你们呢"
            content.font=UIFont.systemFontOfSize(15)
            content.numberOfLines=0
            content.textColor=UIColor(red: 111/255, green: 111/255, blue: 111/255, alpha: 1.0)
            cell.addSubview(content)
            let focus=UIButton(frame: CGRectMake(10,100,60,15))
            focus.setTitleColor(UIColor(red: 205/255, green: 49/255, blue: 37/255, alpha: 0.77), forState: UIControlState.Normal)
            focus.setTitle("编辑", forState: UIControlState.Normal)
            focus.titleLabel?.font=UIFont.systemFontOfSize(13)
            cell.addSubview(focus)
            let like=UIImageView(frame: CGRectMake(self.view.frame.width/3*2, 100, 15, 15))
            like.image=UIImage(named: "喜欢1.png")
            cell.addSubview(like)
            let likeCount=UILabel(frame: CGRectMake(self.view.frame.width/3*2+15,100,50,15))
            likeCount.textColor=UIColor(red: 186/255, green: 186/255, blue: 186/255, alpha: 0.77)
            likeCount.text="589"
            likeCount.font=UIFont.systemFontOfSize(12)
            cell.addSubview(likeCount)
            
            let comment=UIImageView(frame: CGRectMake(self.view.frame.width/3*2+60, 100, 15, 15))
            comment.image=UIImage(named: "评论3.png")
            cell.addSubview(comment)
            let commentCount=UILabel(frame: CGRectMake(self.view.frame.width/3*2+80,100,50,15))
            commentCount.textColor=UIColor(red: 186/255, green: 186/255, blue: 186/255, alpha: 0.77)
            commentCount.text="233"
            commentCount.font=UIFont.systemFontOfSize(12)
            cell.addSubview(commentCount)
            return cell
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        MTL.deselectRowAtIndexPath(indexPath, animated: true)
        let anotherView:UIViewController=self.storyboard!.instantiateViewControllerWithIdentifier("TopicDetail");
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
