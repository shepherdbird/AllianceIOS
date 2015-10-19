//
//  ChatCell.swift
//  AllianceIOS
//
//  Created by dawei on 15/9/23.
//
//

import UIKit

class ChatCell: UITableViewCell {
    //消息内容视图
    var customView:UILabel!
    
    //var bubbleImage:UIImageView!
    //头像
    var avatarImage:UIImageView!
    //消息数据结构
    var msgItem:MessageItem!
    
    //- (void) setupInternalData
    init(data:MessageItem, reuseIdentifier cellId:String)
    {
        print(data.avatar+"ee")
        self.msgItem=MessageItem(avatar: data.avatar, date: data.date, content: data.content, from: data.from, to: data.to)
//        self.msgItem.avatar = data.avatar
//        self.msgItem.content=data.content
//        self.msgItem.date=data.date
//        self.msgItem.from=data.from
//        self.msgItem.to=data.to
        super.init(style: UITableViewCellStyle.Default, reuseIdentifier:cellId)
        rebuildUserInterface()
    }
    func rebuildUserInterface()
    {
        
        self.selectionStyle = UITableViewCellSelectionStyle.None
//        if (self.bubbleImage == nil)
//        {
//            self.bubbleImage = UIImageView()
//            self.addSubview(self.bubbleImage)
//            
//        }
        self.avatarImage=UIImageView(image: UIImage(named: (self.msgItem.avatar != "" ? self.msgItem.avatar : "mango")))
        //别人头像，在左边，我的头像在右边
        let avatarX =  (self.msgItem.to == "dawei") ? 2 : self.frame.width - 52
        //头像居于消息底部
        let avatarY =  self.frame.minY
        //set the frame correctly
        self.avatarImage.frame = CGRectMake(avatarX, avatarY, 40, 40)
        self.avatarImage.clipsToBounds=true
        self.avatarImage.layer.cornerRadius=self.avatarImage.bounds.width*0.5
        self.addSubview(self.avatarImage)
        self.customView=UILabel()
        self.customView.text=self.msgItem.content
        self.customView.frame=CGRectMake(54, self.frame.minY, self.frame.width-110, 40)
        self.customView.backgroundColor=UIColor.greenColor()
        self.addSubview(self.customView)
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
