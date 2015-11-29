//
//  HobbyController.swift
//  AllianceIOS
//
//  Created by dawei on 15/11/1.
//
//

import UIKit
import SwiftHTTP
import JSONJoy

class HobbyController: UITableViewController {

    @IBOutlet var HobbyController: UITableView!
    
    @IBOutlet weak var Search: UISearchBar!
    
    
    struct Item : JSONJoy {
        var objID: String?
        var userID: String?
        var picture: String?
        var sex:String?
        var age: String?
        var hobbyid: String?
        var hobby: String?
        var content: String?
        var created_at: String?
        var phone: String?
        var nickname: String?
        var thumb: String?
        init(_ decoder: JSONDecoder) {
            objID = decoder["id"].string
            userID=decoder["userid"].string
            picture=decoder["picture"].string
            sex=decoder["sex"].string
            age=decoder["age"].string
            hobbyid=decoder["hobbyid"].string
            hobby=decoder["hobby"].string
            content=decoder["content"].string
            created_at=decoder["created_at"].string
            phone=decoder["phone"].string
            nickname=decoder["nickname"].string
            thumb=decoder["thumb"].string
        }
    }
    
    struct Url : JSONJoy {
        var href:String?
        init(_ decoder: JSONDecoder) {
            href = decoder["href"].string
        }
    }
    
    struct Link : JSONJoy {
        var prev:Url?
        var next:Url?
        init(_ decoder: JSONDecoder) {
            prev = Url(decoder["prev"])
            next = Url(decoder["next"])
        }
    }
    
    struct Meta : JSONJoy {
        var totalCount: Int?
        var pageCount: Int?
        var currentPage: Int?
        var perPage: Int?
        init(_ decoder: JSONDecoder) {
            totalCount = decoder["totalCount"].integer
            pageCount = decoder["pageCount"].integer
            currentPage = decoder["currentPage"].integer
            perPage = decoder["perPage"].integer
        }
        
    }
    
    struct Info: JSONJoy {
        var items: Array<Item>!
        var _links : Link!
        var _meta : Meta!
        init(_ decoder: JSONDecoder) {
            //we check if the array is valid then alloc our array and loop through it, creating the new address objects.
            if let it = decoder["items"].array {
                items = Array<Item>()
                for itemDecoder in it {
                    items.append(Item(itemDecoder))
                }
            }
            
            _links = Link(decoder["_links"])
            _meta = Meta(decoder["_meta"])
        }
    }

    
    
    var alert:UIAlertController!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.backBarButtonItem=UIBarButtonItem(title: "", style: UIBarButtonItemStyle.Plain, target: nil, action: nil)
        self.navigationItem.rightBarButtonItem=UIBarButtonItem(image: UIImage(named: "发帖按钮.png"), style: UIBarButtonItemStyle.Plain, target: self, action: Selector("mine"))
        //self.navigationItem.rightBarButtonItem?.tintColor=UIColor.redColor()
        self.HobbyController.dataSource=self
        self.HobbyController.delegate=self
        self.HobbyController.registerClass(HobbyCell.self, forCellReuseIdentifier: "HobbyCell")
        self.HobbyController.allowsSelection=true
        self.HobbyController.separatorStyle=UITableViewCellSeparatorStyle.SingleLine
        //self.HobbyController.backgroundColor=UIColor(red: 250/255, green: 250/255, blue: 250/255, alpha: 0.3)
        
        let SendAction=UIAlertAction(title: "我要交友", style: UIAlertActionStyle.Default) { (action:UIAlertAction) -> Void in
            let anotherView:UIViewController=self.storyboard!.instantiateViewControllerWithIdentifier("HobbyReq");
            self.navigationController?.pushViewController(anotherView, animated: true)
            //print("我要求职")
        }
        let MySendAction=UIAlertAction(title: "我的交友", style: UIAlertActionStyle.Default) { (action:UIAlertAction) -> Void in
            let anotherView:UIViewController=self.storyboard!.instantiateViewControllerWithIdentifier("HobbyMy");
            self.navigationController?.pushViewController(anotherView, animated: true)
            //print("我要求职")
        }
        alert=UIAlertController(title: "", message: "", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(SendAction)
        alert.addAction(MySendAction)
        //self.navigationItem.
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
        return 3
        
    }
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("HobbyCell", forIndexPath: indexPath) as! HobbyCell
        return cell
        
        
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.HobbyController.deselectRowAtIndexPath(indexPath, animated: true)
        //self.performSegueWithIdentifier("detail", sender: nil)
        let anotherView:UIViewController=self.storyboard!.instantiateViewControllerWithIdentifier("HobbyDetail");
        self.navigationController?.pushViewController(anotherView, animated: true)
    }
    
    func mine(){
        print("爱好交友右上角按钮被点击")
        self.presentViewController(alert, animated: true, completion: nil)
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
