//
//  RegisterEventController.swift
//  TubesUas_A_4
//
//  Created by Lab PK 15 on 11/18/19.
//  Copyright © 2019 Fendy Heryanto Chandra, I Putu Ary Sukma Bayu, Otniel Putra Zebua. All rights reserved.
//

import UIKit

class RegisterEventController: UIViewController {
    var userId:String = ""
    
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
    @IBOutlet weak var kategoriTxt: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var usernameTxt: UITextField!
    @IBOutlet weak var namaRekTxt: UITextField!
    @IBOutlet weak var bankTxt: UITextField!
    @IBOutlet weak var noRekTxt: UITextField!
    @IBOutlet weak var hargaTxt: UITextField!
    @IBOutlet weak var namaTxt: UITextField!
    @IBOutlet weak var penyelenggaraTxt: UITextField!
    @IBOutlet weak var tempatTxt: UITextField!
    @IBOutlet weak var waktuTxt: UITextField!
    @IBOutlet weak var deskripsiTxt: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.deskripsiTxt.text = self.deskripsi
        self.waktuTxt.text = self.waktu
        self.tempatTxt.text = self.tempat
        self.penyelenggaraTxt.text = self.penyelenggara
        self.namaTxt.text = self.nama
        self.namaRekTxt.text = self.namaRek
        self.kategoriTxt.text = self.kategori
        self.emailTxt.text = self.email
        self.passwordTxt.text = self.password
        self.usernameTxt.text = self.username
        self.noRekTxt.text = self.noRek
        self.bankTxt.text = self.bank
        self.hargaTxt.text = self.harga
        
        
        // Do any additional setup after loading the view.
    }
    @IBAction func RegisterBtn(_ sender: Any) {
        self.nama = namaTxt.text!
        self.email = emailTxt.text!
        self.password = passwordTxt.text!
        self.username = usernameTxt.text!
        self.namaRek = namaRekTxt.text!
        self.bank = bankTxt.text!
        self.noRek = noRekTxt.text!
        self.harga = hargaTxt.text!
        self.penyelenggara = penyelenggaraTxt.text!
        self.tempat = tempatTxt.text!
        self.waktu = waktuTxt.text!
        self.deskripsi = deskripsiTxt.text!
        self.kategori = kategoriTxt.text!
        performSegue(withIdentifier: "UserConfirmRegisterEventVC", sender: self)
    }
    
    @IBAction func CancelBtn(_ sender: Any) {
        performSegue(withIdentifier: "BacktoDashboardVC", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       if(segue.identifier == "BacktoDashboardVC"){
            let destination = segue.destination as? MainMenuUserController
            destination!.userId = self.userId
        }
        if(segue.identifier == "UserConfirmRegisterEventVC"){
            let destination = segue.destination as? UserKonfirmasiRegistrasiEventController
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
    }
    
}
