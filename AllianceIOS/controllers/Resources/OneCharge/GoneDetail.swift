//
//  NewestGoneDetail.swift
//  AllianceIOS
//
//  Created by dawei on 15/11/5.
//
//

import UIKit
import SwiftHTTP
import JSONJoy

class GoneDetail: UITableViewController {

    @IBOutlet var detail: UITableView!
    var Id:Int=0
    //var Phone:String=""
    var activityIndicatorView: UIActivityIndicatorView!
    var sv=UIScrollView()
    var pg=UIPageControl()
    var pk=UIPickerView()
    var timer:NSTimer!
    var Through="corn"
    //直接参与弹出按钮
    var gray=UIView()
    var white=UIView()
    var titleSelect=UILabel()
    var OK=UIButton()
    var Lin:GrabCommodityList?
    var alert:UIAlertController?
    var OneChargeView:GrabcornsView?
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
            var params:Dictionary<String,AnyObject>=["grabcommodityid":Id,"phone":Phone]
            var opt=try HTTP.POST(URL+"/grabcommodities/view", parameters: params)
            if(self.Through=="corn"){
                params=["grabcornid":Id,"phone":Phone]
                opt=try HTTP.POST(URL+"/grabcorns/view", parameters: params)
            }
            opt.start { response in
                if let err = response.error {
                    print("error: \(err.localizedDescription)")
                    return //also notify app of failure as needed
                }
                print("opt finished: \(response.description)")
                self.OneChargeView = GrabcornsView(JSONDecoder(response.data))
                //print(self.TenCharge!._meta.totalCount)
            }
        } catch let error {
            print("got an error creating the request: \(error)")
        }
        
    }
    func connect1(){
        do {
            let params:Dictionary<String,AnyObject>=["kind":(OneChargeView?.detail.version)!]
            var opt=try HTTP.POST(URL+"/grabcommodities/formeractivities", parameters: params)
            if(self.Through=="commodity"){
                opt=try HTTP.POST(URL+"/grabcorns/formeractivities", parameters: params)
            }
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

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        if((OneChargeView) != nil){
            return 4
        }
        return 0
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if(section==2){
            return 1+(OneChargeView?.records.count)!
        }else if(section==1)
        {
            if(self.Through=="corn"){
                return 1
            }
            return 2
        }else if(section==0){
            return 1+OneChargeView!.myrecords.count
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
            if(OneChargeView!.myrecords.count==0){
                return self.view.frame.width*1.5
            }else{
                if(indexPath.row==0){
                    return self.view.frame.width*1.5
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
        
        let picture=OneChargeView!.detail.pictures.componentsSeparatedByString(" ")
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
        coming.image=UIImage(named: "已揭晓图标.png")
        let name=UILabel(frame: CGRectMake(75,self.view.frame.width/4*3,self.view.frame.width-75,40))
        name.text=OneChargeView!.detail.title
        name.font=UIFont.systemFontOfSize(15)
        name.numberOfLines=0
        //        let time=UILabel(frame: CGRectMake(10,self.view.frame.width/4*3+25,self.view.frame.width-10,20))
        //        time.text="日期：2015-09-01至2015-12-01"
        //        time.font=UIFont.systemFontOfSize(12)
        //        time.textColor=UIColor(red: 220/255, green: 100/255, blue: 100/255, alpha: 1.0)
        let progress=UIProgressView(frame: CGRectMake(10,self.view.frame.width/4*3+45, self.view.frame.width-10, 10))
        progress.progress=1-Float(OneChargeView!.detail.remain)/Float(OneChargeView!.detail.needed)
        progress.progressTintColor=UIColor(red: 255/255, green: 150/255, blue: 0/255, alpha: 1.0)
        progress.transform=CGAffineTransformMakeScale(1.0, 5.0)
        progress.trackTintColor=UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1.0)
        progress.clipsToBounds=true
        progress.layer.cornerRadius=2
        let total=UILabel(frame: CGRectMake(15, self.view.frame.width/4*3+55, 100, 20))
        total.text="总需："+String(OneChargeView!.detail.needed)+"人次"
        total.font=UIFont.systemFontOfSize(11)
        total.textColor=UIColor(red: 111/255, green: 111/255, blue: 111/255, alpha: 1.0)
        let remain=UILabel(frame: CGRectMake(self.view.frame.width-50, self.view.frame.width/4*3+55, 50, 20))
        remain.text="剩余"+String(OneChargeView!.detail.remain)
        remain.font=UIFont.systemFontOfSize(11)
        remain.textColor=UIColor(red: 220/255, green: 100/255, blue: 100/255, alpha: 1.0)
        let background=UIImageView(frame: CGRectMake(10,self.view.frame.width/4*3+75,self.view.frame.width-20,self.view.frame.width/3+20))
        background.image=UIImage(named: "商品获奖展示.png")
        let number=UILabel(frame: CGRectMake(30,self.view.frame.width/4*3+80,150,40))
        number.text="幸运号码："+String(OneChargeView!.detail.winnernumber)
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
        avator.sd_setImageWithURL(NSURL(string: OneChargeView!.detail.thumb)!, placeholderImage: UIImage(named: "avator.jpg"))
        avator.clipsToBounds=true
        avator.layer.cornerRadius=20
        let username=UILabel(frame: CGRectMake(80,self.view.frame.width/4*3+120,150,20))
        username.text="获奖者："+OneChargeView!.detail.nickname
        username.font=UIFont.systemFontOfSize(12)
        let id=UILabel(frame: CGRectMake(80,self.view.frame.width/4*3+140,150,20))
        id.text="用户ID："+String(OneChargeView!.detail.winneruserid)
        id.font=UIFont.systemFontOfSize(12)
        let term=UILabel(frame: CGRectMake(80,self.view.frame.width/4*3+160,150,20))
        term.text="本期参与：500"+OneChargeView!.detail.count+"人次"
        term.font=UIFont.systemFontOfSize(12)
        let time=UILabel(frame: CGRectMake(80,self.view.frame.width/4*3+180,300,20))
        time.text="揭晓时间："+String(NSDate(timeIntervalSince1970:Double(OneChargeView!.detail.end_at)!))
        
        time.font=UIFont.systemFontOfSize(12)
    
        let reminder=UIButton(frame: CGRectMake(10,self.view.frame.width/4*3+230,self.view.frame.width-20,40))
        reminder.setTitle("您没有参与本次夺宝哟～", forState: UIControlState.Normal)
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
        cell.addSubview(background)
        cell.addSubview(number)
        cell.addSubview(avator)
        cell.addSubview(username)
        cell.addSubview(countdetail)
        cell.addSubview(id)
        cell.addSubview(term)
        cell.addSubview(time)
        if(OneChargeView!.myrecords.count==0){
            cell.addSubview(reminder)
        }
        
        return cell
    }
    func FirstMyRecordCell(index:Int)->UITableViewCell {
        let cell=UITableViewCell()
        let count=UILabel(frame: CGRectMake(15,10,300,15))
        count.font=UIFont.systemFontOfSize(13)
        count.text="您参与了"+OneChargeView!.myrecords[index].count+"人次"
        count.textColor=UIColor(red: 186/255, green: 186/255, blue: 186/255, alpha: 1.0)
        let numbers=UILabel(frame: CGRectMake(15,30,self.view.frame.width-30,15))
        numbers.text=OneChargeView!.myrecords[index].numbers
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
        let begin=UILabel(frame: CGRectMake(85,13,self.view.frame.width-90,14))
        begin.font=UIFont.systemFontOfSize(12)
        begin.textColor=UIColor(red: 186/255, green: 186/255, blue: 186/255, alpha: 1.0)
        begin.text="自"+String(NSDate(timeIntervalSince1970: Double(OneChargeView!.detail.created_at)))+"开始"
        cell.addSubview(record)
        cell.addSubview(begin)
        return cell
    }
    func ThirdContentCell(index:Int)->UITableViewCell {
        let cell=UITableViewCell()
        let avator=UIImageView(frame: CGRectMake(15, 10, 30, 30))
        //avator.image=UIImage(data: NSData(contentsOfURL: NSURL(string: OneChargeView!.records[index].thumb)!)!)
        avator.sd_setImageWithURL(NSURL(string: OneChargeView!.records[index].thumb)!, placeholderImage: UIImage(named: "avator.jpg"))
        avator.clipsToBounds=true
        avator.layer.cornerRadius=15
        let username=UILabel(frame: CGRectMake(50,10,50,15))
        username.text=OneChargeView!.records[index].nickname
        username.font=UIFont.systemFontOfSize(12)
        let time=UILabel(frame: CGRectMake(100,10,300,15))
        time.font=UIFont.systemFontOfSize(12)
        time.text=String(NSDate(timeIntervalSince1970: Double(OneChargeView!.records[index].created_at)!))
        time.textColor=UIColor(red: 186/255, green: 186/255, blue: 186/255, alpha: 1.0)
        let count=UILabel(frame: CGRectMake(50,30,100,15))
        count.text="参与了"+OneChargeView!.records[index].count+"人次"
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
        will.text="第201期正在火热进行中..."
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
        
        if(self.Through=="corn"){
            let anotherView=OneChargeDetailController()
            if(self.Lin!.items.count>0){
                anotherView.GrabCommodityId=self.Lin!.items[0].id
                self.navigationController?.pushViewController(anotherView, animated: true)
            }
        }else{
            let anotherView=TenChargeDetailController()
            if(self.Lin!.items.count>0){
                anotherView.GrabcornId=self.Lin!.items[0].id
                self.navigationController?.pushViewController(anotherView, animated: true)
            }
        }
        
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
        if(indexPath.section==1 && indexPath.row==1){
            let another=PictureAndWord()
            another.Details=self.OneChargeView!.detail.details
            self.navigationController?.pushViewController(another, animated: true)
        }else if(indexPath.section==1 && indexPath.row==0){
            let another=AgeJieXiao()
            another.Kind=OneChargeView!.detail.kind
            another.Url=URL+"/grabcommodities/formeractivities"
            if(self.Through=="corn"){
                another.Url=URL+"/grabcorns/formeractivities"
            }
            self.navigationController?.pushViewController(another, animated: true)
        }
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
        let picture=OneChargeView!.detail.pictures.componentsSeparatedByString(" ")
        if pageIndex == picture.count-1 {
            pageIndex = 0
        } else {
            pageIndex++
        }
        let offsetX = CGFloat(pageIndex) * self.view.frame.width
        sv.setContentOffset(CGPointMake(offsetX, 0), animated: true)
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
