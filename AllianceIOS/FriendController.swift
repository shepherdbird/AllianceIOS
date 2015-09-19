//
//  FriendController.swift
//  AllianceIOS
//
//  Created by dawei on 15/9/17.
//
//

import Foundation
import UIKit
let OceanImFriendsTableViewCellIdentifier = "FriendCell"
class FriendController:UITableViewController{
    
    
    @IBOutlet var oceanim_friends_view_tableview: UITableView!
    
    var oceanim_friends_view_dataSource:NSMutableArray!
    var oceanim_friends_view_sectionSource:Dictionary<String, NSMutableArray>! = Dictionary<String, NSMutableArray>()
    var oceanim_friends_view_headerSource:NSMutableArray!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.title = "好友"
        self.view.backgroundColor = UIColor.whiteColor()
        
        //self.oceanim_friends_view_tableview = UITableView(frame: CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds)))
        self.oceanim_friends_view_tableview.registerClass(FriendCell.self, forCellReuseIdentifier: OceanImFriendsTableViewCellIdentifier)
        self.oceanim_friends_view_tableview.separatorStyle              = .None
        self.oceanim_friends_view_tableview.allowsSelection             = true
        self.oceanim_friends_view_tableview.delegate = self
        self.oceanim_friends_view_tableview.dataSource = self
        self.oceanim_friends_view_tableview.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
        
        //self.view.addSubview(self.oceanim_friends_view_tableview)
        
        self.oceanim_friends_view_dataSource = NSMutableArray()
        self.oceanim_friends_view_headerSource = NSMutableArray()
        
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
            
            self.initData()
            
            dispatch_async(dispatch_get_main_queue(), {
                self.oceanim_friends_view_tableview.reloadData()
            })
        })
        
    }
    
    func initData(){
        self.oceanim_friends_view_dataSource.addObject(UserModel(userId: "1", userName: "阿恒", userAvator: "", userStatus: 1))
        self.oceanim_friends_view_dataSource.addObject(UserModel(userId: "2", userName: "波哥", userAvator: "", userStatus: 1))
        self.oceanim_friends_view_dataSource.addObject(UserModel(userId: "3", userName: "蔡丽", userAvator: "", userStatus: 1))
        self.oceanim_friends_view_dataSource.addObject(UserModel(userId: "4", userName: "曹东宇", userAvator: "", userStatus: 1))
        self.oceanim_friends_view_dataSource.addObject(UserModel(userId: "5", userName: "cc晨", userAvator: "", userStatus: 1))
        self.oceanim_friends_view_dataSource.addObject(UserModel(userId: "6", userName: "大纲神", userAvator: "", userStatus: 1))
        self.oceanim_friends_view_dataSource.addObject(UserModel(userId: "7", userName: "东方小鑫", userAvator: "", userStatus: 1))
        self.oceanim_friends_view_dataSource.addObject(UserModel(userId: "8", userName: "杜瑞恒", userAvator: "", userStatus: 1))
        self.oceanim_friends_view_dataSource.addObject(UserModel(userId: "9", userName: "房子", userAvator: "", userStatus: 1))
        self.oceanim_friends_view_dataSource.addObject(UserModel(userId: "10", userName: "高阳", userAvator: "", userStatus: 1))
        self.oceanim_friends_view_dataSource.addObject(UserModel(userId: "11", userName: "何思梅", userAvator: "", userStatus: 1))
        self.oceanim_friends_view_dataSource.addObject(UserModel(userId: "12", userName: "辉仔", userAvator: "", userStatus: 1))
        self.oceanim_friends_view_dataSource.addObject(UserModel(userId: "13", userName: "浅浅", userAvator: "", userStatus: 1))
        self.oceanim_friends_view_dataSource.addObject(UserModel(userId: "14", userName: "金知云", userAvator: "", userStatus: 1))
        self.oceanim_friends_view_dataSource.addObject(UserModel(userId: "15", userName: "金胜轩", userAvator: "", userStatus: 1))
        self.oceanim_friends_view_dataSource.addObject(UserModel(userId: "16", userName: "李高", userAvator: "", userStatus: 1))
        self.oceanim_friends_view_dataSource.addObject(UserModel(userId: "17", userName: "刘宇", userAvator: "", userStatus: 1))
        self.oceanim_friends_view_dataSource.addObject(UserModel(userId: "18", userName: "李阳", userAvator: "", userStatus: 1))
        
        //self.getSysContacts()
        
        self.oceanim_friends_view_sectionSource["#"] = NSMutableArray()
        for i in 65...90 {
            let key = String(format: "%c", i)
            //            println(key)
            self.oceanim_friends_view_sectionSource[key] = NSMutableArray()
            
            self.oceanim_friends_view_headerSource.addObject(key)
        }
        
        self.sortArray()
    }
    
    
    func isPureInt(string:String!) ->Bool{
        let scan:NSScanner! = NSScanner(string: string)
        var result = 0
        return scan.scanInteger(&result) && scan.atEnd
    }
    
    func sortArray(){
        for userModel in self.oceanim_friends_view_dataSource{
            
            var str:NSString! = NSString(UTF8String: (userModel as! UserModel).userName)
            
            if(str == ""){ continue }
            
            if str.containsString(" "){
                str = str.stringByReplacingOccurrencesOfString(" ", withString: "")
            }
            
            var key:String!
            
            key = String(format: "%c", pinyinFirstLetter(str.characterAtIndex(0))).uppercaseString
            
            if str.length <= 0 || isPureInt(key) || key == "_"{
                key = "#"
            }
            
            self.oceanim_friends_view_sectionSource[key.uppercaseString]!.addObject(userModel as! UserModel)
        }
        
        
        //        for i in 65...90 {
        //            let key = String(format: "%c", i)
        //            println(key)
        //            println(self.oceanim_friends_view_sectionSource[key]!.count)
        //
        //            if(self.oceanim_friends_view_sectionSource[key]!.count <= 0){
        //                self.oceanim_friends_view_sectionSource.removeValueForKey(key)
        //            }
        //        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //    func sectionIndexTitlesForTableView(tableView: UITableView) -> [String]! {
    //        //        return self.oceanim_friends_view_sectionSource.keys.array
    //        return self.oceanim_friends_view_headerSource as [AnyObject]
    //    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        //        return self.oceanim_friends_view_sectionSource.count
        return self.oceanim_friends_view_headerSource.count
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        //        return self.oceanim_friends_view_sectionSource.keys.array[section]
        
        return self.oceanim_friends_view_headerSource.objectAtIndex(section) as? String
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return self.oceanim_friends_view_sectionSource[self.oceanim_friends_view_headerSource.objectAtIndex(section) as! String]!.count
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if(self.oceanim_friends_view_sectionSource[self.oceanim_friends_view_headerSource.objectAtIndex(section) as! String]!.count <= 0){
            return 0
        }
        
        return 25
    }
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // Configure the cell...
        
        let cell = tableView.dequeueReusableCellWithIdentifier(OceanImFriendsTableViewCellIdentifier, forIndexPath: indexPath) as! FriendCell
        
        print(self.oceanim_friends_view_headerSource.objectAtIndex(indexPath.section))
        
        
        let sectionData = self.oceanim_friends_view_sectionSource[self.oceanim_friends_view_headerSource.objectAtIndex(indexPath.section) as! String]
        
        let user:UserModel! = sectionData?.objectAtIndex(indexPath.row) as! UserModel
        
        cell.configContact(user, oceanImFriendsViewController: self)
        
        //        if(indexPath.row % 3 == 0){
        //            cell.backgroundColor = UIColor(red: 254/255.0, green: 214/255.0, blue: 49/255.0, alpha: 1.0)
        //        }else if(indexPath.row  % 3 == 1){
        //            cell.backgroundColor = UIColor(red: 253/255.0, green: 173/255.0, blue: 43/255.0, alpha: 1.0)
        //        }else if(indexPath.row  % 3 == 2){
        //            cell.backgroundColor = UIColor(red: 254/255.0, green: 139/255.0, blue: 46/255.0, alpha: 1.0)
        //        }
        
        return cell;
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    }
}