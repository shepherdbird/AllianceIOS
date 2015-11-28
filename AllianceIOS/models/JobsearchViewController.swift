//
//  JobsearchViewController.swift
//  AllianceIOS
//
//  Created by xufei on 15/11/22.
//
//

import UIKit
import WEPopover
import SwiftHTTP
import JSONJoy


class JobsearchViewController: UITableViewController {

    @IBOutlet weak var Pro: UILabel!
    @IBOutlet weak var Zhi: UILabel!
    
    var allpro=["兼职","全职"]
    var deg = ["初中及初中以下", "高中", "大专", "本科", "硕士", "博士"]
    
    var activityIndicatorView: UIActivityIndicatorView!
    var Jobinfo:JobInfoController?
    var zhiye:JobZhiyViewController.Info?
    var Iscreate:JobInfoReqController.res? {
        didSet
        {
            print(self.Iscreate?.msg)
            if (self.Iscreate?.flag==1){
                self.activityIndicatorView.stopAnimating()
                self.activityIndicatorView.hidden=true
                self.tableView.backgroundView=nil
                dispatch_async(dispatch_get_main_queue()){
                    self.navigationController?.popViewControllerAnimated(true)
                }
            }
            
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem=UIBarButtonItem(title:"筛选", style: UIBarButtonItemStyle.Plain, target: self, action: Selector("CompletePost"))
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        let jobInfo=UIButton(frame: CGRectMake(0, 0, 80, 50))
        jobInfo.tag=1
        jobInfo.addTarget(self, action:Selector("ButtonAction:"), forControlEvents: UIControlEvents.TouchUpInside)
        let jobInfoIco=UIImageView(frame: CGRectMake(72, 22, 11, 6))
        jobInfoIco.image=UIImage(named: "xialaf.png")
        let jobInfoLabel=UILabel(frame: CGRectMake(0, 0, 70,50))
        jobInfoLabel.text="求职信息"
        jobInfoLabel.textColor=UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        jobInfoLabel.adjustsFontSizeToFitWidth=true
        //        self.view.addSubview(jobInfo)
        //        self.view.addSubview(jobInfoIco)
        // self.navigationController?.navigationBar.center.x addSubview(jobInfo)
        jobInfo.addSubview(jobInfoLabel)
        jobInfo.addSubview(jobInfoIco)
        self.navigationItem.titleView=jobInfo
    }
    
    func ButtonAction(sender:UIButton){
        switch sender.tag {
        case 1:
            self.navigationController?.popViewControllerAnimated(true)
            
        default:
            break
        }
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
        
        connect()
        
    }
    
    func connect(){
        if ((self.Pro.text!+self.Zhi.text!).isEmpty)
        {
            Jobinfo?.allflag=1
            Jobinfo?.prop=nil
            Jobinfo?.zhi=nil
            self.navigationController?.popViewControllerAnimated(true)
        }else if(self.Pro.text!.isEmpty){
            var pa_zhi=Int()
            
            for(var i=0;i<self.zhiye?.items.count;i++){
                if(self.zhiye?.items[i].profession==self.Zhi.text){
                    pa_zhi=(self.zhiye?.items[i].objID)!
                    break
                }
            }
            Jobinfo?.allflag=1
            Jobinfo?.prop=nil
            Jobinfo?.zhi=pa_zhi
            self.navigationController?.popViewControllerAnimated(true)
       }else if(self.Zhi.text!.isEmpty){
            let pa_pro:Int=self.allpro.indexOf(self.Pro.text!)!
            Jobinfo?.allflag=1
            Jobinfo?.prop=pa_pro
            Jobinfo?.zhi=nil
            self.navigationController?.popViewControllerAnimated(true)
            return
        }else{
            var pa_zhi=Int()
            let pa_pro:Int=self.allpro.indexOf(self.Pro.text!)!
            for(var i=0;i<self.zhiye?.items.count;i++){
                if(self.zhiye?.items[i].profession==self.Zhi.text){
                    pa_zhi=(self.zhiye?.items[i].objID)!
                    break
                }
            }
            
            
            print(pa_zhi)
            print("筛选成功")
            self.navigationController?.popViewControllerAnimated(true)
            Jobinfo?.allflag=1
            Jobinfo?.prop=pa_pro
            Jobinfo?.zhi=pa_zhi
        }
        
        //let pa_deg:Int=self.deg.indexOf(self.Degree.text!)!
        
    }



    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
        if(indexPath.section==0){
            print("性质")
            let anotherView=JobproViewController()
            anotherView.Jobsearch=self
            anotherView.flag=1
            anotherView.selected=self.Pro.text
            self.navigationController?.pushViewController(anotherView, animated: true)
        }
        if(indexPath.section==1){
            let anotherView=JobZhiyViewController()
            anotherView.Jobsearch=self
            anotherView.selected=self.Zhi.text
            anotherView.flag=1
            self.navigationController?.pushViewController(anotherView, animated: true)
        }

    }

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
