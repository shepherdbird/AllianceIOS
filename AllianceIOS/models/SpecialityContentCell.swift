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
    var imageurls:String?
    var imagecount:Int?
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
        
        
    }
    
    func addpic(){
        let images:Array<String>=(self.imageurls?.componentsSeparatedByString(" "))!
        self.imagecount=images.count
        
        for i in 0...self.imagecount!-1{
            if (i<4){
                let detail=UIImageView(frame: CGRectMake(CGFloat(10+84*i), 60, 80, 80))
                
                detail.sd_setImageWithURL(NSURL(string: (images[i])), placeholderImage: UIImage(named: "avator.jpg"))
                self.addSubview(detail)
            }
//            else if(i>=4&&i<8){
//                let detail=UIImageView(frame: CGRectMake(CGFloat(10+84*(i%4)), 60+84, 80, 80))
//                detail.sd_setImageWithURL(NSURL(string: (images[i])), placeholderImage: UIImage(named: "avator.jpg"))
//                self.addSubview(detail)
//            }else{
//                let detail=UIImageView(frame: CGRectMake(CGFloat(10+84*(i%8)), 60+84*2, 80, 80))
//                detail.sd_setImageWithURL(NSURL(string: (images[i])), placeholderImage: UIImage(named: "avator.jpg"))
//                self.addSubview(detail)
//            }
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
