//
//  ChargeRecord.swift
//  AllianceIOS
//
//  Created by dawei on 15/11/8.
//
//

import UIKit
import SwiftHTTP
import JSONJoy

class ChargeRecord: UIViewController {
    var index:Int=0
//    var activityIndicatorView: UIActivityIndicatorView!
//    var GrabCommodity:GrabCommodityRecord?
//    var GrabCorns:GrabcornsList?
//        {
//        didSet{
//            activityIndicatorView.stopAnimating()
//            self.activityIndicatorView.hidden=true
//            self.tableView.backgroundView=nil
//            //self.tableView.reloadData()
//            dispatch_async(dispatch_get_main_queue()){
//                self.tableView.reloadData()
//                self.tableView.refreshFooter.endRefresh()
//                self.tableView.refreshHeader.endRefresh()
//            }
//        }
//    }
    let commodity=CRCommodity()
    let corn=CRCorn()
    let got=CRGot()
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.navigationItem.backBarButtonItem=UIBarButtonItem(title: "", style: UIBarButtonItemStyle.Plain, target: nil, action: nil)
        self.view.backgroundColor=UIColor.whiteColor()
        let segmented=UISegmentedControl(frame: CGRectMake(0, -3, self.view.frame.width, 53))
        segmented.insertSegmentWithTitle("夺宝列表", atIndex: 0, animated: true)
        segmented.insertSegmentWithTitle("夺金列表", atIndex: 1, animated: true)
        segmented.insertSegmentWithTitle("中奖列表", atIndex: 2, animated: true)
        //segmented.center=self.view.center
        segmented.selectedSegmentIndex=0 //默认选中第二项
        segmented.alpha=1.0
        segmented.addTarget(self, action: "segmentDidchange:",
            forControlEvents: UIControlEvents.ValueChanged)  //添加值改变监听
        self.view.addSubview(segmented)
        commodity.view.frame=CGRectMake(0, 50, self.view.frame.width, self.view.frame.height)
        corn.view.frame=CGRectMake(0, 50, self.view.frame.width, self.view.frame.height)
        got.view.frame=CGRectMake(0, 50, self.view.frame.width, self.view.frame.height)
        self.addChildViewController(commodity)
        self.addChildViewController(corn)
        self.addChildViewController(got)
        self.view.addSubview(commodity.view)

    }
    func segmentDidchange(segmented:UISegmentedControl){
        //获得选项的索引
        print(segmented.selectedSegmentIndex)
        if(segmented.selectedSegmentIndex==1){
            
            commodity.removeFromParentViewController()
            got.removeFromParentViewController()
            self.view.addSubview(corn.view)
        }else if(segmented.selectedSegmentIndex==0){
            corn.removeFromParentViewController()
            got.removeFromParentViewController()
            self.view.addSubview(commodity.view)
        }else{
            corn.removeFromParentViewController()
            commodity.removeFromParentViewController()
            self.view.addSubview(got.view)
        }
        
        //获得选择的文字
        print(segmented.titleForSegmentAtIndex(segmented.selectedSegmentIndex))
    }

}
