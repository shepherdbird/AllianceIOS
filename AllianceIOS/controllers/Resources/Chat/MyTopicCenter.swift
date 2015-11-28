//
//  MyTopicCenter.swift
//  AllianceIOS
//
//  Created by dawei on 15/11/16.
//
//

import UIKit
import SwiftHTTP
import JSONJoy

class MyTopicCenter: UITableViewController {

    @IBOutlet var MTC: UITableView!
    var activityIndicatorView: UIActivityIndicatorView!
    var view1=UIView()
    var LiaoBaFansInstance:LiaobaFans?
    var LiaoBaUserInstance:LiaoBaUser?
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
        print("聊吧主界面")
        do {
            let params:Dictionary<String,AnyObject>=["phone":Phone,"herphone":"1"]
            let new=try HTTP.POST(URL+"/tbusers/view", parameters: params)
            new.start { response in
                if let err = response.error {
                    print("error: \(err.localizedDescription)")
                    return //also notify app of failure as needed
                }
                print("opt finished: \(response.description)")
                self.LiaoBaUserInstance = LiaoBaUser(JSONDecoder(response.data))
            }
            let param:Dictionary<String,AnyObject>=["phone":"1"]
            let fans=try HTTP.POST(URL+"/tbusers/myfans", parameters: param)
            fans.start { response in
                if let err = response.error {
                    print("error: \(err.localizedDescription)")
                    return //also notify app of failure as needed
                }
                print("opt finished: \(response.description)")
                self.LiaoBaFansInstance = LiaobaFans(JSONDecoder(response.data))
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
        // #warning Incomplete implementation, return the number of sections
        if((LiaoBaUserInstance) != nil){
            return 2
        }
        return 0
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
        if let Ndata=NSData(contentsOfURL: NSURL(string: LiaoBaUserInstance!.thumb)!){
            avator.image=UIImage(data: Ndata)
        }
        avator.clipsToBounds=true
        avator.layer.cornerRadius=self.view.frame.width/16
        cell.addSubview(avator)
        let name=UILabel(frame: CGRectMake(self.view.frame.width/16*7-20,self.view.frame.width/4+10,200,20))
        name.textColor=UIColor.whiteColor()
        name.text=LiaoBaUserInstance!.nickname
        name.font=UIFont.systemFontOfSize(18)
        cell.addSubview(name)
        let friend=UILabel(frame: CGRectMake(self.view.frame.width/4,self.view.frame.width/4+40,200,20))
        friend.textColor=UIColor.whiteColor()
        friend.text="人脉好友  "+LiaoBaUserInstance!.friendcount
        friend.font=UIFont.systemFontOfSize(14)
        cell.addSubview(friend)
        let fans=UILabel(frame: CGRectMake(self.view.frame.width/2,self.view.frame.width/4+40,200,20))
        fans.textColor=UIColor.whiteColor()
        fans.text="聊吧粉丝  "+LiaoBaUserInstance!.concerncount
        fans.font=UIFont.systemFontOfSize(14)
        cell.addSubview(fans)
        let signature=UILabel(frame: CGRectMake(self.view.frame.width/4+20,self.view.frame.width/4+60,self.view.frame.width/2,15))
        signature.textColor=UIColor.whiteColor()
        signature.text="个性签名："+LiaoBaUserInstance!.signature
        signature.font=UIFont.systemFontOfSize(12)
        cell.addSubview(signature)
        
        return cell
    }
    func SecondCell()->UITableViewCell{
        let cell=UITableViewCell()
        cell.accessoryType=UITableViewCellAccessoryType.DisclosureIndicator
        if(LiaoBaFansInstance!.items.count>0){
            for i in 0...((LiaoBaFansInstance!.items.count-1)%4) {
                let avator=UIImageView(frame: CGRectMake(20+60*CGFloat(i), 5, 40, 40))
                if let Ndata=NSData(contentsOfURL: NSURL(string: LiaoBaFansInstance!.items[i].thumb)!){
                    avator.image=UIImage(data: Ndata)
                }
                avator.clipsToBounds=true
                avator.layer.cornerRadius=20
                cell.addSubview(avator)
            }
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
        if(indexPath.section==1){
            switch indexPath.row{
            case 0:
                let anotherView:UIViewController=self.storyboard!.instantiateViewControllerWithIdentifier("Focus");
                self.navigationController?.pushViewController(anotherView, animated: true)
            case 1:
                let anotherView:UIViewController=self.storyboard!.instantiateViewControllerWithIdentifier("MyTopicList");
                self.navigationController?.pushViewController(anotherView, animated: true)
            case 2:
                let anotherView:UIViewController=self.storyboard!.instantiateViewControllerWithIdentifier("MyZan");
                self.navigationController?.pushViewController(anotherView, animated: true)
            default:
                break
            }
        }
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
