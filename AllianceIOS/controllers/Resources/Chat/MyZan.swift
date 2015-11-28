//
//  MyZan.swift
//  AllianceIOS
//
//  Created by dawei on 15/11/16.
//
//

import UIKit
import SwiftHTTP
import JSONJoy

class MyZan: UITableViewController {

    @IBOutlet var MZ: UITableView!
    var activityIndicatorView: UIActivityIndicatorView!
    var view1=UIView()
    var MyZanList:ChatMessageList?
        {
        didSet{
            activityIndicatorView.stopAnimating()
            self.activityIndicatorView.hidden=true
            self.tableView.backgroundView=nil
            self.tableView.reloadData()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView=UITableView(frame: self.view.frame, style: UITableViewStyle.Grouped)
        view1=UIView(frame: CGRectMake(0, 0, self.tableView.frame.size.width, self.tableView.frame.size.height))
        view1.backgroundColor=UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.White)
        
        activityIndicatorView.frame = CGRectMake(self.tableView.frame.size.width/2-100, -30, 200, 200)
        
        activityIndicatorView.hidesWhenStopped = true
        
        activityIndicatorView.color = UIColor.blackColor()
        view1.addSubview(activityIndicatorView)
        self.tableView.backgroundView=view1
        activityIndicatorView.startAnimating()
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)){
            self.connect()
        }
    }
    func connect(){
        print("聊吧-我的点赞")
        do {
            let params:Dictionary<String,AnyObject>=["phone":"1"]
            let new=try HTTP.POST(URL+"/tbmessages/mylikes", parameters: params)
            new.start { response in
                if let err = response.error {
                    print("error: \(err.localizedDescription)")
                    return //also notify app of failure as needed
                }
                print("opt finished: \(response.description)")
                self.MyZanList = ChatMessageList(JSONDecoder(response.data))
            }
            
        } catch let error {
            print("got an error creating the request: \(error)")
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if((MyZanList) != nil){
            return MyZanList!.items.count
        }
        return 0
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
//    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        if(section==0){
//            return "2015-11-01"
//        }
//        return "2015-11-02"
//    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell=UITableViewCell()
        let avator=UIImageView(frame: CGRectMake(5, 5, 30, 30))
        avator.clipsToBounds=true
        avator.layer.cornerRadius=15
        if let Ndata=NSData(contentsOfURL: NSURL(string: MyZanList!.items[indexPath.row].thumb)!){
            avator.image=UIImage(data: Ndata)
        }
        cell.addSubview(avator)
        let name=UILabel(frame: CGRectMake(40,10,60,15))
        name.text=MyZanList!.items[indexPath.row].nickname
        name.font=UIFont.systemFontOfSize(15)
        name.textColor=UIColor(red: 186/255, green: 186/255, blue: 186/255, alpha: 0.77)
        cell.addSubview(name)
        let time=UILabel(frame: CGRectMake(90,10,200,15))
        time.text=String(NSDate(timeIntervalSince1970: Double(MyZanList!.items[indexPath.row].created_at)!))
        time.font=UIFont.systemFontOfSize(13)
        time.textColor=UIColor(red: 186/255, green: 186/255, blue: 186/255, alpha: 0.77)
        cell.addSubview(time)
        
//        let type=UIImageView(frame: CGRectMake(10, 40, 20, 20))
//        type.clipsToBounds=true
//        type.layer.cornerRadius=2
//        type.image=UIImage(named: "组-1.png")
//        cell.addSubview(type)
        let title=UILabel(frame: CGRectMake(35,40,self.view.frame.width-40,25))
        title.text=MyZanList!.items[indexPath.row].title
        title.font=UIFont.systemFontOfSize(17)
        //title.textColor=UIColor(red: 186/255, green: 186/255, blue: 186/255, alpha: 0.77)
        cell.addSubview(title)
        let content=UILabel(frame: CGRectMake(5,65,self.view.frame.width-10,30))
        content.text=MyZanList!.items[indexPath.row].content
        content.font=UIFont.systemFontOfSize(15)
        content.numberOfLines=0
        content.textColor=UIColor(red: 111/255, green: 111/255, blue: 111/255, alpha: 1.0)
        cell.addSubview(content)
        if MyZanList!.items[indexPath.row].isconcerned=="1" {
            let focus=UILabel(frame: CGRectMake(10,100,60,15))
            focus.textColor=UIColor(red: 186/255, green: 186/255, blue: 186/255, alpha: 0.77)
            focus.text="已关注"
            focus.font=UIFont.systemFontOfSize(13)
            cell.addSubview(focus)
        }else{
            let focusIcon=UIImageView(frame: CGRectMake(10, 100, 15, 15))
            focusIcon.image=UIImage(named: "关注图标.png")
            cell.addSubview(focusIcon)
            let focusBtn=UIButton(frame: CGRectMake(30,100,50,15))
            focusBtn.setTitle("关注TA", forState: UIControlState.Normal)
            focusBtn.titleLabel?.font=UIFont.systemFontOfSize(13)
            focusBtn.setTitleColor(UIColor(red: 230/255, green: 120/255, blue: 40/255, alpha: 1.0), forState: UIControlState.Normal)
            cell.addSubview(focusBtn)
        }
        
        let like=UIImageView(frame: CGRectMake(self.view.frame.width/3*2, 100, 15, 15))
        like.image=UIImage(named: "喜欢1.png")
        cell.addSubview(like)
        let likeCount=UILabel(frame: CGRectMake(self.view.frame.width/3*2+15,100,50,15))
        likeCount.textColor=UIColor(red: 186/255, green: 186/255, blue: 186/255, alpha: 0.77)
        likeCount.text=MyZanList!.items[indexPath.row].likecount
        likeCount.font=UIFont.systemFontOfSize(12)
        cell.addSubview(likeCount)
        
        let comment=UIImageView(frame: CGRectMake(self.view.frame.width/3*2+60, 100, 15, 15))
        comment.image=UIImage(named: "评论3.png")
        cell.addSubview(comment)
        let commentCount=UILabel(frame: CGRectMake(self.view.frame.width/3*2+80,100,50,15))
        commentCount.textColor=UIColor(red: 186/255, green: 186/255, blue: 186/255, alpha: 0.77)
        commentCount.text=MyZanList!.items[indexPath.row].replycount
        commentCount.font=UIFont.systemFontOfSize(12)
        cell.addSubview(commentCount)
        return cell

    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        MZ.deselectRowAtIndexPath(indexPath, animated: true)
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
