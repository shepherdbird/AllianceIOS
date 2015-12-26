//
//  Wallet.swift
//  AllianceIOS
//
//  Created by dawei on 15/12/21.
//
//

import UIKit
import SwiftHTTP
import JSONJoy

class Wallet: UITableViewController {

    var activityIndicatorView: UIActivityIndicatorView!
    var view1=UIView()
    var AllMoneyInstance:AllMoney?
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
    }
    func connect(){
        print("个人中心钱包")
        do {
            let params:Dictionary<String,AnyObject>=["phone":Phone]
            let new=try HTTP.POST(URL+"/users/allmoney", parameters: params)
            new.start { response in
                if let err = response.error {
                    print("error: \(err.localizedDescription)")
                    return //also notify app of failure as needed
                }
                print("opt finished: \(response.description)")
                self.AllMoneyInstance = AllMoney(JSONDecoder(response.data))
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
        if((self.AllMoneyInstance) != nil){
            return 3
        }
        return 0
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section{
        case 0:
            return 2
        case 1:
            return 1
        default:
            return 1
        }
    }
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if(section==2){
            return 200
        }
        return 15
    }
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.001
    }
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        switch indexPath.section{
        case 0:
            if(indexPath.row==0){
                return 130
            }else{
                return 100
            }
//        case 1:
//            if(indexPath.row==0){
//                return 40
//            }else{
//                return 60
//            }
        case 1:
            return self.view.frame.width/4
        default:
            return 50
        }
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell=UITableViewCell()
        var boundingRect:CGRect
        switch indexPath.section{
        case 0:
            if(indexPath.row==0){
                let backgroud=UIButton(frame: CGRectMake(0,0,self.view.frame.width,130))
                backgroud.backgroundColor=UIColor(red: 34/255, green: 41/255, blue: 49/255, alpha: 1.0)
                cell.addSubview(backgroud)
                let Mymoneylabel=UILabel()
                Mymoneylabel.text="我的余额(元)"
                Mymoneylabel.font=UIFont.systemFontOfSize(20)
                Mymoneylabel.textColor=UIColor(red: 186/255, green: 186/255, blue: 186/255, alpha: 1.0)
                boundingRect=GetBounds(300, height: 100, font: Mymoneylabel.font, str: Mymoneylabel.text!)
                Mymoneylabel.frame=CGRectMake(self.view.frame.width/2-boundingRect.width/2,30,boundingRect.width,boundingRect.height)
                cell.addSubview(Mymoneylabel)
                let Mymoney=UILabel()
                Mymoney.text="¥"+String(self.AllMoneyInstance!.money)+".00"
                Mymoney.font=UIFont.systemFontOfSize(25)
                Mymoney.textColor=UIColor.whiteColor()
                boundingRect=GetBounds(300, height: 100, font: Mymoney.font, str: Mymoney.text!)
                Mymoney.frame=CGRectMake(self.view.frame.width/2-boundingRect.width/2,Mymoneylabel.frame.maxY+10,boundingRect.width,boundingRect.height)
                cell.addSubview(Mymoney)
            }else{
                let backgroud=UIButton(frame: CGRectMake(0,0,self.view.frame.width/3,100))
                backgroud.addTarget(self, action: Selector("ButtonAction:"), forControlEvents: UIControlEvents.TouchUpInside)
                backgroud.tag=1
                let cornlabel=UILabel()
                cornlabel.text="金币"
                cornlabel.font=UIFont.systemFontOfSize(20)
                cornlabel.textColor=UIColor(red: 186/255, green: 186/255, blue: 186/255, alpha: 1.0)
                boundingRect=GetBounds(300, height: 100, font: cornlabel.font, str: cornlabel.text!)
                cornlabel.frame=CGRectMake(self.view.frame.width/6-20,20,boundingRect.width,boundingRect.height)
                cell.addSubview(cornlabel)
                let corn=UILabel()
                corn.text=String(self.AllMoneyInstance!.corns)
                corn.font=UIFont.systemFontOfSize(23)
                boundingRect=GetBounds(300, height: 100, font: corn.font, str: corn.text!)
                corn.frame=CGRectMake(self.view.frame.width/6-boundingRect.width/2,cornlabel.frame.maxY+10,boundingRect.width,boundingRect.height)
                cell.addSubview(corn)
                cell.addSubview(backgroud)
                
                let backgroud2=UIButton(frame: CGRectMake(self.view.frame.width/3,0,self.view.frame.width/3,100))
                let grabcornlabel=UILabel()
                grabcornlabel.text="夺宝币"
                grabcornlabel.font=UIFont.systemFontOfSize(20)
                grabcornlabel.textColor=UIColor(red: 186/255, green: 186/255, blue: 186/255, alpha: 1.0)
                boundingRect=GetBounds(300, height: 100, font: grabcornlabel.font, str: grabcornlabel.text!)
                grabcornlabel.frame=CGRectMake(self.view.frame.width/3+self.view.frame.width/6-30,20,boundingRect.width,boundingRect.height)
                cell.addSubview(grabcornlabel)
                let grabcorn=UILabel()
                grabcorn.text=String(self.AllMoneyInstance!.cornsforgrab)
                grabcorn.font=UIFont.systemFontOfSize(23)
                boundingRect=GetBounds(300, height: 100, font: grabcorn.font, str: grabcorn.text!)
                grabcorn.frame=CGRectMake(self.view.frame.width/3+self.view.frame.width/6-boundingRect.width/2,grabcornlabel.frame.maxY+10,boundingRect.width,boundingRect.height)
                cell.addSubview(grabcorn)
                cell.addSubview(backgroud2)
                
                let backgroud3=UIButton(frame: CGRectMake(self.view.frame.width/3*2,0,self.view.frame.width/3,100))
                backgroud3.addTarget(self, action: Selector("ButtonAction:"), forControlEvents: UIControlEvents.TouchUpInside)
                backgroud3.tag=2
                let cardlabel=UILabel()
                cardlabel.text="银行卡"
                cardlabel.font=UIFont.systemFontOfSize(20)
                cardlabel.textColor=UIColor(red: 186/255, green: 186/255, blue: 186/255, alpha: 1.0)
                boundingRect=GetBounds(300, height: 100, font: cardlabel.font, str: cardlabel.text!)
                cardlabel.frame=CGRectMake(self.view.frame.width/3*2+self.view.frame.width/6-30,20,boundingRect.width,boundingRect.height)
                cell.addSubview(cardlabel)
                let card=UILabel()
                card.text=String(self.AllMoneyInstance!.cardcount)
                card.font=UIFont.systemFontOfSize(23)
                boundingRect=GetBounds(300, height: 100, font: card.font, str: card.text!)
                card.frame=CGRectMake(self.view.frame.width/3*2+self.view.frame.width/6-boundingRect.width/2,cardlabel.frame.maxY+10,boundingRect.width,boundingRect.height)
                cell.addSubview(card)
                cell.addSubview(backgroud3)
            }
//        case 1:
//            if(indexPath.row==0){
//                let label=UILabel(frame: CGRectMake(20,0,300,40))
//                label.text="联盟奖励"
//                label.font=UIFont.systemFontOfSize(20)
//                cell.addSubview(label)
//            }else{
//                let already=UILabel(frame: CGRectMake(20,20,self.view.frame.width/2,20))
//                already.text="已提取 ¥"+"0.00"
//                already.font=UIFont.systemFontOfSize(15)
//                already.textColor=UIColor(red: 186/255, green: 186/255, blue: 186/255, alpha: 1.0)
//                cell.addSubview(already)
//                
//                let have=UILabel(frame: CGRectMake(self.view.frame.width/2+20,20,self.view.frame.width/2,20))
//                have.text="未提取 ¥"+"60.00"
//                have.font=UIFont.systemFontOfSize(15)
//                have.textColor=UIColor(red: 186/255, green: 186/255, blue: 186/255, alpha: 1.0)
//                cell.addSubview(have)
//            }
        case 1:
            let corn1=UIImageView(frame: CGRectMake(self.view.frame.width/32*3,self.view.frame.width/16,self.view.frame.width/16,self.view.frame.width/16))
            corn1.image=UIImage(named: "充值.png")
            cell.addSubview(corn1)
            let corn1label=UILabel(frame: CGRectMake(self.view.frame.width/32*3-5,self.view.frame.width/32*5,33,20))
            corn1label.text="充值"
            corn1label.font=UIFont.systemFontOfSize(15)
            cell.addSubview(corn1label)
            let corn1btn=UIButton(frame: CGRectMake(0,0,self.view.frame.width/4,self.view.frame.width/4))
            corn1btn.addTarget(self, action: Selector("ButtonAction:"), forControlEvents: UIControlEvents.TouchUpInside)
            corn1btn.tag=3
            cell.addSubview(corn1btn)
            
            let corn2=UIImageView(frame: CGRectMake(self.view.frame.width/32*11,self.view.frame.width/16,self.view.frame.width/16,self.view.frame.width/16))
            corn2.image=UIImage(named: "提现.png")
            cell.addSubview(corn2)
            let corn2label=UILabel(frame: CGRectMake(self.view.frame.width/32*11-5,self.view.frame.width/32*5,33,20))
            corn2label.text="提现"
            corn2label.font=UIFont.systemFontOfSize(15)
            cell.addSubview(corn2label)
            let corn2btn=UIButton(frame: CGRectMake(self.view.frame.width/4,0,self.view.frame.width/4,self.view.frame.width/4))
            corn2btn.addTarget(self, action: Selector("ButtonAction:"), forControlEvents: UIControlEvents.TouchUpInside)
            corn2btn.tag=4
            cell.addSubview(corn2btn)
            
            let corn3=UIImageView(frame: CGRectMake(self.view.frame.width/32*19,self.view.frame.width/16,self.view.frame.width/16,self.view.frame.width/16))
            corn3.image=UIImage(named: "交易密码.png")
            cell.addSubview(corn3)
            let corn3label=UILabel(frame: CGRectMake(self.view.frame.width/32*19-15,self.view.frame.width/32*5,63,20))
            corn3label.text="支付密码"
            corn3label.font=UIFont.systemFontOfSize(15)
            cell.addSubview(corn3label)
            let corn3btn=UIButton(frame: CGRectMake(self.view.frame.width/2,0,self.view.frame.width/4,self.view.frame.width/4))
            corn3btn.addTarget(self, action: Selector("ButtonAction:"), forControlEvents: UIControlEvents.TouchUpInside)
            corn3btn.tag=5
            cell.addSubview(corn3btn)
            
            let corn4=UIImageView(frame: CGRectMake(self.view.frame.width/32*27,self.view.frame.width/16,self.view.frame.width/16,self.view.frame.width/16))
            corn4.image=UIImage(named: "交易记录.png")
            cell.addSubview(corn4)
            let corn4label=UILabel(frame: CGRectMake(self.view.frame.width/32*27-15,self.view.frame.width/32*5,63,20))
            corn4label.text="交易记录"
            corn4label.font=UIFont.systemFontOfSize(15)
            cell.addSubview(corn4label)
            let corn4btn=UIButton(frame: CGRectMake(self.view.frame.width/4*3,0,self.view.frame.width/4,self.view.frame.width/4))
            corn4btn.addTarget(self, action: Selector("ButtonAction:"), forControlEvents: UIControlEvents.TouchUpInside)
            corn4btn.tag=6
            cell.addSubview(corn4btn)
        default:
            let label=UILabel(frame: CGRectMake(20,0,300,50))
            label.text="常见问题"
            label.font=UIFont.systemFontOfSize(20)
            cell.addSubview(label)
        }
        return cell
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    func ButtonAction(sender:UIButton){
        switch sender.tag {
        case 1:
            let another=MyCorn()
            self.navigationController?.pushViewController(another, animated: true)
        default:
            let another=MyCorn()
            self.navigationController?.pushViewController(another, animated: true)
        }
    }

}
