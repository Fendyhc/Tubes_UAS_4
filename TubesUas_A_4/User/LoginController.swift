//
//  LoginController.swift
//  TubesUas_A_4
//
//  Created by Lab PK 13 on 15/11/19.
//  Copyright © 2019 Fendy Heryanto Chandra, I Putu Ary Sukma Bayu, Otniel Putra Zebua. All rights reserved.
//

import UIKit

class LoginController: UIViewController {
    //test ary
    @IBOutlet weak var Passwordtxt: UITextField!
    @IBOutlet weak var Usernametxt: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func LoginBtn(_ sender: Any) {
        performSegue(withIdentifier: "MainMenuUserVC", sender: self)
        
    }
    
    @IBAction func SignUpBtn(_ sender: Any) {
        performSegue(withIdentifier: "RegisterVC", sender: self)
    }
}
