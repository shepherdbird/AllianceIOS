//
//  PictureAndWord.swift
//  AllianceIOS
//
//  Created by dawei on 15/11/24.
//
//

import UIKit

class PictureAndWord: UITableViewController {

    var Details:String=""
    //var picture:Array<String>=[""]
    override func viewDidLoad() {
        super.viewDidLoad()
        if(Details==""){
            return
        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.1
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let picture=Details.componentsSeparatedByString(" ")
        return picture.count
    }
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return self.view.frame.height
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell=UITableViewCell()
        let picture=Details.componentsSeparatedByString(" ")
        let imageView = UIImageView(frame: CGRectMake(0, 0, self.view.frame.width, self.view.frame.height))
        imageView.sd_setImageWithURL(NSURL(string: picture[indexPath.row])!, placeholderImage: UIImage(named: "avator.jpg"))
        cell.addSubview(imageView)
        return cell
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
