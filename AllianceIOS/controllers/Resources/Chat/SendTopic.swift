//
//  SendTopic.swift
//  AllianceIOS
//
//  Created by dawei on 15/11/16.
//
//

import UIKit
import DKImagePickerController
import Qiniu
import SwiftHTTP
import JSONJoy

class SendTopic: UITableViewController{

    @IBOutlet var ST: UITableView!
    var assets: Array<DKAsset> = []
    var token:Qiniutoken.Item?
    var activityIndicatorView: UIActivityIndicatorView!
    var first=""
    var content=""
    var alert:UIAlertController?
    var Fg:Flag?
        {
        didSet{
            activityIndicatorView.stopAnimating()
            self.activityIndicatorView.hidden=true
            self.tableView.backgroundView=nil
            self.navigationController?.popViewControllerAnimated(true)
            RefreshStatus=1
//            let reqAction=UIAlertAction(title: "确定", style: UIAlertActionStyle.Default) { (action:UIAlertAction) -> Void in
//                self.navigationController?.popViewControllerAnimated(true)
//                //self.RefreshData()
//            }
//            alert=UIAlertController(title: "", message: Fg?.msg, preferredStyle: UIAlertControllerStyle.Alert)
//            alert!.addAction(reqAction)
//            self.addChildViewController(alert!)
//            self.presentViewController(alert!, animated: true, completion: nil)
        }
    }
    var allurl=String()
    var picurl=String()
        {
        didSet
        {
            allurl+=self.picurl
            if(self.allurl.componentsSeparatedByString(" ").count==self.assets.count+1){
                // print("好好好")
                let whitespace = NSCharacterSet.whitespaceAndNewlineCharacterSet()
                self.allurl=self.allurl.stringByTrimmingCharactersInSet(whitespace)
                print(self.allurl)
                dispatch_async(dispatch_get_main_queue()){
                    self.connect()                }
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.backBarButtonItem=UIBarButtonItem(title: "", style: UIBarButtonItemStyle.Plain, target: nil, action: nil)
        self.navigationItem.rightBarButtonItem=UIBarButtonItem(title:"发送", style: UIBarButtonItemStyle.Plain, target: self, action: Selector("CompletePost"))
        self.navigationItem.rightBarButtonItem?.tintColor=UIColor(red: 220/255, green: 100/255, blue: 100/255, alpha: 1.0)

        
        
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
            pickerController.maxSelectableCount=9
            pickerController.defaultSelectedAssets=self.assets
            
            pickerController.didSelectAssets = { [unowned self] (assets: [DKAsset]) in
                print("didSelectAssets")
                print(assets.map({ $0.url}))
                
                self.assets = assets
                //self.preview?.reloadData()
                self.tableView.reloadData()
            }
            
            self.presentViewController(pickerController, animated: true) {}
    }
    func gettoken(){
        print("聊吧－发表新话题")
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
    func connect(){
        print("聊吧-发表话题")
        do {
            let title=self.view.viewWithTag(1) as! UITextField
            let content=self.view.viewWithTag(2) as! UITextView
            let params:Dictionary<String,AnyObject>=["phone":Phone,"title":title.text!,"content":content.text!,"pictures":self.allurl]
            let new=try HTTP.POST(URL+"/tbmessages/send", parameters: params)
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
        self.navigationController?.popViewControllerAnimated(true)
        
        
    }
    func CompletePost(){
        let upManager = QNUploadManager()
        
        let preurl="http://7xoc8r.com2.z0.glb.qiniucdn.com/"
        
        for(var i=0;i<self.assets.count;i++){
            upManager.putData(self.assets[i].rawData, key: nil, token: self.token?.token, complete:  {(info, key, resp) -> Void in
                if (info.statusCode == 200 && resp != nil){
                    print("上传")
                    let url=resp["hash"] as! String
                    self.picurl=preurl+url+"-style "
                }
                }, option: nil)
        }
        let view1=UIView(frame: CGRectMake(0, 0, self.tableView.frame.size.width, self.tableView.frame.size.height))
        view1.backgroundColor=UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0)
        
        
        activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.White)
        
        activityIndicatorView.frame = CGRectMake(self.tableView.frame.size.width/2-100, -30, 200, 200)
        
        activityIndicatorView.hidesWhenStopped = true
        
        activityIndicatorView.color = UIColor.blackColor()
        view1.addSubview(activityIndicatorView)
        self.tableView.addSubview(view1)
        activityIndicatorView.startAnimating()
        print("发帖完成")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if(section==2){
            return 30
        }
        return 30
    }
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if(section==0){
            return "话题标题"
        }else if(section==1){
            return "话题内容"
        }
        return "上传图片"
    }
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if(indexPath.section==0){
            return 50
        }else if(indexPath.section==1){
            return self.view.frame.width/3
        }
        let width=(self.view.frame.width-50)/4+10
        return CGFloat(self.assets.count/4+1)*width+10
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell=UITableViewCell()
        if(indexPath.section==0){
            let title=UITextField(frame: CGRectMake(0,10,self.view.frame.width,25))
            title.placeholder="请输入标题"
            title.tag=1
            title.font=UIFont.systemFontOfSize(18)
            if(self.first != ""){
                title.text=first
            }
            
            cell.addSubview(title)
        }else if(indexPath.section==1){
            let content=UITextView(frame: CGRectMake(0,0,self.view.frame.width,self.view.frame.width/3))
            content.font=UIFont.systemFontOfSize(17)
            content.tag=2
            if(self.content != ""){
                content.text=self.content
            }
            cell.addSubview(content)
        }else{
            let width=(self.view.frame.width-50)/4+10
            for i in 0...self.assets.count{
                
                if(i<self.assets.count){
                    let img=UIImageView(frame: CGRectMake(10+width*CGFloat(i%4), 10+width*CGFloat(i/4), width-10, width-10))
                    img.image=self.assets[i].thumbnailImage
                    cell.addSubview(img)
                }else{
                    let add=UIButton(frame: CGRectMake(10+width*CGFloat(i%4), 10+width*CGFloat(i/4), width-10, width-10))
                    add.addTarget(self, action: Selector("AddPicture"), forControlEvents: UIControlEvents.TouchUpInside)
                    add.setBackgroundImage(UIImage(named: "上传照片2.png"), forState: UIControlState.Normal)
                    cell.addSubview(add)
                }
                
            }
        }
        return cell
    }
    func AddPicture(){
        let title=self.view.viewWithTag(1) as! UITextField
        let content=self.view.viewWithTag(2) as! UITextView
        if((title.text) != nil){
            self.first=title.text!
        }
        if((content.text) != nil){
            self.content=content.text!
        }
        self.showImagePickerWithAssetType(DKImagePickerControllerAssetType.allPhotos)
    }

}
