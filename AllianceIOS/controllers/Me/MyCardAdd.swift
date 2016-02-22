//
//  MyCardAdd.swift
//  AllianceIOS
//
//  Created by dawei on 16/1/16.
//
//

import UIKit
import SwiftHTTP
import JSONJoy

class MyCardAdd: UITableViewController ,UITextFieldDelegate{
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
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 3
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(section==0){
            return 2
        }else if(section==1){
            return 4
        }
        return 1
    }
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if(section==2){
            return 200
        }
        return 10
    }
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if(section==2){
            return 10
        }
        return 40
    }
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if(section==0){
            return "此银行卡可用于快捷支付和提现"
        }else if(section==1){
            return "请填写银行预留信息"
        }
        return ""
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell=UITableViewCell()
        switch indexPath.section {
        case 0:
            if(indexPath.row==0){
                let content=UITextField(frame: CGRectMake(10,0,self.view.frame.width-40,50))
                content.placeholder="银行名称"
                content.font=UIFont.systemFontOfSize(15)
                content.tag=3001
                cell.addSubview(content)
            }else{
                let content=UITextField(frame: CGRectMake(10,0,self.view.frame.width-40,50))
                content.placeholder="银行卡号"
                content.font=UIFont.systemFontOfSize(15)
                content.tag=3002
                cell.addSubview(content)
            }
        case 1:
            if(indexPath.row==0){
                let content=UITextField(frame: CGRectMake(10,0,self.view.frame.width-40,50))
                content.placeholder="姓名"
                content.font=UIFont.systemFontOfSize(15)
                content.tag=3003
                cell.addSubview(content)
            }else if(indexPath.row==1){
                let content=UITextField(frame: CGRectMake(10,0,self.view.frame.width-40,50))
                content.placeholder="身份证号"
                content.font=UIFont.systemFontOfSize(15)
                content.tag=3004
                cell.addSubview(content)
            }else if(indexPath.row==2){
                let content=UITextField(frame: CGRectMake(10,0,self.view.frame.width-40,50))
                content.placeholder="预留手机号"
                content.font=UIFont.systemFontOfSize(15)
                content.tag=1005
                cell.addSubview(content)
            }else{
                let content=UITextField(frame: CGRectMake(10,0,self.view.frame.width-40,50))
                content.placeholder="开户地"
                content.font=UIFont.systemFontOfSize(15)
                content.tag=3006
                cell.addSubview(content)
            }
        default:
            let next=UIButton(frame: CGRectMake(20,5,self.view.frame.width-40,40))
            next.setTitle("下一步", forState: UIControlState.Normal)
            next.titleLabel?.font=UIFont.systemFontOfSize(17)
            next.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
            next.addTarget(self, action: Selector("Save"), forControlEvents: UIControlEvents.TouchUpInside)
            next.setBackgroundImage(UIImage(named: "安全退出按钮.png"), forState: UIControlState.Normal)
            cell.addSubview(next)
        }
        return cell
    }
    func Save(){
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)){
            do {
                let bankname=self.view.viewWithTag(3001) as! UITextField
                let cardnumber=self.view.viewWithTag(3002) as! UITextField
                let name=self.view.viewWithTag(3003) as! UITextField
                let idcard=self.view.viewWithTag(3004) as! UITextField
                let phone=self.view.viewWithTag(3005) as! UITextField
                let location=self.view.viewWithTag(3006) as! UITextField
                if(bankname.text==nil || cardnumber.text==nil || name.text==nil || idcard.text==nil || phone.text==nil || location.text==nil){
                    return
                    
                }
                let params:Dictionary<String,AnyObject>=["phone":Phone,"cardnumber":cardnumber.text!,"name":name.text!,"idcard":idcard.text!,"lphone":phone.text!,"location":location.text!]
                let new=try HTTP.POST(URL+"/usertocards/create", parameters: params)
                new.start { response in
                    if let err = response.error {
                        print("error: \(err.localizedDescription)")
                        return //also notify app of failure as needed
                    }
                    print("opt finished: \(response.description)")
                    self.Fg = Flag(JSONDecoder(response.data))
                    RefreshCard=1
                }
                
            } catch let error {
                print("got an error creating the request: \(error)")
            }
        }
    }

}
