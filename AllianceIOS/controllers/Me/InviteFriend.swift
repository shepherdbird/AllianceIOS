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

    var Qcode=""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView=UITableView(frame: self.view.frame, style: UITableViewStyle.Grouped)
        let center=UILabel(frame: CGRectMake(0,0,50,50))
        center.text="邀请好友"
        center.font=UIFont.systemFontOfSize(20)
        center.textColor=UIColor.whiteColor()
        self.navigationItem.titleView=center

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
            return 50
        }else if(indexPath.section==0 && indexPath.row==1){
            return self.view.frame.width/4*3
        }
        return self.view.frame.width/4*2
    }
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if(section==0){
            return 0.01
        }
        return 20
    }
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if(section==1){
            return "邀请好友规则"
        }
        return ""
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if(indexPath.section==0){
            if(indexPath.row==0){
                let cell=UITableViewCell()
                var boundingRect:CGRect
                let us=UILabel(frame: CGRectMake(self.view.frame.width/2-65,25,250,20))
                us.text="您的邀请码是："+Qcode
                us.font=UIFont.systemFontOfSize(17)
                boundingRect=GetBounds(300, height: 100, font: us.font, str: us.text!)
                us.frame=CGRectMake(self.view.frame.width/2-boundingRect.width/2,25-boundingRect.height/2,boundingRect.width,boundingRect.height)
                cell.addSubview(us)

                return cell
            }else{
                let cell=UITableViewCell()
                let QRCode=UIImageView(frame: CGRectMake(self.view.frame.width/7*2-20, 40, self.view.frame.width/7*3+40, self.view.frame.width/7*3+40))
                QRCode.image=UIImage(named: "QRCode.jpg")
                cell.addSubview(QRCode)
                return cell
            }
            
        }
        return FirstCell()
        
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
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
        //QQ空间
        let QQ2btn=UIButton(frame: CGRectMake(0,self.view.frame.width/4,self.view.frame.width/4,self.view.frame.width/4))
        let QQ2icon=UIImageView(frame: CGRectMake(self.view.frame.width/16,self.view.frame.width/4+10,self.view.frame.width/8,self.view.frame.width/8))
        QQ2icon.image=UIImage(named: "qq.png")
        QQ2icon.clipsToBounds=true
        QQ2icon.layer.cornerRadius=self.view.frame.width/16
        let QQ2name=UILabel(frame: CGRectMake(self.view.frame.width/8-20,self.view.frame.width/8*3+15,50,15))
        QQ2name.text="QQ空间"
        QQ2name.textColor=UIColor(red: 111/255, green: 111/255, blue: 111/255, alpha: 1.0)
        QQ2name.font=UIFont.systemFontOfSize(12)
        cell.addSubview(QQ2btn)
        cell.addSubview(QQ2icon)
        cell.addSubview(QQ2name)
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
        //朋友圈
        let WebChat2btn=UIButton(frame: CGRectMake(self.view.frame.width/4,self.view.frame.width/4,self.view.frame.width/4,self.view.frame.width/4))
        let WebChat2icon=UIImageView(frame: CGRectMake(self.view.frame.width/16*5,self.view.frame.width/4+10,self.view.frame.width/8,self.view.frame.width/8))
        WebChat2icon.image=UIImage(named: "微信.png")
        WebChat2icon.clipsToBounds=true
        WebChat2icon.layer.cornerRadius=self.view.frame.width/16
        let WebChat2name=UILabel(frame: CGRectMake(self.view.frame.width/8*3-15,self.view.frame.width/8*3+15,40,15))
        WebChat2name.text="朋友圈"
        WebChat2name.textColor=UIColor(red: 111/255, green: 111/255, blue: 111/255, alpha: 1.0)
        WebChat2name.font=UIFont.systemFontOfSize(12)
        cell.addSubview(WebChat2btn)
        cell.addSubview(WebChat2icon)
        cell.addSubview(WebChat2name)
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
