//
//  SendTopic.swift
//  AllianceIOS
//
//  Created by dawei on 15/11/16.
//
//

import UIKit
import SwiftHTTP
import JSONJoy

class SendTopic: UITableViewController ,UIImagePickerControllerDelegate,UINavigationControllerDelegate{

    @IBOutlet var ST: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.backBarButtonItem=UIBarButtonItem(title: "", style: UIBarButtonItemStyle.Plain, target: nil, action: nil)
        self.navigationItem.rightBarButtonItem=UIBarButtonItem(title:"发送", style: UIBarButtonItemStyle.Plain, target: self, action: Selector("CompletePost"))
        self.navigationItem.rightBarButtonItem?.tintColor=UIColor(red: 220/255, green: 100/255, blue: 100/255, alpha: 1.0)

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    func CompletePost(){
        print("聊吧-发表话题")
        do {
            let title=self.view.viewWithTag(1) as! UITextField
            let content=self.view.viewWithTag(2) as! UITextField
            let params:Dictionary<String,AnyObject>=["phone":Phone,"title":title.text!,"content":content.text!,"pictures":""]
            let new=try HTTP.POST(URL+"/tbmessages/send", parameters: params)
            new.start { response in
                if let err = response.error {
                    print("error: \(err.localizedDescription)")
                    return //also notify app of failure as needed
                }
                print("opt finished: \(response.description)")
                let flag = Flag(JSONDecoder(response.data))
                print(flag.flag,flag.msg)
                if (flag.flag==1){
                    print("OK")
                    
                }else{
                    print("Error")
                }
            }
            
        } catch let error {
            print("got an error creating the request: \(error)")
        }
        self.navigationController?.popViewControllerAnimated(true)
        
        
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
            return 10
        }
        return 30
    }
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if(section==0){
            return "话题标题"
        }else if(section==1){
            return "话题内容"
        }
        return ""
    }
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if(indexPath.section==0){
            return 50
        }else if(indexPath.section==1){
            return self.view.frame.width/3
        }
        return 100
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell=UITableViewCell()
        if(indexPath.section==0){
            let title=UITextField(frame: CGRectMake(0,10,self.view.frame.width,25))
            title.placeholder="请输入标题"
            title.tag=1
            title.font=UIFont.systemFontOfSize(18)
            cell.addSubview(title)
        }else if(indexPath.section==1){
            let content=UITextField(frame: CGRectMake(0,0,self.view.frame.width,self.view.frame.width/3))
            content.tag=2
            cell.addSubview(content)
        }else{
            let upload=UIButton(frame: CGRectMake(10,40,100,30))
            upload.layer.borderWidth=1
            upload.layer.borderColor=UIColor.grayColor().CGColor
            upload.clipsToBounds=true
            upload.layer.cornerRadius=3
            upload.setTitle("上传相片", forState: UIControlState.Normal)
            upload.addTarget(self, action: Selector("UploadImage"), forControlEvents: UIControlEvents.TouchUpInside)
            upload.setTitleColor(UIColor.grayColor(), forState: UIControlState.Normal)
            upload.titleLabel?.font=UIFont.systemFontOfSize(18)
            cell.addSubview(upload)
        }
        return cell
    }
    func UploadImage(){
        let pickerImage = UIImagePickerController()
        if !UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary){
            pickerImage.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
            pickerImage.mediaTypes = UIImagePickerController.availableMediaTypesForSourceType(pickerImage.sourceType)!
        }
        pickerImage.delegate = self
        pickerImage.allowsEditing = true
        self.presentViewController(pickerImage, animated: true, completion: nil)
    }
//    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]){
//        print("choose--------->>")
//        print(info)
//        let img = info[UIImagePickerControllerEditedImage] as! UIImage
//        //imgView.image = img
//        picker.dismissViewControllerAnimated(true, completion: nil)
//    }
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        print("choose--------->>")
        print(info)
        let img = info[UIImagePickerControllerEditedImage] as! UIImage
        //imgView.image = img
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    func imagePickerControllerDidCancel(picker: UIImagePickerController){
        print("cancel--------->>")
        picker.dismissViewControllerAnimated(true, completion: nil)
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
