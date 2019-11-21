//
//  MainMenuUserController.swift
//  TubesUas_A_4
//
//  Created by Signal on 11/21/19.
//  Copyright © 2019 Fendy Heryanto Chandra, I Putu Ary Sukma Bayu, Otniel Putra Zebua. All rights reserved.
//

import UIKit

class MainMenuUserController: UITabBarController {
    var userId:String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        let barViewControllers = self.viewControllers
        let dashboard = barViewControllers![0] as? DashboardController
        let transaksi = barViewControllers![1] as? UserDaftarTransaksiController
        let tiket = barViewControllers![2] as? UserMyTicketController
        let profile = barViewControllers![3] as? UserProfileController
        dashboard!.userId = self.userId
        transaksi!.userId = self.userId
        tiket!.userId = self.userId
        profile!.userId = self.userId
        print(userId)
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
