//
//  UserConfirmPembayaran2Controller.swift
//  TubesUas_A_4
//
//  Created by Lab PK 15 on 11/18/19.
//  Copyright © 2019 Fendy Heryanto Chandra, I Putu Ary Sukma Bayu, Otniel Putra Zebua. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
class UserConfirmPembayaran2Controller: UIViewController {
    var transaksiId:String = ""
    var userId:String = ""
    var namaRek:String = ""
    var nama:String = ""
    var harga:String = ""
    var bankRek:String = ""
    var noRek:String = ""
    var noRekUsr:String = ""
    var namaRekUsr:String = ""
    var URL_Create_Detil:String = "https://uajytix.xyz/REST-API/detilTransaksi/create.php"
    
    @IBOutlet weak var namaText: UILabel!
    @IBOutlet weak var namaRekTxt: UILabel!
    @IBOutlet weak var bankRekTxt: UILabel!
    @IBOutlet weak var noRekTxt: UILabel!
    @IBOutlet weak var hargaTxt: UILabel!
    
    
    @IBOutlet weak var noRekUser: UITextField!
    @IBOutlet weak var namaRekUser: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.namaRekTxt.text = self.namaRek
        self.bankRekTxt.text = self.bankRek
        self.namaText.text = self.nama
        self.noRekTxt.text = self.noRek
        self.hargaTxt.text = self.harga
        self.namaRekUser.text = self.namaRekUsr
        self.noRekUser.text = self.noRekUsr
        // Do any additional setup after loading the view.
    }
    
    @IBAction func cancelBtn(_ sender: Any) {
        performSegue(withIdentifier: "cancelPayment2", sender: self)
    }
    
    @IBAction func submitBtn(_ sender: Any) {
        self.noRekUsr = self.noRekUser.text ?? ""
        self.namaRekUsr = self.namaRekUser.text ?? ""
        let params = [
            "id_transaksi":self.transaksiId,
            "no_rek":self.noRekUsr,
            "nama_rek":self.namaRekUsr
        ]
        var request = URLRequest(url: URL(string: URL_Create_Detil)!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try! JSONSerialization.data(withJSONObject: params)
        Alamofire.request(request).responseJSON{
            response in
            if response.result.isSuccess{
                print(JSON(response.result.value!))
                self.pindah()
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "cancelPayment2"){
            let destination = segue.destination as? UserConfirmPembayaran1Controller
            destination?.userId = self.userId
            destination?.transaksiId = self.transaksiId
            destination?.namaRek = self.namaRek
            destination?.nama = self.nama
            destination?.bankRek = self.bankRek
            destination?.noRek = self.noRek
            destination?.harga = self.harga
        }
        if(segue.identifier == "successAddDetil"){
            let destintaion = segue.destination as? MainMenuUserController
            destintaion?.userId = self.userId
        }
    }
    func pindah(){
        performSegue(withIdentifier: "successAddDetil", sender: self)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
