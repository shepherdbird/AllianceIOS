//
//  ChangeGender.swift
//  AllianceIOS
//
//  Created by dawei on 15/11/8.
//
//

import UIKit
import SwiftHTTP
import JSONJoy

class ChangeGender: UITableViewController {

    @IBOutlet var CG: UITableView!
    var SelectBoy:UIImageView!
    var SelectGirl:UIImageView!
    var IsBoy:Int?
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
        self.navigationItem.rightBarButtonItem=UIBarButtonItem(title:"保存", style: UIBarButtonItemStyle.Plain, target: self, action: Selector("Save"))
        self.navigationItem.rightBarButtonItem?.tintColor=UIColor(red: 220/255, green: 100/255, blue: 100/255, alpha: 1.0)
        
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
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 2
    }
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell=UITableViewCell()
        let gender=UILabel(frame: CGRectMake(15,15,20,20))
        if(indexPath.row==0){
            gender.text="男"
            SelectBoy=UIImageView(frame: CGRectMake(self.view.frame.width-40, 15, 17, 17))
            SelectBoy.image=UIImage(named: "勾选按钮.png")
            cell.addSubview(SelectBoy)
            if(self.IsBoy==0){
                SelectBoy.hidden=true
                
            }
        }else{
            gender.text="女"
            SelectGirl=UIImageView(frame: CGRectMake(self.view.frame.width-40, 15, 17, 17))
            SelectGirl.image=UIImage(named: "勾选按钮.png")
            cell.addSubview(SelectGirl)
            if(self.IsBoy==1){
                
                SelectGirl.hidden=true
            }
            
        }
        gender.font=UIFont.systemFontOfSize(15)
        cell.addSubview(gender)
        
        return cell
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
        if(indexPath.row==0){
            SelectBoy.hidden=false
            SelectGirl.hidden=true
            self.IsBoy=1
        }else{
            SelectBoy.hidden=true
            SelectGirl.hidden=false
            self.IsBoy=0
        }
    }
    func Save(){
        //self.navigationController?.popViewControllerAnimated(true)
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)){
            do {
                let params:Dictionary<String,AnyObject>=["phone":Phone,"gender":self.IsBoy!]
                let new=try HTTP.POST(URL+"/users/modify", parameters: params)
                new.start { response in
                    if let err = response.error {
                        print("error: \(err.localizedDescription)")
                        return //also notify app of failure as needed
                    }
                    print("opt finished: \(response.description)")
                    self.Fg = Flag(JSONDecoder(response.data))
                    RefreshAboutMe=1
                    
                }
                
            } catch let error {
                print("got an error creating the request: \(error)")
            }
        }
    }
}
