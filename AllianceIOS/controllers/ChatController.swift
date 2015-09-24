//
//  ChatController.swift
//  AllianceIOS
//
//  Created by dawei on 15/9/22.
//
//

import UIKit

class ChatController: UITableViewController {
    var dataSource:[MessageItem] = []

    @IBOutlet var ChatTV: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = [MessageItem]()
        self.ChatTV.dataSource=self
        self.ChatTV.delegate=self
        self.ChatTV.registerClass(ChatCell.self, forCellReuseIdentifier: "ChatCell")
        self.initdata()
        self.ChatTV.separatorStyle=UITableViewCellSeparatorStyle.None

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
    }
    func initdata(){
        print("HAHA")
        self.dataSource.append(MessageItem(avatar: "login_bg.jpg", date: NSDate(), content: "哈哈", from: "威少", to: "dawei"))
        self.dataSource.append(MessageItem(avatar: "login.jpg", date: NSDate(), content: "都比？？？？？？？？？", from: "dawei", to: "威少"))
        self.dataSource.append(MessageItem(avatar: "login_bg.jpg", date: NSDate(), content: "饿", from: "威少", to: "dawei"))
        
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return dataSource.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //var cell = tableView.dequeueReusableCellWithIdentifier("ChatCell", forIndexPath: indexPath) as! ChatCell
        let cell=ChatCell(data: dataSource[indexPath.row], reuseIdentifier: "ChatCell")
        // Configure the cell...

        return cell
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
