//
//  OneChargeDetailController.swift
//  AllianceIOS
//
//  Created by dawei on 15/11/5.
//
//

import UIKit

class OneChargeDetailController: UITableViewController {

    @IBOutlet var Detail: UITableView!
    
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
        return 4
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if(section==2){
            return 4
        }else if(section==1)
        {
            return 2
        }else{
            return 1
        }
    }
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if(indexPath.section==0){
            return self.view.frame.width*1.1
        }else if(indexPath.section==1){
            return 40
        }else if(indexPath.section==2){
            if(indexPath.row==0){
                return 40
            }else{
                return 50
            }
        }
        return 50
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch indexPath.section{
        case 0:
            return FirstCell()
        case 1:
            return SecondCell(indexPath.row)
        case 2:
            if(indexPath.row==0){
                return ThirdTitleCell()
            }else{
                return ThirdContentCell()
            }
        default:
            return FourthCell()
        }
    }
    func FirstCell()->UITableViewCell {
        let cell=UITableViewCell()
        let pic=UIImageView(frame: CGRectMake(self.view.frame.width/8, 0, self.view.frame.width/4*3, self.view.frame.width/4*3))
        pic.image=UIImage(named: "watch.jpg")
        let coming=UIImageView(frame: CGRectMake(10, self.view.frame.width/4*3,50,20))
        coming.image=UIImage(named: "进行中图标.png")
        let name=UILabel(frame: CGRectMake(75,self.view.frame.width/4*3,self.view.frame.width-75,40))
        name.text="第200期 Apple Watch Sport38毫米铝合金金属表壳运动表带"
        name.font=UIFont.systemFontOfSize(15)
        name.numberOfLines=0
//        let time=UILabel(frame: CGRectMake(10,self.view.frame.width/4*3+25,self.view.frame.width-10,20))
//        time.text="日期：2015-09-01至2015-12-01"
//        time.font=UIFont.systemFontOfSize(12)
//        time.textColor=UIColor(red: 220/255, green: 100/255, blue: 100/255, alpha: 1.0)
        let progress=UIProgressView(frame: CGRectMake(10,self.view.frame.width/4*3+45, self.view.frame.width-10, 10))
        progress.progress=Float(Int(arc4random())%101)/100.0
        progress.progressTintColor=UIColor(red: 255/255, green: 150/255, blue: 0/255, alpha: 1.0)
        progress.transform=CGAffineTransformMakeScale(1.0, 5.0)
        progress.trackTintColor=UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1.0)
        progress.clipsToBounds=true
        progress.layer.cornerRadius=2
        let total=UILabel(frame: CGRectMake(15, self.view.frame.width/4*3+55, 100, 20))
        total.text="总需：2332人次"
        total.font=UIFont.systemFontOfSize(11)
        total.textColor=UIColor(red: 111/255, green: 111/255, blue: 111/255, alpha: 1.0)
        let remain=UILabel(frame: CGRectMake(self.view.frame.width-50, self.view.frame.width/4*3+55, 50, 20))
        remain.text="剩余"+String(arc4random()%10000)
        remain.font=UIFont.systemFontOfSize(11)
        remain.textColor=UIColor(red: 220/255, green: 100/255, blue: 100/255, alpha: 1.0)
        let reminder=UIButton(frame: CGRectMake(10,self.view.frame.width/4*3+75,self.view.frame.width-20,40))
        reminder.setTitle("您还没有参与本次夺宝哟～", forState: UIControlState.Normal)
        reminder.backgroundColor=UIColor(red: 186/255, green: 186/255, blue: 186/255, alpha: 0.44)
        reminder.setTitleColor(UIColor(red: 111/255, green: 111/255, blue: 111/255, alpha: 1.0), forState: UIControlState.Normal)
        reminder.clipsToBounds=true
        reminder.layer.cornerRadius=5
        cell.addSubview(pic)
        cell.addSubview(coming)
        cell.addSubview(name)
        //cell.addSubview(time)
        cell.addSubview(progress)
        cell.addSubview(total)
        cell.addSubview(remain)
        cell.addSubview(reminder)
        return cell
    }
    func SecondCell(row:Int)->UITableViewCell {
        let cell=UITableViewCell()
        if(row==1){
            let table=UILabel(frame: CGRectMake(15,10,100,20))
            table.text="往期揭晓"
            table.font=UIFont.systemFontOfSize(15)
            cell.addSubview(table)
            cell.accessoryType=UITableViewCellAccessoryType.DisclosureIndicator
            return cell
        }else{
            let PicAndWord=UILabel(frame: CGRectMake(15,10,100,20))
            PicAndWord.text="图文详情"
            PicAndWord.font=UIFont.systemFontOfSize(15)
            cell.addSubview(PicAndWord)
            cell.accessoryType=UITableViewCellAccessoryType.DisclosureIndicator
            return cell
        }
    }
    func ThirdTitleCell()->UITableViewCell {
        let cell=UITableViewCell()
        let record=UILabel(frame: CGRectMake(15,10,70,20))
        record.text="参与记录"
        record.font=UIFont.systemFontOfSize(15)
        let begin=UILabel(frame: CGRectMake(85,13,200,14))
        begin.font=UIFont.systemFontOfSize(12)
        begin.textColor=UIColor(red: 186/255, green: 186/255, blue: 186/255, alpha: 1.0)
        begin.text="自2015-08-24 08:08:54开始"
        cell.addSubview(record)
        cell.addSubview(begin)
        return cell
    }
    func ThirdContentCell()->UITableViewCell {
        let cell=UITableViewCell()
        let avator=UIImageView(frame: CGRectMake(15, 10, 30, 30))
        avator.image=UIImage(named: "avator.jpg")
        avator.clipsToBounds=true
        avator.layer.cornerRadius=15
        let username=UILabel(frame: CGRectMake(50,15,50,15))
        username.text="用户昵称"
        username.font=UIFont.systemFontOfSize(12)
        let time=UILabel(frame: CGRectMake(100,15,200,15))
        time.font=UIFont.systemFontOfSize(10)
        time.text="2015-08-09 08:10:56"
        time.textColor=UIColor(red: 186/255, green: 186/255, blue: 186/255, alpha: 1.0)
        let count=UILabel(frame: CGRectMake(50,30,60,15))
        count.text="参与了2人次"
        count.font=UIFont.systemFontOfSize(10)
        let phone=UILabel(frame: CGRectMake(110,30,150,15))
        phone.font=UIFont.systemFontOfSize(10)
        phone.text="查看他的号码"
        phone.textColor=UIColor(red: 220/255, green: 100/255, blue: 100/255, alpha: 1.0)
        cell.addSubview(avator)
        cell.addSubview(username)
        cell.addSubview(time)
        cell.addSubview(count)
        cell.addSubview(phone)
        return cell
    }
    func FourthCell()->UITableViewCell{
        let cell=UITableViewCell()
        let now=UIButton(frame: CGRectMake(20,5,self.view.frame.width/2-25,30))
        now.setBackgroundImage(UIImage(named: "立即参与大按钮.png"), forState: UIControlState.Normal)
        now.setTitle("立即参与", forState: UIControlState.Normal)
        now.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        now.titleLabel?.font=UIFont.systemFontOfSize(17)
        let buy=UIButton(frame: CGRectMake(self.view.frame.width/2+5,5,self.view.frame.width/2-25,30))
        buy.setBackgroundImage(UIImage(named: "直接兑换按钮.png"), forState: UIControlState.Normal)
        buy.setTitleColor(UIColor(red: 220/255, green: 100/255, blue: 100/255, alpha: 1.0), forState: UIControlState.Normal)
        buy.setTitle("直接兑换", forState: UIControlState.Normal)
        buy.titleLabel?.font=UIFont.systemFontOfSize(17)
        cell.addSubview(now)
        cell.addSubview(buy)
        return cell
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.Detail.deselectRowAtIndexPath(indexPath, animated: true)
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
