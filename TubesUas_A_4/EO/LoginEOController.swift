//
//  LoginEOController.swift
//  TubesUas_A_4
//
//  Created by Lab PK 13 on 15/11/19.
//  Copyright © 2019 Fendy Heryanto Chandra, I Putu Ary Sukma Bayu, Otniel Putra Zebua. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
class LoginEOController: UIViewController {
    let URL_Login = "https://uajytix.xyz/REST-API/event/login.php"
    var user:Response? = nil
    @IBOutlet weak var UsernameEO: UITextField!
    @IBOutlet weak var PasswordEO: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func LoginBtn(_ sender: Any) {
        if UsernameEO.text == "admin" && PasswordEO.text == "admin" {
            performSegue(withIdentifier: "MainMenuAdminVC", sender: self)
        }else{
            let params = [
                "username" : self.UsernameEO.text ?? "",
                "password" : self.PasswordEO.text ?? ""
            ]
            var request = URLRequest(url: URL(string: self.URL_Login)!)
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
                        print(self.user)
                        self.pindah()
                    }catch{
                        print(Error.self)
                    }
                }
            }
        }
        
    }
    func pindah(){
        performSegue(withIdentifier: "MainMenuEOVC", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "MainMenuEOVC"){
            let destination = segue.destination as? MainMenuEO
            destination?.eventId = self.user!.id
        }
    }

}
