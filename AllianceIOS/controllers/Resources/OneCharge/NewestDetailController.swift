//
//  NewestDetailController.swift
//  AllianceIOS
//
//  Created by dawei on 15/11/5.
//
//

import UIKit
import SwiftHTTP
import JSONJoy

class NewestDetailController: UITableViewController ,UIPickerViewDelegate, UIPickerViewDataSource{

    @IBOutlet var Detail: UITableView!
    var running:Int=1
    var NewestId:Int=0
    var activityIndicatorView: UIActivityIndicatorView!
    var sv=UIScrollView()
    var pg=UIPageControl()
    var pk=UIPickerView()
    var timer:NSTimer!
    var alert:UIAlertController?
    var Lin:GrabCommodityList?
    var NewestView:GrabcornsView?
        {
        didSet{
            activityIndicatorView.stopAnimating()
            self.activityIndicatorView.hidden=true
            self.tableView.backgroundView=nil
            //self.tableView.reloadData()
            dispatch_async(dispatch_get_main_queue()){
                self.tableView.reloadData()
                self.tableView.refreshHeader.endRefresh()
            }
            dispatch_async(dispatch_get_main_queue()){
                self.connect1()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.backBarButtonItem=UIBarButtonItem(title: "", style: UIBarButtonItemStyle.Plain, target: nil, action: nil)
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
        self.tableView.refreshHeader=self.tableView.addRefreshHeaderWithHandler{
            self.refreshData()
        }
    }
    func refreshData() {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)){
            self.connect()
        }
    }
    func connect(){
        do {
            let params:Dictionary<String,AnyObject>=["grabcommodityid":NewestId,"phone":Phone]
            let opt=try HTTP.POST(URL+"/grabcommodities/view", parameters: params)
            opt.start { response in
                if let err = response.error {
                    print("error: \(err.localizedDescription)")
                    return //also notify app of failure as needed
                }
                print("opt finished: \(response.description)")
                self.NewestView = GrabcornsView(JSONDecoder(response.data))
                //print(self.TenCharge!._meta.totalCount)
            }
        } catch let error {
            print("got an error creating the request: \(error)")
        }
        
    }
    func connect1(){
        do {
            let params:Dictionary<String,AnyObject>=["kind":(NewestView?.detail.version)!]
            let opt=try HTTP.POST(URL+"/grabcommodities/formeractivities", parameters: params)
            opt.start { response in
                if let err = response.error {
                    print("error: \(err.localizedDescription)")
                    return //also notify app of failure as needed
                }
                print("opt finished: \(response.description)")
                self.Lin = GrabCommodityList(JSONDecoder(response.data))
                
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
        if((NewestView) != nil){
            return 4
        }
        return 0
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if(section==2){
            return 1+(NewestView?.records.count)!
        }else if(section==1)
        {
            return 2
        }else if(section==0){
            return 1+NewestView!.myrecords.count
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
            if(NewestView!.myrecords.count==0){
                return self.view.frame.width*1.25
            }else{
                if(indexPath.row==0){
                    return self.view.frame.width*1.25-70
                }else{
                    return 50
                }
            }
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
            if(indexPath.row==0){
                return FirstCell()
            }else{
                return FirstMyRecordCell(indexPath.row-1)
            }
        case 1:
            return SecondCell(indexPath.row)
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
        
        let picture=NewestView!.detail.pictures.componentsSeparatedByString(" ")
        pg.frame=CGRectMake((self.view.frame.width-CGFloat(10*picture.count))/2, self.view.frame.width/4*3-30, CGFloat(10*picture.count), 5)
        for i in 0...(picture.count-1){
            let x = CGFloat(i) * self.view.frame.width
            let imageView = UIImageView(frame: CGRectMake(x, 0, self.view.frame.width, self.view.frame.width/4*3))
            //            if let Ndata=NSData(contentsOfURL: NSURL(string: picture[i])!){
            //                imageView.image = UIImage(data: Ndata)
            //            }
            imageView.sd_setImageWithURL(NSURL(string: picture[i])!, placeholderImage: UIImage(named: "avator.jpg"))
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
        let coming=UIImageView(frame: CGRectMake(10, self.view.frame.width/4*3+5,50,20))
        coming.image=UIImage(named: "进行中图标.png")
        let name=UILabel(frame: CGRectMake(75,self.view.frame.width/4*3,self.view.frame.width-75,40))
        name.text=NewestView!.detail.title
        name.font=UIFont.systemFontOfSize(15)
        name.numberOfLines=0
        //        let time=UILabel(frame: CGRectMake(10,self.view.frame.width/4*3+25,self.view.frame.width-10,20))
        //        time.text="日期：2015-09-01至2015-12-01"
        //        time.font=UIFont.systemFontOfSize(12)
        //        time.textColor=UIColor(red: 220/255, green: 100/255, blue: 100/255, alpha: 1.0)
        let progress=UIProgressView(frame: CGRectMake(10,self.view.frame.width/4*3+45, self.view.frame.width-10, 10))
        progress.progress=1-Float(NewestView!.detail.remain)/Float(NewestView!.detail.needed)
        progress.progressTintColor=UIColor(red: 255/255, green: 150/255, blue: 0/255, alpha: 1.0)
        progress.transform=CGAffineTransformMakeScale(1.0, 5.0)
        progress.trackTintColor=UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1.0)
        progress.clipsToBounds=true
        progress.layer.cornerRadius=2
        let total=UILabel(frame: CGRectMake(15, self.view.frame.width/4*3+55, 100, 20))
        total.text="总需："+String(NewestView!.detail.needed)+"人次"
        total.font=UIFont.systemFontOfSize(11)
        total.textColor=UIColor(red: 111/255, green: 111/255, blue: 111/255, alpha: 1.0)
        let remain=UILabel(frame: CGRectMake(self.view.frame.width-50, self.view.frame.width/4*3+55, 50, 20))
        remain.text="剩余"+String(NewestView!.detail.remain)
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
        cell.addSubview(sv)
        cell.addSubview(pg)
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
        if(NewestView!.myrecords.count==0){
            cell.addSubview(reminder)
        }
        return cell
    }
    func FirstMyRecordCell(index:Int)->UITableViewCell {
        let cell=UITableViewCell()
        let count=UILabel(frame: CGRectMake(15,10,300,15))
        count.font=UIFont.systemFontOfSize(13)
        count.text="您参与了"+NewestView!.myrecords[index].count!+"人次"
        count.textColor=UIColor(red: 186/255, green: 186/255, blue: 186/255, alpha: 1.0)
        let numbers=UILabel(frame: CGRectMake(15,30,self.view.frame.width-30,15))
        numbers.text=NewestView!.myrecords[index].numbers
        numbers.font=UIFont.systemFontOfSize(13)
        cell.addSubview(count)
        cell.addSubview(numbers)
        return cell
    }
    func SecondCell(row:Int)->UITableViewCell {
        let cell=UITableViewCell()
        if(row==0){
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
        begin.text="自"+String(NSDate(timeIntervalSince1970: Double(NewestView!.detail.created_at)))+"开始"
        
        cell.addSubview(record)
        cell.addSubview(begin)
        return cell
    }
    func ThirdContentCell(index:Int)->UITableViewCell {
        let cell=UITableViewCell()
        let avator=UIImageView(frame: CGRectMake(15, 10, 30, 30))
        avator.sd_setImageWithURL(NSURL(string: NewestView!.records[index].thumb!)!, placeholderImage: UIImage(named: "avator.jpg"))
        avator.clipsToBounds=true
        avator.layer.cornerRadius=15
        let username=UILabel(frame: CGRectMake(50,15,100,15))
        username.text=NewestView!.records[index].nickname
        username.font=UIFont.systemFontOfSize(12)
        let time=UILabel(frame: CGRectMake(100,10,300,15))
        time.font=UIFont.systemFontOfSize(12)
        time.text=String(NSDate(timeIntervalSince1970: Double(NewestView!.records[index].created_at!)!))
        time.textColor=UIColor(red: 186/255, green: 186/255, blue: 186/255, alpha: 1.0)
        let count=UILabel(frame: CGRectMake(50,30,100,15))
        count.text="参与了"+NewestView!.records[index].count!+"人次"
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
        let will=UILabel(frame: CGRectMake(20,20,self.view.frame.width/2+10,15))
        will.textColor=UIColor(red: 186/255, green: 186/255, blue: 186/255, alpha: 1.0)
        will.text="新的一期正在火热进行中..."
        will.font=UIFont.systemFontOfSize(12)
        let buy=UIButton(frame: CGRectMake(self.view.frame.width/2+20,10,self.view.frame.width/2-30,30))
        buy.setBackgroundImage(UIImage(named: "立即参与按钮.png"), forState: UIControlState.Normal)
        buy.setTitleColor(UIColor(red: 220/255, green: 100/255, blue: 100/255, alpha: 1.0), forState: UIControlState.Normal)
        buy.setTitle("立即前往", forState: UIControlState.Normal)
        buy.titleLabel?.font=UIFont.systemFontOfSize(17)
        buy.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        buy.addTarget(self, action: Selector("Go"), forControlEvents: UIControlEvents.TouchUpInside)
        cell.addSubview(will)
        cell.addSubview(buy)
        return cell
    }
    func Go(){
        let anotherView=OneChargeDetailController()
        if(self.Lin!.items.count>0){
            anotherView.GrabCommodityId=self.Lin!.items[0].id
            self.navigationController?.pushViewController(anotherView, animated: true)
        }
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
        if(indexPath.section==1 && indexPath.row==0){
            let another=AgeJieXiao()
            another.Kind=NewestView!.detail.kind
            another.Url=URL+"/grabcommodities/formeractivities"
            another.Through="commodity"
            self.navigationController?.pushViewController(another, animated: true)
        }
        if(indexPath.section==1 && indexPath.row==1){
            let another=PictureAndWord()
            another.Details=self.NewestView!.detail.details
            self.navigationController?.pushViewController(another, animated: true)
        }
    }
    func config(run:Int){
        self.running=run
    }
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 1000
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
        let picture=NewestView!.detail.pictures.componentsSeparatedByString(" ")
        if pageIndex == picture.count-1 {
            pageIndex = 0
        } else {
            pageIndex++
        }
        let offsetX = CGFloat(pageIndex) * self.view.frame.width
        sv.setContentOffset(CGPointMake(offsetX, 0), animated: true)
    }
}
