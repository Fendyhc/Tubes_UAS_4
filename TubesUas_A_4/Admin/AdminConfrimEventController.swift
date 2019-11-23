//
//  AdminConfrimEventController.swift
//  TubesUas_A_4
//
//  Created by Lab PK 15 on 11/18/19.
//  Copyright © 2019 Fendy Heryanto Chandra, I Putu Ary Sukma Bayu, Otniel Putra Zebua. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
class AdminConfrimEventController: UIViewController {
    let URL_Confirm = "https://uajytix.xyz/REST-API/event/confrim.php?id="
    var id:String=""
    var nama:String=""
    var namaRek:String=""
    var bank:String=""
    var noRek:String=""
    var harga:String=""
    var penyelenggara:String=""
    var tempat:String=""
    var waktu:String=""
    var deskripsi:String=""
    @IBOutlet weak var namaRekTxt: UILabel!
    @IBOutlet weak var emailTxt: UILabel!
    @IBOutlet weak var noRekTxt: UILabel!
    @IBOutlet weak var hargaTxt: UILabel!
    @IBOutlet weak var deskripsiTxt: UILabel!
    @IBOutlet weak var waktuTxt: UILabel!
    @IBOutlet weak var tempatTxt: UILabel!
    @IBOutlet weak var penyelenggaraTxt: UILabel!
    @IBOutlet weak var namaTxt: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        namaRekTxt.text = namaRek
        emailTxt.text = bank
        noRekTxt.text = noRek
        hargaTxt.text = harga
        deskripsiTxt.text = deskripsi
        tempatTxt.text = tempat
        penyelenggaraTxt.text = penyelenggara
        namaTxt.text = nama
        waktuTxt.text = waktu
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func ConfirmAdminBtn(_ sender: Any) {
        self.confirm(urlString: self.URL_Confirm+self.id)
    }
    
    @IBAction func CancelAdminBtn(_ sender: Any) {
        self.pindah()
    }
    fileprivate func confirm(urlString : String){
        print(urlString)
        Alamofire.request(urlString, method: .post).responseJSON{ response in
            if response.result.isSuccess{
                self.pindah()
            }
        }
    }
    func pindah(){
         performSegue(withIdentifier: "AdminConfirmEventVC", sender: self)
    }
}
