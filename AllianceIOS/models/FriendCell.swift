//
//  FriendCell.swift
//  AllianceIOS
//
//  Created by dawei on 15/9/17.
//
//
import UIKit
let oceanim_friends_cell_heigth:CGFloat! = 50
class FriendCell: UITableViewCell {
    
    var oceanim_friends_head_img:UIImageView!
    var oceanim_friends_name_lab:UILabel!
    var oceanim_friends_status_btn:UIButton!
    
    var oceanim_img_w_h:CGFloat! = 50
    
    var userModel:UserModel!
    var oceanImFriendsViewController:FriendController!
    
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
        
        self.oceanim_friends_head_img = UIImageView(frame: CGRectMake(10, (oceanim_friends_cell_heigth - (self.oceanim_img_w_h - 20)) / 2, self.oceanim_img_w_h-20, self.oceanim_img_w_h-20))
        self.oceanim_friends_head_img.image = UIImage(named: "mango")
        
        
        self.oceanim_friends_name_lab = UILabel(frame: CGRectMake(self.oceanim_img_w_h, (oceanim_friends_cell_heigth - 20) / 2, CGRectGetWidth(self.bounds) - self.oceanim_img_w_h - 66, 20))
        //self.oceanim_friends_name_lab?.font = UIFont.boldSystemFontOfSize(20)
        self.oceanim_friends_name_lab?.text = "用户名字"
        self.oceanim_friends_name_lab?.textColor = UIColor.blackColor()
        
        
        self.oceanim_friends_status_btn = UIButton(frame: CGRectMake(CGRectGetWidth(self.bounds) - 100 - 20, 25, 100, 30))
        
        self.oceanim_friends_status_btn?.setTitle("聊天", forState: UIControlState.Normal)
        self.oceanim_friends_status_btn?.layer.cornerRadius = 5
        self.oceanim_friends_status_btn.titleLabel?.font = UIFont.boldSystemFontOfSize(14)
        self.oceanim_friends_status_btn?.userInteractionEnabled = true
        self.oceanim_friends_status_btn?.hidden = true
        self.oceanim_friends_status_btn?.backgroundColor = UIColor.orangeColor()
        self.oceanim_friends_status_btn?.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        self.oceanim_friends_status_btn?.addTarget(self, action: "oceanim_friends_status_btnClick", forControlEvents: UIControlEvents.TouchUpInside)
        
        
        self.addSubview(self.oceanim_friends_head_img)
        self.addSubview(self.oceanim_friends_name_lab)
        self.addSubview(self.oceanim_friends_status_btn)
        
        //        self.addSubview(self.oceanim_chat_message_context_view)
        
        //        self.oceanim_friends_name_lab.backgroundColor = UIColor.greenColor()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    /**
    * 用户所属状态<br>
    *
    * 我的好友         1<br>
    * 对我发出邀请的    2<br>
    * 我发出好友邀请的  3<br>
    * 未知            4<br>
    * 手机号好友       5<br>
    * 群聊            10<br>
    */
    func configContact(user:UserModel!,oceanImFriendsViewController:FriendController!){
        
        self.oceanImFriendsViewController = oceanImFriendsViewController
        self.oceanim_friends_name_lab.text = user.userName
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
}
