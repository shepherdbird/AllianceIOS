//
//  MessageControllerTableViewController.swift
//  AllianceIOS
//
//  Created by dawei on 15/9/20.
//
//

import UIKit
class MessageController: UITableViewController {
    
    @IBOutlet var MessageView: UITableView!
    var dataSource:[Player] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        //self.view.addSubview(self.oceanim_friends_view_tableview)
        
        self.dataSource = [Player]()
        self.initdata()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func initdata(){
         self.dataSource.append(Player(name: "刘刚", content: "晚上去健身。", avatar: "mango", time: "17:30"))
         self.dataSource.append(Player(name: "威少", content: "去怡膳堂吃饭去", avatar: "login_bg.jpg", time: "11:30"))
        self.dataSource.append(Player(name: "苏宁", content: "丁轶群：得到了？", avatar: "loadscreen.jpeg", time: "17.59"))
        self.dataSource.append(Player(name: "QQ邮箱提醒", content: "swiftV课堂：欢迎加入swiftV课堂", avatar: "login.jpg", time: "14:30"))
        self.dataSource.append(Player(name: "文件传输助手", content: "", avatar: "liugang.png", time: "15/8/5"))
        self.dataSource.append(Player(name: "微信运动", content: "[应用消息]", avatar: "login_bg.jpg", time: "昨天"))
        self.dataSource.append(Player(name: "波哥", content: "／ok", avatar: "mango", time: "昨天"))
        self.dataSource.append(Player(name: "明哥", content: "嗯", avatar: "loadscreen.jpeg", time: "昨天"))
        self.dataSource.append(Player(name: "改革", content: "[小视频]", avatar: "login.jpg", time: "星期五"))
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.dataSource.count
    }
//    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
//        return 50
//    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MessageCell", forIndexPath: indexPath)
            as UITableViewCell
        
        let message = self.dataSource[indexPath.row] as Player
        if let nameLabel = cell.viewWithTag(2) as? UILabel { //3
            nameLabel.text = message.name
        }
        if let gameLabel = cell.viewWithTag(3) as? UILabel {
            gameLabel.text = message.content
        }
        if let ratingImageView = cell.viewWithTag(1) as? UIImageView {
            ratingImageView.image = UIImage(named: message.avatar)
            ratingImageView.clipsToBounds=true
            ratingImageView.layer.cornerRadius=ratingImageView.bounds.width*0.5
        }
        if let time_=cell.viewWithTag(4) as? UILabel{
            time_.text=message.time
        }
        return cell
    }
//    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        self.performSegueWithIdentifier(<#T##identifier: String##String#>, sender: <#T##AnyObject?#>)
//        
//    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let chat=segue.destinationViewController as! ChatController
        let cell=sender as! UITableViewCell
        let nameLabel = cell.viewWithTag(2) as? UILabel
        chat.title=nameLabel!.text
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
    class Player: NSObject {
        var name: String
        var content: String
        var avatar: String
        var time: String
        
        init(name: String, content: String, avatar: String,time:String) {
            self.name = name
            self.content = content
            self.avatar = avatar
            self.time=time
        }
    }

}
