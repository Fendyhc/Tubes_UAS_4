//
//  UserMyTicketController.swift
//  TubesUas_A_4
//
//  Created by Lab PK 15 on 11/18/19.
//  Copyright © 2019 Fendy Heryanto Chandra, I Putu Ary Sukma Bayu, Otniel Putra Zebua. All rights reserved.
//

import UIKit

class UserMyTicketController: UIViewController {
    var userId:String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        print(self.userId)
        let barViewControllers = self.tabBarController?.viewControllers
        let dashboard = barViewControllers![0] as? DashboardController
        let transaksi = barViewControllers![1] as? UserDaftarTransaksiController
        let profile = barViewControllers![3] as? UserProfileController
        dashboard!.userId = self.userId
        transaksi!.userId = self.userId
        profile!.userId = self.userId
        // Do any additional setup after loading the view.
    }	

}
