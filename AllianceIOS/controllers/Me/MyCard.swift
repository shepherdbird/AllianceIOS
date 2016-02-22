//
//  MyCorn.swift
//  AllianceIOS
//
//  Created by dawei on 15/12/22.
//
//

import UIKit
import SwiftHTTP
import JSONJoy

var RefreshCard=0

class MyCard: UITableViewController {
    
    var activityIndicatorView: UIActivityIndicatorView!
    var view1=UIView()
    var timer:NSTimer!
    var cards:Cards?
        {
        didSet{
            activityIndicatorView.stopAnimating()
            self.activityIndicatorView.hidden=true
            self.tableView.backgroundView=nil
            dispatch_async(dispatch_get_main_queue()){
                self.tableView.reloadData()
                self.tableView.refreshHeader.endRefresh()
            }
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
        addRefreshView()
        addTimer()
    }
    func connect(){
        print("银行卡")
        do {
            let params:Dictionary<String,AnyObject>=["phone":Phone]
            let new=try HTTP.POST(URL+"/usertocards/list", parameters: params)
            new.start { response in
                if let err = response.error {
                    print("error: \(err.localizedDescription)")
                    return //also notify app of failure as needed
                }
                print("opt finished: \(response.description)")
                self.cards = Cards(JSONDecoder(response.data))
            }
        } catch let error {
            print("got an error creating the request: \(error)")
        }
        
    }
    func addRefreshView(){
        self.tableView.refreshHeader=self.tableView.addRefreshHeaderWithHandler{
            self.RefreshData()
        }
    }
    func RefreshData() {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)){
            self.connect()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if((self.cards) != nil){
            if(self.cards?.items.count==0){
                return 1
            }else{
                return 2
            }
            
        }
        return 0
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if((self.cards) != nil){
            if(self.cards?.items.count==0){
                return 1
            }else{
                return (self.cards?.items.count)!
            }
            
        }
        return 1
    }
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if(section==1){
            return 200
        }
        return 15
    }
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.001
    }
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if((self.cards) != nil && self.cards?.items.count > 0){
            if(indexPath.section==0){
                return 80
            }else{
                return 50
            }
        }
        return 50
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
        if((self.cards) != nil && self.cards?.items.count > 0){
            if(indexPath.section==0){
                let another=MyCardAdd()
                self.navigationController?.pushViewController(another, animated: true)
            }else{
                let another=MyCardAdd()
                self.navigationController?.pushViewController(another, animated: true)
            }
        }else{
            let another=MyCardAdd()
            self.navigationController?.pushViewController(another, animated: true)
        }
        
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if((self.cards) != nil && self.cards?.items.count > 0){
            if(indexPath.section==0){
                return FirstCell(indexPath.row)
            }else{
                return AddCell()
            }
        }
        return AddCell()
    }
    func AddCell()->UITableViewCell {
        let cell=UITableViewCell()
        let add=UIImageView(frame: CGRectMake(20, 15, 20, 20))
        add.image=UIImage(named: "添加银行卡图标.png")
        cell.addSubview(add)
        let label=UILabel(frame: CGRectMake(50,17,150,17))
        label.text="添加银行卡"
        label.font=UIFont.systemFontOfSize(17)
        cell.addSubview(label)
        return cell
    }
    func FirstCell(index:Int)->UITableViewCell {
        let cell=UITableViewCell()
        let background=UIImageView(frame: CGRectMake(20, 30, 30, 20))
        background.image=UIImage(named: "银行卡图标.png")
        cell.addSubview(background)
        let name=UILabel(frame: CGRectMake(70,25,251,18))
        name.text=self.cards?.items[index].name!
        name.font=UIFont.systemFontOfSize(18)
        cell.addSubview(name)
        let detail=UILabel(frame: CGRectMake(70,50,251,15))
        detail.text=self.cards?.items[index].name!
        detail.font=UIFont.systemFontOfSize(15)
        detail.textColor=UIColor(red: 186/255, green: 186/255, blue: 186/255, alpha: 1.0)
        let s=self.cards!.items[index].cardnumber
        let index = s!.startIndex.advancedBy(2)
        let s1:String=s!.substringFromIndex(index)
        detail.text="尾号"+s1+"  "+detail.text!
        cell.addSubview(detail)
        
        return cell
    }
    func addTimer() {
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "nextImage", userInfo: nil, repeats: true)
    }
    func nextImage() {
        if(RefreshCard==1){
            self.RefreshData()
            RefreshCard=0
        }
        
    }

}
