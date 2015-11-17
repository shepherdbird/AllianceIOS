//
//  Chat.swift
//  AllianceIOS
//
//  Created by dawei on 15/11/13.
//
//

import UIKit

class Chat: UITableViewController {
    
    @IBOutlet var C: UITableView!
    var index=0
    var alert:UIAlertController!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.backBarButtonItem=UIBarButtonItem(title: "", style: UIBarButtonItemStyle.Plain, target: nil, action: nil)
        self.navigationItem.rightBarButtonItem=UIBarButtonItem(image: UIImage(named: "发帖按钮.png"), style: UIBarButtonItemStyle.Plain, target: self, action: Selector("mine"))
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        let reqAction=UIAlertAction(title: "发表话题", style: UIAlertActionStyle.Default) { (action:UIAlertAction) -> Void in
            let anotherView:UIViewController=self.storyboard!.instantiateViewControllerWithIdentifier("SendTopic");
            self.navigationController?.pushViewController(anotherView, animated: true)
            //print("我要求职")
        }
        let myreqAction=UIAlertAction(title: "我的聊吧", style: UIAlertActionStyle.Default) { (action:UIAlertAction) -> Void in
            let anotherView:UIViewController=self.storyboard!.instantiateViewControllerWithIdentifier("MyTopicCenter");
            self.navigationController?.pushViewController(anotherView, animated: true)
            //print("我要求职")
        }
        alert=UIAlertController(title: "", message: "", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(reqAction)
        alert.addAction(myreqAction)
    }
    func mine(){
        self.presentViewController(alert, animated: true, completion: nil)
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
        return 10
    }
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 1
    }
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if(indexPath.section==0){
            return 50
        }
        if(index==2){
            return 80
        }
        return 120
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if(indexPath.section==0){
            return FirstCell(index)
        }
        if(index==2){
            return popularity(indexPath.row)
        }
        return Common(index)
    }
    func FirstCell(index:Int)->UITableViewCell{
        let cell=UITableViewCell()
        let title=["最新","热门","人气","关注"]
        for i in 0...3{
            let btn=UIButton(frame: CGRectMake(self.view.frame.width/4*CGFloat(Float(i)),0,self.view.frame.width/4,50))
            btn.setTitle(title[i], forState: UIControlState.Normal)
            btn.tag=i
            btn.titleLabel?.font=UIFont.systemFontOfSize(18)
            btn.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
            btn.addTarget(self, action: Selector("ButtonAction:"), forControlEvents: UIControlEvents.TouchUpInside)
            if(index==i){
                btn.setTitleColor(UIColor(red: 200/255, green: 100/255, blue: 100/255, alpha: 1.0), forState: UIControlState.Normal)
            }
            cell.addSubview(btn)
        }
        return cell
    }
    func ButtonAction(sender:UIButton){
        index=sender.tag
        C.reloadData()
    }
    func Common(index:Int)->UITableViewCell{
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
        
        let type=UIImageView(frame: CGRectMake(10, 40, 20, 20))
        type.clipsToBounds=true
        type.layer.cornerRadius=2
        type.image=UIImage(named: "组-1.png")
        cell.addSubview(type)
        let title=UILabel(frame: CGRectMake(35,40,self.view.frame.width-40,25))
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
        let focus=UILabel(frame: CGRectMake(10,100,60,15))
        focus.textColor=UIColor(red: 186/255, green: 186/255, blue: 186/255, alpha: 0.77)
        focus.text="已关注"
        focus.font=UIFont.systemFontOfSize(13)
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
    func popularity(rake:Int)->UITableViewCell{
        let cell=UITableViewCell()
        var image=["1.png","2.png","3.png"]
        if(rake<3){
            let rakeImage=UIImageView(frame: CGRectMake(20, 25, 30, 30))
            rakeImage.image=UIImage(named: image[rake])
            cell.addSubview(rakeImage)
        }else{
            let rakeImage=UIImageView(frame: CGRectMake(20, 25, 30, 30))
            rakeImage.image=UIImage(named: "组-7.png")
            cell.addSubview(rakeImage)
            let rakenum=UILabel(frame: CGRectMake(30,35,10,10))
            rakenum.text=String(rake)
            rakenum.font=UIFont.systemFontOfSize(15)
            cell.addSubview(rakenum)
        }
        let avator=UIImageView(frame: CGRectMake(60, 20, 40, 40))
        avator.image=UIImage(named: "avator.jpg")
        avator.clipsToBounds=true
        avator.layer.cornerRadius=20
        cell.addSubview(avator)
        let name=UILabel(frame: CGRectMake(110,20,200,15))
        name.text="用户名啦"
        name.font=UIFont.systemFontOfSize(18)
        cell.addSubview(name)
        let fans=UILabel(frame: CGRectMake(110,40,250,15))
        fans.text="聊吧粉丝：2658"
        fans.font=UIFont.systemFontOfSize(15)
        fans.textColor=UIColor(red: 186/255, green: 186/255, blue: 186/255, alpha: 0.77)
        cell.addSubview(fans)
        let focus=UIButton(frame: CGRectMake(self.view.frame.width-60,25,50,30))
        focus.setTitle("已关注", forState: UIControlState.Normal)
        focus.layer.borderWidth=1
        focus.clipsToBounds=true
        focus.layer.cornerRadius=3
        focus.layer.borderColor=UIColor(red: 186/255, green: 186/255, blue: 186/255, alpha: 0.77).CGColor
        focus.titleLabel?.font=UIFont.systemFontOfSize(15)
        focus.setTitleColor(UIColor(red: 186/255, green: 186/255, blue: 186/255, alpha: 0.77), forState: UIControlState.Normal)
        cell.addSubview(focus)
        return cell
        
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        C.deselectRowAtIndexPath(indexPath, animated: true)
        if(index==2){
            let anotherView:UIViewController=self.storyboard!.instantiateViewControllerWithIdentifier("MyTopicCenter");
            self.navigationController?.pushViewController(anotherView, animated: true)
        }else{
            let anotherView:UIViewController=self.storyboard!.instantiateViewControllerWithIdentifier("TopicDetail");
            self.navigationController?.pushViewController(anotherView, animated: true)
        }
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
