//
//  SpecialityTitleCell.swift
//  AllianceIOS
//
//  Created by dawei on 15/11/1.
//
//

import UIKit

class SpecialityTitleCell: UITableViewCell {

    var avator:UIImageView!
    var username:UILabel!
    var location:UILabel!
    var kind:UILabel!
    var time:UILabel!
    var messageIcon:UIImageView!
    var messageCount:UILabel!
    
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
        self.avator=UIImageView(frame: CGRectMake(10, 8, 34, 34))
        self.avator.image=UIImage(named: "avator.jpg")
        self.avator.clipsToBounds=true
        self.avator.layer.cornerRadius=self.avator.bounds.width*0.5
        self.addSubview(self.avator)
        //用户昵称
        self.username=UILabel(frame: CGRectMake(54,10,60,15))
        self.username.text="用户昵称"
        self.username.font=UIFont.systemFontOfSize(15)
        self.username.textColor=UIColor(red: 111/255, green: 111/255, blue: 111/255, alpha: 1.0)
        self.username.sizeToFit()
        self.addSubview(self.username)
        //位置
        self.location=UILabel(frame: CGRectMake(54,30,30,15))
        self.location.text="浦东新区"
        self.location.font=UIFont.systemFontOfSize(13)
        self.location.textColor=UIColor(red: 111/255, green: 111/255, blue: 111/255, alpha: 1.0)
        self.location.sizeToFit()
        self.addSubview(self.location)
        //推荐种类
        self.kind=UILabel(frame: CGRectMake(114,30,30,15))
        self.kind.text="外卖"
        self.kind.font=UIFont.systemFontOfSize(13)
        self.kind.textColor=UIColor(red: 111/255, green: 111/255, blue: 111/255, alpha: 1.0)
        self.kind.sizeToFit()
        self.addSubview(self.kind)
        //时间
        self.time=UILabel(frame: CGRectMake(self.frame.width-45,10,20,15))
        self.time.text=String(arc4random()%60)+"分钟前"
        self.time.font=UIFont.systemFontOfSize(12)
        self.time.textColor=UIColor(red: 111/255, green: 111/255, blue: 111/255, alpha: 0.44)
        self.time.sizeToFit()
        self.addSubview(self.time)
        //消息图标
        self.messageIcon=UIImageView(frame: CGRectMake(self.frame.width+10, 12, 12, 12))
        self.messageIcon.image=UIImage(named: "评论图标.png")
        self.addSubview(self.messageIcon)
        //评论数
        self.messageCount=UILabel(frame: CGRectMake(self.frame.width+25,10,15,15))
        self.messageCount.text=String(arc4random()%100)
        self.messageCount.font=UIFont.systemFontOfSize(12)
        self.messageCount.textColor=UIColor.redColor()
        self.messageCount.sizeToFit()
        self.addSubview(self.messageCount)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
