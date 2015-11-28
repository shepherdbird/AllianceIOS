//
//  PictureAndWord.swift
//  AllianceIOS
//
//  Created by dawei on 15/11/24.
//
//

import UIKit

class PictureAndWord: UIViewController {

    var Details:String=""
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        if(Details==""){
            return
        }
        let picture=self.Details.componentsSeparatedByString(" ")
        for i in 0...(picture.count-1){
            let y = CGFloat(i) * self.view.frame.height
            let imageView = UIImageView(frame: CGRectMake(0, y, self.view.frame.width, self.view.frame.height))
            if let Ndata=NSData(contentsOfURL: NSURL(string: picture[i])!){
                imageView.image = UIImage(data: Ndata)
            }
            self.view.addSubview(imageView)
        }
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
