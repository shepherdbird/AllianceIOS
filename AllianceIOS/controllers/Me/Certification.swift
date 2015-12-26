//
//  Certification.swift
//  AllianceIOS
//
//  Created by dawei on 15/11/8.
//
//

import UIKit
import SwiftHTTP
import JSONJoy

class Certification: UITableViewController {

    var Status:Int?
    var alert:UIAlertController?
    var Fg:Flag?
        {
        didSet{
            let reqAction=UIAlertAction(title: "确定", style: UIAlertActionStyle.Default) { (action:UIAlertAction) -> Void in
                self.navigationController?.popViewControllerAnimated(true)
                //self.RefreshData()
            }
            alert=UIAlertController(title: "", message: Fg?.msg, preferredStyle: UIAlertControllerStyle.Alert)
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
        return 2
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 2
    }
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell=UITableViewCell()
        if(indexPath.section==0){
            if(indexPath.row==0){
                let nameInput=UITextField(frame: CGRectMake(10,0,self.view.frame.width-20,50))
                nameInput.font=UIFont.systemFontOfSize(15)
                nameInput.placeholder="姓名"
                nameInput.tag=1
                cell.addSubview(nameInput)
            }else{
                let nameInput=UITextField(frame: CGRectMake(10,0,self.view.frame.width-20,50))
                nameInput.font=UIFont.systemFontOfSize(15)
                nameInput.placeholder="身份证号码"
                nameInput.tag=2
                cell.addSubview(nameInput)
            }
        }else{
            if(indexPath.row==0){
            let reminder=UILabel(frame: CGRectMake(10,15,250,20))
            reminder.text="一经绑定不得修改"
            reminder.font=UIFont.systemFontOfSize(15)
            reminder.textColor=UIColor(red: 111/255, green: 111/255, blue: 111/255, alpha: 1.0)
            cell.addSubview(reminder)
            }else{
                let BangDing=UIButton(frame: CGRectMake(20,5,self.view.frame.width-40,40))
                BangDing.setBackgroundImage(UIImage(named: "安全退出按钮.png"), forState: UIControlState.Normal)
                BangDing.setTitle("绑定", forState: UIControlState.Normal)
                BangDing.addTarget(self, action: Selector("Bang"), forControlEvents: UIControlEvents.TouchUpInside)
                BangDing.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
                BangDing.titleLabel?.font=UIFont.systemFontOfSize(18)
                if(self.Status==1){
                    BangDing.setTitle("正在认证中...", forState: UIControlState.Normal)
                    BangDing.enabled=false
                }
                cell.addSubview(BangDing)
            }
        }
        return cell
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    func Bang(){
        print("实名认证")
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)){
            do {
                let name=self.view.viewWithTag(1) as! UITextField
                let number=self.view.viewWithTag(2) as! UITextField
                let params:Dictionary<String,AnyObject>=["phone":Phone,"realname":name.text!,"idcard":number.text!]
                let new=try HTTP.POST(URL+"/users/realauth", parameters: params)
                new.start { response in
                    if let err = response.error {
                        print("error: \(err.localizedDescription)")
                        return //also notify app of failure as needed
                    }
                    print("opt finished: \(response.description)")
                    self.Fg = Flag(JSONDecoder(response.data))
                    
                }
                
            } catch let error {
                print("got an error creating the request: \(error)")
            }
        }
    }

}
