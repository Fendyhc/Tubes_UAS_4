//
//  UserKonfirmasiRegistrasiEventController.swift
//  TubesUas_A_4
//
//  Created by Lab PK 15 on 11/18/19.
//  Copyright © 2019 Fendy Heryanto Chandra, I Putu Ary Sukma Bayu, Otniel Putra Zebua. All rights reserved.
//

import UIKit

class UserKonfirmasiRegistrasiEventController: UIViewController {
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
        performSegue(withIdentifier: "CancelRegisterEventVC", sender: self.dismiss(animated: true, completion: nil))
    }
    
    @IBAction func ConfirmBtn(_ sender: Any) {
        performSegue(withIdentifier: "UserConfirmRegisterVC", sender: self.dismiss(animated: true, completion: nil))
    }
}
