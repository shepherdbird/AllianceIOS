//
//  ResourceController.swift
//  AllianceIOS
//
//  Created by dawei on 15/9/21.
//
//

import UIKit

class ResourceController: UIViewController ,UIScrollViewDelegate{
    
    //@IBOutlet weak var sv: UIScrollView!
    //@IBOutlet weak var pg: UIPageControl!
    
    
    
    var timer:NSTimer!
    var sv=UIScrollView()
    var pg=UIPageControl()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.backBarButtonItem=UIBarButtonItem(title: "", style: UIBarButtonItemStyle.Plain, target: nil, action: nil)
        
        //self.navigationController?.navigationBar.barTintColor=UIColor.blackColor()
        //self.navigationController?.navigationItem.backBarButtonItem=UIBarButtonItem(title: "", style: UIBarButtonItemStyle.Plain, target: nil, action: nil)
        //self.navigationController?.navigationBar.backgroundColor=UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        sv.frame=CGRectMake(0, 0, self.view.frame.width, self.view.frame.width/5*2+60)
        pg.frame=CGRectMake((self.view.frame.width-40)/2, 40+self.view.frame.width/5*2, 40, 5)
        var image = UIImage(named: "login_bg.jpg")!
        for i in 1...3{
            if i==2 {
                image = UIImage(named: "login.jpg")!
            }else if i==3 {
                image=UIImage(named: "loadscreen.jpeg")!
            }
            let x = CGFloat(i - 1) * self.view.frame.width
            let imageView = UIImageView(frame: CGRectMake(x, 0, self.view.frame.width, 210))
            imageView.image = image
            sv.pagingEnabled = true
            sv.showsHorizontalScrollIndicator = false
            sv.scrollEnabled = true
            sv.addSubview(imageView)
            sv.delegate = self
        }
        sv.contentSize = CGSizeMake((self.view.frame.width * 3), 210)
        //sv.setContentOffset(CGPointMake(0, 0), animated: true)
        pg.numberOfPages = 3
        pg.currentPageIndicatorTintColor = UIColor.redColor()
        pg.pageIndicatorTintColor = UIColor.whiteColor()
        addTimer()
        //print(sv.frame.height)
        
        //一元夺宝按钮
        let yiyuan=UIButton(frame:CGRectMake(-2, sv.frame.height-3, self.view.frame.width/3+2, self.view.frame.width/3+4))
        let yiyuanico=UIImageView(frame: CGRectMake(self.view.frame.width/8, sv.frame.height+3+self.view.frame.width/12, self.view.frame.width/12, self.view.frame.width/12))
        yiyuan.layer.borderWidth=CGFloat(1.0)
        yiyuan.layer.borderColor=UIColor(red: 186/255, green: 186/255, blue: 186/255, alpha: 0.73).CGColor
        yiyuanico.image=UIImage(named: "一元夺宝图标.png")
        yiyuanico.contentMode=UIViewContentMode.ScaleAspectFill
        let yiyuanlabel=UILabel(frame: CGRectMake(self.view.frame.width/12, sv.frame.height+3+self.view.frame.width/24*5, self.view.frame.width/6, self.view.frame.width/24))
        yiyuanlabel.text="一元夺宝"
        yiyuanlabel.adjustsFontSizeToFitWidth=true
        yiyuanlabel.textColor=UIColor(red: 111/255, green: 111/255, blue: 111/255, alpha: 0.44)
        yiyuan.tag=1
        yiyuan.addTarget(self, action:Selector("ButtonAction:"), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(yiyuan)
        self.view.addSubview(yiyuanico)
        self.view.addSubview(yiyuanlabel)
        //抢红包
        let qiang=UIButton(frame:CGRectMake(self.view.frame.width/3-1, sv.frame.height-3, self.view.frame.width/3+1, self.view.frame.width/3+4))
        let qiangico=UIImageView(frame: CGRectMake(self.view.frame.width/24*11, sv.frame.height+3+self.view.frame.width/12, self.view.frame.width/12, self.view.frame.width/12))
        qiang.layer.borderWidth=CGFloat(1.0)
        qiang.layer.borderColor=UIColor(red: 186/255, green: 186/255, blue: 186/255, alpha: 0.73).CGColor
        qiangico.image=UIImage(named: "抢红包图标.png")
        qiangico.contentMode=UIViewContentMode.ScaleAspectFill
        let qianglabel=UILabel(frame: CGRectMake(self.view.frame.width/9*4, sv.frame.height+3+self.view.frame.width/24*5, self.view.frame.width/9, self.view.frame.width/24))
        qianglabel.text="抢红包"
        qianglabel.adjustsFontSizeToFitWidth=true
        qianglabel.textColor=UIColor(red: 111/255, green: 111/255, blue: 111/255, alpha: 0.44)
        qiang.tag=2
        qiang.addTarget(self, action:Selector("ButtonAction:"), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(qiang)
        self.view.addSubview(qiangico)
        self.view.addSubview(qianglabel)
        //附近
        let near=UIButton(frame:CGRectMake(self.view.frame.width/3*2-1, sv.frame.height-3, self.view.frame.width/3+1, self.view.frame.width/3+4))
        let nearico=UIImageView(frame: CGRectMake(self.view.frame.width/24*19, sv.frame.height+3+self.view.frame.width/12, self.view.frame.width/12, self.view.frame.width/12))
        near.layer.borderWidth=CGFloat(1.0)
        near.layer.borderColor=UIColor(red: 186/255, green: 186/255, blue: 186/255, alpha: 0.73).CGColor
        nearico.image=UIImage(named: "附近图标.png")
        nearico.contentMode=UIViewContentMode.ScaleAspectFill
        let nearlabel=UILabel(frame: CGRectMake(self.view.frame.width/24*19, sv.frame.height+3+self.view.frame.width/24*5, self.view.frame.width/12, self.view.frame.width/24))
        nearlabel.text="附近"
        nearlabel.adjustsFontSizeToFitWidth=true
        nearlabel.textColor=UIColor(red: 111/255, green: 111/255, blue: 111/255, alpha: 0.44)
        near.tag=3
        near.addTarget(self, action: Selector("ButtonAction:"), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(near)
        self.view.addSubview(nearico)
        self.view.addSubview(nearlabel)

        //聊吧
        let xunren=UIButton(frame:CGRectMake(-2, sv.frame.height+self.view.frame.width/3, self.view.frame.width/3+2, self.view.frame.width/3))
        xunren.tag=4
        xunren.addTarget(self, action: Selector("ButtonAction:"), forControlEvents: UIControlEvents.TouchUpInside)
        let xunrenico=UIImageView(frame: CGRectMake(self.view.frame.width/8, sv.frame.height+3+self.view.frame.width/12*5, self.view.frame.width/12, self.view.frame.width/12))
        xunren.layer.borderWidth=CGFloat(1.0)
        xunren.layer.borderColor=UIColor(red: 186/255, green: 186/255, blue: 186/255, alpha: 0.73).CGColor
        xunrenico.image=UIImage(named: "聊吧图标.png")
        xunrenico.contentMode=UIViewContentMode.ScaleAspectFill
        let xunrenlabel=UILabel(frame: CGRectMake(self.view.frame.width/15*2, sv.frame.height+3+self.view.frame.width/48*25, self.view.frame.width/12, self.view.frame.width/24))
        xunrenlabel.text="聊吧"
        xunrenlabel.adjustsFontSizeToFitWidth=true
        xunrenlabel.textColor=UIColor(red: 111/255, green: 111/255, blue: 111/255, alpha: 0.44)
        let zhushilabel=UILabel(frame: CGRectMake(self.view.frame.width/30, sv.frame.height+3+self.view.frame.width/36*21, self.view.frame.width/15*4, self.view.frame.width/24))
        zhushilabel.text="寻找曾经的小伙伴"
        zhushilabel.adjustsFontSizeToFitWidth=true
        zhushilabel.textColor=UIColor(red: 186/255, green: 186/255, blue: 186/255, alpha: 0.73)
        //yiyuan.addTarget(self, action:Selector("OneCharge"), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(xunren)
        self.view.addSubview(xunrenico)
        self.view.addSubview(xunrenlabel)
        self.view.addSubview(zhushilabel)
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        self.view.addSubview(sv)
        self.view.addSubview(pg)
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    func ButtonAction(sender:UIButton){
        let num=sender.tag
        let myStoryBoard = UIStoryboard(name: "Main", bundle: nil)
        switch num {
        case 1:
            let anotherView:UIViewController=myStoryBoard.instantiateViewControllerWithIdentifier("OneCharge");
            self.navigationController?.pushViewController(anotherView, animated: true)
        case 2:
            let anotherView:UIViewController=myStoryBoard.instantiateViewControllerWithIdentifier("GrabRed");
            //self.hidesBottomBarWhenPushed=true
            self.navigationController?.pushViewController(anotherView, animated: true)
        case 3:
            let anotherView:UIViewController=myStoryBoard.instantiateViewControllerWithIdentifier("Near");
            self.navigationController?.pushViewController(anotherView, animated: true)
        case 4:
            let anotherView:UIViewController=myStoryBoard.instantiateViewControllerWithIdentifier("Chat");
            self.navigationController?.pushViewController(anotherView, animated: true)
        default:
            break
        }
    }
//    func OneCharge(){
//        let myStoryBoard = self.storyboard
//        let anotherView:UIViewController=myStoryBoard!.instantiateViewControllerWithIdentifier("OneCharge");
//        self.navigationController?.pushViewController(anotherView, animated: true)
//    }
//    func GrabRed(){
//        let myStoryBoard = self.storyboard
//        let anotherView:UIViewController=myStoryBoard!.instantiateViewControllerWithIdentifier("GrabRed");
//        //self.hidesBottomBarWhenPushed=true
//        self.navigationController?.pushViewController(anotherView, animated: true)
//    }
//    func Near(){
//        let myStoryBoard = self.storyboard
//        let anotherView:UIViewController=myStoryBoard!.instantiateViewControllerWithIdentifier("Near");
//        self.navigationController?.pushViewController(anotherView, animated: true)
//    }
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let width = self.view.frame.width
        let offsetX = scrollView.contentOffset.x
        let index = (offsetX + width / 2) / width
        pg.currentPage = Int(index)
    }
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        removeTimer()
    }
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
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
        if pageIndex == 2 {
            pageIndex = 0
        } else {
            pageIndex++
        }
       let offsetX = CGFloat(pageIndex) * self.view.frame.width
       sv.setContentOffset(CGPointMake(offsetX, 0), animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
