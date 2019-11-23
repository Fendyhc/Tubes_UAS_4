//
//  RegisterController.swift
//  TubesUas_A_4
//
//  Created by Lab PK 13 on 15/11/19.
//  Copyright © 2019 Fendy Heryanto Chandra, I Putu Ary Sukma Bayu, Otniel Putra Zebua. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
class RegisterController: UIViewController {
    var URL_REGISTER:String = "https://uajytix.xyz/REST-API/user/create.php"
    @IBOutlet weak var namaTxt: UITextField!
    @IBOutlet weak var npmTxt: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var prodiTxt: UITextField!
    @IBOutlet weak var confirmPasswordTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var nomorHpTxt: UITextField!
    @IBOutlet weak var usernameTxt: UITextField!
    @IBOutlet weak var fakultasTxt: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func LoginBtn(_ sender: Any) {
        performSegue(withIdentifier: "LoginUserVC", sender: self.dismiss(animated: true, completion: nil ))
    }
    
    @IBAction func registerBtn(_ sender: Any) {
        if passwordTxt.text == confirmPasswordTxt.text {
            let params = [
                "nama":namaTxt.text,
                "npm":npmTxt.text,
                "email":emailTxt.text,
                "prodi":prodiTxt.text,
                "telp":nomorHpTxt.text,
                "username":usernameTxt.text,
                "password":passwordTxt.text,
                "fakultas":fakultasTxt.text
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
                    let alertController = UIAlertController(title: "Success Register", message:
                        "Verify your Email", preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "OK", style: .default))

                    self.present(alertController, animated: true, completion: nil)
                    print("success!")
                }else{
                    let alertController = UIAlertController(title: "Gagal Register", message:
                        "Periksa Kembali Inputan Anda", preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "OK", style: .default))

                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
    }
}
