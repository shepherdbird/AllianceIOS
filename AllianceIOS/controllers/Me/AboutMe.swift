//
//  AboutMe.swift
//  AllianceIOS
//
//  Created by dawei on 15/11/8.
//
//

import UIKit

class AboutMe: UITableViewController {
    
    @IBOutlet var AM: UITableView!

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
            return 4
        case 1:
            return 3
        case 2:
            return 2
        default:
            return 1
        }
    }
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell=UITableViewCell()
        cell.accessoryType=UITableViewCellAccessoryType.DisclosureIndicator
        switch indexPath.section{
        case 0:
            switch indexPath.row{
            case 0:
                let title=UILabel(frame: CGRectMake(15,15,150,20))
                title.text="头像"
                title.font=UIFont.systemFontOfSize(15)
                let avator=UIImageView(frame: CGRectMake(self.view.frame.width-60, 10, 30, 30))
                avator.image=UIImage(named: "avator.jpg")
                avator.clipsToBounds=true
                avator.layer.cornerRadius=15
                cell.addSubview(title)
                cell.addSubview(avator)
            case 1:
                let title=UILabel(frame: CGRectMake(15,15,150,20))
                title.text="昵称"
                title.font=UIFont.systemFontOfSize(15)
                let detail=UILabel(frame: CGRectMake(self.view.frame.width-90, 15, 70, 20))
                detail.text="飞翔DE鸟"
                detail.font=UIFont.systemFontOfSize(15)
                detail.textColor=UIColor(red: 111/255, green: 111/255, blue: 111/255, alpha: 0.44)
                cell.addSubview(title)
                cell.addSubview(detail)
            case 2:
                cell.accessoryType=UITableViewCellAccessoryType.None
                let title=UILabel(frame: CGRectMake(15,15,150,20))
                title.text="账户"
                title.font=UIFont.systemFontOfSize(15)
                let detail=UILabel(frame: CGRectMake(self.view.frame.width-90, 15, 90, 20))
                detail.text="23155466"
                detail.font=UIFont.systemFontOfSize(15)
                detail.textColor=UIColor(red: 111/255, green: 111/255, blue: 111/255, alpha: 0.44)
                cell.addSubview(title)
                cell.addSubview(detail)
            default:
                let title=UILabel(frame: CGRectMake(15,15,150,20))
                title.text="我的二维码"
                title.font=UIFont.systemFontOfSize(15)
                let avator=UIImageView(frame: CGRectMake(self.view.frame.width-60, 10, 30, 30))
                avator.image=UIImage(named: "二维码.png")
                cell.addSubview(title)
                cell.addSubview(avator)
            }
        case 1:
            switch indexPath.row{
            case 0:
                let title=UILabel(frame: CGRectMake(15,15,150,20))
                title.text="性别"
                title.font=UIFont.systemFontOfSize(15)
                let detail=UILabel(frame: CGRectMake(self.view.frame.width-40, 15, 30, 20))
                detail.text="女"
                detail.font=UIFont.systemFontOfSize(15)
                detail.textColor=UIColor(red: 111/255, green: 111/255, blue: 111/255, alpha: 0.44)
                cell.addSubview(title)
                cell.addSubview(detail)
            case 1:
                let title=UILabel(frame: CGRectMake(15,15,150,20))
                title.text="地区"
                title.font=UIFont.systemFontOfSize(15)
                let detail=UILabel(frame: CGRectMake(self.view.frame.width-60, 15, 30, 20))
                detail.text="上海"
                detail.font=UIFont.systemFontOfSize(15)
                detail.textColor=UIColor(red: 111/255, green: 111/255, blue: 111/255, alpha: 0.44)
                cell.addSubview(title)
                cell.addSubview(detail)
            default:
                let title=UILabel(frame: CGRectMake(15,15,150,20))
                title.text="个性签名"
                title.font=UIFont.systemFontOfSize(15)
                let detail=UILabel(frame: CGRectMake(self.view.frame.width/2, 15, self.view.frame.width/2-20, 20))
                detail.text="某东老板若是真的强，头条何须老板娘"
                detail.font=UIFont.systemFontOfSize(15)
                detail.textColor=UIColor(red: 111/255, green: 111/255, blue: 111/255, alpha: 0.44)
                cell.addSubview(title)
                cell.addSubview(detail)
            }
        case 2:
            if(indexPath.row==0){
                let title=UILabel(frame: CGRectMake(15,15,150,20))
                title.text="实名认证"
                title.font=UIFont.systemFontOfSize(15)
                cell.addSubview(title)
            }else{
                let title=UILabel(frame: CGRectMake(15,15,150,20))
                title.text="收货地址"
                title.font=UIFont.systemFontOfSize(15)
                cell.addSubview(title)
            }
        default:
            cell.accessoryType=UITableViewCellAccessoryType.None
            let exit=UIButton(frame: CGRectMake(20,5,self.view.frame.width-40,40))
            exit.setTitle("安全退出", forState: UIControlState.Normal)
            exit.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
            exit.setBackgroundImage(UIImage(named: "安全退出按钮.png"), forState: UIControlState.Normal)
            cell.addSubview(exit)
        }
        return cell
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        AM.deselectRowAtIndexPath(indexPath, animated: true)
        switch indexPath.section{
        case 0:
            if(indexPath.row==1){
                let anotherView:UIViewController=self.storyboard!.instantiateViewControllerWithIdentifier("ChangeName");
                self.navigationController?.pushViewController(anotherView, animated: true)
            }else if(indexPath.row==3){
                let anotherView:UIViewController=self.storyboard!.instantiateViewControllerWithIdentifier("MyQRcode");
                self.navigationController?.pushViewController(anotherView, animated: true)
            }
        case 1:
            if(indexPath.row==0){
                let anotherView:UIViewController=self.storyboard!.instantiateViewControllerWithIdentifier("ChangeGender");
                self.navigationController?.pushViewController(anotherView, animated: true)
            }
        case 2:
            if(indexPath.row==0){
                let anotherView:UIViewController=self.storyboard!.instantiateViewControllerWithIdentifier("Certification");
                self.navigationController?.pushViewController(anotherView, animated: true)
            }else{
                let anotherView:UIViewController=self.storyboard!.instantiateViewControllerWithIdentifier("ShippingAddress");
                self.navigationController?.pushViewController(anotherView, animated: true)
            }
        default:
            break
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
