//
//  LoginController.swift
//  TubesUas_A_4
//
//  Created by Lab PK 13 on 15/11/19.
//  Copyright © 2019 Fendy Heryanto Chandra, I Putu Ary Sukma Bayu, Otniel Putra Zebua. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
struct Response: Decodable {
    var id: String!
    var status: String!
}
class LoginController: UIViewController {
    //test ary
    let URL_Login = "https://uajytix.xyz/REST-API/user/login.php"
    var user:Response? = nil
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
            let params = [
                "username" : Usernametxt.text ?? "",
                "password" : Passwordtxt.text ?? ""
            ]
            var request = URLRequest(url: URL(string: URL_Login)!)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")

            request.httpBody = try! JSONSerialization.data(withJSONObject: params)
            Alamofire.request(request).responseJSON{
                response in
                print(JSON(response.result.value!))
                let statusCode = response.response?.statusCode
                if(statusCode == 200){
                    do{
                        let decoder = try JSONDecoder().decode(Response.self, from: response.data!)
                        self.user = decoder
                        self.pindah()
                    }catch{
                        print(Error.self)
                    }
                }
            }
        }
        
    }
    
    @IBAction func SignUpBtn(_ sender: Any) {
        performSegue(withIdentifier: "RegisterVC", sender: self)
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool{
        textField.resignFirstResponder()
        return true
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "MainMenuUserVC"){
            let destination = segue.destination as? MainMenuUserController
            destination!.userId = user!.id
        }
    }
    func pindah(){
        performSegue(withIdentifier: "MainMenuUserVC", sender: self)
    }
}
