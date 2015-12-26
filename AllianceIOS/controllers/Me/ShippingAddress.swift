//
//  ShippingAddress.swift
//  AllianceIOS
//
//  Created by dawei on 15/11/8.
//
//

import UIKit
import SwiftHTTP
import JSONJoy

var RefreshAddress=0
class ShippingAddress: UITableViewController {

    var activityIndicatorView: UIActivityIndicatorView!
    var view1=UIView()
    var timer:NSTimer!
    var AddressesInstance:Addresses?
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
        self.navigationItem.backBarButtonItem=UIBarButtonItem(title: "", style: UIBarButtonItemStyle.Plain, target: nil, action: nil)
        self.navigationItem.rightBarButtonItem=UIBarButtonItem(title:"新增", style: UIBarButtonItemStyle.Plain, target: self, action: Selector("Add"))
        self.navigationItem.rightBarButtonItem?.tintColor=UIColor(red: 220/255, green: 100/255, blue: 100/255, alpha: 1.0)
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
        print("个人中心收货地址列表")
        do {
            let params:Dictionary<String,AnyObject>=["phone":Phone]
            let new=try HTTP.POST(URL+"/users/listaddresses", parameters: params)
            new.start { response in
                if let err = response.error {
                    print("error: \(err.localizedDescription)")
                    return //also notify app of failure as needed
                }
                print("opt finished: \(response.description)")
                self.AddressesInstance = Addresses(JSONDecoder(response.data))
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
        if((self.AddressesInstance) != nil){
            return self.AddressesInstance!.items.count
        }
        return 0
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if((self.AddressesInstance) != nil){
            if(section==self.AddressesInstance!.items.count-1){
                return 150
            }
        }
        return 0.01
    }
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell=UITableViewCell()
        var boundingRect:CGRect
        let name=UILabel(frame: CGRectMake(20,10,self.view.frame.width/2,30))
        name.text=self.AddressesInstance!.items[indexPath.section].name
        name.font=UIFont.systemFontOfSize(20)
        cell.addSubview(name)
        let number=UILabel(frame: CGRectMake(self.view.frame.width-200,10,130,30))
        number.text=self.AddressesInstance!.items[indexPath.section].aphone
        number.font=UIFont.systemFontOfSize(20)
        boundingRect=GetBounds(300, height: 100, font: number.font, str: number.text!)
        number.frame=CGRectMake(self.view.frame.width-boundingRect.width-60,10,boundingRect.width,30)
        cell.addSubview(number)
        let address=UILabel(frame: CGRectMake(20,40,self.view.frame.width-80,20))
        address.text=self.AddressesInstance!.items[indexPath.section].address
        address.font=UIFont.systemFontOfSize(14)
        address.textColor=UIColor(red: 111/255, green: 111/255, blue: 111/255, alpha: 1.0)
        address.numberOfLines=0
        cell.addSubview(address)
        if(self.AddressesInstance!.items[indexPath.section].isdefault==1){
            let select=UIButton(frame: CGRectMake(self.view.frame.width-40,30,20,20))
            select.setBackgroundImage(UIImage(named: "选择按钮2.png"), forState: UIControlState.Normal)
            select.clipsToBounds=true
            select.layer.cornerRadius=7.5
            cell.addSubview(select)
        }
        return cell
    }
    func Add(){
        let anotherView=ShippingAddressAdd()
        self.navigationController?.pushViewController(anotherView, animated: true)
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let anotherView=ShippingAddressDetail()
        anotherView.address=self.AddressesInstance!.items[indexPath.section]
        self.navigationController?.pushViewController(anotherView, animated: true)
    }
    func addTimer() {
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "nextImage", userInfo: nil, repeats: true)
    }
    func nextImage() {
        if(RefreshAddress==1){
            self.RefreshData()
            RefreshAddress=0
        }
        
    }

}
