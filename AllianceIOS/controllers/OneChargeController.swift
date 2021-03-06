//
//  OneCHargeController.swift
//  AllianceIOS
//
//  Created by dawei on 15/10/17.
//
//

import UIKit
import SwiftHTTP
import JSONJoy

class OneChargeController: UITableViewController{
    
    @IBOutlet var OneChargeController: UITableView!
    var activityIndicatorView: UIActivityIndicatorView!
    var OneCharge:GrabCommodity_getthree?
    var Newest:GrabCommodityList?
    var TenCharge:Grabcorns_getthree?
        {
        didSet{
            activityIndicatorView.stopAnimating()
            self.activityIndicatorView.hidden=true
            self.tableView.backgroundView=nil
            
            dispatch_async(dispatch_get_main_queue()){
                self.tableView.reloadData()
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.backBarButtonItem=UIBarButtonItem(title: "", style: UIBarButtonItemStyle.Plain, target: nil, action: nil)
        let view1=UIView(frame: CGRectMake(0, 0, self.tableView.frame.size.width, self.tableView.frame.size.height))
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
        print("一元夺宝主界面")
        do {
            let grabcommodity=try HTTP.GET(URL+"/grabcommodities/getthree")
            grabcommodity.start { response in
                if let err = response.error {
                    print("error: \(err.localizedDescription)")
                    return //also notify app of failure as needed
                }
                print("opt finished: \(response.description)")
                self.OneCharge = GrabCommodity_getthree(JSONDecoder(response.data))
            }
            let grabcorns=try HTTP.GET(URL+"/grabcorns/getthree")
            grabcorns.start { response in
                if let err = response.error {
                    print("error: \(err.localizedDescription)")
                    return //also notify app of failure as needed
                }
                print("opt finished: \(response.description)")
                self.TenCharge = Grabcorns_getthree(JSONDecoder(response.data))
            }
            let params:Dictionary<String,AnyObject>=["type":1]
            let opt=try HTTP.POST(URL+"/grabcommodities/search", parameters: params)
            opt.start { response in
                if let err = response.error {
                    print("error: \(err.localizedDescription)")
                    return //also notify app of failure as needed
                }
                print("opt finished: \(response.description)")
                self.Newest = GrabCommodityList(JSONDecoder(response.data))
                //print(self.TenCharge!._meta.totalCount)
            }
            
        } catch let error {
            print("got an error creating the request: \(error)")
        }
        
    }
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        if((TenCharge) != nil){
            return 4
        }
        return 0
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
        
    }
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
           return 10
    }
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 5
    }
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        switch indexPath.section{
        case 0:
            return 100
        case 3:
            return 120
        default:
            return 120
        }
    }
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
            let anotherView=ChargeRecord()
            self.navigationController?.pushViewController(anotherView, animated: true)
        default:
            let anotherView:UIViewController=self.storyboard!.instantiateViewControllerWithIdentifier("TenChargeList");
            self.navigationController?.pushViewController(anotherView, animated: true)
        }
    }
    func TenChargeCell() -> UITableViewCell{
        let cell=UITableViewCell()
        let title=UILabel(frame: CGRectMake(10,0,50,30))
        title.text="10夺金"
        title.font=UIFont.systemFontOfSize(14)
        let more=UIButton(frame: CGRectMake(self.view.frame.width-40,0,40,20))
        more.tag=101
        more.addTarget(self, action: Selector("MoreGet:"), forControlEvents: UIControlEvents.TouchUpInside)
        more.setTitle("更多>", forState: UIControlState.Normal)
        more.titleLabel?.font=UIFont.systemFontOfSize(12)
        more.setTitleColor(UIColor(red: 111/255, green: 111/255, blue: 111/255, alpha: 0.77), forState: UIControlState.Normal)
        var lin=0-1
        if (TenCharge != nil) {
            lin=(TenCharge?.items.count)!-1
            if(lin>=2){
                lin=2
            }
        }
        print(lin)
        for var i=0;i<=lin;i++ {
            let btn=UIButton(frame: CGRectMake(self.view.frame.width/3*CGFloat(i), 0,self.view.frame.width/3, 120))
            btn.tag=1000+i
            btn.addTarget(self, action: Selector("detail:"), forControlEvents: UIControlEvents.TouchUpInside)
            let pic=UIImageView(frame: CGRectMake(self.view.frame.width/3*CGFloat(i)+self.view.frame.width/12,15, self.view.frame.width/6, self.view.frame.width/6))
            //pic.backgroundColor=UIColor.blackColor()
            //print(TenCharge!.items[i].picture)
            //pic.image=UIImage(named: TenCharge!.items[i].picture)
            //pic.image=UIImage(data: NSData(contentsOfURL: NSURL(string: TenCharge!.items[i].picture)!)!)
//            if let Ndata=NSData(contentsOfURL: NSURL(string: TenCharge!.items[i].picture)!){
//                pic.image=UIImage(data: Ndata)
//            }
            pic.sd_setImageWithURL(NSURL(string: TenCharge!.items[i].picture)!, placeholderImage: UIImage(named: "avator.jpg"))
            let money=UILabel(frame: CGRectMake(self.view.frame.width/3*CGFloat(i)+self.view.frame.width/10, self.view.frame.width/9+30, self.view.frame.width/9+30, 20))
            money.text=TenCharge?.items[i].title
            money.font=UIFont.systemFontOfSize(12)
            //money.adjustsFontSizeToFitWidth=true
            let process=UILabel(frame: CGRectMake(self.view.frame.width/3*CGFloat(i)+15, self.view.frame.width/9+50, self.view.frame.width/3-15, 10))
            
            //process.adjustsFontSizeToFitWidth=true
            process.font=UIFont.systemFontOfSize(10)
            let progress=UIProgressView(frame: CGRectMake(self.view.frame.width/3*CGFloat(i)+15,self.view.frame.width/9+65 , self.view.frame.width/3-30, 15))
            //progress.progress=Float(Int(arc4random())%101)/100.0
            progress.progress=1-Float(TenCharge!.items[i].remain)/Float(TenCharge!.items[i].needed)
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
        var lin=0-1
        if (Newest != nil) {
            lin=(Newest?.items.count)!-1
            if(lin>=2){
                lin=2
            }
        }
        print(lin)
        
        for var i=0;i<=lin;i++ {
            let btn=UIButton(frame: CGRectMake(self.view.frame.width/3*CGFloat(i), 0,self.view.frame.width/3, 120))
            btn.tag=1003+i
            btn.addTarget(self, action: Selector("detail:"), forControlEvents: UIControlEvents.TouchUpInside)
            let pic=UIImageView(frame: CGRectMake(self.view.frame.width/3*CGFloat(i)+self.view.frame.width/24,10, self.view.frame.width/4, self.view.frame.width/4))
            //pic.image=UIImage(named: "newestFood.jpg")
            pic.sd_setImageWithURL(NSURL(string: Newest!.items[i].picture)!, placeholderImage: UIImage(named: "avator.jpg"))
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
        let title=UILabel(frame: CGRectMake(10,0,70,30))
        title.text="一元夺宝"
        title.font=UIFont.systemFontOfSize(14)
        let more=UIButton(frame: CGRectMake(self.view.frame.width-40,0,40,20))
        more.tag=103
        more.addTarget(self, action: Selector("MoreGet:"), forControlEvents: UIControlEvents.TouchUpInside)
        more.setTitle("更多>", forState: UIControlState.Normal)
        more.titleLabel?.font=UIFont.systemFontOfSize(12)
        more.setTitleColor(UIColor(red: 111/255, green: 111/255, blue: 111/255, alpha: 0.77), forState: UIControlState.Normal)
        var lin=0-1
        if (OneCharge != nil) {
            lin=(OneCharge?.items.count)!-1
            if(lin>=2){
                lin=2
            }
        }
        print(lin)
        for var i=0;i<=lin;i++ {
            let btn=UIButton(frame: CGRectMake(self.view.frame.width/3*CGFloat(i), 0,self.view.frame.width/3, 120))
            btn.tag=1006+i
            btn.addTarget(self, action: Selector("detail:"), forControlEvents: UIControlEvents.TouchUpInside)
            let pic=UIImageView(frame: CGRectMake(self.view.frame.width/3*CGFloat(i)+self.view.frame.width/12,15, self.view.frame.width/6, self.view.frame.width/6))
            //pic.image=UIImage(data: NSData(contentsOfURL: NSURL(string: OneCharge!.items[i].picture)!)!)
//            if let Ndata=NSData(contentsOfURL: NSURL(string: OneCharge!.items[i].picture)!){
//                pic.image=UIImage(data: Ndata)
//            }
            pic.sd_setImageWithURL(NSURL(string: OneCharge!.items[i].picture)!, placeholderImage: UIImage(named: "avator.jpg"))
            let name=UILabel(frame: CGRectMake(self.view.frame.width/3*CGFloat(i)+self.view.frame.width/10, self.view.frame.width/9+30, self.view.frame.width/9+30, 20))
            name.text=OneCharge?.items[i].title
            name.font=UIFont.systemFontOfSize(12)
            let progress=UIProgressView(frame: CGRectMake(self.view.frame.width/3*CGFloat(i)+15,self.view.frame.width/9+65 , self.view.frame.width/3-30, 15))
            progress.progress=1-Float(OneCharge!.items[i].remain)/Float(OneCharge!.items[i].needed)
            progress.progressTintColor=UIColor(red: 255/255, green: 150/255, blue: 0/255, alpha: 1.0)
            progress.transform=CGAffineTransformMakeScale(1.0, 3.0)
            progress.trackTintColor=UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1.0)
            progress.clipsToBounds=true
            progress.layer.cornerRadius=2
            let process=UILabel(frame: CGRectMake(self.view.frame.width/3*CGFloat(i)+15, self.view.frame.width/9+50, self.view.frame.width/3-15, 10))
            process.font=UIFont.systemFontOfSize(10)
            process.text="开奖进度       "+String(Int(progress.progress*100))+"%"
            process.textColor=UIColor(red: 111/255, green: 111/255, blue: 111/255, alpha: 1.0)
//            let total=UILabel(frame: CGRectMake(CGFloat(Float(i%2)*halfwidth)+15, CGFloat(Float(i/2)*halfwidth)+CGFloat(halfwidth/2)+65, CGFloat(halfwidth)-30, 20))
//            total.text="总需：60人次         "
//            total.font=UIFont.systemFontOfSize(11)
//            total.textColor=UIColor(red: 111/255, green: 111/255, blue: 111/255, alpha: 1.0)
//            let remain=UILabel(frame: CGRectMake(CGFloat(Float(i%2+1)*halfwidth)-40, CGFloat(Float(i/2)*halfwidth)+CGFloat(halfwidth/2)+65, 40, 20))
//            remain.text="剩余"+String(arc4random()%100)
//            remain.font=UIFont.systemFontOfSize(11)
            //remain.textColor=UIColor(red: 220/255, green: 100/255, blue: 100/255, alpha: 1.0)
            cell.addSubview(btn)
            cell.addSubview(pic)
            cell.addSubview(name)
            //cell.addSubview(total)
            cell.addSubview(progress)
            cell.addSubview(process)
            //cell.addSubview(remain)
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
    func detail(sender:UIButton){
        if(sender.tag<=1002){
            let anotherView=TenChargeDetailController()
            anotherView.GrabcornId=(TenCharge?.items[sender.tag-1000].id)!
            //let anotherView:UIViewController=self.storyboard!.instantiateViewControllerWithIdentifier("TenChargeDetail");
            self.navigationController?.pushViewController(anotherView, animated: true)
        }else if(sender.tag>=1006){
            let anotherView=OneChargeDetailController()
            anotherView.GrabCommodityId=(OneCharge?.items[sender.tag-1006].id)!
            self.navigationController?.pushViewController(anotherView, animated: true)
        }else{
            let anotherView=NewestDetailController()
            anotherView.NewestId=Newest!.items[sender.tag-1003].id
            //let anotherView:UIViewController=self.storyboard!.instantiateViewControllerWithIdentifier("NewestDetail");
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