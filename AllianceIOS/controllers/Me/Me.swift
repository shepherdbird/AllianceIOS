//
//  Me.swift
//  AllianceIOS
//
//  Created by dawei on 15/11/6.
//
//

import UIKit

class Me: UITableViewController {
    
    @IBOutlet var I: UITableView!

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
        return 4
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        switch section{
        case 0:
            return 1
        case 2:
            return 3
        default:
            return 1
        }
    }
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 15
    }
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        switch indexPath.section{
        case 0:
            return self.view.frame.width
        default:
            return 40
        }
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        switch indexPath.section{
        case 0:
            return FirstCell()
        case 1:
            let icon=UIImageView(frame: CGRectMake(10, 10, 20, 20))
            icon.image=UIImage(named: "邀请好友图标.png")
            icon.clipsToBounds=true
            icon.layer.cornerRadius=10
            let name=UILabel(frame: CGRectMake(40,15,150,15))
            name.text="邀请好友"
            name.font=UIFont.systemFontOfSize(15)
            cell.addSubview(icon)
            cell.addSubview(name)
            cell.accessoryType=UITableViewCellAccessoryType.DisclosureIndicator
            return cell
        case 3:
            let icon=UIImageView(frame: CGRectMake(10, 10, 20, 20))
            icon.image=UIImage(named: "设置图标.png")
            icon.clipsToBounds=true
            icon.layer.cornerRadius=10
            let name=UILabel(frame: CGRectMake(40,15,150,15))
            name.text="设置"
            name.font=UIFont.systemFontOfSize(15)
            cell.addSubview(icon)
            cell.addSubview(name)
            cell.accessoryType=UITableViewCellAccessoryType.DisclosureIndicator
            return cell
        default:
            switch indexPath.row{
            case 0:
                let icon=UIImageView(frame: CGRectMake(10, 10, 20, 20))
                icon.image=UIImage(named: "我的钱包图标.png")
                icon.clipsToBounds=true
                icon.layer.cornerRadius=10
                let name=UILabel(frame: CGRectMake(40,15,150,15))
                name.text="我的钱包"
                name.font=UIFont.systemFontOfSize(15)
                cell.addSubview(icon)
                cell.addSubview(name)
                cell.accessoryType=UITableViewCellAccessoryType.DisclosureIndicator
                return cell
            case 1:
                let icon=UIImageView(frame: CGRectMake(10, 10, 20, 20))
                icon.image=UIImage(named: "我的收藏图标.png")
                icon.clipsToBounds=true
                icon.layer.cornerRadius=10
                let name=UILabel(frame: CGRectMake(40,15,150,15))
                name.text="我的收藏"
                name.font=UIFont.systemFontOfSize(15)
                cell.addSubview(icon)
                cell.addSubview(name)
                cell.accessoryType=UITableViewCellAccessoryType.DisclosureIndicator
                return cell
            default:
                let icon=UIImageView(frame: CGRectMake(10, 10, 20, 20))
                icon.image=UIImage(named: "我的相册图标.png")
                icon.clipsToBounds=true
                icon.layer.cornerRadius=10
                let name=UILabel(frame: CGRectMake(40,15,150,15))
                name.text="我的相册"
                name.font=UIFont.systemFontOfSize(15)
                cell.addSubview(icon)
                cell.addSubview(name)
                cell.accessoryType=UITableViewCellAccessoryType.DisclosureIndicator
                return cell
            }
        }
    }
    func FirstCell()->UITableViewCell{
        let cell=UITableViewCell()
        let backgroud=UIImageView(frame: CGRectMake(0, 0, self.view.frame.width, self.view.frame.width/4*3))
        //backgroud.backgroundColor=UIColor(red: 220/255, green: 100/255, blue: 100/255, alpha: 1.0)
        backgroud.backgroundColor=UIColor(red: 200/255, green: 0, blue: 0, alpha: 1.0)
        cell.addSubview(backgroud)
        let avator=UIImageView(frame: CGRectMake(self.view.frame.width/2-50, 80, 100, 100))
        avator.image=UIImage(named: "avator.jpg")
        avator.clipsToBounds=true
        avator.layer.cornerRadius=50
        cell.addSubview(avator)
        let avator_edit=UIButton(frame: CGRectMake(self.view.frame.width/2+10, 160, 20, 20))
        avator_edit.setBackgroundImage(UIImage(named: "修改资料图标.png"), forState: UIControlState.Normal)
        avator_edit.tag=1
        avator_edit.addTarget(self, action: Selector("ButtonAction:"), forControlEvents: UIControlEvents.TouchUpInside)
        avator_edit.clipsToBounds=true
        avator_edit.layer.cornerRadius=10
        cell.addSubview(avator_edit)
        let username=UILabel(frame: CGRectMake(self.view.frame.width/2-40,self.view.frame.width/2-10,80,30))
        username.text="飞翔DE鸟"
        username.textColor=UIColor.whiteColor()
        username.font=UIFont.systemFontOfSize(18)
        cell.addSubview(username)
        let id=UILabel(frame: CGRectMake(self.view.frame.width/2-40,self.view.frame.width/2+15,110,20))
        id.text="帐号：22335698"
        id.textColor=UIColor.whiteColor()
        id.font=UIFont.systemFontOfSize(12)
        cell.addSubview(id)
        //直接联盟
        let DirectAlliance=UIButton(frame: CGRectMake(0,self.view.frame.width/4*3,self.view.frame.width/3,self.view.frame.width/4))
        DirectAlliance.tag=100
        DirectAlliance.addTarget(self, action: Selector("ButtonAction:"), forControlEvents: UIControlEvents.TouchUpInside)
        let DA_icon=UIImageView(frame: CGRectMake(self.view.frame.width/12, self.view.frame.width/4*3+20, 15, 15))
        DA_icon.image=UIImage(named: "直接联盟图标.png")
        let DA_name=UILabel(frame: CGRectMake(self.view.frame.width/12+15,self.view.frame.width/4*3+20,120,15))
        DA_name.text="直接联盟"
        DA_name.font=UIFont.systemFontOfSize(13)
        let DA_count=UILabel(frame: CGRectMake(self.view.frame.width/6-10,self.view.frame.width/8*7,50,30))
        DA_count.text="10人"
        DA_count.font=UIFont.systemFontOfSize(20)
        DA_count.textColor=UIColor.blueColor()
        cell.addSubview(DirectAlliance)
        cell.addSubview(DA_icon)
        cell.addSubview(DA_name)
        cell.addSubview(DA_count)
        //五层总数
        let FiveAll=UIButton(frame: CGRectMake(self.view.frame.width/3,self.view.frame.width/4*3,self.view.frame.width/3,self.view.frame.width/4))
        let FA_icon=UIImageView(frame: CGRectMake(self.view.frame.width/12*5, self.view.frame.width/4*3+20, 15, 15))
        FA_icon.image=UIImage(named: "五层人数图标.png")
        let FA_name=UILabel(frame: CGRectMake(self.view.frame.width/12*5+15,self.view.frame.width/4*3+20,120,15))
        FA_name.text="五层总数"
        FA_name.font=UIFont.systemFontOfSize(13)
        let FA_count=UILabel(frame: CGRectMake(self.view.frame.width/2-10,self.view.frame.width/8*7,50,30))
        FA_count.text="30人"
        FA_count.font=UIFont.systemFontOfSize(20)
        FA_count.textColor=UIColor.redColor()
        cell.addSubview(FiveAll)
        cell.addSubview(FA_icon)
        cell.addSubview(FA_name)
        cell.addSubview(FA_count)
        //联盟奖励
        let AllianceGive=UIButton(frame: CGRectMake(self.view.frame.width/3*2,self.view.frame.width/4*3,self.view.frame.width/3,self.view.frame.width/4))
        AllianceGive.tag=102
        AllianceGive.addTarget(self, action: Selector("ButtonAction:"), forControlEvents: UIControlEvents.TouchUpInside)
        
        let AG_icon=UIImageView(frame: CGRectMake(self.view.frame.width/12*9, self.view.frame.width/4*3+20, 15, 15))
        AG_icon.image=UIImage(named: "联盟奖励图标.png")
        let AG_name=UILabel(frame: CGRectMake(self.view.frame.width/12*9+15,self.view.frame.width/4*3+20,120,15))
        AG_name.text="联盟奖励"
        AG_name.font=UIFont.systemFontOfSize(13)
        let AG_count=UILabel(frame: CGRectMake(self.view.frame.width/6*5-10,self.view.frame.width/8*7,80,30))
        AG_count.text="150元"
        AG_count.font=UIFont.systemFontOfSize(20)
        AG_count.textColor=UIColor.greenColor()
        cell.addSubview(AllianceGive)
        cell.addSubview(AG_icon)
        cell.addSubview(AG_name)
        cell.addSubview(AG_count)
        return cell
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.I.deselectRowAtIndexPath(indexPath, animated: true)
        if(indexPath.section==1){
            let anotherView:UIViewController=self.storyboard!.instantiateViewControllerWithIdentifier("InviteFriend");
            self.navigationController?.pushViewController(anotherView, animated: true)
        }else if(indexPath.section==3){
            let anotherView:UIViewController=self.storyboard!.instantiateViewControllerWithIdentifier("Settings");
            self.navigationController?.pushViewController(anotherView, animated: true)
        }
    }
    func ButtonAction(sender:UIButton){
        switch sender.tag{
        case 1:
            let anotherView:UIViewController=self.storyboard!.instantiateViewControllerWithIdentifier("AboutMe");
            self.navigationController?.pushViewController(anotherView, animated: true)
        case 100:
            let anotherView:UIViewController=self.storyboard!.instantiateViewControllerWithIdentifier("DirectAlliance");
            self.navigationController?.pushViewController(anotherView, animated: true)
        case 102:
            let anotherView:UIViewController=self.storyboard!.instantiateViewControllerWithIdentifier("AllianceGive");
            self.navigationController?.pushViewController(anotherView, animated: true)
        default:
            break
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
