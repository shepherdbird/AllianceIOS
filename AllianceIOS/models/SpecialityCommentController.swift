//
//  SpecialityCommentController.swift
//  AllianceIOS
//
//  Created by xufei on 15/11/28.
//
//

import UIKit
import SwiftHTTP
import JSONJoy

class SpecialityCommentController: UITableViewController {
    @IBOutlet weak var comment: UITextView!

    var reid=String()
    
    var activityIndicatorView: UIActivityIndicatorView!
    var Iscreate:Flag? {
        didSet
        {
            print(self.Iscreate?.msg)
            if (self.Iscreate?.flag==1){
                self.getcomment()
            }
        }
    }
    
    var info:SpecialityController.Item?
        {
        //我们需要在age属性发生变化后，更新一下nickName这个属性
        didSet
        {
            self.SpecD?.comments=(self.info?.comments)!
            activityIndicatorView.stopAnimating()
            self.activityIndicatorView.hidden=true
            self.tableView.backgroundView=nil
            dispatch_async(dispatch_get_main_queue()){
                self.navigationController?.popViewControllerAnimated(true)
            }
        }
    }

    var SpecD:SpecialityDetailController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        self.navigationItem.backBarButtonItem=UIBarButtonItem(title: "", style: UIBarButtonItemStyle.Plain, target: nil, action: nil)
        self.navigationItem.rightBarButtonItem=UIBarButtonItem(title:"发表", style: UIBarButtonItemStyle.Plain, target: self, action: Selector("CompletePost"))
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

    }
    
    func connect(){
        do {
            let params:Dictionary<String,AnyObject>=["phone":"1","recommendationid":reid,"content":self.comment.text]
            
            let opt=try HTTP.POST("http://183.129.190.82:50001/v1/recommendationcomments/create",parameters:params)
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
    
    func getcomment(){
        do {
            let params:Dictionary<String,AnyObject>=["recommendationid":reid]
            let opt=try HTTP.POST("http://183.129.190.82:50001/v1/recommendations/search",parameters:params)
            
            opt.start { response in
                if let err = response.error {
                    print("error: \(err.localizedDescription)")
                    return //also notify app of failure as needed
                }
                print("opt finished: \(response.description)")
                //print("data is: \(response.data)") access the response of the data with response.data
                self.info = SpecialityController.Item(JSONDecoder(response.data))
                print("content is: \(self.info!)")
                
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
