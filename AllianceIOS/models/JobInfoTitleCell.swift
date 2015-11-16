//
//  JobInfoCell.swift
//  AllianceIOS
//
//  Created by dawei on 15/10/31.
//
//

import UIKit

class JobInfoTitleCell: UITableViewCell {
    
    var avator:UIImageView!
    var username:UILabel!
    var kind:UILabel!
    var job:UILabel!
    var time:UILabel!
    
    

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
        //全职/兼职
        self.kind=UILabel(frame: CGRectMake(54,30,30,15))
        self.kind.text="全职"
        self.kind.font=UIFont.systemFontOfSize(13)
        self.kind.textColor=UIColor(red: 111/255, green: 111/255, blue: 111/255, alpha: 1.0)
        self.kind.sizeToFit()
        self.addSubview(self.kind)
        //行业
        self.job=UILabel(frame: CGRectMake(84,30,30,15))
        self.job.text="金融"
        self.job.font=UIFont.systemFontOfSize(13)
        self.job.textColor=UIColor(red: 111/255, green: 111/255, blue: 111/255, alpha: 1.0)
        self.job.sizeToFit()
        self.addSubview(self.job)
        //时间
        self.time=UILabel(frame: CGRectMake(self.frame.width-20,10,20,15))
        self.time.text="11分钟前"
        self.time.font=UIFont.systemFontOfSize(13)
        self.time.textColor=UIColor(red: 111/255, green: 111/255, blue: 111/255, alpha: 0.44)
        self.time.sizeToFit()
        self.addSubview(self.time)
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
