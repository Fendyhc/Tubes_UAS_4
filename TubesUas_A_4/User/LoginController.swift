//
//  LoginController.swift
//  TubesUas_A_4
//
//  Created by Lab PK 13 on 15/11/19.
//  Copyright © 2019 Fendy Heryanto Chandra, I Putu Ary Sukma Bayu, Otniel Putra Zebua. All rights reserved.
//

import UIKit

class LoginController: UIViewController {
    //test ary
    let URL_Login = "https://uajytix.xyz/REST-API/user/login.php"
    var user:[String:AnyObject] = [:]
    @IBOutlet weak var Passwordtxt: UITextField!
    @IBOutlet weak var Usernametxt: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func LoginBtn(_ sender: Any) {
        if Usernametxt.text == "admin" && Passwordtxt.text == "admin" {
            performSegue(withIdentifier: "MainMenuAdminVC", sender: self)
        }else{
            postPegawai(username: Usernametxt.text ?? "", password: Passwordtxt.text ?? "")
        }
        
    }
    
    @IBAction func SignUpBtn(_ sender: Any) {
        performSegue(withIdentifier: "RegisterVC", sender: self)
    }
    fileprivate func postPegawai(username: String, password: String){
        let parameters : [String:Any] = ["username":username, "password":password]
        guard let url = URL(string: URL_Login)else{
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: [])else{
            return
        }
        request.httpBody = httpBody
        
        let session = URLSession.shared
        session.dataTask(with: request){
            (data,response,err) in
            if let response = response{
                print(response)
            }
            if let data = data{
                do{
                    let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as AnyObject
                    print(json)
                    
                    if let usr = json as? [String: AnyObject]{
                        self.user = usr
                        print(self.user["status"] as? String ?? "gamau cuk")
                        DispatchQueue.main.async {
                            if(self.user["status"] as? String ?? "" == "Confirm"){
                                self.performSegue(withIdentifier: "MainMenuUserVC", sender: self)
                            }else{
                                print("Gamau CUk")
                            }
                        }
                        
                    }
                }
                catch{
                    print(error)
                }
            }
        }.resume()
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool{
        textField.resignFirstResponder()
        return true
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "MainMenuUserVC"){
            let destination = segue.destination as? MainMenuUserController
            destination!.userId = user["id"] as? String ?? ""
        }
    }
}
