//
//  UserEditPembayaranController.swift
//  TubesUas_A_4
//
//  Created by Lab PK 15 on 11/18/19.
//  Copyright © 2019 Fendy Heryanto Chandra, I Putu Ary Sukma Bayu, Otniel Putra Zebua. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class UserEditPembayaranController: UIViewController {
    var transaksiId:String = ""
    var userId:String = ""
    var namaRek:String = ""
    var nama:String = ""
    var harga:String = ""
    var bankRek:String = ""
    var noRek:String = ""
    var noRekUsr:String = ""
    var namaRekUsr:String = ""
    var URL_Create_Detil:String = "https://uajytix.xyz/REST-API/detilTransaksi/edit.php"
    @IBOutlet weak var namaRekUserTxt: UITextField!
    @IBOutlet weak var noRekUserTxt: UITextField!
    @IBOutlet weak var hargaTxt: UILabel!
    @IBOutlet weak var bankRekEventTxt: UILabel!
    @IBOutlet weak var namaTxt: UILabel!
    @IBOutlet weak var noRekEventTxt: UILabel!
    @IBOutlet weak var namaRekEventTxt: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hargaTxt.text=self.harga
        self.noRekEventTxt.text=self.noRek
        self.namaRekEventTxt.text=self.namaRek
        self.namaTxt.text=self.nama
        self.namaRekUserTxt.text=self.namaRekUsr
        self.noRekUserTxt.text=self.noRekUsr
        self.bankRekEventTxt.text=self.bankRek
        // Do any additional setup after loading the view.
    }
    
    @IBAction func cancelBtn(_ sender: Any) {
        performSegue(withIdentifier: "cancelEditDetilVC", sender: self)
    }
    @IBAction func submitBtn(_ sender: Any) {
        self.noRekUsr = self.noRekUserTxt.text ?? ""
        self.namaRekUsr = self.namaRekUserTxt.text ?? ""
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
        if(segue.identifier == "cancelEditDetilVC"){
            let destination = segue.destination as? UserDetailPembayaranController
            destination?.userId =  self.userId
            destination?.transaksiId = self.transaksiId
            destination?.namaRek = self.namaRek
            destination?.nama = self.nama
            destination?.bankRek = self.bankRek
            destination?.noRek = self.noRek
            destination?.harga = self.harga
            destination?.namaRekUsr = self.namaRekUsr
            destination?.noRekUsr = self.noRekUsr
        }
        if(segue.identifier == "successEditVC"){
            let destination = segue.destination as? MainMenuUserController
            destination?.userId = self.userId
        }
    }
    func pindah(){
        performSegue(withIdentifier: "successEditVC", sender: self)
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
