//
//  SpecialityDetailController.swift
//  AllianceIOS
//
//  Created by dawei on 15/11/1.
//
//

import UIKit

class SpecialityDetailController: UITableViewController,TapImageViewDelegate,ImgScrollViewDelegate{

    @IBOutlet var detail: UITableView!
    
    let Key=["类型","地点","商家电话","推荐理由"]
    var Value=["外卖","浦东新区xx路","022-2245679","他们家还可以送外卖哟，大家快来看看"]
    var imageurls:String?
    var imagecount:Int?
    var nickname:String?
    var thumb:String?
    
    var reid:String?
    var myphone:String?
    var comments: Array<SpecialityController.Comments> = []
    var imagewidth:Int?
    
    var myTable:UITableView?
    var myScrollView:UIScrollView?
    var currentIndex:Int?
    
    var markView:UIView?
    var scrollPanel:UIView!
    var tapCell:UITableViewCell?
    var currentWindow:UIWindow?
    var pg=UIPageControl()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detail.rowHeight=UITableViewAutomaticDimension
        self.detail.allowsSelection=true
        self.detail.separatorStyle=UITableViewCellSeparatorStyle.SingleLine
        self.detail.backgroundColor=UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
        
        var footrect=CGRect()
        footrect.size.height=1
        let footview=UIView.init(frame: footrect)
        self.tableView.tableFooterView=footview
        
        let images:Array<String>=(self.imageurls?.componentsSeparatedByString(" "))!
        self.imagecount=images.count
        
        
         currentWindow=UIApplication.sharedApplication().keyWindow!
         pg.frame=CGRectMake((self.view.frame.width-40)/2, self.view.frame.height-40, 40, 5)
        pg.numberOfPages = self.imagecount!
        pg.currentPageIndicatorTintColor = UIColor.whiteColor()
        pg.pageIndicatorTintColor = UIColor.grayColor()
        pg.alpha=0
        
        scrollPanel=UIView.init(frame: currentWindow!.bounds)
        scrollPanel.backgroundColor = UIColor.clearColor();
        scrollPanel.alpha = 0;
        //self.view.addSubview(scrollPanel)
        
       
        currentWindow!.addSubview(scrollPanel)
        
        
        markView=UIView.init(frame: scrollPanel.bounds)
        markView!.backgroundColor = UIColor.blackColor()
        markView!.alpha = 0.0;
        scrollPanel.addSubview(markView!)
        scrollPanel.addSubview(pg)
        
        myScrollView=UIScrollView.init(frame: currentWindow!.bounds)
        scrollPanel.addSubview(myScrollView!)
        myScrollView!.pagingEnabled = true
        myScrollView!.delegate = self
        var contentSize:CGSize = myScrollView!.contentSize
        contentSize.height = currentWindow!.bounds.size.height
        contentSize.width = currentWindow!.bounds.size.width * CGFloat(self.imagecount!)
        myScrollView!.contentSize = contentSize
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addSubImgView(){
        self.myScrollView!.subviews.map({ $0.removeFromSuperview() })
        for (var j = 0;j<self.imagecount;j++){
            if (j == self.currentIndex)
            {
                continue;
            }
            let tmpView:TapImageView=tapCell?.viewWithTag(10 + j) as! TapImageView
            let convertRect:CGRect=(tmpView.superview?.convertRect(tmpView.frame, toView: currentWindow!))!
            let tmpImgScrollView:ImgScrollView=ImgScrollView.init(frame:CGRect(origin:CGPoint(x: CGFloat(j)*myScrollView!.bounds.size.width,y: CGFloat(0)),size: myScrollView!.bounds.size))
           
            
            tmpImgScrollView.setContentWithFrame(convertRect)
            tmpImgScrollView.setImage(tmpView.image)
            self.myScrollView?.addSubview(tmpImgScrollView)
            tmpImgScrollView.i_delegate=self
            tmpImgScrollView.setAnimationRect()
        }
        

    }
    
    func setOriginFrame(sender:ImgScrollView){
         UIApplication.sharedApplication().setStatusBarStyle(UIStatusBarStyle.LightContent, animated: false)
        UIView.animateWithDuration(0.4, animations:{
            sender.setAnimationRect()
            self.markView!.alpha = 1.0
            self.pg.alpha=1.0
            })
    }
    
    
    override func scrollViewDidEndDecelerating(scrollView:UIScrollView){
        let pageWidth:CGFloat=scrollView.frame.size.width
        self.currentIndex = Int(floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + CGFloat(1))
        pg.currentPage=self.currentIndex!
    }
    
    func tappedWithObject(sender:AnyObject){
        currentWindow!.bringSubviewToFront(self.scrollPanel)
        self.scrollPanel.bringSubviewToFront(self.pg)
        self.scrollPanel.alpha=1.0
        let tmpView:TapImageView=sender as! TapImageView
        self.currentIndex = tmpView.tag - 10
        pg.currentPage=self.currentIndex!
        
        self.tapCell = tmpView.identifier as? UITableViewCell
        let convertRect:CGRect=(tmpView.superview?.convertRect(tmpView.frame, toView: currentWindow!))!
        var contentOffset:CGPoint=self.myScrollView!.contentOffset
        contentOffset.x = CGFloat(self.currentIndex!*Int(currentWindow!.bounds.size.width))
        self.myScrollView!.contentOffset = contentOffset
        self.addSubImgView()
        
        let tmpImgScrollView:ImgScrollView=ImgScrollView.init(frame:CGRect(origin:contentOffset,size:myScrollView!.bounds.size))
        tmpImgScrollView.setContentWithFrame(convertRect)
        tmpImgScrollView.setImage(tmpView.image)
        self.myScrollView?.addSubview(tmpImgScrollView)
        tmpImgScrollView.i_delegate = self
        self.performSelector(Selector("setOriginFrame:"), withObject: tmpImgScrollView, afterDelay: 0.1)
        
    }
    
    func tapImageViewTappedWithObject(sender:AnyObject){
        self.pg.alpha=0.0
        let tmpImgView:ImgScrollView=sender as! ImgScrollView
        UIView.animateWithDuration(0.5, animations:{
            self.markView!.alpha = 0
            tmpImgView.rechangeInitRdct()
            }, completion:{finished in
                self.scrollPanel.alpha = 0
        })
        
        
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if(section==0){
            return 6
        }
        return self.comments.count+2
    }
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if(indexPath.section==0){
            if(indexPath.row==0){
                return 80
            }else if(indexPath.row==5){
                imagewidth=Int((self.view.bounds.size.width-35))/4
                if(self.imagecount<=4){
                    return CGFloat(20+self.imagewidth!)
                }else if(self.imagecount>4&&self.imagecount<=8){
                    return CGFloat(25+self.imagewidth!*2)
                }else{
                    return CGFloat(30+self.imagewidth!*3)
                }
                return 0
            }
            return 50
        }else{
            if(indexPath.row==0){
                return 30
            }
            return 80
        }
    }
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:UITableViewCell=UITableViewCell()
        
        let username:UILabel!
        let IComment:UILabel!
        let key:UILabel!
        let value:UILabel!
        if(indexPath.section==0){
        switch indexPath.row{
        case 0:
            var avator:UIImageView!
            avator=UIImageView(frame: CGRectMake(15, 15, 50, 50))
            avator.sd_setImageWithURL(NSURL(string: (self.thumb)!), placeholderImage: UIImage(named: "avator.jpg"))
            avator.clipsToBounds=true
            avator.layer.cornerRadius=avator.bounds.width*0.5
            username=UILabel(frame: CGRectMake(80,35,40,30))
            username.text=nickname
            username.textColor=UIColor(red: 111/255, green: 111/255, blue: 111/255, alpha: 1.0)
            username.font=UIFont.systemFontOfSize(18)
            username.sizeToFit()
            cell.addSubview(avator)
            cell.addSubview(username)
            cell.userInteractionEnabled=false
        case 5:
            
            let images:Array<String>=(self.imageurls?.componentsSeparatedByString(" "))!
            
            for (var i=0;i<self.imagecount;i++)
            {
                if(i<4){
                    let tmpView:TapImageView = TapImageView.init(frame: CGRectMake(CGFloat(10+(imagewidth!+5)*i), 10, CGFloat(imagewidth!), CGFloat(imagewidth!)))
                    tmpView.t_delegate = self;
                    tmpView.sd_setImageWithURL(NSURL(string: (images[i])), placeholderImage: UIImage(named: "avator.jpg"))
                    tmpView.tag = 10 + i;
                    cell.contentView.addSubview(tmpView)
                }else if(i>=4&&i<8){
                    let tmpView:TapImageView = TapImageView.init(frame: CGRectMake(CGFloat(10+(imagewidth!+5)*(i%4)), CGFloat(imagewidth!+15), CGFloat(imagewidth!), CGFloat(imagewidth!)))
                    tmpView.t_delegate = self;
                    tmpView.sd_setImageWithURL(NSURL(string: (images[i])), placeholderImage: UIImage(named: "avator.jpg"))
                    tmpView.tag = 10 + i;
                    cell.contentView.addSubview(tmpView)
                }else{
                    let tmpView:TapImageView = TapImageView.init(frame: CGRectMake(CGFloat(10+(imagewidth!+5)*(i%8)), CGFloat(imagewidth!*2+20), CGFloat(imagewidth!), CGFloat(imagewidth!)))
                    tmpView.t_delegate = self;
                    tmpView.sd_setImageWithURL(NSURL(string: (images[i])), placeholderImage: UIImage(named: "avator.jpg"))
                    tmpView.tag = 10 + i;
                    cell.contentView.addSubview(tmpView)
                }
            }
            cell.selectionStyle = UITableViewCellSelectionStyle.None
           
           for(var j=0;j<self.imagecount;j++){
               let tmpView1:TapImageView = cell.contentView.viewWithTag(10+j) as! TapImageView
                tmpView1.identifier = cell;
           }
            
        default:
            key=UILabel(frame: CGRectMake(15,15,80,20))
            key.text=Key[indexPath.row-1]
            key.textColor=UIColor(red: 111/255, green: 111/255, blue: 111/255, alpha: 0.44)
            key.font=UIFont.systemFontOfSize(15)
            key.sizeToFit()
            cell.addSubview(key)
            value=UILabel(frame: CGRectMake(110,15,cell.frame.width-60,20))
            print(cell.frame.width)
            value.text=Value[indexPath.row-1]
            value.numberOfLines=0
            value.textColor=UIColor(red: 111/255, green: 111/255, blue: 111/255, alpha: 1.0)
            value.font=UIFont.systemFontOfSize(15)
            value.sizeToFit()
            cell.addSubview(value)
            cell.userInteractionEnabled=false
        }
        }else{
            switch indexPath.row{
            case 0:
                let count=UILabel(frame: CGRectMake(10,8,60,14))
                let allcount=self.comments.count
                count.text="网友点评（"+String(allcount)+")"
                count.textColor=UIColor(red: 111/255, green: 111/255, blue: 111/255, alpha: 1.0)
                count.font=UIFont.systemFontOfSize(15)
                count.sizeToFit()
                cell.addSubview(count)
                cell.userInteractionEnabled=false
            case self.comments.count+1:
                let CommentIcon=UIImageView(frame: CGRectMake(cell.frame.width/9*4, 45, 20, 20))
                CommentIcon.image=UIImage(named: "评论按钮大.png")
                cell.addSubview(CommentIcon)
                IComment=UILabel(frame: CGRectMake(cell.frame.width/9*4+30,40,cell.frame.width/3,25))
                IComment.text="我要点评"
                IComment.textColor=UIColor(red: 220/255, green: 100/255, blue: 100/255, alpha: 1.0)
                cell.backgroundColor=UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 0.3)
                cell.addSubview(IComment)
            default:
                //头像
                let commentavator=UIImageView(frame: CGRectMake(10, 10, 50, 50))
                commentavator.sd_setImageWithURL(NSURL(string: (self.comments[indexPath.row-1].thumb)!), placeholderImage: UIImage(named: "avator.jpg"))
                //commentavator.image=UIImage(named: "avator.jpg")
                commentavator.clipsToBounds=true
                commentavator.layer.cornerRadius=commentavator.bounds.width*0.5
                cell.addSubview(commentavator)
                //用户昵称
                let commentusername=UILabel(frame: CGRectMake(70,15,60,20))
                //commentusername.text="用户昵称"
                commentusername.text=self.comments[indexPath.row-1].nickname
                commentusername.font=UIFont.systemFontOfSize(15)
                commentusername.textColor=UIColor(red: 111/255, green: 111/255, blue: 111/255, alpha: 1.0)
                commentusername.sizeToFit()
                cell.addSubview(commentusername)
                //评论内容
                let content=UILabel(frame: CGRectMake(70,40,detail.frame.width-70,40))
                //content.text="很干净的店，真心不错！！！下次还回来的，必须支持点赞！！！！！！！！！！！！！"
                content.text=self.comments[indexPath.row-1].content
                content.font=UIFont.systemFontOfSize(13)
                content.textColor=UIColor(red: 111/255, green: 111/255, blue: 111/255, alpha: 0.44)
                content.numberOfLines=0
                content.sizeToFit()
                cell.addSubview(content)
                //时间
                let commenttime=UILabel(frame: CGRectMake(detail.frame.width-100,20,40,20))
                //commenttime.text="2015-10-01"
                commenttime.text=self.comments[indexPath.row-1].created_at
                commenttime.font=UIFont.systemFontOfSize(13)
                commenttime.textColor=UIColor(red: 111/255, green: 111/255, blue: 111/255, alpha: 0.44)
                commenttime.sizeToFit()
                cell.addSubview(commenttime)
            }
        }
        
       
        
        return cell
    }
    
    func addpic(){
        
    }

    override func viewWillAppear(animated: Bool){
        self.tableView.reloadData()
        print("appesr")
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.detail.deselectRowAtIndexPath(indexPath, animated: true)
        if(indexPath.section==1&&indexPath.row==self.comments.count+1){
            print("我要评论")
            let anotherView=self.storyboard!.instantiateViewControllerWithIdentifier("SpecialityComment") as! SpecialityCommentController
            anotherView.reid=self.reid!
            anotherView.SpecD=self
            self.navigationController?.pushViewController(anotherView, animated: true)
        }
    }

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
