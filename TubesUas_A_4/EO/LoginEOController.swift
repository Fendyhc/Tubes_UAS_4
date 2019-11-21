//
//  LoginEOController.swift
//  TubesUas_A_4
//
//  Created by Lab PK 13 on 15/11/19.
//  Copyright © 2019 Fendy Heryanto Chandra, I Putu Ary Sukma Bayu, Otniel Putra Zebua. All rights reserved.
//

import UIKit

class LoginEOController: UIViewController {

    @IBOutlet weak var UsernameEO: UITextField!
    @IBOutlet weak var PasswordEO: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func LoginBtn(_ sender: Any) {
        if UsernameEO.text == "admin" && PasswordEO.text == "admin" {
            performSegue(withIdentifier: "MainMenuAdminVC", sender: self)
        }else{
            performSegue(withIdentifier: "MainMenuEOVC", sender: self)
        }
        
    }
    

}
