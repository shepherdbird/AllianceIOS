//
//  Me.swift
//  AllianceIOS
//
//  Created by dawei on 15/11/6.
//
//

import UIKit
import SwiftHTTP
import JSONJoy
var RefreshPerson=0
class Me: UITableViewController {
    
    @IBOutlet var I: UITableView!
    var timer:NSTimer!
    let myStoryBoard = UIStoryboard(name: "Main", bundle: nil)
    var activityIndicatorView: UIActivityIndicatorView!
    var view1=UIView()
    var PersonInfoInstance:PersonInfo?
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
        print("个人中心主界面")
        do {
            let params:Dictionary<String,AnyObject>=["phone":Phone]
            let new=try HTTP.POST(URL+"/users/view", parameters: params)
            new.start { response in
                if let err = response.error {
                    print("error: \(err.localizedDescription)")
                    return //also notify app of failure as needed
                }
                print("opt finished: \(response.description)")
                self.PersonInfoInstance = PersonInfo(JSONDecoder(response.data))
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
        if((self.PersonInfoInstance) != nil){
            return 4
        }
        return 0
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        switch section{
        case 0:
            return 1
        case 2:
            return 3
        default:
            return 1
        }
    }
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if(section==3){
            return 200
        }
        return 15
    }
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        switch indexPath.section{
        case 0:
            return self.view.frame.width
        default:
            return 50
        }
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        switch indexPath.section{
        case 0:
            return FirstCell()
        case 1:
            let icon=UIImageView(frame: CGRectMake(10, 10, 30, 30))
            icon.image=UIImage(named: "邀请好友图标.png")
            icon.clipsToBounds=true
            icon.layer.cornerRadius=15
            let name=UILabel(frame: CGRectMake(50,15,150,18))
            name.text="邀请好友"
            name.font=UIFont.systemFontOfSize(18)
            cell.addSubview(icon)
            cell.addSubview(name)
            cell.accessoryType=UITableViewCellAccessoryType.DisclosureIndicator
            return cell
        case 3:
            let icon=UIImageView(frame: CGRectMake(10, 10, 30, 30))
            icon.image=UIImage(named: "设置图标.png")
            icon.clipsToBounds=true
            icon.layer.cornerRadius=15
            let name=UILabel(frame: CGRectMake(50,15,150,18))
            name.text="设置"
            name.font=UIFont.systemFontOfSize(18)
            cell.addSubview(icon)
            cell.addSubview(name)
            cell.accessoryType=UITableViewCellAccessoryType.DisclosureIndicator
            return cell
        default:
            switch indexPath.row{
            case 0:
                let icon=UIImageView(frame: CGRectMake(10, 10, 30, 30))
                icon.image=UIImage(named: "我的钱包图标.png")
                icon.clipsToBounds=true
                icon.layer.cornerRadius=15
                let name=UILabel(frame: CGRectMake(50,15,150,18))
                name.text="我的钱包"
                name.font=UIFont.systemFontOfSize(18)
                cell.addSubview(icon)
                cell.addSubview(name)
                cell.accessoryType=UITableViewCellAccessoryType.DisclosureIndicator
                return cell
            case 1:
                let icon=UIImageView(frame: CGRectMake(10, 10, 30, 30))
                icon.image=UIImage(named: "我的收藏图标.png")
                icon.clipsToBounds=true
                icon.layer.cornerRadius=15
                let name=UILabel(frame: CGRectMake(50,15,150,18))
                name.text="我的收藏"
                name.font=UIFont.systemFontOfSize(18)
                cell.addSubview(icon)
                cell.addSubview(name)
                cell.accessoryType=UITableViewCellAccessoryType.DisclosureIndicator
                return cell
            default:
                let icon=UIImageView(frame: CGRectMake(10, 10, 30, 30))
                icon.image=UIImage(named: "我的相册图标.png")
                icon.clipsToBounds=true
                icon.layer.cornerRadius=15
                let name=UILabel(frame: CGRectMake(50,15,150,18))
                name.text="我的相册"
                name.font=UIFont.systemFontOfSize(18)
                cell.addSubview(icon)
                cell.addSubview(name)
                cell.accessoryType=UITableViewCellAccessoryType.DisclosureIndicator
                return cell
            }
        }
    }
    func FirstCell()->UITableViewCell{
        let cell=UITableViewCell()
        var boundingRect:CGRect
        let backgroud=UIImageView(frame: CGRectMake(0, 0, self.view.frame.width, self.view.frame.width/4*3))
        //backgroud.backgroundColor=UIColor(red: 220/255, green: 100/255, blue: 100/255, alpha: 1.0)
        backgroud.backgroundColor=UIColor(red: 200/255, green: 0, blue: 0, alpha: 1.0)
        cell.addSubview(backgroud)
        let avator=UIImageView(frame: CGRectMake(self.view.frame.width/2-50, 80, 100, 100))
        print(self.PersonInfoInstance?.thumb)
        avator.sd_setImageWithURL(NSURL(string: self.PersonInfoInstance!.thumb)!, placeholderImage: UIImage(named: "avator.jpg"))
        avator.clipsToBounds=true
        avator.layer.cornerRadius=50
        cell.addSubview(avator)
        let avator_edit=UIButton(frame: CGRectMake(0, 0, self.view.frame.width, self.view.frame.width/4*3))
        //avator_edit.setBackgroundImage(UIImage(named: "修改资料图标.png"), forState: UIControlState.Normal)
        avator_edit.tag=1
        avator_edit.addTarget(self, action: Selector("ButtonAction:"), forControlEvents: UIControlEvents.TouchUpInside)
        //avator_edit.clipsToBounds=true
        //avator_edit.layer.cornerRadius=10
        
        let username=UILabel(frame: CGRectMake(self.view.frame.width/2-40,self.view.frame.width/2-10,80,30))
        username.text=self.PersonInfoInstance!.nickname
        username.textColor=UIColor.whiteColor()
        username.font=UIFont.systemFontOfSize(20)
        boundingRect=GetBounds(300, height: 100, font: username.font, str: username.text!)
        username.frame=CGRectMake(self.view.frame.width/2-boundingRect.width/2,avator.frame.maxY+20,boundingRect.width,boundingRect.height)
        cell.addSubview(username)
        let id=UILabel(frame: CGRectMake(self.view.frame.width/2-40,self.view.frame.width/2+15,110,20))
        id.text="帐号："+String(self.PersonInfoInstance!.id)
        id.textColor=UIColor.whiteColor()
        id.font=UIFont.systemFontOfSize(17)
        boundingRect=GetBounds(300, height: 100, font: id.font, str: id.text!)
        id.frame=CGRectMake(self.view.frame.width/2-boundingRect.width/2,username.frame.maxY+10,boundingRect.width,boundingRect.height)
        cell.addSubview(id)
        cell.addSubview(avator_edit)
        //直接联盟
        let DirectAlliance=UIButton(frame: CGRectMake(0,self.view.frame.width/4*3,self.view.frame.width/3,self.view.frame.width/4))
        DirectAlliance.tag=100
        DirectAlliance.addTarget(self, action: Selector("ButtonAction:"), forControlEvents: UIControlEvents.TouchUpInside)
        let DA_icon=UIImageView(frame: CGRectMake(self.view.frame.width/12, self.view.frame.width/4*3+20, 20, 20))
        DA_icon.image=UIImage(named: "直接联盟图标.png")
        let DA_name=UILabel(frame: CGRectMake(self.view.frame.width/12+22,self.view.frame.width/4*3+20,120,17))
        DA_name.text="直接联盟"
        DA_name.font=UIFont.systemFontOfSize(17)
        let DA_count=UILabel(frame: CGRectMake(self.view.frame.width/6-10,self.view.frame.width/8*7,50,30))
        DA_count.text=String(self.PersonInfoInstance!.directalliancecount)+"人"
        DA_count.font=UIFont.systemFontOfSize(20)
        DA_count.textColor=UIColor.blueColor()
        boundingRect=GetBounds(300, height: 100, font: DA_count.font, str: DA_count.text!)
        DA_count.frame=CGRectMake(self.view.frame.width/6-boundingRect.width/2,DA_name.frame.maxY+10,boundingRect.width,boundingRect.height)
        cell.addSubview(DirectAlliance)
        cell.addSubview(DA_icon)
        cell.addSubview(DA_name)
        cell.addSubview(DA_count)
        //五层总数
        let FiveAll=UIButton(frame: CGRectMake(self.view.frame.width/3,self.view.frame.width/4*3,self.view.frame.width/3,self.view.frame.width/4))
        let FA_icon=UIImageView(frame: CGRectMake(self.view.frame.width/12*5, self.view.frame.width/4*3+20, 20, 20))
        FA_icon.image=UIImage(named: "五层人数图标.png")
        let FA_name=UILabel(frame: CGRectMake(self.view.frame.width/12*5+22,self.view.frame.width/4*3+20,120,17))
        FA_name.text="两层总数"
        FA_name.font=UIFont.systemFontOfSize(17)
        let FA_count=UILabel(frame: CGRectMake(self.view.frame.width/2-10,self.view.frame.width/8*7,50,30))
        FA_count.text=String(self.PersonInfoInstance!.allalliancecount)+"人"
        FA_count.font=UIFont.systemFontOfSize(20)
        FA_count.textColor=UIColor.redColor()
        boundingRect=GetBounds(300, height: 100, font: FA_count.font, str: FA_count.text!)
        FA_count.frame=CGRectMake(self.view.frame.width/2-boundingRect.width/2,FA_name.frame.maxY+10,boundingRect.width,boundingRect.height)
        cell.addSubview(FiveAll)
        cell.addSubview(FA_icon)
        cell.addSubview(FA_name)
        cell.addSubview(FA_count)
        //联盟奖励
        let AllianceGive=UIButton(frame: CGRectMake(self.view.frame.width/3*2,self.view.frame.width/4*3,self.view.frame.width/3,self.view.frame.width/4))
        AllianceGive.tag=102
        AllianceGive.addTarget(self, action: Selector("ButtonAction:"), forControlEvents: UIControlEvents.TouchUpInside)
        
        let AG_icon=UIImageView(frame: CGRectMake(self.view.frame.width/12*9, self.view.frame.width/4*3+20, 20, 20))
        AG_icon.image=UIImage(named: "联盟奖励图标.png")
        let AG_name=UILabel(frame: CGRectMake(self.view.frame.width/12*9+22,self.view.frame.width/4*3+20,120,17))
        AG_name.text="联盟奖励"
        AG_name.font=UIFont.systemFontOfSize(17)
        let AG_count=UILabel(frame: CGRectMake(self.view.frame.width/6*5-10,self.view.frame.width/8*7,80,30))
        AG_count.text=String(self.PersonInfoInstance!.alliancerewards)+"元"
        AG_count.font=UIFont.systemFontOfSize(20)
        AG_count.textColor=UIColor.greenColor()
        boundingRect=GetBounds(300, height: 100, font: AG_count.font, str: AG_count.text!)
        AG_count.frame=CGRectMake(self.view.frame.width/6*5-boundingRect.width/2,AG_name.frame.maxY+10,boundingRect.width,boundingRect.height)
        cell.addSubview(AllianceGive)
        cell.addSubview(AG_icon)
        cell.addSubview(AG_name)
        cell.addSubview(AG_count)
        return cell
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //self.I.deselectRowAtIndexPath(indexPath, animated: true)
        
        if(indexPath.section==1){
            let anotherView:UIViewController=myStoryBoard.instantiateViewControllerWithIdentifier("InviteFriend");
            self.navigationController?.pushViewController(anotherView, animated: true)
        }else if(indexPath.section==3){
            let anotherView:UIViewController=myStoryBoard.instantiateViewControllerWithIdentifier("Settings");
            self.navigationController?.pushViewController(anotherView, animated: true)
        }else if(indexPath.section==2){
            if(indexPath.row==0){
                let another=Wallet()
                self.navigationController?.pushViewController(another, animated: true)
            }else if(indexPath.row==1){
                let another=MyCollectbefore()
                self.navigationController?.pushViewController(another, animated: true)
            }else{
                let another=SNSbefore()
                self.navigationController?.pushViewController(another, animated: true)
            }
            
        }
    }
    func ButtonAction(sender:UIButton){
        switch sender.tag{
        case 1:
            let anotherView=AboutMe()
            //anotherView.Personinfo=self.PersonInfoInstance
            //let anotherView:UIViewController=myStoryBoard.instantiateViewControllerWithIdentifier("AboutMe");
            self.navigationController?.pushViewController(anotherView, animated: true)
        case 100:
            let anotherView:UIViewController=myStoryBoard.instantiateViewControllerWithIdentifier("DirectAlliance");
            self.navigationController?.pushViewController(anotherView, animated: true)
        case 102:
            let anotherView:UIViewController=myStoryBoard.instantiateViewControllerWithIdentifier("AllianceGive");
            self.navigationController?.pushViewController(anotherView, animated: true)
        default:
            break
        }
    }
    func addTimer() {
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "nextImage", userInfo: nil, repeats: true)
    }
    func nextImage() {
        if(RefreshPerson==1){
            self.RefreshData()
            RefreshPerson=0
        }
        
    }


}
