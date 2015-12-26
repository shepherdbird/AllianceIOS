//
//  Signature.swift
//  AllianceIOS
//
//  Created by dawei on 15/12/20.
//
//

import UIKit
import SwiftHTTP
import JSONJoy

class Signature: UITableViewController {

    var Content:String?
    var alert:UIAlertController?
    var text:UITextView!
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
        return 1
    }
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 15
    }
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell=UITableViewCell()
        text=UITextView(frame: CGRectMake(0,0,self.view.frame.width,100))
        text.tag=2
        text.font=UIFont.systemFontOfSize(17)
        text.text=self.Content!
        cell.addSubview(text)
        //        let del=UIButton(frame: CGRectMake(self.view.frame.width-30,15,20,20))
        //        del.addTarget(self, action: Selector("delete"), forControlEvents: UIControlEvents.TouchDragInside)
        //        del.setBackgroundImage(UIImage(named: "delete.png"), forState: UIControlState.Normal)
        //        del.clipsToBounds=true
        //        del.layer.cornerRadius=10
        //        cell.addSubview(del)
        return cell
    }
    func Save(){
        print("修改昵称")
        self.navigationController?.popViewControllerAnimated(true)
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)){
            do {
                let content=self.view.viewWithTag(2) as! UITextView
                let params:Dictionary<String,AnyObject>=["phone":Phone,"signature":content.text!]
                let new=try HTTP.POST(URL+"/users/modify", parameters: params)
                new.start { response in
                    if let err = response.error {
                        print("error: \(err.localizedDescription)")
                        return //also notify app of failure as needed
                    }
                    print("opt finished: \(response.description)")
                    self.Fg = Flag(JSONDecoder(response.data))
                    RefreshPerson=1
                    RefreshAboutMe=1
                    
                }
                
            } catch let error {
                print("got an error creating the request: \(error)")
            }
        }
    }

}
