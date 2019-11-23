//
//  UserConfirmPembayaran1Controller.swift
//  TubesUas_A_4
//
//  Created by Lab PK 15 on 11/18/19.
//  Copyright © 2019 Fendy Heryanto Chandra, I Putu Ary Sukma Bayu, Otniel Putra Zebua. All rights reserved.
//

import UIKit

class UserConfirmPembayaran1Controller: UIViewController {
    var transaksiId:String = ""
    var userId:String = ""
    var namaRek:String = ""
    var nama:String = ""
    var harga:String = ""
    var bankRek:String = ""
    var noRek:String = ""
    
    @IBOutlet weak var namaRekTxt: UILabel!
    @IBOutlet weak var namaText: UILabel!
    @IBOutlet weak var bankRekTxt: UILabel!
    @IBOutlet weak var noRekTxt: UILabel!
    @IBOutlet weak var hargaTxt: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(self.bankRek)
        self.namaRekTxt.text = self.namaRek
        self.bankRekTxt.text = self.bankRek
        self.namaText.text = self.nama
        self.noRekTxt.text = self.noRek
        self.hargaTxt.text = self.harga
    }
    
    @IBAction func insertBtn(_ sender: Any) {
        performSegue(withIdentifier: "tambahPayment", sender: self)
    }
    
    @IBAction func cancelBtn(_ sender: Any) {
        performSegue(withIdentifier: "cancelPayment1", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "cancelPayment1"){
            let destination = segue.destination as? MainMenuUserController
            destination?.userId = self.userId
        }
        if(segue.identifier == "tambahPayment"){
            let destination = segue.destination as? UserConfirmPembayaran2Controller
            destination?.userId = self.userId
            destination?.transaksiId = self.transaksiId
            destination?.namaRek = self.namaRek
            destination?.nama = self.nama
            destination?.bankRek = self.bankRek
            destination?.noRek = self.noRek
            destination?.harga = self.harga
        }
    }
}
