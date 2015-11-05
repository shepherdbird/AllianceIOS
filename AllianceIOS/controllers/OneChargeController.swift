//
//  OneCHargeController.swift
//  AllianceIOS
//
//  Created by dawei on 15/10/17.
//
//

import UIKit

class OneChargeController: UITableViewController{
    
    @IBOutlet var OneChargeController: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.backBarButtonItem=UIBarButtonItem(title: "", style: UIBarButtonItemStyle.Plain, target: nil, action: nil)
    }
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 4
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
        
    }
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section{
        case 0:
            return 0
        case 3:
            return 20
        default:
            return 10
        }
    }
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        switch indexPath.section{
        case 0:
            return 100
        case 3:
            return self.OneChargeController.frame.width*1.5
        default:
            return 120
        }
    }
//    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        switch section{
//        case 1:
//            return "10夺金"
//        case 2:
//            return "最新揭晓"
//        case 3:
//            return "一元夺宝"
//        default:
//            return ""
//        }
//    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch indexPath.section{
        case 0:
            return firstcell()
        case 1:
            return TenChargeCell()
        case 2:
            return NewestCell()
        default:
            return OnechargeCell()
        }
    }
    func firstcell() ->UITableViewCell{
        let cell=UITableViewCell()
        //10夺金
        let tencharge=UIButton(frame:CGRectMake(0, 0, self.view.frame.width/4, 100))
        tencharge.tag=0
        tencharge.addTarget(self, action: Selector("FirstCellButton:"), forControlEvents: UIControlEvents.TouchUpInside)
        let tenchargeIcon=UIImageView(frame: CGRectMake(20,15,60,60))
        tenchargeIcon.image=UIImage(named: "十元夺金.png")
        let tenchargelabel=UILabel(frame: CGRectMake(25,80,50,20))
        tenchargelabel.text="10夺金"
        tenchargelabel.textColor=UIColor(red: 111/255, green: 111/255, blue: 111/255, alpha: 1.0)
        tenchargelabel.font=UIFont.systemFontOfSize(13)
        cell.addSubview(tencharge)
        cell.addSubview(tenchargeIcon)
        cell.addSubview(tenchargelabel)
        //一元夺宝
        let onecharge=UIButton(frame:CGRectMake(self.view.frame.width/4, 0, self.view.frame.width/4, 100))
        onecharge.tag=1
        onecharge.addTarget(self, action: Selector("FirstCellButton:"), forControlEvents: UIControlEvents.TouchUpInside)
        let onechargeIcon=UIImageView(frame: CGRectMake(self.view.frame.width/4+20,15,60,60))
        onechargeIcon.image=UIImage(named: "一元夺宝.png")
        let onechargelabel=UILabel(frame: CGRectMake(self.view.frame.width/4+20,80,60,20))
        onechargelabel.text="一元夺宝"
        onechargelabel.textColor=UIColor(red: 111/255, green: 111/255, blue: 111/255, alpha: 1.0)
        onechargelabel.font=UIFont.systemFontOfSize(13)
        cell.addSubview(onecharge)
        cell.addSubview(onechargeIcon)
        cell.addSubview(onechargelabel)
        //夺宝记录
        let chargerecord=UIButton(frame:CGRectMake(self.view.frame.width/4*2, 0, self.view.frame.width/4, 100))
        chargerecord.tag=2
        chargerecord.addTarget(self, action: Selector("FirstCellButton:"), forControlEvents: UIControlEvents.TouchUpInside)
        let chargerecordIcon=UIImageView(frame: CGRectMake(self.view.frame.width/2+20,15,60,60))
        chargerecordIcon.image=UIImage(named: "夺宝记录.png")
        let chargerecordlabel=UILabel(frame: CGRectMake(self.view.frame.width/4*2+20,80,60,20))
        chargerecordlabel.text="夺宝记录"
        chargerecordlabel.textColor=UIColor(red: 111/255, green: 111/255, blue: 111/255, alpha: 1.0)
        chargerecordlabel.font=UIFont.systemFontOfSize(13)
        cell.addSubview(chargerecord)
        cell.addSubview(chargerecordIcon)
        cell.addSubview(chargerecordlabel)
        //常见问题
        let problem=UIButton(frame:CGRectMake(self.view.frame.width/4*3, 0, self.view.frame.width/4, 100))
        problem.tag=3
        problem.addTarget(self, action: Selector("FirstCellButton:"), forControlEvents: UIControlEvents.TouchUpInside)
        let problemIcon=UIImageView(frame: CGRectMake(self.view.frame.width/4*3+20,15,60,60))
        problemIcon.image=UIImage(named: "常见问题.png")
        let problemlabel=UILabel(frame: CGRectMake(self.view.frame.width/4*3+20,80,60,20))
        problemlabel.text="常见问题"
        problemlabel.textColor=UIColor(red: 111/255, green: 111/255, blue: 111/255, alpha: 1.0)
        problemlabel.font=UIFont.systemFontOfSize(13)
        cell.addSubview(problem)
        cell.addSubview(problemIcon)
        cell.addSubview(problemlabel)
        return cell

    }
    func FirstCellButton(sender:UIButton){
        switch sender.tag {
        case 0:
            let anotherView:UIViewController=self.storyboard!.instantiateViewControllerWithIdentifier("TenChargeList");
            self.navigationController?.pushViewController(anotherView, animated: true)
        case 1:
            let anotherView:UIViewController=self.storyboard!.instantiateViewControllerWithIdentifier("OneChargeList");
            self.navigationController?.pushViewController(anotherView, animated: true)
        case 2:
            let anotherView:UIViewController=self.storyboard!.instantiateViewControllerWithIdentifier("TenChargeList");
            self.navigationController?.pushViewController(anotherView, animated: true)
        default:
            let anotherView:UIViewController=self.storyboard!.instantiateViewControllerWithIdentifier("TenChargeList");
            self.navigationController?.pushViewController(anotherView, animated: true)
        }
    }
    func TenChargeCell() -> UITableViewCell{
        let cell=UITableViewCell()
//        tenchargeSv.frame=CGRectMake(tenchargecell.frame.minX, tenchargecell.frame.minY,self.view.frame.width, 120)
//        tenchargeSv.contentSize=CGSizeMake(600, 120)
//        tenchargeSv.pagingEnabled=true
//        tenchargeSv.showsHorizontalScrollIndicator=false
//        tenchargeSv.scrollEnabled=true
//        tenchargeSv.delegate=self
//        tenchargecell.addSubview(tenchargeSv)
        let title=UILabel(frame: CGRectMake(10,0,50,30))
        title.text="10夺金"
        title.font=UIFont.systemFontOfSize(14)
        let more=UIButton(frame: CGRectMake(self.view.frame.width-40,0,40,20))
        more.tag=101
        more.addTarget(self, action: Selector("MoreGet:"), forControlEvents: UIControlEvents.TouchUpInside)
        more.setTitle("更多>", forState: UIControlState.Normal)
        more.titleLabel?.font=UIFont.systemFontOfSize(12)
        more.setTitleColor(UIColor(red: 111/255, green: 111/255, blue: 111/255, alpha: 0.77), forState: UIControlState.Normal)
        for i in 0...2{
            let btn=UIButton(frame: CGRectMake(self.view.frame.width/3*CGFloat(i), 0,self.view.frame.width/3, 120))
            let pic=UIImageView(frame: CGRectMake(self.view.frame.width/3*CGFloat(i)+self.view.frame.width/15,10, self.view.frame.width/5, self.view.frame.width/5))
            pic.backgroundColor=UIColor.blackColor()
            pic.image=UIImage(named: "coin.png")
            let money=UILabel(frame: CGRectMake(self.view.frame.width/3*CGFloat(i)+self.view.frame.width/9, self.view.frame.width/9+30, self.view.frame.width/9+20, 20))
            money.text=String(i*100)+"金币"
            money.font=UIFont.systemFontOfSize(12)
            //money.adjustsFontSizeToFitWidth=true
            let process=UILabel(frame: CGRectMake(self.view.frame.width/3*CGFloat(i)+15, self.view.frame.width/9+50, self.view.frame.width/3-15, 10))
            
            //process.adjustsFontSizeToFitWidth=true
            process.font=UIFont.systemFontOfSize(10)
            let progress=UIProgressView(frame: CGRectMake(self.view.frame.width/3*CGFloat(i)+15,self.view.frame.width/9+65 , self.view.frame.width/3-30, 15))
            progress.progress=Float(Int(arc4random())%101)/100.0
            progress.progressTintColor=UIColor(red: 255/255, green: 150/255, blue: 0/255, alpha: 1.0)
            progress.trackTintColor=UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1.0)
            progress.clipsToBounds=true
            progress.layer.cornerRadius=2
            progress.transform=CGAffineTransformMakeScale(1.0, 3.0)
        
            process.text="开奖进度    "+String(Int(progress.progress*100))+"%"
            //tenchargeSv.addSubview(cellview)
            cell.addSubview(btn)
            cell.addSubview(pic)
            cell.addSubview(money)
            cell.addSubview(process)
            cell.addSubview(progress)
            
        }
        cell.addSubview(title)
        cell.addSubview(more)
        return cell
    }
    func NewestCell() ->UITableViewCell{
        let title=UILabel(frame: CGRectMake(10,0,70,30))
        title.text="最新揭晓"
        title.font=UIFont.systemFontOfSize(14)
        let more=UIButton(frame: CGRectMake(self.view.frame.width-40,0,40,20))
        more.tag=102
        more.addTarget(self, action: Selector("MoreGet:"), forControlEvents: UIControlEvents.TouchUpInside)
        more.setTitle("更多>", forState: UIControlState.Normal)
        more.titleLabel?.font=UIFont.systemFontOfSize(12)
        more.setTitleColor(UIColor(red: 111/255, green: 111/255, blue: 111/255, alpha: 0.77), forState: UIControlState.Normal)
        let cell=UITableViewCell()
        for i in 0...2{
            let btn=UIButton(frame: CGRectMake(self.view.frame.width/3*CGFloat(i), 0,self.view.frame.width/3, 120))
            let pic=UIImageView(frame: CGRectMake(self.view.frame.width/3*CGFloat(i)+self.view.frame.width/24,10, self.view.frame.width/4, self.view.frame.width/4))
            pic.image=UIImage(named: "newestFood.jpg")
            let come=UILabel(frame: CGRectMake(self.view.frame.width/3*CGFloat(i)+self.view.frame.width/24, 90, self.view.frame.width/8, 30))
            come.text="倒计时"
            come.font=UIFont.systemFontOfSize(12)
            come.textColor=UIColor(red: 111/255, green: 111/255, blue: 111/255, alpha: 1.0)
            let time=UILabel(frame: CGRectMake(self.view.frame.width/3*CGFloat(i)+self.view.frame.width/240*35, 90, self.view.frame.width/240*35, 30))
            time.text="02:04.60"
            time.font=UIFont.systemFontOfSize(12)
            time.textColor=UIColor(red: 220/255, green: 100/255, blue: 100/255, alpha: 1.0)
            cell.addSubview(btn)
            cell.addSubview(pic)
            cell.addSubview(come)
            cell.addSubview(time)
        }
        cell.addSubview(title)
        cell.addSubview(more)
        return cell
    }
    func OnechargeCell()->UITableViewCell{
        let cell=UITableViewCell()
        let halfwidth=Float(self.view.frame.width)/2
        let title=UILabel(frame: CGRectMake(10,0,70,30))
        title.text="一元夺宝"
        title.font=UIFont.systemFontOfSize(14)
        let more=UIButton(frame: CGRectMake(self.view.frame.width-40,0,40,20))
        more.tag=103
        more.addTarget(self, action: Selector("MoreGet:"), forControlEvents: UIControlEvents.TouchUpInside)
        more.setTitle("更多>", forState: UIControlState.Normal)
        more.titleLabel?.font=UIFont.systemFontOfSize(12)
        more.setTitleColor(UIColor(red: 111/255, green: 111/255, blue: 111/255, alpha: 0.77), forState: UIControlState.Normal)
        
        for i in 0...5{
            let btn=UIButton(frame: CGRectMake(CGFloat(Float(i%2)*halfwidth), CGFloat(Float(i/2)*halfwidth), CGFloat(halfwidth), CGFloat(halfwidth)))
            let pic=UIImageView(frame: CGRectMake(CGFloat(Float(i%2)*halfwidth)+CGFloat(halfwidth/4),CGFloat(Float(i/2)*halfwidth)+20, CGFloat(halfwidth/2), CGFloat(halfwidth/2)))
            pic.image=UIImage(named: "电饭煲.jpg")
            let name=UILabel(frame: CGRectMake(CGFloat(Float(i%2)*halfwidth)+15, CGFloat(Float(i/2)*halfwidth)+CGFloat(halfwidth/2)+20, CGFloat(halfwidth)-15, 20))
            name.text="不锈钢保温密封盒"
            name.font=UIFont.systemFontOfSize(15)
            let progress=UIProgressView(frame: CGRectMake(CGFloat(Float(i%2)*halfwidth)+15, CGFloat(Float(i/2)*halfwidth)+CGFloat(halfwidth/2)+60, CGFloat(halfwidth)-15, 10))
            progress.progress=Float(Int(arc4random())%101)/100.0
            progress.progressTintColor=UIColor(red: 255/255, green: 150/255, blue: 0/255, alpha: 1.0)
            progress.transform=CGAffineTransformMakeScale(1.0, 3.0)
            progress.trackTintColor=UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1.0)
            progress.clipsToBounds=true
            progress.layer.cornerRadius=2
            let process=UILabel(frame: CGRectMake(CGFloat(Float(i%2)*halfwidth)+15, CGFloat(Float(i/2)*halfwidth)+CGFloat(halfwidth/2)+40, CGFloat(halfwidth)-15, 20))
            process.font=UIFont.systemFontOfSize(11)
            process.text="开奖进度       "+String(Int(progress.progress*100))+"%"
            process.textColor=UIColor(red: 111/255, green: 111/255, blue: 111/255, alpha: 1.0)
            let total=UILabel(frame: CGRectMake(CGFloat(Float(i%2)*halfwidth)+15, CGFloat(Float(i/2)*halfwidth)+CGFloat(halfwidth/2)+65, CGFloat(halfwidth)-30, 20))
            total.text="总需：60人次         "
            total.font=UIFont.systemFontOfSize(11)
            total.textColor=UIColor(red: 111/255, green: 111/255, blue: 111/255, alpha: 1.0)
            let remain=UILabel(frame: CGRectMake(CGFloat(Float(i%2+1)*halfwidth)-40, CGFloat(Float(i/2)*halfwidth)+CGFloat(halfwidth/2)+65, 40, 20))
            remain.text="剩余"+String(arc4random()%100)
            remain.font=UIFont.systemFontOfSize(11)
            remain.textColor=UIColor(red: 220/255, green: 100/255, blue: 100/255, alpha: 1.0)
            cell.addSubview(btn)
            cell.addSubview(pic)
            cell.addSubview(name)
            cell.addSubview(total)
            cell.addSubview(progress)
            cell.addSubview(process)
            cell.addSubview(remain)
        }
        cell.addSubview(title)
        cell.addSubview(more)
        return cell
    }
    func MoreGet(sender:UIButton){
        switch sender.tag {
        case 101:
            let anotherView:UIViewController=self.storyboard!.instantiateViewControllerWithIdentifier("TenChargeList");
            self.navigationController?.pushViewController(anotherView, animated: true)
        case 102:
            let anotherView:UIViewController=self.storyboard!.instantiateViewControllerWithIdentifier("NewestList");
            self.navigationController?.pushViewController(anotherView, animated: true)
        default:
            let anotherView:UIViewController=self.storyboard!.instantiateViewControllerWithIdentifier("OneChargeList");
            self.navigationController?.pushViewController(anotherView, animated: true)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.OneChargeController.deselectRowAtIndexPath(indexPath, animated: true)
    }

    // MARK: - Table view data source

//    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }
//
//    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 0
//    }

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