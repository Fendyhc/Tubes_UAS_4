//
//  UserProfileController.swift
//  TubesUas_A_4
//
//  Created by Lab PK 13 on 15/11/19.
//  Copyright © 2019 Fendy Heryanto Chandra, I Putu Ary Sukma Bayu, Otniel Putra Zebua. All rights reserved.
//

import UIKit
import Alamofire
class UserProfileController: UIViewController {
    var userId:String = ""
    let URL_Get_User = "https://uajytix.xyz/REST-API/user/searchById.php?id="
    var userData:user? = nil
    @IBOutlet weak var namaTxt: UILabel!
    @IBOutlet weak var npmTxt: UILabel!
    @IBOutlet weak var fakultasTxt: UILabel!
    @IBOutlet weak var prodiTxt: UILabel!
    @IBOutlet weak var emailTxt: UILabel!
    @IBOutlet weak var telpTxt: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(self.userId)
        let barViewControllers = self.tabBarController?.viewControllers
        let dashboard = barViewControllers![0] as? DashboardController
        let transaksi = barViewControllers![1] as? UserDaftarTransaksiController
        let tiket = barViewControllers![2] as? UserMyTicketController
        dashboard!.userId = self.userId
        transaksi!.userId = self.userId
        tiket!.userId = self.userId
        getJson(urlString: URL_Get_User+self.userId)
        // Do any additional setup after loading the view.
    }
    @IBAction func EditProfileBtn(_ sender: Any) {
        performSegue(withIdentifier: "UserEditProfileVC", sender: self)
    }
    @IBAction func LogoutBtn(_ sender: Any) {
        performSegue(withIdentifier: "UserLogoutVC", sender: self)
    }
    fileprivate func getJson(urlString : String){
        print(urlString)
        Alamofire.request(urlString, method: .get).responseJSON{ response in
            
            do{
               let decoder = try JSONDecoder().decode(user.self, from: response.data!)
                self.userData = decoder
                self.insertData()
            }catch _ {
                print(Error.self)
            }
            
        }
    }
    func insertData(){
        self.namaTxt.text = self.userData?.nama
        self.npmTxt.text = self.userData?.npm
        self.fakultasTxt.text = self.userData?.fakultas
        self.prodiTxt.text = self.userData?.prodi
        self.emailTxt.text = self.userData?.email
        self.telpTxt.text = self.userData?.telp
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "UserEditProfileVC"){
            let destination = segue.destination as? UserEditProfileController
            destination?.nama = self.userData!.nama
            destination?.npm = self.userData!.npm
            destination?.fakultas = self.userData!.fakultas
            destination?.prodi = self.userData!.prodi
            destination?.telp = self.userData!.telp
            destination?.email = self.userData!.email
            destination?.username = self.userData!.username
            destination?.password = self.userData!.password
            destination?.userId = self.userId
        }
    }
}
