//
//  UserEditProfileController.swift
//  TubesUas_A_4
//
//  Created by Lab PK 13 on 15/11/19.
//  Copyright © 2019 Fendy Heryanto Chandra, I Putu Ary Sukma Bayu, Otniel Putra Zebua. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
class UserEditProfileController: UIViewController {
    var URL_REGISTER:String = "https://uajytix.xyz/REST-API/user/edit.php"
    var userId:String = ""
    var nama:String = ""
    var npm:String = ""
    var fakultas:String = ""
    var prodi:String = ""
    var telp:String = ""
    var email:String = ""
    var username:String = ""
    var password:String = ""
    @IBOutlet weak var npmTxt: UITextField!
    @IBOutlet weak var namaTxt: UITextField!
    @IBOutlet weak var fakultasTxt: UITextField!
    @IBOutlet weak var prodiTxt: UITextField!
    @IBOutlet weak var telpTxt: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.namaTxt.text=self.nama
        self.npmTxt.text=self.npm
        self.fakultasTxt.text=self.fakultas
        self.prodiTxt.text=self.prodi
        self.telpTxt.text=self.telp
        // Do any additional setup after loading the view.
    }
    
    @IBAction func CancelBtn(_ sender: Any) {
        performSegue(withIdentifier: "CancelEditProfileVC", sender: self)
    }
    
    @IBAction func submitBtn(_ sender: Any) {
        self.nama=namaTxt.text ?? ""
        self.npm=npmTxt.text ?? ""
        self.fakultas=fakultasTxt.text ?? ""
        self.prodi=prodiTxt.text ?? ""
        self.telp=telpTxt.text ?? ""
            let params = [
                "id":self.userId,
                "nama":self.nama,
                "npm":self.npm,
                "email":self.email,
                "prodi":self.prodi,
                "telp":self.telp,
                "username":self.username,
                "password":self.password,
                "fakultas":self.fakultas
            ]
        var request = URLRequest(url: URL(string: URL_REGISTER)!)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")

            request.httpBody = try! JSONSerialization.data(withJSONObject: params)
            Alamofire.request(request).responseJSON{
                response in
                print(JSON(response.result.value!))
                let statusCode = response.response?.statusCode
                if(statusCode == 201){
                    print("success!")
                    self.pindah()
                }
            }
        }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "CancelEditProfileVC"){
            let destination = segue.destination as? MainMenuUserController
            destination?.userId = self.userId
        }
    }
    func pindah(){
        performSegue(withIdentifier: "CancelEditProfileVC", sender: self)
    }
}
