//
//  MyTopicList.swift
//  AllianceIOS
//
//  Created by dawei on 15/11/16.
//
//

import UIKit
import SwiftHTTP
import JSONJoy

class MyTopicList: UITableViewController {

    @IBOutlet var MTL: UITableView!
    var activityIndicatorView: UIActivityIndicatorView!
    var view1=UIView()
    var MyTopicList:ChatMessageList?
        {
        didSet{
            activityIndicatorView.stopAnimating()
            self.activityIndicatorView.hidden=true
            self.tableView.backgroundView=nil
            self.tableView.reloadData()
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
    }
    func connect(){
        print("聊吧-我的话题")
        do {
            let params:Dictionary<String,AnyObject>=["phone":Phone]
            let new=try HTTP.POST(URL+"/tbmessages/me", parameters: params)
            new.start { response in
                if let err = response.error {
                    print("error: \(err.localizedDescription)")
                    return //also notify app of failure as needed
                }
                print("opt finished: \(response.description)")
                self.MyTopicList = ChatMessageList(JSONDecoder(response.data))
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
        if((MyTopicList) != nil){
            return MyTopicList!.items.count
        }
        return 0
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 5
    }
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5
    }
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 120
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
            let cell=UITableViewCell()
            let avator=UIImageView(frame: CGRectMake(5, 5, 30, 30))
            avator.clipsToBounds=true
            avator.layer.cornerRadius=15
            if let Ndata=NSData(contentsOfURL: NSURL(string: MyTopicList!.items[indexPath.row].thumb)!){
                avator.image=UIImage(data: Ndata)
            }
            cell.addSubview(avator)
            let name=UILabel(frame: CGRectMake(40,10,60,15))
            name.text=MyTopicList!.items[indexPath.section].nickname
            name.font=UIFont.systemFontOfSize(15)
            name.textColor=UIColor(red: 186/255, green: 186/255, blue: 186/255, alpha: 0.77)
            cell.addSubview(name)
            let time=UILabel(frame: CGRectMake(90,10,200,15))
            time.text=String(NSDate(timeIntervalSince1970: Double(MyTopicList!.items[indexPath.section].created_at)!))
            time.font=UIFont.systemFontOfSize(13)
            time.textColor=UIColor(red: 186/255, green: 186/255, blue: 186/255, alpha: 0.77)
            cell.addSubview(time)
            let title=UILabel(frame: CGRectMake(5,40,self.view.frame.width-40,25))
            title.text=MyTopicList!.items[indexPath.section].title
            title.font=UIFont.systemFontOfSize(17)
            //title.textColor=UIColor(red: 186/255, green: 186/255, blue: 186/255, alpha: 0.77)
            cell.addSubview(title)
            let content=UILabel(frame: CGRectMake(5,65,self.view.frame.width-10,30))
            content.text=MyTopicList!.items[indexPath.section].content
            content.font=UIFont.systemFontOfSize(15)
            content.numberOfLines=0
            content.textColor=UIColor(red: 111/255, green: 111/255, blue: 111/255, alpha: 1.0)
            cell.addSubview(content)
            let focus=UIButton(frame: CGRectMake(10,100,60,15))
            focus.setTitleColor(UIColor(red: 205/255, green: 49/255, blue: 37/255, alpha: 0.77), forState: UIControlState.Normal)
            focus.setTitle("删除", forState: UIControlState.Normal)
            focus.titleLabel?.font=UIFont.systemFontOfSize(13)
            focus.tag=1000+indexPath.section
            focus.addTarget(self, action: Selector("Delete:"), forControlEvents: UIControlEvents.TouchUpInside)
            cell.addSubview(focus)
            let like=UIImageView(frame: CGRectMake(self.view.frame.width/3*2, 100, 15, 15))
            like.image=UIImage(named: "喜欢1.png")
            cell.addSubview(like)
            let likeCount=UILabel(frame: CGRectMake(self.view.frame.width/3*2+15,100,50,15))
            likeCount.textColor=UIColor(red: 186/255, green: 186/255, blue: 186/255, alpha: 0.77)
            likeCount.text=MyTopicList!.items[indexPath.section].likecount
            likeCount.font=UIFont.systemFontOfSize(12)
            cell.addSubview(likeCount)
            
            let comment=UIImageView(frame: CGRectMake(self.view.frame.width/3*2+60, 100, 15, 15))
            comment.image=UIImage(named: "评论3.png")
            cell.addSubview(comment)
            let commentCount=UILabel(frame: CGRectMake(self.view.frame.width/3*2+80,100,50,15))
            commentCount.textColor=UIColor(red: 186/255, green: 186/255, blue: 186/255, alpha: 0.77)
            commentCount.text=MyTopicList!.items[indexPath.section].replycount
            commentCount.font=UIFont.systemFontOfSize(12)
            cell.addSubview(commentCount)
            return cell
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        MTL.deselectRowAtIndexPath(indexPath, animated: true)
        let anotherView:UIViewController=self.storyboard!.instantiateViewControllerWithIdentifier("TopicDetail");
        self.navigationController?.pushViewController(anotherView, animated: true)
    }
    func Delete(sender:UIButton){
        do {
            let params:Dictionary<String,AnyObject>=["phone":Phone,"tbmessageid":MyTopicList!.items[sender.tag-1000].id]
            let new=try HTTP.POST(URL+"/tbmessages/delete", parameters: params)
            new.start { response in
                if let err = response.error {
                    print("error: \(err.localizedDescription)")
                    return //also notify app of failure as needed
                }
                print("opt finished: \(response.description)")
                let flag = Flag(JSONDecoder(response.data))
                if(flag.flag==1){
                    print("删除成功")
                    self.MyTopicList!.items.removeAtIndex(sender.tag-1000)
                    self.tableView.reloadData()
                }
            }
            
        } catch let error {
            print("got an error creating the request: \(error)")
        }
    }

}
