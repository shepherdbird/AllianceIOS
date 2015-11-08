//
//  InviteFriend.swift
//  AllianceIOS
//
//  Created by dawei on 15/11/7.
//
//

import UIKit

class InviteFriend: UITableViewController {
    
    @IBOutlet var IF: UITableView!

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
            return 2
        }
        return 1
    }
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if(indexPath.section==0 && indexPath.row==0){
            return self.view.frame.width/4*3
        }else if(indexPath.section==0 && indexPath.row==1){
            return self.view.frame.width/4
        }
        return 50
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if(indexPath.section==0){
            if(indexPath.row==0){
                let cell=UITableViewCell()
                let us=UILabel(frame: CGRectMake(self.view.frame.width/2-65,25,250,20))
                us.text="邀请好友加入我们"
                us.font=UIFont.systemFontOfSize(15)
                let QRCode=UIImageView(frame: CGRectMake(self.view.frame.width/7*2, 60, self.view.frame.width/7*3, self.view.frame.width/7*3))
                QRCode.image=UIImage(named: "QRCode.jpg")
                cell.addSubview(us)
                cell.addSubview(QRCode)
                return cell
            }
            return FirstCell()
        }else{
            let cell=UITableViewCell()
            let rule=UILabel(frame: CGRectMake(10,10,200,30))
            rule.text="邀请奖励规则"
            rule.font=UIFont.systemFontOfSize(15)
            cell.addSubview(rule)
            cell.accessoryType=UITableViewCellAccessoryType.DisclosureIndicator
            return cell
        }
        
        
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.IF.deselectRowAtIndexPath(indexPath, animated: true)
    }
    func FirstCell()->UITableViewCell{
        let cell=UITableViewCell()
        //QQ
        let QQbtn=UIButton(frame: CGRectMake(0,0,self.view.frame.width/4,self.view.frame.width/4))
        let QQicon=UIImageView(frame: CGRectMake(self.view.frame.width/16,10,self.view.frame.width/8,self.view.frame.width/8))
        QQicon.image=UIImage(named: "qq.png")
        QQicon.clipsToBounds=true
        QQicon.layer.cornerRadius=self.view.frame.width/16
        let QQname=UILabel(frame: CGRectMake(self.view.frame.width/8-10,self.view.frame.width/8+15,30,15))
        QQname.text="QQ"
        QQname.textColor=UIColor(red: 111/255, green: 111/255, blue: 111/255, alpha: 1.0)
        QQname.font=UIFont.systemFontOfSize(12)
        cell.addSubview(QQbtn)
        cell.addSubview(QQicon)
        cell.addSubview(QQname)
        //微信
        let WebChatbtn=UIButton(frame: CGRectMake(self.view.frame.width/4,0,self.view.frame.width/4,self.view.frame.width/4))
        let WebChaticon=UIImageView(frame: CGRectMake(self.view.frame.width/16*5,10,self.view.frame.width/8,self.view.frame.width/8))
        WebChaticon.image=UIImage(named: "微信.png")
        WebChaticon.clipsToBounds=true
        WebChaticon.layer.cornerRadius=self.view.frame.width/16
        let WebChatname=UILabel(frame: CGRectMake(self.view.frame.width/8*3-10,self.view.frame.width/8+15,30,15))
        WebChatname.text="微信"
        WebChatname.textColor=UIColor(red: 111/255, green: 111/255, blue: 111/255, alpha: 1.0)
        WebChatname.font=UIFont.systemFontOfSize(12)
        cell.addSubview(WebChatbtn)
        cell.addSubview(WebChaticon)
        cell.addSubview(WebChatname)
        //微博
        let WBbtn=UIButton(frame: CGRectMake(self.view.frame.width/2,0,self.view.frame.width/4,self.view.frame.width/4))
        let WBicon=UIImageView(frame: CGRectMake(self.view.frame.width/16*9,10,self.view.frame.width/8,self.view.frame.width/8))
        WBicon.image=UIImage(named: "微博.png")
        WBicon.clipsToBounds=true
        WBicon.layer.cornerRadius=self.view.frame.width/16
        let WBname=UILabel(frame: CGRectMake(self.view.frame.width/8*5-10,self.view.frame.width/8+15,30,15))
        WBname.text="微博"
        WBname.textColor=UIColor(red: 111/255, green: 111/255, blue: 111/255, alpha: 1.0)
        WBname.font=UIFont.systemFontOfSize(12)
        cell.addSubview(WBbtn)
        cell.addSubview(WBicon)
        cell.addSubview(WBname)
        //短信
        let MSGbtn=UIButton(frame: CGRectMake(self.view.frame.width/4*3,0,self.view.frame.width/4,self.view.frame.width/4))
        let MSGicon=UIImageView(frame: CGRectMake(self.view.frame.width/16*13,10,self.view.frame.width/8,self.view.frame.width/8))
        MSGicon.image=UIImage(named: "短信.png")
        MSGicon.clipsToBounds=true
        MSGicon.layer.cornerRadius=self.view.frame.width/16
        let MSGname=UILabel(frame: CGRectMake(self.view.frame.width/8*7-10,self.view.frame.width/8+15,30,15))
        MSGname.text="短信"
        MSGname.textColor=UIColor(red: 111/255, green: 111/255, blue: 111/255, alpha: 1.0)
        MSGname.font=UIFont.systemFontOfSize(12)
        cell.addSubview(MSGbtn)
        cell.addSubview(MSGicon)
        cell.addSubview(MSGname)
        return cell
        
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
