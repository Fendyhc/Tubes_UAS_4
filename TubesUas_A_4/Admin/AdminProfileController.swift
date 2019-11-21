//
//  AdminProfileController.swift
//  TubesUas_A_4
//
//  Created by Lab PK 11 on 21/11/19.
//  Copyright © 2019 Fendy Heryanto Chandra, I Putu Ary Sukma Bayu, Otniel Putra Zebua. All rights reserved.
//

import UIKit

class AdminProfileController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func LogoutBtn(_ sender: Any) {
        performSegue(withIdentifier: "AdminLogoutVC", sender: self.dismiss(animated: true, completion: nil))
    }
    
}
