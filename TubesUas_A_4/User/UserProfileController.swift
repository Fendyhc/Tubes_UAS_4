//
//  UserProfileController.swift
//  TubesUas_A_4
//
//  Created by Lab PK 13 on 15/11/19.
//  Copyright © 2019 Fendy Heryanto Chandra, I Putu Ary Sukma Bayu, Otniel Putra Zebua. All rights reserved.
//

import UIKit

class UserProfileController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func EditProfileBtn(_ sender: Any) {
        performSegue(withIdentifier: "UserEditProfileVC", sender: self)
    }
    @IBAction func LogoutBtn(_ sender: Any) {
        performSegue(withIdentifier: "UserLogoutVC", sender: self.dismiss(animated: true, completion: nil))
    }
    
}
