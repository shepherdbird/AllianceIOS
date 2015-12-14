//
//  MessageView.swift
//  AllianceIOS
//
//  Created by dawei on 15/12/13.
//
//

import UIKit
import SwiftHTTP
import JSONJoy

class MessageView: UIViewController ,UITextFieldDelegate{

    let textFeild=UITextField()
    let keyBaordView=UIView()
    let back=UIView()
    var pivot=0
    var TbMessageId:Int=0
    let detail=MessageDetail()
    var alert:UIAlertController?
    var Fg:Flag?
        {
        didSet{
            let reqAction=UIAlertAction(title: "确定", style: UIAlertActionStyle.Default) { (action:UIAlertAction) -> Void in
                //self.navigationController?.popViewControllerAnimated(true)
                self.detail.RefreshData()
            }
            alert=UIAlertController(title: "Success!", message: Fg?.msg, preferredStyle: UIAlertControllerStyle.Alert)
            if(Fg?.flag==0){
                alert?.title="Fail!"
            }
            alert!.addAction(reqAction)
            self.presentViewController(alert!, animated: true, completion: nil)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor=UIColor.whiteColor()
        
        detail.view.frame=CGRectMake(0, 0, self.view.frame.width, self.view.frame.height-50)
        
        self.addChildViewController(detail)
        detail.TbMessageId=TbMessageId
        detail.tableView.reloadData()
        self.view.addSubview(detail.view)
        print("messageview id: "+String(self.view.frame.height-50))
        let comment=UIButton(frame: CGRectMake(0,self.view.frame.height-120,self.view.frame.width/2-5,50))
        comment.setTitle("评论", forState: UIControlState.Normal)
        comment.titleLabel?.font=UIFont.systemFontOfSize(17)
        comment.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        comment.backgroundColor=UIColor(red: 186/255, green: 186/255, blue: 186/255, alpha: 1.0)
        comment.addTarget(self, action: Selector("Comment"), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(comment)
        let like=UIButton(frame: CGRectMake(self.view.frame.width/2+5,self.view.frame.height-120,self.view.frame.width/2-5,50))
        like.setTitle("喜欢", forState: UIControlState.Normal)
        like.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        like.titleLabel?.font=UIFont.systemFontOfSize(17)
        like.backgroundColor=UIColor(red: 186/255, green: 186/255, blue: 186/255, alpha: 1.0)
        like.addTarget(self, action: Selector("Like"), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(like)
        
        back.frame=self.view.frame
        keyBaordView.frame=CGRectMake(0, self.view.frame.height-117, self.view.frame.width, 50)
        print(self.view.frame.height)
        keyBaordView.backgroundColor=UIColor(red: 160/255, green: 160/255, blue: 160/255, alpha: 1.0)
        textFeild.frame=CGRectMake(20, 5, self.view.frame.width-40, 40)
        textFeild.delegate = self
        textFeild.placeholder = "评论："
        textFeild.returnKeyType = UIReturnKeyType.Send
        textFeild.borderStyle=UITextBorderStyle.RoundedRect
        textFeild.enablesReturnKeyAutomatically  = true
        //textFeild.backgroundColor=UIColor.blueColor()
        keyBaordView.addSubview(textFeild)
        //keyBaordView.backgroundColor=UIColor.redColor()
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action:"handleTouches:")
        tapGestureRecognizer.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tapGestureRecognizer)
        
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector:"keyBoardWillShow:", name:UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector:"keyBoardWillHide:", name:UIKeyboardWillHideNotification, object: nil)

        // Do any additional setup after loading the view.
    }
    func Like(){
        do {
            let params:Dictionary<String,AnyObject>=["phone":Phone,"tbmessageid":TbMessageId]
            let new=try HTTP.POST(URL+"/tbmessages/like", parameters: params)
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
    func Comment(){
        self.view.addSubview(back)
        self.view.addSubview(keyBaordView)
        //self.view.addSubview(textFeild)
        print("弹出评论框")
        pivot=1
        textFeild.becomeFirstResponder()
    }
    func textFieldShouldReturn(textField:UITextField) -> Bool
    {
        //收起键盘
        textFeild.resignFirstResponder()
        back.removeFromSuperview()
        keyBaordView.removeFromSuperview()
        pivot=0
        do {
            let params:Dictionary<String,AnyObject>=["tbmessageid":TbMessageId,"fphone":Phone,"tphone":"","content":textFeild.text!]
            let new=try HTTP.POST(URL+"/tbmessages/reply", parameters: params)
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
        textFeild.text=""
        //打印出文本框中的值
        print(textField.text!)
        return true;
    }
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        textFeild.resignFirstResponder()
        back.removeFromSuperview()
        keyBaordView.removeFromSuperview()
        pivot=0
    }
    func keyBoardWillShow(note:NSNotification)
    {
        let userInfo  = note.userInfo as! NSDictionary
        let  keyBoardBounds = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
        let duration = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as! NSNumber).doubleValue
        _ = self.view.convertRect(keyBoardBounds, toView:nil)
        _ = keyBaordView.frame
        let deltaY = keyBoardBounds.size.height
        let animations:(() -> Void) = {
            self.keyBaordView.transform = CGAffineTransformMakeTranslation(0,-deltaY)
        }
        if duration > 0 {
            let options = UIViewAnimationOptions(rawValue: UInt((userInfo[UIKeyboardAnimationCurveUserInfoKey] as! NSNumber).integerValue << 16))
            UIView.animateWithDuration(duration, delay: 0, options:options, animations: animations, completion: nil)
        }else{
            animations()
        }
    }
    func keyBoardWillHide(note:NSNotification)
    {
        let userInfo  = note.userInfo as! NSDictionary
        let duration = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as! NSNumber).doubleValue
        let animations:(() -> Void) = {
            self.keyBaordView.transform = CGAffineTransformIdentity
        }
        if duration > 0 {
            let options = UIViewAnimationOptions(rawValue: UInt((userInfo[UIKeyboardAnimationCurveUserInfoKey] as! NSNumber).integerValue << 16))
            UIView.animateWithDuration(duration, delay: 0, options:options, animations: animations, completion: nil)
        }else{
            
            animations()
        }
    }
    func handleTouches(sender:UITapGestureRecognizer){
        if(pivot==1){
            print(sender.locationInView(self.view).y,keyBaordView.frame.minY)
            if sender.locationInView(self.view).y < keyBaordView.frame.minY{
                textFeild.resignFirstResponder()
                back.removeFromSuperview()
                keyBaordView.removeFromSuperview()
                pivot=0
            }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
