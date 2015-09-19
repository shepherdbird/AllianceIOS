//
//  LoginViewController.swift
//  AllianceIOS
//
//  Created by dawei on 15/9/19.
//
//

import UIKit
class LoginViewController: UIViewController {
    
    //@IBOutlet weak var Background: UIImageView!
    //Background.frame=CGRectMake(0,0,600,600
    //@IBOutlet weak var btnLogin: UIButton!
    
    @IBOutlet weak var BtnLogin: UIButton!
    
    @IBOutlet weak var username: UITextField!
    
    @IBOutlet weak var pwd: UITextField!
    
    
    override func viewDidLoad() {
        BtnLogin.layer.cornerRadius=4.0
        BtnLogin.layer.masksToBounds=true
    }
    @IBAction func LoginBtn(Sender:AnyObject){
        if username.text=="dawei" && pwd.text=="123456"{
            self.performSegueWithIdentifier("login", sender:self)
        }else{
            print("login failed")
        }
    }
    
}
