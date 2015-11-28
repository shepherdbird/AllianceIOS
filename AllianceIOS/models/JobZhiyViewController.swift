//
//  JobproViewController.swift
//  AllianceIOS
//
//  Created by xufei on 15/11/19.
//
//

import UIKit
import SwiftHTTP
import JSONJoy

class JobZhiyViewController: UITableViewController {
    
    
    struct Item : JSONJoy {
        var objID: Int?
        var profession: String?
        init(_ decoder: JSONDecoder) {
            objID = decoder["id"].integer
            profession=decoder["profession"].string
        }
    }
    
    struct Info: JSONJoy {
        var items: Array<Item>!
        
        init(_ decoder: JSONDecoder) {
            //we check if the array is valid then alloc our array and loop through it, creating the new address objects.
            if let it = decoder.array {
                items = Array<Item>()
                for itemDecoder in it {
                    items.append(Item(itemDecoder))
                }
            }
        }
    }

    var zhi: Array<String> = []
    var activityIndicatorView: UIActivityIndicatorView!
    var info:Info?
        {
        //我们需要在age属性发生变化后，更新一下nickName这个属性
        didSet
        {
            zhi=Array<String>()
            activityIndicatorView.stopAnimating()
            self.activityIndicatorView.hidden=true
            self.tableView.backgroundView=nil
            for(var i=0;i<self.info?.items.count;i++){
               zhi.append((info?.items[i].profession)!)
            }
            dispatch_async(dispatch_get_main_queue()){
               self.tableView.reloadData()
            }
        }
    }
    
    
    
    
    var selected:String?
    var selectedIndex:Int? = nil
    var Jobreq:JobInfoReqController?
    var Jobsearch:JobsearchViewController?
    var flag:Int?
    override func viewDidLoad() {
        super.viewDidLoad()
        print(zhi)
        if let game = selected {
            selectedIndex = zhi.indexOf(game)
        }
        
        var footrect=CGRect()
        footrect.size.height=46
        let footview=UIView.init(frame: footrect)
        self.tableView.tableFooterView=footview
        
        let view1=UIView(frame: CGRectMake(0, 0, self.tableView.frame.size.width, self.tableView.frame.size.height))
        view1.backgroundColor=UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        
        
        activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.White)
        
        activityIndicatorView.frame = CGRectMake(self.tableView.frame.size.width/2-100, -30, 200, 200)
        
        activityIndicatorView.hidesWhenStopped = true
        
        activityIndicatorView.color = UIColor.blackColor()
        view1.addSubview(activityIndicatorView)
        self.tableView.backgroundView=view1
        activityIndicatorView.startAnimating()
        //self.navigationItem.
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)){
            self.connect()
        }

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
        return zhi.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .Default, reuseIdentifier: nil)
        
        cell.textLabel?.text = zhi[indexPath.row]
        if indexPath.row == selectedIndex {
            cell.accessoryType = .Checkmark
        } else {
            cell.accessoryType = .None
        }
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
        if let index = selectedIndex {
            let cell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: index, inSection: 0))
            cell?.accessoryType = .None
        }
        
        selectedIndex = indexPath.row
        
        if(flag==0){
            Jobreq?.Zhiye.text = self.zhi[indexPath.row]
        
            //update the checkmark for the current row
            let cell = tableView.cellForRowAtIndexPath(indexPath)
            cell?.accessoryType = .Checkmark
            Jobreq?.tableView.reloadData()
        
            Jobreq?.zhiinfo=self.info
        }else{
            Jobsearch?.Zhi.text = self.zhi[indexPath.row]
            
            //update the checkmark for the current row
            let cell = tableView.cellForRowAtIndexPath(indexPath)
            cell?.accessoryType = .Checkmark
            Jobsearch?.tableView.reloadData()
            
            Jobsearch?.zhiye=self.info
        }
        self.navigationController?.popViewControllerAnimated(true)
        
    }
    
    func connect(){
        print("ccccc")
        do {
            let opt=try HTTP.GET("http://183.129.190.82:50001/v1/professions/list")
            
            opt.start { response in
                if let err = response.error {
                    print("error: \(err.localizedDescription)")
                    return //also notify app of failure as needed
                }
                print("opt finished: \(response.description)")
                //print("data is: \(response.data)") access the response of the data with response.data
                self.info = Info(JSONDecoder(response.data))
                  print("content is: \(self.info!.items[0].profession)")
                
            }
        } catch let error {
            print("got an error creating the request: \(error)")
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
