//
//  ShippingAddressDetail.swift
//  AllianceIOS
//
//  Created by dawei on 15/11/8.
//
//

import UIKit
import SwiftHTTP
import JSONJoy

class ShippingAddressDetail: UITableViewController {

    var TitleName=["姓名","电话号码","邮政编码","省份","城市","地区","详细地址"]
    var address:AddressOne?
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
        self.navigationItem.backBarButtonItem=UIBarButtonItem(title: "", style: UIBarButtonItemStyle.Plain, target: nil, action: nil)
        //self.navigationItem.rightBarButtonItem=UIBarButtonItem(title:"保存", style: UIBarButtonItemStyle.Plain, target: self, action: Selector("Save"))
        self.navigationItem.rightBarButtonItem?.tintColor=UIColor(red: 220/255, green: 100/255, blue: 100/255, alpha: 1.0)
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
        if(section==0){
            return 7
        }
        return 1
    }
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if(indexPath.row==6){
            return 120
        }
        return 50
    }
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if(section==2){
            return 150
        }
        return 0.01
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell=UITableViewCell()
        if(indexPath.section==0){
        let dizhi=self.address!.address.componentsSeparatedByString(" ")
        let title=UILabel(frame: CGRectMake(15,15,100,20))
        title.textColor=UIColor(red: 111/255, green: 111/255, blue: 111/255, alpha: 1.0)
        title.text=TitleName[indexPath.row]
        title.font=UIFont.systemFontOfSize(15)
        cell.addSubview(title)
        let content=UITextField(frame: CGRectMake(130,0,self.view.frame.width-150,50))
            switch indexPath.row {
            case 0:
                content.text=self.address!.name
            case 1:
                content.text=self.address!.aphone
            case 2:
                content.text=self.address!.postcode
            case 3:
                if(dizhi.count>=1){
                    content.text=dizhi[0]
                }
            case 4:
                if(dizhi.count>=2){
                    content.text=dizhi[1]
                }
            case 5:
                if(dizhi.count>=3){
                    content.text=dizhi[2]
                }
            default:
                if(dizhi.count>=4){
                    content.text=dizhi[3]
                }
            }
        cell.addSubview(content)
        }else if(indexPath.section==1){
            let delete=UIButton(frame: CGRectMake(20,5,self.view.frame.width-40,40))
            delete.setTitle("删除该收货地址", forState: UIControlState.Normal)
            delete.addTarget(self, action: Selector("Action:"), forControlEvents: UIControlEvents.TouchUpInside)
            delete.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
            delete.tag=1
            delete.setBackgroundImage(UIImage(named: "安全退出按钮.png"), forState: UIControlState.Normal)
            cell.addSubview(delete)
        }else{
            let delete=UIButton(frame: CGRectMake(20,5,self.view.frame.width-40,40))
            delete.setTitle("设为默认收货地址", forState: UIControlState.Normal)
            delete.tag=2
            delete.addTarget(self, action: Selector("Action:"), forControlEvents: UIControlEvents.TouchUpInside)
            delete.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
            delete.setBackgroundImage(UIImage(named: "安全退出按钮.png"), forState: UIControlState.Normal)
            cell.addSubview(delete)
        }
        return cell
    }
    func Action(sender:UIButton){
        if(sender.tag==1){
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)){
                do {
                    let params:Dictionary<String,AnyObject>=["phone":Phone,"addressid":self.address!.id]
                    let new=try HTTP.POST(URL+"/users/deleteaddress", parameters: params)
                    new.start { response in
                        if let err = response.error {
                            print("error: \(err.localizedDescription)")
                            return //also notify app of failure as needed
                        }
                        print("opt finished: \(response.description)")
                        self.Fg = Flag(JSONDecoder(response.data))
                        RefreshAddress=1
                    }
                    
                } catch let error {
                    print("got an error creating the request: \(error)")
                }
            }
        }else if(sender.tag==2){
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)){
                do {
                    let params:Dictionary<String,AnyObject>=["phone":Phone,"addressid":self.address!.id]
                    let new=try HTTP.POST(URL+"/users/setdefaultaddress", parameters: params)
                    new.start { response in
                        if let err = response.error {
                            print("error: \(err.localizedDescription)")
                            return //also notify app of failure as needed
                        }
                        print("opt finished: \(response.description)")
                        self.Fg = Flag(JSONDecoder(response.data))
                        RefreshAddress=1
                    }
                    
                } catch let error {
                    print("got an error creating the request: \(error)")
                }
            }
        }
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    func Save(){
        self.navigationController?.popViewControllerAnimated(true)
    }

}
