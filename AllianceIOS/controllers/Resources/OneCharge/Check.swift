//
//  Check.swift
//  AllianceIOS
//
//  Created by dawei on 15/11/28.
//
//

import UIKit
import SwiftHTTP
import JSONJoy

class Check: UITableViewController {

    var Count:Int=0
    var Id:Int=0
    var SetTitle:String=""
    var Select=1
    var All=0
    var Through="corn"
    var alert:UIAlertController?
    var Fg:Flag?
        {
        didSet{
            let reqAction=UIAlertAction(title: "确定", style: UIAlertActionStyle.Default) { (action:UIAlertAction) -> Void in
                self.navigationController?.popViewControllerAnimated(true)
            }
            alert=UIAlertController(title: "购买成功", message: Fg?.msg, preferredStyle: UIAlertControllerStyle.Alert)
            if(Fg?.flag==0){
                alert?.title="购买失败"
            }
            alert!.addAction(reqAction)
            self.presentViewController(alert!, animated: true, completion: nil)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView=UITableView(frame: self.view.frame, style: UITableViewStyle.Grouped)
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
        return 3
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if(section==1){
            return 5
        }
        return 1
    }
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.1
    }
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if(indexPath.section==1){
            Select=indexPath.row
            self.tableView.reloadData()
        }
    }
    func OK(){
        do {
            if(Through=="corn"){
                var params:Dictionary<String,AnyObject>=["grabcornid":Id,"phone":Phone,"count":Count,"type":Select-1]
                var opt=try HTTP.POST(URL+"/grabcorns/buy", parameters: params)
                if(All==1){
                    params=["grabcornid":Id,"phone":Phone,"type":Select-1]
                    opt=try HTTP.POST(URL+"/grabcorns/buyall", parameters: params)
                }
                opt.start { response in
                    if let err = response.error {
                        print("error: \(err.localizedDescription)")
                        return //also notify app of failure as needed
                    }
                    print("opt finished: \(response.description)")
                    self.Fg = Flag(JSONDecoder(response.data))
                    //print(self.TenCharge!._meta.totalCount)
                }
            }else{
                var params:Dictionary<String,AnyObject>=["grabcommodityid":Id,"phone":Phone,"count":Count,"type":Select-1]
                var opt=try HTTP.POST(URL+"/grabcommodities/buy", parameters: params)
                if(All==1){
                    params=["grabcommodityid":Id,"phone":Phone,"type":Select-1]
                    opt=try HTTP.POST(URL+"/grabcommodities/buyall", parameters: params)
                }
                opt.start { response in
                    if let err = response.error {
                        print("error: \(err.localizedDescription)")
                        return //also notify app of failure as needed
                    }
                    print("opt finished: \(response.description)")
                    self.Fg = Flag(JSONDecoder(response.data))
                    //print(self.TenCharge!._meta.totalCount)
                }
            }
            
        } catch let error {
            print("got an error creating the request: \(error)")
        }
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell=UITableViewCell()
        if(indexPath.section==0){
            let title=UILabel(frame: CGRectMake(20,10,self.view.frame.width-100,30))
            title.text=SetTitle
            title.font=UIFont.systemFontOfSize(18)
            title.textColor=UIColor(red: 186/255, green: 186/255, blue: 186/255, alpha: 1.0)
            cell.addSubview(title)
            let count=UILabel(frame: CGRectMake(self.view.frame.width-100,10,90,30))
            count.text=String(Count)+"人次"
            count.font=UIFont.systemFontOfSize(18)
            count.textColor=UIColor(red: 220/255, green: 50/255, blue: 50/255, alpha: 1.0)
            cell.addSubview(count)
        }else if(indexPath.section==2){
            let Confirm=UIButton(frame: CGRectMake(20,5,self.view.frame.width-40,40))
            Confirm.backgroundColor=UIColor(red: 220/255, green: 50/255, blue: 50/255, alpha: 1.0)
            Confirm.setTitle("确认支付", forState: UIControlState.Normal)
            Confirm.titleLabel?.font=UIFont.systemFontOfSize(18)
            Confirm.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
            Confirm.addTarget(self, action: Selector("OK"), forControlEvents: UIControlEvents.TouchUpInside)
            Confirm.clipsToBounds=true
            Confirm.layer.cornerRadius=5
            cell.addSubview(Confirm)
        }else{
            switch indexPath.row {
            case 0:
                let title=UILabel(frame: CGRectMake(20,10,self.view.frame.width-100,30))
                title.text="奖品合计"
                title.font=UIFont.systemFontOfSize(18)
                cell.addSubview(title)
                let count=UILabel(frame: CGRectMake(self.view.frame.width-100,10,90,30))
                count.text=String(Count)+".00元"
                count.font=UIFont.systemFontOfSize(18)
                count.textColor=UIColor(red: 220/255, green: 50/255, blue: 50/255, alpha: 1.0)
                cell.addSubview(count)
            case 1:
                let title=UILabel(frame: CGRectMake(20,10,self.view.frame.width-100,30))
                title.text="余额支付（余额：100.00元）"
                title.font=UIFont.systemFontOfSize(15)
                cell.addSubview(title)
                let select=UIImageView(frame: CGRectMake(self.view.frame.width-40, 15, 20, 20))
                select.clipsToBounds=true
                select.layer.cornerRadius=10
                select.image=UIImage(named: "结算选择框.png")
                if(Select==1){
                    select.image=UIImage(named: "结算选择框2.png")
                }
                cell.addSubview(select)
            case 2:
                let title=UILabel(frame: CGRectMake(20,10,self.view.frame.width-100,30))
                title.text="金币支付（余额：100.00元）"
                title.font=UIFont.systemFontOfSize(15)
                cell.addSubview(title)
                let select=UIImageView(frame: CGRectMake(self.view.frame.width-40, 15, 20, 20))
                select.clipsToBounds=true
                select.layer.cornerRadius=10
                select.image=UIImage(named: "结算选择框.png")
                if(Select==2){
                    select.image=UIImage(named: "结算选择框2.png")
                }
                cell.addSubview(select)
            case 3:
                let title=UILabel(frame: CGRectMake(20,10,self.view.frame.width-100,30))
                title.text="联盟奖励支付（余额：100.00元）"
                title.font=UIFont.systemFontOfSize(15)
                cell.addSubview(title)
                let select=UIImageView(frame: CGRectMake(self.view.frame.width-40, 15, 20, 20))
                select.clipsToBounds=true
                select.layer.cornerRadius=10
                select.image=UIImage(named: "结算选择框.png")
                if(Select==3){
                    select.image=UIImage(named: "结算选择框2.png")
                }
                cell.addSubview(select)
            default:
                let title=UILabel(frame: CGRectMake(20,10,self.view.frame.width-100,30))
                title.text="银行卡支付"
                title.font=UIFont.systemFontOfSize(15)
                cell.addSubview(title)
                let select=UIImageView(frame: CGRectMake(self.view.frame.width-40, 15, 20, 20))
                select.clipsToBounds=true
                select.layer.cornerRadius=10
                select.image=UIImage(named: "结算选择框.png")
                if(Select==4){
                    select.image=UIImage(named: "结算选择框2.png")
                }
                cell.addSubview(select)
            }
            
        }
        return cell
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
