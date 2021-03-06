//
//  ShippingAddressAdd.swift
//  AllianceIOS
//
//  Created by dawei on 15/11/8.
//
//

import UIKit
import SwiftHTTP
import JSONJoy

class ShippingAddressAdd: UITableViewController {

    var TitleName=["姓名","电话号码","邮政编码","省份","城市","地区","详细地址"]
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
        self.navigationItem.rightBarButtonItem=UIBarButtonItem(title:"保存", style: UIBarButtonItemStyle.Plain, target: self, action: Selector("Save"))
        self.navigationItem.rightBarButtonItem?.tintColor=UIColor(red: 220/255, green: 100/255, blue: 100/255, alpha: 1.0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 7
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
        return 150
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell=UITableViewCell()
        let content=UITextField(frame: CGRectMake(20,0,self.view.frame.width-40,50))
        content.placeholder=TitleName[indexPath.row]
        content.font=UIFont.systemFontOfSize(15)
        content.tag=indexPath.row+1000
        cell.addSubview(content)
        
        return cell
    }
    func Save(){
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)){
            do {
                let name=self.view.viewWithTag(1000) as! UITextField
                let phone=self.view.viewWithTag(1001) as! UITextField
                let postcode=self.view.viewWithTag(1002) as! UITextField
                let sheng=self.view.viewWithTag(1003) as! UITextField
                let shi=self.view.viewWithTag(1004) as! UITextField
                let qu=self.view.viewWithTag(1005) as! UITextField
                let dizhi=self.view.viewWithTag(1006) as! UITextField
                let xiangxidizhi=sheng.text!+" "+shi.text!+" "+qu.text!+" "+dizhi.text!
                let params:Dictionary<String,AnyObject>=["phone":Phone,"aphone":phone.text!,"name":name.text!,"isdefault":0,"postcode":postcode.text!,"address":xiangxidizhi]
                let new=try HTTP.POST(URL+"/users/createaddress", parameters: params)
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
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
}
