//
//  AboutMe.swift
//  AllianceIOS
//
//  Created by dawei on 15/11/8.
//
//

import UIKit
import DKImagePickerController
import Qiniu
import SwiftHTTP
import JSONJoy

var RefreshAboutMe=0
class AboutMe: UITableViewController {

    var activityIndicatorView: UIActivityIndicatorView!
    var timer:NSTimer!
    var Personinfo:PersonInfo?
        {
        didSet{
            activityIndicatorView.stopAnimating()
            self.activityIndicatorView.hidden=true
            self.tableView.backgroundView=nil
            //self.tableView.reloadData()
            dispatch_async(dispatch_get_main_queue()){
                self.tableView.reloadData()
            }
        }
    }
    
    var assets: Array<DKAsset> = []
        {
        didSet{
            let upManager = QNUploadManager()
            
            let preurl="http://7xoc8r.com2.z0.glb.qiniucdn.com/"
            upManager.putData(self.assets[0].rawData, key: nil, token: self.token?.token, complete:  {(info, key, resp) -> Void in
                if (info.statusCode == 200 && resp != nil){
                    print("上传")
                    let url=resp["hash"] as! String
                    self.picurl=preurl+url+"-style"
                }
                }, option: nil)
        }
    }
    var picurl:String?
        {
        didSet{
            dispatch_async(dispatch_get_main_queue()){
                self.connect()
            }
        }
    }
    var token:Qiniutoken.Item?
    var alert:UIAlertController?
    var Fg:Flag?
        {
        didSet{
//            activityIndicatorView.stopAnimating()
//            self.activityIndicatorView.hidden=true
//            self.tableView.backgroundView=nil
            RefreshPerson=1
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)){
                self.connect1()
                
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView=UITableView(frame: self.view.frame, style: UITableViewStyle.Grouped)
        let view1=UIView(frame: CGRectMake(0, 0, self.tableView.frame.size.width, self.tableView.frame.size.height))
        view1.backgroundColor=UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        
        
        activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.White)
        
        activityIndicatorView.frame = CGRectMake(self.tableView.frame.size.width/2-100, -30, 200, 200)
        
        activityIndicatorView.hidesWhenStopped = true
        
        activityIndicatorView.color = UIColor.blackColor()
        view1.addSubview(activityIndicatorView)
        self.tableView.backgroundView=view1
        activityIndicatorView.startAnimating()
        addTimer()
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)){
            self.connect1()
            
        }
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)){
            self.gettoken()
        }
    }
    func showImagePickerWithAssetType(assetType: DKImagePickerControllerAssetType,
        allowMultipleType: Bool = true,
        sourceType: DKImagePickerControllerSourceType = [.Camera, .Photo]) {
            
            let pickerController = DKImagePickerController()
            pickerController.assetType = assetType
            pickerController.showCancelButton = true
            pickerController.allowMultipleTypes = allowMultipleType
            pickerController.sourceType = sourceType
            pickerController.maxSelectableCount=1
            pickerController.defaultSelectedAssets=self.assets
            
            pickerController.didSelectAssets = { [unowned self] (assets: [DKAsset]) in
                print("didSelectAssets")
                print(assets.map({ $0.url}))
                
                self.assets = assets
        
            }
            self.presentViewController(pickerController, animated: true) {}
    }
    func connect(){
        print("更新头像")
        do {
        let params:Dictionary<String,AnyObject>=["phone":Phone,"thumb":self.picurl!]
        let new=try HTTP.POST(URL+"/users/modify", parameters: params)
        new.start { response in
        if let err = response.error {
        print("error: \(err.localizedDescription)")
        return //also notify app of failure as needed
        }
        print("opt finished: \(response.description)")
        self.Fg = Flag(JSONDecoder(response.data))
        }
        
        } catch let error {
        print("got an error creating the request: \(error)")
        }
    }
    func connect1(){
        do {
            let params:Dictionary<String,AnyObject>=["phone":Phone]
            let new=try HTTP.POST(URL+"/users/view", parameters: params)
            new.start { response in
                if let err = response.error {
                    print("error: \(err.localizedDescription)")
                    return //also notify app of failure as needed
                }
                print("opt finished: \(response.description)")
                self.Personinfo = PersonInfo(JSONDecoder(response.data))
            }
        } catch let error {
            print("got an error creating the request: \(error)")
        }
        
    }
    func gettoken(){
        print("上传头像")
        do {
            let opt=try HTTP.GET(URL+"/users/token")
            
            opt.start { response in
                if let err = response.error {
                    print("error: \(err.localizedDescription)")
                    return //also notify app of failure as needed
                }
                print("opt finished: \(response.description)")
                //print("data is: \(response.data)") access the response of the data with response.data
                self.token = Qiniutoken.Item(JSONDecoder(response.data))
                // print("content is: \(self.info!.items[0].content)")
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
        if((self.Personinfo) != nil){
            return 4
        }
        return 0
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        switch section{
        case 0:
            return 4
        case 1:
            return 3
        case 2:
            return 2
        default:
            return 1
        }
    }
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell=UITableViewCell()
        var boundingRect:CGRect
        cell.accessoryType=UITableViewCellAccessoryType.DisclosureIndicator
        switch indexPath.section{
        case 0:
            switch indexPath.row{
            case 0:
                let title=UILabel(frame: CGRectMake(15,15,150,20))
                title.text="头像"
                title.font=UIFont.systemFontOfSize(15)
                let avator=UIImageView(frame: CGRectMake(self.view.frame.width-70, 5, 40, 40))
                avator.image=UIImage(named: "avator.jpg")
                avator.sd_setImageWithURL(NSURL(string: self.Personinfo!.thumb)!, placeholderImage: UIImage(named: "avator.jpg"))
                avator.clipsToBounds=true
                avator.layer.cornerRadius=20
                cell.addSubview(title)
                cell.addSubview(avator)
            case 1:
                let title=UILabel(frame: CGRectMake(15,15,150,20))
                title.text="昵称"
                title.font=UIFont.systemFontOfSize(15)
                let detail=UILabel(frame: CGRectMake(self.view.frame.width-90, 15, 70, 20))
                detail.text=self.Personinfo!.nickname
                detail.font=UIFont.systemFontOfSize(17)
                detail.textColor=UIColor(red: 111/255, green: 111/255, blue: 111/255, alpha: 0.44)
                boundingRect=GetBounds(300, height: 100, font: detail.font, str: detail.text!)
                detail.frame=CGRectMake(self.view.frame.width-boundingRect.width-30,15,boundingRect.width,boundingRect.height)
                cell.addSubview(title)
                cell.addSubview(detail)
            case 2:
                cell.accessoryType=UITableViewCellAccessoryType.None
                let title=UILabel(frame: CGRectMake(15,15,150,20))
                title.text="账户"
                title.font=UIFont.systemFontOfSize(15)
                let detail=UILabel(frame: CGRectMake(self.view.frame.width-90, 15, 90, 20))
                detail.text=String(self.Personinfo!.id)
                detail.font=UIFont.systemFontOfSize(17)
                detail.textColor=UIColor(red: 111/255, green: 111/255, blue: 111/255, alpha: 0.44)
                boundingRect=GetBounds(300, height: 100, font: detail.font, str: detail.text!)
                detail.frame=CGRectMake(self.view.frame.width-boundingRect.width-30,15,boundingRect.width,boundingRect.height)
                cell.addSubview(title)
                cell.addSubview(detail)
            default:
                let title=UILabel(frame: CGRectMake(15,15,150,20))
                title.text="我的二维码"
                title.font=UIFont.systemFontOfSize(15)
                let avator=UIImageView(frame: CGRectMake(self.view.frame.width-60, 10, 30, 30))
                avator.image=UIImage(named: "二维码.png")
                cell.addSubview(title)
                cell.addSubview(avator)
            }
        case 1:
            switch indexPath.row{
            case 0:
                let title=UILabel(frame: CGRectMake(15,15,150,20))
                title.text="性别"
                title.font=UIFont.systemFontOfSize(15)
                let detail=UILabel(frame: CGRectMake(self.view.frame.width-50, 15, 20, 20))
                if(self.Personinfo!.gender==0){
                    detail.text="女"
                }else{
                    detail.text="男"
                }
                detail.font=UIFont.systemFontOfSize(17)
                detail.textColor=UIColor(red: 111/255, green: 111/255, blue: 111/255, alpha: 0.44)
                cell.addSubview(title)
                cell.addSubview(detail)
            case 1:
                let title=UILabel(frame: CGRectMake(15,15,150,20))
                title.text="地区"
                title.font=UIFont.systemFontOfSize(15)
                let detail=UILabel(frame: CGRectMake(self.view.frame.width-60, 15, 30, 20))
                detail.text=self.Personinfo!.area
                detail.font=UIFont.systemFontOfSize(17)
                detail.textColor=UIColor(red: 111/255, green: 111/255, blue: 111/255, alpha: 0.44)
                boundingRect=GetBounds(300, height: 100, font: detail.font, str: detail.text!)
                detail.frame=CGRectMake(self.view.frame.width-boundingRect.width-30,15,boundingRect.width,boundingRect.height)
                cell.addSubview(title)
                cell.addSubview(detail)
            default:
                let title=UILabel(frame: CGRectMake(15,15,70,20))
                title.text="个性签名"
                title.font=UIFont.systemFontOfSize(15)
                let detail=UILabel(frame: CGRectMake(self.view.frame.width/2, 15, self.view.frame.width/2-20, 20))
                detail.text=self.Personinfo!.signature
                detail.font=UIFont.systemFontOfSize(17)
                //print(detail.text)
                detail.textColor=UIColor(red: 111/255, green: 111/255, blue: 111/255, alpha: 0.44)
                boundingRect=GetBounds(4000, height: 20, font: detail.font, str: detail.text!)
                var width=self.view.frame.width/2-30
                if(boundingRect.width+30<self.view.frame.width/2){
                    width=boundingRect.width
                }
                detail.frame=CGRectMake(self.view.frame.width-width-30,15,width,boundingRect.height)
                print(self.view.frame.width-width-30,15,width,boundingRect.height)
                cell.addSubview(title)
                cell.addSubview(detail)
            }
        case 2:
            if(indexPath.row==0){
                let title=UILabel(frame: CGRectMake(15,15,150,20))
                title.text="实名认证"
                title.font=UIFont.systemFontOfSize(15)
                cell.addSubview(title)
            }else{
                let title=UILabel(frame: CGRectMake(15,15,150,20))
                title.text="收货地址"
                title.font=UIFont.systemFontOfSize(15)
                cell.addSubview(title)
            }
        default:
            cell.accessoryType=UITableViewCellAccessoryType.None
            let exit=UIButton(frame: CGRectMake(20,5,self.view.frame.width-40,40))
            exit.setTitle("安全退出", forState: UIControlState.Normal)
            exit.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
            exit.setBackgroundImage(UIImage(named: "安全退出按钮.png"), forState: UIControlState.Normal)
            cell.addSubview(exit)
        }
        return cell
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
        switch indexPath.section{
        case 0:
            if(indexPath.row==0){
                self.showImagePickerWithAssetType(DKImagePickerControllerAssetType.allPhotos)
            }else if(indexPath.row==1){
                
                let anotherView=ChangeName()
                anotherView.Nick=self.Personinfo!.nickname
                self.navigationController?.pushViewController(anotherView, animated: true)
            }else if(indexPath.row==3){
                let anotherView=MyQRcode()
                self.navigationController?.pushViewController(anotherView, animated: true)
            }
        case 1:
            if(indexPath.row==0){
                let anotherView=ChangeGender()
                if(self.Personinfo!.gender==1){
                    anotherView.IsBoy=1
                }else{
                    anotherView.IsBoy=0
                }
                self.navigationController?.pushViewController(anotherView, animated: true)
            }else if(indexPath.row==2){
                let anotherView=Signature()
                anotherView.Content=self.Personinfo!.signature
                self.navigationController?.pushViewController(anotherView, animated: true)
            }
        case 2:
            if(indexPath.row==0){
                let anotherView=Certification()
                anotherView.Status=self.Personinfo!.status
                self.navigationController?.pushViewController(anotherView, animated: true)
            }else{
                let anotherView=ShippingAddress()
                self.navigationController?.pushViewController(anotherView, animated: true)
            }
        default:
            break
        }
    }
    func addTimer() {
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "nextImage", userInfo: nil, repeats: true)
    }
    func nextImage() {
        if(RefreshAboutMe==1){
            
            RefreshAboutMe=0
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)){
                self.connect1()
                
            }
        }
        
    }

}
