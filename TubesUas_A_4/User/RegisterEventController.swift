//
//  RegisterEventController.swift
//  TubesUas_A_4
//
//  Created by Lab PK 15 on 11/18/19.
//  Copyright © 2019 Fendy Heryanto Chandra, I Putu Ary Sukma Bayu, Otniel Putra Zebua. All rights reserved.
//

import UIKit

class RegisterEventController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func RegisterBtn(_ sender: Any) {
    
    }
    
    @IBAction func CancelBtn(_ sender: Any) {
        performSegue(withIdentifier: "BacktoDashboardVC", sender: self.dismiss(animated: true, completion: nil))
    }
    
}
