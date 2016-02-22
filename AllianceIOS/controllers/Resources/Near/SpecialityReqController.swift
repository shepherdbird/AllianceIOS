//
//  SpecialityReqController.swift
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

class SpecialityReqController: UITableViewController,UICollectionViewDataSource, UICollectionViewDelegate{

    @IBOutlet weak var preview: UICollectionView!
    var assets: Array<DKAsset> = []
    
    @IBOutlet weak var spkind: UILabel!
    @IBOutlet weak var Sptitle: UITextField!
    @IBOutlet weak var Reason: UITextView!
    @IBOutlet weak var phone: UITextField!
    
    @IBOutlet weak var Location: UITextField!
    
    struct res : JSONJoy {
        var flag: Int?
        var msg: String?
        init(_ decoder: JSONDecoder) {
            flag = decoder["flag"].integer
            msg=decoder["msg"].string
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
    var token:Qiniutoken.Item?
    var activityIndicatorView: UIActivityIndicatorView!
    
    var Iscreate:res? {
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
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.backBarButtonItem=UIBarButtonItem(title: "", style: UIBarButtonItemStyle.Plain, target: nil, action: nil)
        self.navigationItem.rightBarButtonItem=UIBarButtonItem(title:"发帖", style: UIBarButtonItemStyle.Plain, target: self, action: Selector("CompletePost"))
        self.navigationItem.rightBarButtonItem?.tintColor=UIColor(red: 220/255, green: 100/255, blue: 100/255, alpha: 1.0)
        
        self.preview.backgroundColor=UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
        let tapGr=UITapGestureRecognizer.init(target: self, action: "viewTapped")
        tapGr.cancelsTouchesInView=false
        self.view.addGestureRecognizer(tapGr)
       
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)){
            self.gettoken()
        }
    }
    func viewTapped(){
        self.view.endEditing(true)
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
                self.preview?.reloadData()
            }
            
            self.presentViewController(pickerController, animated: true) {}
    }

    func gettoken(){
        print("ccccc")
        do {
            let opt=try HTTP.GET(URL+"/v1/users/token")
            
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
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
        if(indexPath.section==1){
            print("性质")
            let anotherView=SpecialityKindController()
            anotherView.Sepcreq=self
            anotherView.selected=self.spkind.text
            self.navigationController?.pushViewController(anotherView, animated: true)
        }
    }


    // MARK: - Table view data source

//    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }
//
//    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 0
//    }

    // MARK: - UICollectionViewDataSource, UICollectionViewDelegate methods
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       // return self.assets?.count ?? 0
       
        if(self.assets.count==0){
            return 1
        }else{
            return (self.assets.count)+1
        }
        
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        var asset:DKAsset?
        if(indexPath.row>0){
           asset = self.assets[indexPath.row-1]
        }
        
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CellImage", forIndexPath: indexPath)
            
            let imageView = cell.contentView.viewWithTag(5) as! UIImageView
        if (indexPath.row>0){
            imageView.image = asset!.thumbnailImage
        }else{
            imageView.image=UIImage(named: "上传照片2.png")
        }
        
            return cell
        
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if(indexPath.row==0){
            
            self.showImagePickerWithAssetType(DKImagePickerControllerAssetType.allPhotos)
        }else{
       // let asset = self.assets![indexPath.row]
        }
        
        
    }

    
    func connect(){
        do {
            let params:Dictionary<String,AnyObject>=["phone":Phone,"kindid":"1","title":self.Sptitle.text!,"sellerphone":self.phone.text!,"reason":self.Reason.text!,"location":self.Location.text!,"pictures":self.allurl,"longitude":"1","latitude":"1"]
            
            let opt=try HTTP.POST(URL+"/recommendations/create",parameters:params)
            opt.start { response in
                if let err = response.error {
                    print(err.localizedFailureReason)
                    print("error: \(err.localizedDescription)")
                    return //also notify app of failure as needed
                }
                
                print("opt finished: \(response.description)")
                print("data is: \(response.data)")
                self.Iscreate = res(JSONDecoder(response.data))
            }
        } catch let error {
            print("got an error creating the request: \(error)")
        }
        
    }
    
    func CompletePost(){
        //let anotherView:UIViewController=self.storyboard!.instantiateViewControllerWithIdentifier("Speciality");
        //self.navigationController?.pushViewController(anotherView, animated: true)
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
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)){
            //self.connect()
        }

        
        //self.navigationController?.popViewControllerAnimated(true)
        print("发帖完成")
    }
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
