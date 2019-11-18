//
//  EOProfileController.swift
//  TubesUas_A_4
//
//  Created by Lab PK 15 on 11/18/19.
//  Copyright © 2019 Fendy Heryanto Chandra, I Putu Ary Sukma Bayu, Otniel Putra Zebua. All rights reserved.
//

import UIKit

class EOProfileController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func EditBtn(_ sender: Any) {
        performSegue(withIdentifier: "EOEditEventVC", sender: self)
    }
    
    @IBAction func LogoutEOBtn(_ sender: Any) {
        performSegue(withIdentifier: "EOLogoutVC", sender: self.dismiss(animated: true, completion: nil))
    }
}
