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
    let URL_JSON = "https://uajy-tix.xyz/REST-API/user"
    @IBOutlet weak var Passwordtxt: UITextField!
    @IBOutlet weak var Usernametxt: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func LoginBtn(_ sender: Any) {
        performSegue(withIdentifier: "MainMenuUserVC", sender: self)
        
    }
    
    @IBAction func SignUpBtn(_ sender: Any) {
        performSegue(withIdentifier: "RegisterVC", sender: self)
    }
    fileprivate func postPegawai(name: String, id_number: String, birthdate:String, email:String){
        let parameters : [String:Any] = ["name":name,"id_number": id_number,"birthdate": birthdate,"email" : email]
        guard let url = URL(string: URL_JSON)else{
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
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
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
}
