//
//  IGLoginViewController.swift
//  InstacartGrocery
//
//  Created by DingXiao on 2017/8/18.
//  Copyright © 2017年 AwesomeDennis. All rights reserved.
//

import UIKit

class IGLoginViewController: UIViewController {
    
    private var userNameTextField: UITextField?
    
    private var passwordTextField: UITextField?
    
    private var loginButton: UIButton?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - UI Actions
    
    func loginAction() {
        IGLog("login")
    }

    // MARK: - priviate 
    
    private func setUpViews() {
        userNameTextField = UITextField(frame: CGRect.zero)
        userNameTextField?.backgroundColor = UIColor.white
        userNameTextField?.borderStyle = .roundedRect
        userNameTextField?.placeholder = "用户名"
        self.view.addSubview(userNameTextField!)
        
        passwordTextField = UITextField(frame: CGRect.zero)
        passwordTextField?.backgroundColor = UIColor.white
        passwordTextField?.borderStyle = .roundedRect
        userNameTextField?.placeholder = "密码"
        self.view.addSubview(passwordTextField!)
        
        loginButton = UIButton(type: .custom)
        loginButton?.addTarget(self, action: #selector(IGLoginViewController.loginAction()), for: .touchUpInside)
        self.view.addSubview(loginButton!)
        
    }

 
}
