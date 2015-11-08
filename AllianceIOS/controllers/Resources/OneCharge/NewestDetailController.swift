//
//  NewestDetailController.swift
//  AllianceIOS
//
//  Created by dawei on 15/11/5.
//
//

import UIKit

class NewestDetailController: UITableViewController {

    @IBOutlet var Detail: UITableView!
    var running:Int=1
    
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
            return self.view.frame.width*1.25
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
        let coming=UIImageView(frame: CGRectMake(10, self.view.frame.width/4*3+5,50,20))
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
        let timebackground=UIButton(frame: CGRectMake(10,self.view.frame.width/4*3+75,self.view.frame.width-20,40))
        //timebackground.backgroundColor=UIColor(red: 220/255, green: 100/255, blue: 100/255, alpha: 1.0)
        timebackground.setBackgroundImage(UIImage(named: "倒计时圆角红色框.png"), forState: UIControlState.Normal)
        timebackground.setTitleColor(UIColor(red: 111/255, green: 111/255, blue: 111/255, alpha: 1.0), forState: UIControlState.Normal)
        timebackground.clipsToBounds=true
        timebackground.layer.cornerRadius=5
        let clock=UIImageView(frame: CGRectMake(20, self.view.frame.width/4*3+85, 20, 20))
        clock.image=UIImage(named: "揭晓图标白色.png")
        let countdown=UILabel(frame: CGRectMake(45,self.view.frame.width/4*3+80,80,25))
        countdown.text="揭晓倒计时："
        countdown.font=UIFont.systemFontOfSize(12)
        countdown.textColor=UIColor.whiteColor()
        let time=UILabel(frame: CGRectMake(125,self.view.frame.width/4*3+75,120,40))
        time.text="07:30:54"
        time.font=UIFont.systemFontOfSize(20)
        time.textColor=UIColor.whiteColor()
        let countdetail=UIButton(frame: CGRectMake(self.view.frame.width-70,self.view.frame.width/4*3+80,50,30))
        countdetail.setTitle("计算详情", forState: UIControlState.Normal)
        countdetail.titleLabel?.textColor=UIColor.whiteColor()
        countdetail.titleLabel?.font=UIFont.systemFontOfSize(12)
        countdetail.layer.borderColor=UIColor.whiteColor().CGColor
        countdetail.clipsToBounds=true
        countdetail.layer.cornerRadius=3
        
        let reminder=UIButton(frame: CGRectMake(10,self.view.frame.width/4*3+120,self.view.frame.width-20,40))
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
        cell.addSubview(timebackground)
        cell.addSubview(clock)
        cell.addSubview(countdown)
        cell.addSubview(time)
        cell.addSubview(countdetail)
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
        self.Detail.deselectRowAtIndexPath(indexPath, animated: true)
        if(indexPath.section==1 && indexPath.row==1){
            let anotherView:UIViewController=self.storyboard!.instantiateViewControllerWithIdentifier("AgoJieXiao");
            self.navigationController?.pushViewController(anotherView, animated: true)
        }
    }
    func config(run:Int){
        self.running=run
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
