//
//  SpecialityContentCell.swift
//  AllianceIOS
//
//  Created by dawei on 15/11/1.
//
//

import UIKit

class SpecialityContentCell: UITableViewCell {

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
        self.title.text="这里有家很不错的店"
        self.title.font=UIFont.systemFontOfSize(18)
        self.title.textColor=UIColor.blackColor()
        self.title.sizeToFit()
        self.addSubview(self.title)
        //内容
        self.content=UILabel(frame: CGRectMake(10,35,self.frame.width-10,20))
        self.content.numberOfLines=0
        self.content.text="他们家还可以送外卖呀，快来看呀。"
        self.content.font=UIFont.systemFontOfSize(13)
        self.content.textColor=UIColor(red: 111/255, green: 111/255, blue: 111/255, alpha: 1.0)
        self.content.sizeToFit()
        self.addSubview(self.content)
        for i in 0...2 {
            let detail=UIImageView(frame: CGRectMake(CGFloat(10+90*i), 60, 80, 80))
            detail.image=UIImage(named: "food.jpg")
            self.addSubview(detail)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}
