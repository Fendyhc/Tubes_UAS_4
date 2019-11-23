//
//  MainMenuEO.swift
//  TubesUas_A_4
//
//  Created by Signal on 11/24/19.
//  Copyright © 2019 Fendy Heryanto Chandra, I Putu Ary Sukma Bayu, Otniel Putra Zebua. All rights reserved.
//

import UIKit

class MainMenuEO: UITabBarController {
    var eventId:String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        let barViewControllers = self.viewControllers
        print(barViewControllers![0])
        print(barViewControllers![1])
        print(barViewControllers![2])
        let dashboard = barViewControllers![0] as? DaftarMenungguConfirmEOController
        let daftarPeserta = barViewControllers![1] as? DaftarPesertaEOController
        let profile = barViewControllers![2] as? EOProfileController
        dashboard?.eventId = self.eventId
        daftarPeserta?.eventId = self.eventId
        profile?.eventId = self.eventId
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
