//
//  Chat.swift
//  AllianceIOS
//
//  Created by dawei on 15/11/13.
//
//

import UIKit
import SwiftHTTP
import JSONJoy

class Chat: UIViewController {
    
    var index=0
    var alert:UIAlertController!
    let newest=NewestMessage()
    let hotest=HotestMessage()
    let myconcerns=MyConcerns()
    let pop=PopularityPeople()
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.backBarButtonItem=UIBarButtonItem(title: "", style: UIBarButtonItemStyle.Plain, target: nil, action: nil)
        var lin=Array<UIBarButtonItem>()
        
        lin.append(UIBarButtonItem(image: UIImage(named: "我图标.png"), style: UIBarButtonItemStyle.Plain, target: self, action: Selector("mine")))
        lin.append(UIBarButtonItem(image: UIImage(named: "发表新话题.png"), style: UIBarButtonItemStyle.Plain, target: self, action: Selector("send")))
        let center=UILabel(frame: CGRectMake(0,0,50,50))
        center.text="聊吧"
        center.font=UIFont.systemFontOfSize(20)
        center.textColor=UIColor.whiteColor()
        self.navigationItem.titleView=center
        //self.navigationItem.rightBarButtonItem=UIBarButtonItem(image: UIImage(named: "发帖按钮.png"), style: UIBarButtonItemStyle.Plain, target: self, action: Selector("mine"))
        self.navigationItem.setRightBarButtonItems(lin, animated: true)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        let reqAction=UIAlertAction(title: "发表话题", style: UIAlertActionStyle.Default) { (action:UIAlertAction) -> Void in
            let anotherView=SendTopic()
            self.navigationController?.pushViewController(anotherView, animated: true)
        }
        let myreqAction=UIAlertAction(title: "我的聊吧", style: UIAlertActionStyle.Default) { (action:UIAlertAction) -> Void in
            let anotherView=MyTopicCenter()
            self.navigationController?.pushViewController(anotherView, animated: true)
        }
        alert=UIAlertController(title: "", message: "", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(reqAction)
        alert.addAction(myreqAction)
        self.view.backgroundColor=UIColor.whiteColor()
        let segmented=UISegmentedControl(frame: CGRectMake(0, -3, self.view.frame.width, 43))
        segmented.insertSegmentWithTitle("最新", atIndex: 0, animated: true)
        segmented.insertSegmentWithTitle("最热", atIndex: 1, animated: true)
        segmented.insertSegmentWithTitle("人气", atIndex: 2, animated: true)
        segmented.insertSegmentWithTitle("关注", atIndex: 3, animated: true)
        //segmented.center=self.view.center
        segmented.selectedSegmentIndex=0 //默认选中第二项
        segmented.alpha=1.0
        segmented.addTarget(self, action: "segmentDidchange:",
            forControlEvents: UIControlEvents.ValueChanged)  //添加值改变监听
        self.view.addSubview(segmented)
        newest.view.frame=CGRectMake(0, 40, self.view.frame.width, self.view.frame.height)
        hotest.view.frame=CGRectMake(0, 40, self.view.frame.width, self.view.frame.height)
        pop.view.frame=CGRectMake(0, 40, self.view.frame.width, self.view.frame.height)
        myconcerns.view.frame=CGRectMake(0, 40, self.view.frame.width, self.view.frame.height)
        self.addChildViewController(newest)
        self.addChildViewController(hotest)
        self.addChildViewController(pop)
        self.addChildViewController(myconcerns)
        self.view.addSubview(newest.view)
        
    }
    func send(){
        let myStoryBoard = UIStoryboard(name: "Main", bundle: nil)
        let anotherView:UIViewController=myStoryBoard.instantiateViewControllerWithIdentifier("SendTopic");
        self.navigationController?.pushViewController(anotherView, animated: true)
        //let anotherView=SendTopic()
        //self.navigationController?.pushViewController(anotherView, animated: true)
        //self.presentViewController(alert, animated: true, completion: nil)
    }
    func mine(){
        let myStoryBoard = UIStoryboard(name: "Main", bundle: nil)
        let anotherView:UIViewController=myStoryBoard.instantiateViewControllerWithIdentifier("MyTopicCenter");
        self.navigationController?.pushViewController(anotherView, animated: true)
        //let anotherView=MyTopicCenter()
        //self.navigationController?.pushViewController(anotherView, animated: true)
        //self.presentViewController(alert, animated: true, completion: nil)
    }
    func segmentDidchange(segmented:UISegmentedControl){
        //获得选项的索引
        print(segmented.selectedSegmentIndex)
        if(segmented.selectedSegmentIndex==0){
            
            hotest.removeFromParentViewController()
            pop.removeFromParentViewController()
            myconcerns.removeFromParentViewController()
            self.addChildViewController(newest)
            newest.RefreshData()
            self.view.addSubview(newest.view)
        }else if(segmented.selectedSegmentIndex==1){
            newest.removeFromParentViewController()
            pop.removeFromParentViewController()
            myconcerns.removeFromParentViewController()
            self.addChildViewController(hotest)
            hotest.RefreshData()
            self.view.addSubview(hotest.view)
        }else if(segmented.selectedSegmentIndex==2){
            newest.removeFromParentViewController()
            hotest.removeFromParentViewController()
            myconcerns.removeFromParentViewController()
            self.addChildViewController(pop)
            pop.RefreshData()
            self.view.addSubview(pop.view)
        }else{
            newest.removeFromParentViewController()
            hotest.removeFromParentViewController()
            pop.removeFromParentViewController()
            self.addChildViewController(myconcerns)
            myconcerns.RefreshData()
            self.view.addSubview(myconcerns.view)
        }
        
        //获得选择的文字
        print(segmented.titleForSegmentAtIndex(segmented.selectedSegmentIndex))
    }

}
