//
//  JobInfoReqController.swift
//  AllianceIOS
//
//  Created by dawei on 15/11/1.
//
//

import UIKit
import SwiftHTTP
import JSONJoy


class JobInfoReqController: UITableViewController {

    @IBOutlet weak var Jobtitle: UITextField!
    @IBOutlet weak var Prop: UILabel!
    @IBOutlet weak var Degree: UILabel!
    @IBOutlet weak var Workat: UILabel!
    @IBOutlet weak var Status: UITextField!
    @IBOutlet weak var Phone: UITextField!
    @IBOutlet weak var Content: UITextView!
    @IBOutlet weak var Zhiye: UILabel!
    

    
    var pro=["兼职","全职"]
    var deg = ["初中及初中以下", "高中", "大专", "本科", "硕士", "博士"]
    
    var Jobinfo:JobInfoController?
    var activityIndicatorView: UIActivityIndicatorView!
    var allzhiye:Array<String>=[]
    var zhiinfo:JobInfoController.ZhiInfo?
    var Iscreate:Flag? {
      didSet
        {
            print(self.Iscreate?.msg)
            if (self.Iscreate?.flag==1){
                activityIndicatorView.stopAnimating()
                self.activityIndicatorView.hidden=true
                self.tableView.backgroundView=nil
                dispatch_async(dispatch_get_main_queue()){
                    self.Jobinfo?.allflag=0
                    self.navigationController?.popViewControllerAnimated(true)
                }
            }
            
        }
    }
    var alert:UIAlertController?
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.navigationItem.backBarButtonItem=UIBarButtonItem(title: "", style: UIBarButtonItemStyle.Plain, target: nil, action: nil)
        self.navigationItem.rightBarButtonItem=UIBarButtonItem(title:"发表", style: UIBarButtonItemStyle.Plain, target: self, action: Selector("CompletePost"))
        self.navigationItem.rightBarButtonItem?.tintColor=UIColor(red: 220/255, green: 100/255, blue: 100/255, alpha: 1.0)
        
        let tapGr=UITapGestureRecognizer.init(target: self, action: "viewTapped")
        tapGr.cancelsTouchesInView=false
        self.view.addGestureRecognizer(tapGr)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
        if(indexPath.section==1){
            print("性质")
            let anotherView=JobproViewController()
            anotherView.Jobreq=self
            anotherView.flag=0
            anotherView.selected=self.Prop.text
            self.navigationController?.pushViewController(anotherView, animated: true)
        }
        if(indexPath.section==2){
            print("xueli")
            let anotherView=JobdegViewController()
            anotherView.Jobreq=self
            anotherView.selected=self.Degree.text
            self.navigationController?.pushViewController(anotherView, animated: true)
        }
        if(indexPath.section==3){
            let anotherView=UIDatePicker()
            anotherView.datePickerMode=UIDatePickerMode.Date
            
            let reqAction=UIAlertAction(title: "确定", style: UIAlertActionStyle.Default) { (action:UIAlertAction) -> Void in
                let dateform=NSDateFormatter()
                dateform.dateFormat="yyyyMMdd"
                self.Workat.text=dateform.stringFromDate(anotherView.date)
                self.tableView.reloadData()
                print(self.Workat.text)
            }
            alert=UIAlertController(title: "\n\n\n\n\n\n\n\n\n", message: "", preferredStyle: UIAlertControllerStyle.ActionSheet)
            alert!.addAction(reqAction)
            //alert!.addAction(myreqAction)
            
            
            alert?.view.addSubview(anotherView)
            self.presentViewController(alert!, animated: true, completion: nil)
        }
        if(indexPath.section==4){
            let anotherView=JobZhiyViewController()
            anotherView.Jobreq=self
            anotherView.selected=self.Zhiye.text
            anotherView.flag=0
            anotherView.info=self.zhiinfo
            self.navigationController?.pushViewController(anotherView, animated: true)
        }
        
    }
    
    
    
    func viewTapped(){
        self.view.endEditing(true)
    }
    
    func CompletePost(){
        let view1=UIView(frame: CGRectMake(0, 0, self.tableView.frame.size.width, self.tableView.frame.size.height))
        view1.backgroundColor=UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0)
        
        
        activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.White)
        
        activityIndicatorView.frame = CGRectMake(self.tableView.frame.size.width/2-100, -30, 200, 200)
        
        activityIndicatorView.hidesWhenStopped = true
        
        activityIndicatorView.color = UIColor.blackColor()
        view1.addSubview(activityIndicatorView)
        self.tableView.addSubview(view1)
        activityIndicatorView.startAnimating()
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)){
            self.connect()
        }
        
        print("发表求职成功")
    }
    func connect(){
        let pa_pro:Int=self.pro.indexOf(self.Prop.text!)!
        let pa_deg:Int=self.deg.indexOf(self.Degree.text!)!
        var pa_zhi=Int()
        
        for(var i=0;i<self.zhiinfo?.items.count;i++){
            if(self.zhiinfo?.items[i].profession==self.Zhiye.text){
                pa_zhi=(self.zhiinfo?.items[i].objID)!
                break
            }
        }
        
        
        do {
           let params:Dictionary<String,AnyObject>=["phone":"1","jobproperty":pa_pro,"title":self.Jobtitle.text!,"degree":pa_deg,"work_at":self.Workat.text!,"status":self.Status.text!,"hidephone":1,"content":self.Content.text!,"professionid":pa_zhi]
          
            let opt=try HTTP.POST("http://183.129.190.82:50001/v1/applyjobs/create",parameters:params)
            opt.start { response in
                if let err = response.error {
                    print(err.localizedFailureReason)
                    print("error: \(err.localizedDescription)")
                    return //also notify app of failure as needed
                }
                
                print("opt finished: \(response.description)")
                print("data is: \(response.data)")
                 self.Iscreate = Flag(JSONDecoder(response.data))
            }
        } catch let error {
            print("got an error creating the request: \(error)")
      }

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
