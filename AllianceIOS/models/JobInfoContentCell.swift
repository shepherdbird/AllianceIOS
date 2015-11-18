//
//  JobInfoContentCell.swift
//  AllianceIOS
//
//  Created by dawei on 15/10/31.
//
//

import UIKit

class JobInfoContentCell: UITableViewCell {

    var title:UILabel!
    var content:UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        //求职标题
        self.title=UILabel(frame: CGRectMake(10,10,self.bounds.width-20,20))
        self.title.text="求一个销售顾问的职位"
        self.title.font=UIFont.systemFontOfSize(18)
        self.title.textColor=UIColor.blackColor()
        self.title.sizeToFit()
        self.addSubview(self.title)
        //内容
        self.content=UILabel(frame: CGRectMake(10,35,self.frame.width-10,110))
        self.content.numberOfLines=0
       self.content.text="学历：本科\n参加工作时间：2013-07\n目前状况：我目前处于离职状态，可立即上岗\n留言：本人有两年销售经验，现在离职在家，想换一个新的环境，本人有两年销售经验，现在离职在家，想换一个新的环境"
        self.content.font=UIFont.systemFontOfSize(14)
        self.content.textColor=UIColor(red: 111/255, green: 111/255, blue: 111/255, alpha: 1.0)
        self.content.sizeToFit()
        self.addSubview(self.content)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
