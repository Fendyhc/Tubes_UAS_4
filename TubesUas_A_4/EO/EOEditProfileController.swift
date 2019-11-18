//
//  EOEditProfileController.swift
//  TubesUas_A_4
//
//  Created by Lab PK 15 on 11/18/19.
//  Copyright © 2019 Fendy Heryanto Chandra, I Putu Ary Sukma Bayu, Otniel Putra Zebua. All rights reserved.
//

import UIKit

class EOEditProfileController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func ConfirmBtn(_ sender: Any) {
        performSegue(withIdentifier: "EOEventConfirmProfileVC", sender: self.dismiss(animated: true, completion: nil))
    }
    @IBAction func CancelBtn(_ sender: Any) {
        performSegue(withIdentifier: "EOEventConfirmProfileVC", sender: self.dismiss(animated: true, completion: nil))
    }
}
