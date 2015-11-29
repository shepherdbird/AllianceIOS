//
//  HobbyCell.swift
//  AllianceIOS
//
//  Created by dawei on 15/11/1.
//
//

import UIKit

class HobbyCell: UITableViewCell {

    var avator:UIImageView!
    var username:UILabel!
    var gender:UIImageView!
    var age:UILabel!
    var interest:UILabel!
    //var content:UILabel!
    var distance:UILabel!
    var time:UILabel!
    var genderflag:String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        //头像
        self.avator=UIImageView(frame: CGRectMake(10, 10,80, 80))
        self.avator.image=UIImage(named: "avator.jpg")
        self.avator.clipsToBounds=true
        self.avator.layer.cornerRadius=10
        self.addSubview(self.avator)
        //用户昵称
        self.username=UILabel(frame: CGRectMake(100,15,60,20))
        self.username.text="周子琰"
        self.username.font=UIFont.systemFontOfSize(18)
        //self.username.textColor=UIColor(red: 111/255, green: 111/255, blue: 111/255, alpha: 1.0)
        self.username.sizeToFit()
        self.addSubview(self.username)
        //性别图标
        self.gender=UIImageView(frame: CGRectMake(100, 37, 40, 20))
//        if(Int(self.genderflag!)!%2==0){
//            self.gender.image=UIImage(named: "标签男.png")
//        }else{
//            self.gender.image=UIImage(named: "标签女.png")
//        }
        self.addSubview(self.gender)
        //年龄
        self.age=UILabel(frame: CGRectMake(120,40,20,20))
        self.age.text=String(arc4random()%20+10)
        self.age.font=UIFont.systemFontOfSize(15)
        self.age.textColor=UIColor.whiteColor()
        self.age.sizeToFit()
        self.addSubview(self.age)
        //兴趣&留言
        self.interest=UILabel(frame: CGRectMake(100,60,self.frame.width-100,40))
        self.interest.numberOfLines=0
        self.interest.text="兴趣分组：家居/宠物\n留言：新发型大家还喜欢么?"
        self.interest.font=UIFont.systemFontOfSize(14)
        self.interest.textColor=UIColor(red: 111/255, green: 111/255, blue: 111/255, alpha: 1.0)
        self.interest.sizeToFit()
        self.addSubview(self.interest)
        //距离
        self.distance=UILabel(frame: CGRectMake(self.frame.width-50,15,20,15))
        self.distance.text=String(Float(arc4random()%100)/100)+"km"
        self.distance.font=UIFont.systemFontOfSize(12)
        self.distance.textColor=UIColor(red: 186/255, green: 186/255, blue: 186/255, alpha: 1.0)
        self.distance.sizeToFit()
        self.addSubview(self.distance)
        //时间
        self.time=UILabel(frame: CGRectMake(self.frame.width-5,15,25,15))
        self.time.text=String(arc4random()%60)+"分钟前"
        self.time.font=UIFont.systemFontOfSize(12)
        self.time.textColor=UIColor(red: 186/255, green: 186/255, blue: 186/255, alpha: 1.0)
        self.time.sizeToFit()
        self.addSubview(self.time)
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
