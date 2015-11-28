//
//  Focus.swift
//  AllianceIOS
//
//  Created by dawei on 15/11/16.
//
//

import UIKit
import SwiftHTTP
import JSONJoy

class Focus: UITableViewController {

    @IBOutlet var F: UITableView!
    var activityIndicatorView: UIActivityIndicatorView!
    var view1=UIView()
    var LiaoBaMyConcerns:LiaobaFans?
        {
        didSet{
            activityIndicatorView.stopAnimating()
            self.activityIndicatorView.hidden=true
            self.tableView.backgroundView=nil
            self.tableView.reloadData()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView=UITableView(frame: self.view.frame, style: UITableViewStyle.Grouped)
        view1=UIView(frame: CGRectMake(0, 0, self.tableView.frame.size.width, self.tableView.frame.size.height))
        view1.backgroundColor=UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        
        
        activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.White)
        
        activityIndicatorView.frame = CGRectMake(self.tableView.frame.size.width/2-100, -30, 200, 200)
        
        activityIndicatorView.hidesWhenStopped = true
        
        activityIndicatorView.color = UIColor.blackColor()
        view1.addSubview(activityIndicatorView)
        self.tableView.backgroundView=view1
        activityIndicatorView.startAnimating()
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)){
            self.connect()
        }
    }
    func connect(){
        print("聊吧-我的关注")
        do {
            let param:Dictionary<String,AnyObject>=["phone":Phone]
            let concerns=try HTTP.POST(URL+"/tbusers/myconcerns", parameters: param)
            concerns.start { response in
                if let err = response.error {
                    print("error: \(err.localizedDescription)")
                    return //also notify app of failure as needed
                }
                print("opt finished: \(response.description)")
                self.LiaoBaMyConcerns = LiaobaFans(JSONDecoder(response.data))
            }
            
        } catch let error {
            print("got an error creating the request: \(error)")
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if((LiaoBaMyConcerns) != nil){
            return 1
        }
        return 0
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return LiaoBaMyConcerns!.items.count
    }
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60
    }
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.1
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let avator=UIImageView(frame: CGRectMake(15, 15, 30, 30))
        if let Ndata=NSData(contentsOfURL: NSURL(string: LiaoBaMyConcerns!.items[indexPath.row].thumb)!){
            avator.image=UIImage(data: Ndata)
        }
        avator.clipsToBounds=true
        avator.layer.cornerRadius=15
        cell.addSubview(avator)
        let name=UILabel(frame: CGRectMake(50,15,150,15))
        name.text=LiaoBaMyConcerns!.items[indexPath.row].nickname
        name.font=UIFont.systemFontOfSize(16)
        cell.addSubview(name)
        let fans=UILabel(frame: CGRectMake(50,40,200,10))
        fans.text="聊吧粉丝："+LiaoBaMyConcerns!.items[indexPath.row].concerncount
        fans.font=UIFont.systemFontOfSize(14)
        fans.textColor=UIColor(red: 186/255, green: 186/255, blue: 186/255, alpha: 0.77)
        cell.addSubview(fans)
        let focus=UIButton(frame: CGRectMake(self.view.frame.width-80,18,70,25))
        focus.setTitle("取消关注", forState: UIControlState.Normal)
        focus.layer.borderWidth=1
        focus.clipsToBounds=true
        focus.layer.cornerRadius=3
        focus.layer.borderColor=UIColor(red: 244/255, green: 154/255, blue: 85/255, alpha: 1.0).CGColor
        focus.titleLabel?.font=UIFont.systemFontOfSize(15)
        focus.setTitleColor(UIColor(red: 244/255, green: 154/255, blue: 85/255, alpha: 1.0), forState: UIControlState.Normal)
        cell.addSubview(focus)
        return cell
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
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
