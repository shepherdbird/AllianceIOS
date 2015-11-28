//
//  TenChargeDetailController.swift
//  AllianceIOS
//
//  Created by dawei on 15/11/4.
//
//

import UIKit
import SwiftHTTP
import JSONJoy

class TenChargeDetailController: UITableViewController,UIPickerViewDelegate, UIPickerViewDataSource{
    
    @IBOutlet var TenChargeDetail: UITableView!
    var GrabcornId:Int=0
    var Phone:String=""
    var activityIndicatorView: UIActivityIndicatorView!
    var sv=UIScrollView()
    var pg=UIPageControl()
    var pk=UIPickerView()
    var timer:NSTimer!
    //直接参与弹出按钮
    var gray=UIView()
    var white=UIView()
    var titleSelect=UILabel()
    var OK=UIButton()
    var TenChargeView:GrabcornsView?
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
        self.tableView=UITableView(frame: self.view.frame, style: UITableViewStyle.Grouped)
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
        do {
            let params:Dictionary<String,AnyObject>=["grabcornid":GrabcornId,"phone":"2"]
            let opt=try HTTP.POST(URL+"/grabcorns/view", parameters: params)
            opt.start { response in
                if let err = response.error {
                    print("error: \(err.localizedDescription)")
                    return //also notify app of failure as needed
                }
                print("opt finished: \(response.description)")
                self.TenChargeView = GrabcornsView(JSONDecoder(response.data))
                //print(self.TenCharge!._meta.totalCount)
            }
        } catch let error {
            print("got an error creating the request: \(error)")
        }
        
    }
    func LiMaCanYu_OK(){
        do {
            let params:Dictionary<String,AnyObject>=["grabcornid":GrabcornId,"phone":"2","count":pk.selectedRowInComponent(0),"type":1]
            let opt=try HTTP.POST(URL+"/grabcorns/buy", parameters: params)
            opt.start { response in
                if let err = response.error {
                    print("error: \(err.localizedDescription)")
                    return //also notify app of failure as needed
                }
                print("opt finished: \(response.description)")
                //self.TenChargeView = GrabcornsView(JSONDecoder(response.data))
                //print(self.TenCharge!._meta.totalCount)
            }
        } catch let error {
            print("got an error creating the request: \(error)")
        }
        
    }
    func BuyAll(){
        do {
            let params:Dictionary<String,AnyObject>=["grabcornid":GrabcornId,"phone":"2","type":1]
            let opt=try HTTP.POST(URL+"/grabcorns/buyall", parameters: params)
            opt.start { response in
                if let err = response.error {
                    print("error: \(err.localizedDescription)")
                    return //also notify app of failure as needed
                }
                print("opt finished: \(response.description)")
                //self.TenChargeView = GrabcornsView(JSONDecoder(response.data))
                //print(self.TenCharge!._meta.totalCount)
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
        if((TenChargeView) != nil){
            return 4
        }
        return 0
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if(section==2){
            return 1+TenChargeView!.records.count
        }else{
            return 1
        }
    }
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 1
    }
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
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
            return SecondCell()
        case 2:
            if(indexPath.row==0){
                return ThirdTitleCell()
            }else{
                return ThirdContentCell(indexPath.row-1)
            }
        default:
            return FourthCell()
        }
    }
    func FirstCell()->UITableViewCell {
        let cell=UITableViewCell()
        //轮播图片
        sv.frame=CGRectMake(0, 0, self.view.frame.width, self.view.frame.width/4*3)
        //pg.frame=CGRectMake((self.view.frame.width-60)/2, self.view.frame.width/4*3-30, 60, 5)
        let picture=TenChargeView!.detail.pictures.componentsSeparatedByString(" ")
        pg.frame=CGRectMake((self.view.frame.width-CGFloat(10*picture.count))/2, self.view.frame.width/4*3-30, CGFloat(10*picture.count), 5)
        for i in 0...(picture.count-1){
            let x = CGFloat(i) * self.view.frame.width
            let imageView = UIImageView(frame: CGRectMake(x, 0, self.view.frame.width, self.view.frame.width/4*3))
            //imageView.image = UIImage(data: NSData(contentsOfURL: NSURL(string: picture[i])!)!)
            if let Ndata=NSData(contentsOfURL: NSURL(string: picture[i])!){
                imageView.image = UIImage(data: Ndata)
            }
            sv.pagingEnabled = true
            sv.showsHorizontalScrollIndicator = false
            sv.scrollEnabled = true
            sv.addSubview(imageView)
            sv.delegate = self
        }
        sv.contentSize = CGSizeMake(self.view.frame.width * CGFloat(picture.count), self.view.frame.width/4*3)
        //sv.setContentOffset(CGPointMake(0, 0), animated: true)
        pg.numberOfPages = picture.count
        pg.currentPageIndicatorTintColor = UIColor.redColor()
        pg.pageIndicatorTintColor = UIColor.whiteColor()
        addTimer()
        //详细内容
//        let pic=UIImageView(frame: CGRectMake(self.view.frame.width/8, 0, self.view.frame.width/4*3, self.view.frame.width/4*3))
//        pic.image=UIImage(named: "coin.png")
        let coming=UIImageView(frame: CGRectMake(10, self.view.frame.width/4*3,50,20))
        if(TenChargeView!.detail.islotteried==0){
            coming.image=UIImage(named: "进行中图标.png")
        }else{
            coming.image=UIImage(named: "已揭晓图标.png")
        }
        
        let name=UILabel(frame: CGRectMake(75,self.view.frame.width/4*3,self.view.frame.width-75,20))
        name.text=TenChargeView!.detail.title
        name.font=UIFont.systemFontOfSize(15)
        let format = NSDateFormatter()
        format.dateFormat="yyyy年MM月dd日"
        let begin = NSDate(timeIntervalSince1970: Double(TenChargeView!.detail.date)!)
        var end=NSDate()
        if(TenChargeView!.detail.end_at != "0"){
            end=NSDate(timeIntervalSince1970: Double(Int(TenChargeView!.detail.end_at)!))
        }
        let time=UILabel(frame: CGRectMake(10,self.view.frame.width/4*3+25,self.view.frame.width-10,20))
        time.text="日期："+format.stringFromDate(begin)+"至"+format.stringFromDate(end)
        time.font=UIFont.systemFontOfSize(12)
        time.textColor=UIColor(red: 220/255, green: 100/255, blue: 100/255, alpha: 1.0)
        let progress=UIProgressView(frame: CGRectMake(10,self.view.frame.width/4*3+45, self.view.frame.width-10, 10))
        progress.progress=1-Float(TenChargeView!.detail.remain)/Float(TenChargeView!.detail.needed)
        progress.progressTintColor=UIColor(red: 255/255, green: 150/255, blue: 0/255, alpha: 1.0)
        progress.transform=CGAffineTransformMakeScale(1.0, 3.0)
        progress.trackTintColor=UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1.0)
        progress.clipsToBounds=true
        progress.layer.cornerRadius=2
        let total=UILabel(frame: CGRectMake(15, self.view.frame.width/4*3+55, 100, 20))
        total.text="总需："+String(TenChargeView!.detail.needed)+"人次"
        total.font=UIFont.systemFontOfSize(11)
        total.textColor=UIColor(red: 111/255, green: 111/255, blue: 111/255, alpha: 1.0)
        let remain=UILabel(frame: CGRectMake(self.view.frame.width-80, self.view.frame.width/4*3+55, 80, 20))
        remain.text="剩余"+String(TenChargeView!.detail.remain)
        remain.font=UIFont.systemFontOfSize(11)
        remain.textColor=UIColor(red: 220/255, green: 100/255, blue: 100/255, alpha: 1.0)
        let reminder=UIButton(frame: CGRectMake(10,self.view.frame.width/4*3+75,self.view.frame.width-20,40))
        reminder.setTitle("您还没有参与本次夺宝哟～", forState: UIControlState.Normal)
        reminder.backgroundColor=UIColor(red: 186/255, green: 186/255, blue: 186/255, alpha: 0.44)
        reminder.setTitleColor(UIColor(red: 111/255, green: 111/255, blue: 111/255, alpha: 1.0), forState: UIControlState.Normal)
        reminder.clipsToBounds=true
        reminder.layer.cornerRadius=5
        cell.addSubview(sv)
        cell.addSubview(pg)
        cell.addSubview(coming)
        cell.addSubview(name)
        cell.addSubview(time)
        cell.addSubview(progress)
        cell.addSubview(total)
        cell.addSubview(remain)
        if(TenChargeView!.myrecords.count==0){
            cell.addSubview(reminder)
        }
        return cell
    }
    func SecondCell()->UITableViewCell {
        let cell=UITableViewCell()
        let table=UILabel(frame: CGRectMake(15,10,100,20))
        table.text="往期揭晓"
        table.font=UIFont.systemFontOfSize(15)
        cell.addSubview(table)
        cell.accessoryType=UITableViewCellAccessoryType.DisclosureIndicator
        return cell
    }
    func ThirdTitleCell()->UITableViewCell {
        let cell=UITableViewCell()
        let record=UILabel(frame: CGRectMake(15,10,70,20))
        record.text="参与记录"
        record.font=UIFont.systemFontOfSize(15)
        let begin=UILabel(frame: CGRectMake(85,13,self.view.frame.width-90,14))
        begin.font=UIFont.systemFontOfSize(12)
        begin.textColor=UIColor(red: 186/255, green: 186/255, blue: 186/255, alpha: 1.0)
        begin.text="自"+String(NSDate(timeIntervalSince1970: Double(TenChargeView!.detail.created_at)))+"开始"
        cell.addSubview(record)
        cell.addSubview(begin)
        return cell
    }
    func ThirdContentCell(index:Int)->UITableViewCell {
        let cell=UITableViewCell()
        let avator=UIImageView(frame: CGRectMake(15, 10, 30, 30))
        avator.image=UIImage(data: NSData(contentsOfURL: NSURL(string: TenChargeView!.records[index].thumb)!)!)
        avator.clipsToBounds=true
        avator.layer.cornerRadius=15
        let username=UILabel(frame: CGRectMake(50,10,100,15))
        username.text=TenChargeView!.records[index].nickname
        username.font=UIFont.systemFontOfSize(12)
        let time=UILabel(frame: CGRectMake(100,10,300,15))
        time.font=UIFont.systemFontOfSize(12)
        time.text=String(NSDate(timeIntervalSince1970: Double(TenChargeView!.records[index].created_at)!))
        time.textColor=UIColor(red: 186/255, green: 186/255, blue: 186/255, alpha: 1.0)
        let count=UILabel(frame: CGRectMake(50,30,100,15))
        count.text="参与了"+TenChargeView!.records[index].count+"人次"
        count.font=UIFont.systemFontOfSize(11)
        let phone=UILabel(frame: CGRectMake(150,30,150,15))
        phone.font=UIFont.systemFontOfSize(11)
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
        now.tag=1
        now.addTarget(self, action: Selector("ButtonAction:"), forControlEvents: UIControlEvents.TouchUpInside)
        let buy=UIButton(frame: CGRectMake(self.view.frame.width/2+5,5,self.view.frame.width/2-25,30))
        buy.setBackgroundImage(UIImage(named: "购买全部大按钮.png"), forState: UIControlState.Normal)
        buy.setTitleColor(UIColor(red: 220/255, green: 100/255, blue: 100/255, alpha: 1.0), forState: UIControlState.Normal)
        buy.setTitle("购买全部", forState: UIControlState.Normal)
        buy.titleLabel?.font=UIFont.systemFontOfSize(17)
        buy.tag=2
        buy.addTarget(self, action: Selector("ButtonAction:"), forControlEvents: UIControlEvents.TouchUpInside)
        cell.addSubview(now)
        cell.addSubview(buy)
        return cell
    }
    func ButtonAction(sender:UIButton){
        if(sender.tag==1){
            let width=self.view.frame.width
            //半透明
            gray=UIView(frame: CGRectMake(0, self.tableView.frame.height-self.view.frame.height, width, self.view.frame.height))
            gray.backgroundColor=UIColor(red: 180/255, green: 181/255, blue: 181/255, alpha: 0.7)
            self.view.addSubview(gray)
            white=UIView(frame: CGRectMake(0, self.tableView.frame.height-self.view.frame.width/2, width, self.view.frame.width/2))
            white.backgroundColor=UIColor(red: 250/255, green: 250/255, blue: 250/255, alpha: 1.0)
            self.view.addSubview(white)
            titleSelect=UILabel(frame: CGRectMake(self.view.frame.width/2-60,white.frame.minY+10,200,30))
            titleSelect.text="参与人次选择"
            titleSelect.font=UIFont.systemFontOfSize(20)
            self.view.addSubview(titleSelect)
            pk=UIPickerView(frame: CGRectMake(self.view.frame.width/2-40,white.frame.minY+30,80,100))
            pk.delegate=self
            pk.dataSource=self
            self.view.addSubview(pk)
            OK=UIButton(frame: CGRectMake(self.view.frame.width/2-60,white.frame.minY+150,120,30))
            OK.setBackgroundImage(UIImage(named: "立即参与按钮.png"), forState: UIControlState.Normal)
            OK.setTitle("确定", forState: UIControlState.Normal)
            OK.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
            OK.titleLabel?.font=UIFont.systemFontOfSize(18)
            OK.addTarget(self, action: Selector("OKer"), forControlEvents: UIControlEvents.TouchUpInside)
            self.view.addSubview(OK)
        }else{
            BuyAll()
        }
    }
    func OKer(){
        gray.removeFromSuperview()
        white.removeFromSuperview()
        titleSelect.removeFromSuperview()
        pk.removeFromSuperview()
        OK.removeFromSuperview()
        LiMaCanYu_OK()
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 10
    }
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(row+1)
    }
    //scrollview
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        let width = self.view.frame.width
        let offsetX = scrollView.contentOffset.x
        let index = (offsetX + width / 2) / width
        pg.currentPage = Int(index)
    }
    override func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        removeTimer()
    }
    override func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        addTimer()
    }
    func addTimer() {
        timer = NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector: "nextImage", userInfo: nil, repeats: true)
    }
    func removeTimer() {
        timer.invalidate()
    }
    func nextImage() {
        var pageIndex = pg.currentPage
        let picture=TenChargeView!.detail.pictures.componentsSeparatedByString(" ")
        if pageIndex == picture.count-1 {
            pageIndex = 0
        } else {
            pageIndex++
        }
        let offsetX = CGFloat(pageIndex) * self.view.frame.width
        sv.setContentOffset(CGPointMake(offsetX, 0), animated: true)
    }

}
