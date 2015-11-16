//
//  MyTopicCenter.swift
//  AllianceIOS
//
//  Created by dawei on 15/11/16.
//
//

import UIKit

class MyTopicCenter: UITableViewController {

    @IBOutlet var MTC: UITableView!
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
        if(section==1){
            return 3
        }
        return 2
    }
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 1
    }
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if(indexPath.section==0 && indexPath.row==0){
            return self.view.frame.width/2
        }
        return 50
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if(indexPath.section==0){
            if(indexPath.row==0){
                return FirstCell()
            }
            return SecondCell()
        }else{
            var content=["我的关注","我的话题","我的点赞"]
            let cell=UITableViewCell()
            cell.accessoryType=UITableViewCellAccessoryType.DisclosureIndicator
            let title=UILabel(frame: CGRectMake(20,20,150,15))
            title.text=content[indexPath.row]
            cell.addSubview(title)
            return cell
        }
    }
    func FirstCell()->UITableViewCell{
        let cell=UITableViewCell()
        let back=UIImageView(frame: CGRectMake(0,-1, self.view.frame.width, self.view.frame.width/2+1))
        back.image=UIImage(named: "我的背景.png")
        cell.addSubview(back)
        let avator=UIImageView(frame: CGRectMake(self.view.frame.width/16*7,self.view.frame.width/8,self.view.frame.width/8 , self.view.frame.width/8))
        avator.image=UIImage(named: "avator.jpg")
        avator.clipsToBounds=true
        avator.layer.cornerRadius=self.view.frame.width/16
        cell.addSubview(avator)
        let name=UILabel(frame: CGRectMake(self.view.frame.width/16*7-20,self.view.frame.width/4+10,200,20))
        name.textColor=UIColor.whiteColor()
        name.text="飞翔DE鸟"
        name.font=UIFont.systemFontOfSize(18)
        cell.addSubview(name)
        let friend=UILabel(frame: CGRectMake(self.view.frame.width/4,self.view.frame.width/4+40,200,20))
        friend.textColor=UIColor.whiteColor()
        friend.text="人脉好友  776"
        friend.font=UIFont.systemFontOfSize(14)
        cell.addSubview(friend)
        let fans=UILabel(frame: CGRectMake(self.view.frame.width/2,self.view.frame.width/4+40,200,20))
        fans.textColor=UIColor.whiteColor()
        fans.text="聊吧粉丝  34万+"
        fans.font=UIFont.systemFontOfSize(14)
        cell.addSubview(fans)
        let signature=UILabel(frame: CGRectMake(self.view.frame.width/4+20,self.view.frame.width/4+60,self.view.frame.width/2,15))
        signature.textColor=UIColor.whiteColor()
        signature.text="我就是我颜色不一样的烟火"
        signature.font=UIFont.systemFontOfSize(12)
        cell.addSubview(signature)
        
        return cell
    }
    func SecondCell()->UITableViewCell{
        let cell=UITableViewCell()
        cell.accessoryType=UITableViewCellAccessoryType.DisclosureIndicator
        for i in 0...3 {
            let avator=UIImageView(frame: CGRectMake(20+60*CGFloat(i), 5, 40, 40))
            avator.image=UIImage(named: "avator.jpg")
            avator.clipsToBounds=true
            avator.layer.cornerRadius=20
            cell.addSubview(avator)
        }
        let like=UIImageView(frame: CGRectMake(self.view.frame.width-100, 15, 15, 15))
        like.image=UIImage(named: "喜欢1.png")
        cell.addSubview(like)
        let fans=UILabel(frame: CGRectMake(self.view.frame.width-80,15,75,17))
        fans.text="新的粉丝"
        fans.textColor=UIColor(red: 186/255, green: 186/255, blue: 186/255, alpha: 0.77)
        fans.font=UIFont.systemFontOfSize(13)
        cell.addSubview(fans)
        return cell
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        MTC.deselectRowAtIndexPath(indexPath, animated: true)
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
