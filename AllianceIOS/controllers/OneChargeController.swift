//
//  OneCHargeController.swift
//  AllianceIOS
//
//  Created by dawei on 15/10/17.
//
//

import UIKit

class OneChargeController: UITableViewController{
    
    @IBOutlet weak var firstcell: UIView!
    @IBOutlet weak var tenchargecell: UIView!
    @IBOutlet weak var newestcell: UIView!
    
    @IBOutlet weak var onecharge: UITableViewCell!
    @IBOutlet weak var onechargecell: UIView!
    
    var tenchargeSv=UIScrollView()
    var NewestSv=UIScrollView()
    override func viewDidLoad() {
        super.viewDidLoad()
        let tencharge=UIButton(frame:CGRectMake(0, 0, self.view.frame.width/4, 100))
        let onecharge=UIButton(frame:CGRectMake(self.view.frame.width/4, 0, self.view.frame.width/4, 100))
        let chargerecord=UIButton(frame:CGRectMake(self.view.frame.width/4*2, 0, self.view.frame.width/4, 100))
        let problem=UIButton(frame:CGRectMake(self.view.frame.width/4*3, 0, self.view.frame.width/4, 100))
        //yiyuan.backgroundColor=UIColor.blueColor()
        //yiyuan.setTitle("一元夺宝", forState:UIControlState.Normal)
        tencharge.setBackgroundImage(UIImage(named: "tencharge.png"), forState: UIControlState.Normal)
        onecharge.setBackgroundImage(UIImage(named: "onecharge.png"), forState: UIControlState.Normal)
        chargerecord.setBackgroundImage(UIImage(named: "chargerecord.png"), forState: UIControlState.Normal)
        problem.setBackgroundImage(UIImage(named: "problem.png"), forState: UIControlState.Normal)
        firstcell.addSubview(tencharge)
        firstcell.addSubview(onecharge)
        firstcell.addSubview(chargerecord)
        firstcell.addSubview(problem)
        initTenCharge()
        initNewest()
        initOnecharge()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    func initTenCharge(){
        tenchargeSv.frame=CGRectMake(tenchargecell.frame.minX, tenchargecell.frame.minY,self.view.frame.width, 120)
        tenchargeSv.contentSize=CGSizeMake(600, 120)
        tenchargeSv.pagingEnabled=true
        tenchargeSv.showsHorizontalScrollIndicator=false
        tenchargeSv.scrollEnabled=true
        tenchargeSv.delegate=self
        tenchargecell.addSubview(tenchargeSv)
        for i in 0...5{
            let cellview=UIView(frame: CGRectMake(CGFloat(Float(i*100)), tenchargecell.frame.minY, 100, 120))
            let pic=UIImageView(frame: CGRectMake(22.5,tenchargecell.frame.minY+10, 55, 55))
            pic.image=UIImage(named: "tenchargepic.png")
            let money=UILabel(frame: CGRectMake(25, tenchargecell.frame.minY+65, 50, 20))
            money.text=String(i*100)+"金币"
            money.adjustsFontSizeToFitWidth=true
            let process=UILabel(frame: CGRectMake(15, tenchargecell.frame.minY+85, 70, 15))
            
            process.adjustsFontSizeToFitWidth=true
            let progress=UIProgressView(frame: CGRectMake(15, 105, 70, 10))
            progress.progress=Float(Int(arc4random())%101)/100.0
            progress.progressTintColor=UIColor(red: 0.0/255, green: 200/255, blue: 240/255, alpha: 1.0)
            progress.transform=CGAffineTransformMakeScale(1.0, 3.0)
            
            process.text="开奖进度 "+String(Int(progress.progress*100))+"%"
            tenchargeSv.addSubview(cellview)
            cellview.addSubview(pic)
            cellview.addSubview(money)
            cellview.addSubview(process)
            cellview.addSubview(progress)
            
        }
    }
    func initNewest(){
        NewestSv.frame=CGRectMake(newestcell.frame.minX, newestcell.frame.minY,self.view.frame.width, 120)
        NewestSv.contentSize=CGSizeMake(600, 120)
        NewestSv.pagingEnabled=true
        NewestSv.showsHorizontalScrollIndicator=false
        NewestSv.scrollEnabled=true
        NewestSv.delegate=self
        newestcell.addSubview(NewestSv)
        for i in 0...5{
            let cellview=UIView(frame: CGRectMake(CGFloat(Float(i*100)), newestcell.frame.minY, 100, 120))
            let pic=UIImageView(frame: CGRectMake(20,newestcell.frame.minY+20, 60, 60))
            pic.image=UIImage(named: "tenchargepic.png")
            let time=UILabel(frame: CGRectMake(15, newestcell.frame.minY+85, 70, 30))
            time.text="倒计时02:04:60"
            time.adjustsFontSizeToFitWidth=true
            NewestSv.addSubview(cellview)
            cellview.addSubview(pic)
            cellview.addSubview(time)

            
        }

    }
    func initOnecharge(){
        let halfwidth=Float(self.view.frame.width)/2
        for i in 0...5{
            let cellview=UIView(frame: CGRectMake(CGFloat(Float(i%2)*halfwidth), CGFloat(Float(i/2)*halfwidth), CGFloat(halfwidth), CGFloat(halfwidth)))
            let pic=UIImageView(frame: CGRectMake(CGFloat(halfwidth/3),20, CGFloat(halfwidth/3), CGFloat(halfwidth/3)))
            pic.image=UIImage(named: "tenchargepic.png")
            let name=UILabel(frame: CGRectMake(15, CGFloat(halfwidth/3)+20, CGFloat(halfwidth)-30, 30))
            name.text="(第44期)永久折叠单车"
            name.adjustsFontSizeToFitWidth=true
            let total=UILabel(frame: CGRectMake(15, CGFloat(halfwidth/3)+50, CGFloat(halfwidth)-30, 20))
            total.text="总需：60人次         "
            total.adjustsFontSizeToFitWidth=true
            let progress=UIProgressView(frame: CGRectMake(15, CGFloat(halfwidth/3)+75, CGFloat(halfwidth)-30, 10))
            progress.progress=Float(Int(arc4random())%101)/100.0
            progress.progressTintColor=UIColor(red: 0.0/255, green: 200/255, blue: 240/255, alpha: 1.0)
            progress.transform=CGAffineTransformMakeScale(1.0, 3.0)
            let process=UILabel(frame: CGRectMake(15, CGFloat(halfwidth/3)+90, CGFloat(halfwidth)-30, 20))
            process.adjustsFontSizeToFitWidth=true
            process.text="开奖进度 "+String(Int(progress.progress*100))+"%       "
            onechargecell.addSubview(cellview)
            cellview.addSubview(pic)
            cellview.addSubview(name)
            cellview.addSubview(total)
            cellview.addSubview(progress)
            cellview.addSubview(process)
            
        }
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