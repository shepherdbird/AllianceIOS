//
//  HobbyReqController.swift
//  AllianceIOS
//
//  Created by dawei on 15/11/1.
//
//

import UIKit
import DKImagePickerController
import Qiniu
import SwiftHTTP
import JSONJoy

class HobbyReqController: UITableViewController,UIPickerViewDelegate, UIPickerViewDataSource{

    var pk=UIPickerView()
    var alert:UIAlertController?
    
    var flag:Int?
    var xingbie=["女","男"]
    var assets: Array<DKAsset> = []
    var token:Qiniutoken.Item?
    var allhobbykind:Array<String>=[]
    var aihao:HobbyGlobal.Hobby?
    var activityIndicatorView: UIActivityIndicatorView!

    
    @IBOutlet weak var phototext: UITextView!
    @IBOutlet weak var content: UITextView!
    @IBOutlet weak var hobby: UILabel!
    @IBOutlet weak var age: UILabel!
    @IBOutlet weak var gender: UILabel!
    
    var picurl:String?
    {
        didSet
        {
            dispatch_async(dispatch_get_main_queue()){
                self.createhobby()
            }
        }

    }
    
    var Iscreate:Flag? {
        didSet
        {
            print(self.Iscreate?.msg)
            if (self.Iscreate?.flag==1){
                activityIndicatorView.stopAnimating()
                self.activityIndicatorView.hidden=true
                self.tableView.backgroundView=nil
                dispatch_async(dispatch_get_main_queue()){
                    self.navigationController?.popViewControllerAnimated(true)
                }
            }
            
        }
    }

    
    var mypho=UIImageView()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.backBarButtonItem=UIBarButtonItem(title: "", style: UIBarButtonItemStyle.Plain, target: nil, action: nil)
        self.navigationItem.rightBarButtonItem=UIBarButtonItem(title:"发帖", style: UIBarButtonItemStyle.Plain, target: self, action: Selector("CompletePost"))
        self.navigationItem.rightBarButtonItem?.tintColor=UIColor(red: 220/255, green: 100/255, blue: 100/255, alpha: 1.0)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        let tapGr=UITapGestureRecognizer.init(target: self, action: "viewTapped")
        tapGr.cancelsTouchesInView=false
        self.view.addGestureRecognizer(tapGr)
        
        let photo=UIButton(frame: CGRectMake(0, 20, 100, 100))
        photo.tag=1
        photo.addTarget(self, action:Selector("ButtonAction:"), forControlEvents: UIControlEvents.TouchUpInside)
        let jobInfoIco=UIImageView(frame: CGRectMake(0, 0, 100, 100))
        jobInfoIco.image=UIImage(named: "上传照片2.png")
        
        mypho=UIImageView(frame: CGRectMake(110, 20, 100, 100))
        //mypho.image=UIImage(named: "上传照片2.png")
        
        photo.addSubview(jobInfoIco)
        self.phototext.addSubview(photo)
        self.phototext.addSubview(mypho)
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)){
            self.gettoken()
        }
        for(var i=0;i<self.aihao?.items.count;i++){
            self.allhobbykind.append((self.aihao?.items[i].hobby)!)
        }
    }
    
    func viewTapped(){
        self.view.endEditing(true)
    }
    
    func ButtonAction(sender:UIButton){
        switch sender.tag {
        case 1:
        self.showImagePickerWithAssetType(DKImagePickerControllerAssetType.allPhotos)
        default:
            break
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
                self.mypho.image=assets[0].thumbnailImage
                self.assets = assets
               // self.preview?.reloadData()
            }
            
            self.presentViewController(pickerController, animated: true) {}
    }
    
    func gettoken(){
        print("ccccc")
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
    
    func createhobby(){
        do {
            var hobbyid:Int!
            for(var i=0;i<self.aihao?.items.count;i++){
                if(self.aihao?.items[i].hobby==self.hobby.text){
                    hobbyid=(self.aihao?.items[i].objID)!
                }
            }
            let sex=xingbie.indexOf(self.gender.text!)
            let params:Dictionary<String,AnyObject>=["phone":Phone,"sex":sex!,"age":self.age.text!,"hobbyid":hobbyid,"content":self.content.text!,"picture":self.picurl!]
            
            let opt=try HTTP.POST(URL+"/daters/create",parameters:params)
            opt.start { response in
                if let err = response.error {
                    print(err.localizedFailureReason)
                    print("error: \(err.localizedDescription)")
                    return //also notify app of failure as needed
                }
                
                print("opt finished: \(response.description)")
                print("data is: \(response.data)")
                self.Iscreate = Flag(JSONDecoder(response.data))
            }
        } catch let error {
            print("got an error creating the request: \(error)")
        }

    }
    
    func CompletePost(){

        let upManager = QNUploadManager()
        
        let preurl="http://7xoc8r.com2.z0.glb.qiniucdn.com/"
        
        for(var i=0;i<self.assets.count;i++){
            upManager.putData(self.assets[i].rawData, key: nil, token: self.token?.token, complete:  {(info, key, resp) -> Void in
                if (info.statusCode == 200 && resp != nil){
                    print("上传")
                    let url=resp["hash"] as! String
                    self.picurl=preurl+url+"-style"
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
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)){
            //self.connect()
        }
    }
    
        // MARK: - Table view data source
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if(indexPath.section==1){
            flag=1
            pk=UIPickerView(frame: CGRectMake(20,20,self.view.frame.width-70,150))
            pk.delegate=self
            pk.dataSource=self
            pk.selectRow(0, inComponent: 0, animated: true)
            let reqAction=UIAlertAction(title: "确定", style: UIAlertActionStyle.Default) { (action:UIAlertAction) -> Void in
                self.gender.text=self.xingbie[self.pk.selectedRowInComponent(0)]
                self.tableView.reloadData()
            }
            //            let CancelAction=UIAlertAction(title: "取消", style: UIAlertActionStyle.Default) { (action:UIAlertAction) -> Void in
            //                print("cancel")
            //            }
            alert=UIAlertController(title: "性别", message: "\n\n\n\n\n\n", preferredStyle: UIAlertControllerStyle.ActionSheet)
            alert!.addAction(reqAction)
            alert?.view.addSubview(pk)
            self.presentViewController(alert!, animated: true, completion: nil)
        }else if(indexPath.section==2){
            flag=0
            pk=UIPickerView(frame: CGRectMake(20,20,self.view.frame.width-70,150))
            pk.delegate=self
            pk.dataSource=self
            pk.selectRow(17, inComponent: 0, animated: true)
            let reqAction=UIAlertAction(title: "确定", style: UIAlertActionStyle.Default) { (action:UIAlertAction) -> Void in
                self.age.text=String(Int(self.pk.selectedRowInComponent(0))+1)
                self.tableView.reloadData()
            }
            //            let CancelAction=UIAlertAction(title: "取消", style: UIAlertActionStyle.Default) { (action:UIAlertAction) -> Void in
            //                print("cancel")
            //            }
            alert=UIAlertController(title: "年龄", message: "\n\n\n\n\n\n", preferredStyle: UIAlertControllerStyle.ActionSheet)
            alert!.addAction(reqAction)
            alert?.view.addSubview(pk)
            self.presentViewController(alert!, animated: true, completion: nil)
        }else if(indexPath.section==3){
            flag=2
            pk=UIPickerView(frame: CGRectMake(20,20,self.view.frame.width-70,150))
            pk.delegate=self
            pk.dataSource=self
            pk.selectRow(17, inComponent: 0, animated: true)
            let reqAction=UIAlertAction(title: "确定", style: UIAlertActionStyle.Default) { (action:UIAlertAction) -> Void in
                self.hobby.text=self.allhobbykind[self.pk.selectedRowInComponent(0)]
                self.tableView.reloadData()
            }
            //            let CancelAction=UIAlertAction(title: "取消", style: UIAlertActionStyle.Default) { (action:UIAlertAction) -> Void in
            //                print("cancel")
            //            }
            alert=UIAlertController(title: "爱好", message: "\n\n\n\n\n\n", preferredStyle: UIAlertControllerStyle.ActionSheet)
            alert!.addAction(reqAction)
            alert?.view.addSubview(pk)
            self.presentViewController(alert!, animated: true, completion: nil)
        }
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if(flag==0){
        return 100
        }else if(flag==1){
            return 2
        }else if(flag==2){
            return self.allhobbykind.count
        }
        return 0
    }
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if(flag==0){
            return String(row+1)
        }else if(flag==1){
            return xingbie[row]
        }else if(flag==2){
            return allhobbykind[row]
        }
        return "0"
    }


//    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }
//
//    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 0
//    }

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    */

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
