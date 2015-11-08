//
//  NewestGoneDetail.swift
//  AllianceIOS
//
//  Created by dawei on 15/11/5.
//
//

import UIKit

class NewestGoneDetail: UITableViewController {

    @IBOutlet var detail: UITableView!
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

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if(section==1)
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
            return self.view.frame.width*1.5
        }else if(indexPath.section==1){
            return 40
        }
        return 50
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch indexPath.section{
        case 0:
            return FirstCell()
        case 1:
            return SecondCell(indexPath.row)
        default:
            return FourthCell()
        }
    }
    func FirstCell()->UITableViewCell {
        let cell=UITableViewCell()
        let pic=UIImageView(frame: CGRectMake(self.view.frame.width/8, 0, self.view.frame.width/4*3, self.view.frame.width/4*3))
        pic.image=UIImage(named: "watch.jpg")
        let coming=UIImageView(frame: CGRectMake(10, self.view.frame.width/4*3+5,50,20))
        coming.image=UIImage(named: "已揭晓图标.png")
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
        let background=UIImageView(frame: CGRectMake(10,self.view.frame.width/4*3+75,self.view.frame.width-20,self.view.frame.width/3+20))
        background.image=UIImage(named: "商品获奖展示.png")
        let number=UILabel(frame: CGRectMake(30,self.view.frame.width/4*3+80,150,40))
        number.text="幸运号码：1004516"
        number.font=UIFont.systemFontOfSize(15)
        number.textColor=UIColor.whiteColor()
        let countdetail=UIButton(frame: CGRectMake(self.view.frame.width-70,self.view.frame.width/4*3+80,50,30))
        countdetail.setTitle("计算详情", forState: UIControlState.Normal)
        countdetail.titleLabel?.textColor=UIColor.whiteColor()
        countdetail.titleLabel?.font=UIFont.systemFontOfSize(12)
        countdetail.layer.borderColor=UIColor.whiteColor().CGColor
        countdetail.clipsToBounds=true
        countdetail.layer.cornerRadius=3
        let avator=UIImageView(frame: CGRectMake(30, self.view.frame.width/4*3+120, 40, 40))
        avator.image=UIImage(named: "avator.jpg")
        avator.clipsToBounds=true
        avator.layer.cornerRadius=20
        let username=UILabel(frame: CGRectMake(80,self.view.frame.width/4*3+120,150,20))
        username.text="获奖者：终结者"
        username.font=UIFont.systemFontOfSize(12)
        let id=UILabel(frame: CGRectMake(80,self.view.frame.width/4*3+140,150,20))
        id.text="用户ID：59996354"
        id.font=UIFont.systemFontOfSize(12)
        let term=UILabel(frame: CGRectMake(80,self.view.frame.width/4*3+160,150,20))
        term.text="本期参与：500人次"
        term.font=UIFont.systemFontOfSize(12)
        let time=UILabel(frame: CGRectMake(80,self.view.frame.width/4*3+180,300,20))
        time.text="揭晓时间：2015-10-09 17:54:00"
        time.font=UIFont.systemFontOfSize(12)
    
        let reminder=UIButton(frame: CGRectMake(10,self.view.frame.width/4*3+230,self.view.frame.width-20,40))
        reminder.setTitle("您没有参与本次夺宝哟～", forState: UIControlState.Normal)
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
        cell.addSubview(background)
        cell.addSubview(number)
        cell.addSubview(avator)
        cell.addSubview(username)
        cell.addSubview(countdetail)
        cell.addSubview(id)
        cell.addSubview(term)
        cell.addSubview(time)
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
    func FourthCell()->UITableViewCell{
        let cell=UITableViewCell()
        let will=UILabel(frame: CGRectMake(20,20,self.view.frame.width/2+10,15))
        will.textColor=UIColor(red: 186/255, green: 186/255, blue: 186/255, alpha: 1.0)
        will.text="第201期正在火热进行中..."
        will.font=UIFont.systemFontOfSize(12)
        let buy=UIButton(frame: CGRectMake(self.view.frame.width/2+20,10,self.view.frame.width/2-30,30))
        buy.setBackgroundImage(UIImage(named: "立即参与按钮.png"), forState: UIControlState.Normal)
        buy.setTitleColor(UIColor(red: 220/255, green: 100/255, blue: 100/255, alpha: 1.0), forState: UIControlState.Normal)
        buy.setTitle("立即前往", forState: UIControlState.Normal)
        buy.titleLabel?.font=UIFont.systemFontOfSize(17)
        buy.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        cell.addSubview(will)
        cell.addSubview(buy)
        return cell
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.detail.deselectRowAtIndexPath(indexPath, animated: true)
        if(indexPath.section==1 && indexPath.row==1){
            let anotherView:UIViewController=self.storyboard!.instantiateViewControllerWithIdentifier("AgoJieXiao");
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
