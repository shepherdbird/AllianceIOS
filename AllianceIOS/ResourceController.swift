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
        
        sv.frame=CGRectMake(0, 60, self.view.frame.width, 210)
        pg.frame=CGRectMake((self.view.frame.width-40)/2, 250, 40, 5)
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
        print(sv.frame.height)
        let yiyuan=UIButton(frame:CGRectMake(0, sv.frame.height+63, self.view.frame.width/3, 100))
        let qiang=UIButton(frame:CGRectMake(self.view.frame.width/3, sv.frame.height+63, self.view.frame.width/3, 100))
        let near=UIButton(frame:CGRectMake(self.view.frame.width/3*2, sv.frame.height+63, self.view.frame.width/3, 100))
        //yiyuan.backgroundColor=UIColor.blueColor()
        //yiyuan.setTitle("一元夺宝", forState:UIControlState.Normal)
        yiyuan.setBackgroundImage(UIImage(named: "yiyuan.png"), forState: UIControlState.Normal)
        qiang.setBackgroundImage(UIImage(named: "qiang.png"), forState: UIControlState.Normal)
        near.setBackgroundImage(UIImage(named: "near.png"), forState: UIControlState.Normal)
        //qiang.backgroundColor=UIColor.brownColor()
        //qiang.setTitle("抢红包", forState:UIControlState.Normal)
        //near.backgroundColor=UIColor.darkGrayColor()
        //near.setTitle("附近", forState:UIControlState.Normal)
        self.view.addSubview(sv)
        self.view.addSubview(pg)
        self.view.addSubview(yiyuan)
        self.view.addSubview(qiang)
        self.view.addSubview(near)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
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
