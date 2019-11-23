//
//  UserKonfirmasiRegistrasiEventController.swift
//  TubesUas_A_4
//
//  Created by Lab PK 15 on 11/18/19.
//  Copyright © 2019 Fendy Heryanto Chandra, I Putu Ary Sukma Bayu, Otniel Putra Zebua. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
class UserKonfirmasiRegistrasiEventController: UIViewController {
    var URL_REGISTER:String = "https://uajytix.xyz/REST-API/event/create.php"
    var userId:String=""
    var nama:String=""
    var email:String=""
    var password:String=""
    var username:String=""
    var namaRek:String=""
    var bank:String=""
    var noRek:String=""
    var harga:String=""
    var penyelenggara:String=""
    var tempat:String=""
    var waktu:String=""
    var deskripsi:String=""
    var kategori:String=""
    @IBOutlet weak var deskripsiTxt: UILabel!
    @IBOutlet weak var waktuTxt: UILabel!
    @IBOutlet weak var tempatTxt: UILabel!
    @IBOutlet weak var penyelenggaraTxt: UILabel!
    @IBOutlet weak var namaTxt: UILabel!
    @IBOutlet weak var namaRekTxt: UILabel!
    @IBOutlet weak var hargaTxt: UILabel!
    @IBOutlet weak var noRekTxt: UILabel!
    @IBOutlet weak var bankTxt: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.deskripsiTxt.text = self.deskripsi
        self.waktuTxt.text = self.waktu
        self.tempatTxt.text = self.tempat
        self.penyelenggaraTxt.text = self.penyelenggara
        self.namaTxt.text = self.nama
        self.namaRekTxt.text = self.namaRek
        self.hargaTxt.text = self.harga
        self.noRekTxt.text = self.noRek
        self.bankTxt.text = self.bank
        // Do any additional setup after loading the view.
    }
    
    @IBAction func CancelBtn(_ sender: Any) {
        performSegue(withIdentifier: "CancelRegisterEventVC", sender: self)
    }
    
    @IBAction func ConfirmBtn(_ sender: Any) {
                let params = [
                    "nama":self.nama,
                    "kategori":self.kategori,
                    "penyelenggara":self.penyelenggara,
                    "tempat":self.tempat,
                    "waktu":self.waktu,
                    "deskripsi":self.deskripsi,
                    "harga":self.harga,
                    "no_rek":self.noRek,
                    "nama_rek":self.namaRek,
                    "bank_rek":self.bank,
                    "username":self.username,
                    "password":self.password,
                    "email":self.email
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
    func pindah(){
        performSegue(withIdentifier: "UserConfirmRegisterVC", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "CancelRegisterEventVC"){
            let destination = segue.destination as? RegisterEventController
            destination!.userId = self.userId
            destination!.nama = self.nama
            destination!.email = self.email
            destination!.password = self.password
            destination!.username = self.username
            destination!.namaRek = self.namaRek
            destination!.bank = self.bank
            destination!.noRek = self.noRek
            destination!.harga = self.harga
            destination!.penyelenggara = self.penyelenggara
            destination!.bank = self.bank
            destination!.tempat = self.tempat
            destination!.waktu = self.waktu
            destination!.deskripsi = self.deskripsi
            destination!.kategori = self.kategori
        }
        if(segue.identifier == "UserConfirmRegisterVC"){
            let destination = segue.destination as? MainMenuUserController
            destination!.userId = self.userId
        }
    }
}
