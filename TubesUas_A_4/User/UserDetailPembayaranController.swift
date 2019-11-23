//
//  UserDetailPembayaranController.swift
//  TubesUas_A_4
//
//  Created by Lab PK 15 on 11/18/19.
//  Copyright © 2019 Fendy Heryanto Chandra, I Putu Ary Sukma Bayu, Otniel Putra Zebua. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class UserDetailPembayaranController: UIViewController {
    var transaksiId:String = ""
    var userId:String = ""
    var namaRek:String = ""
    var nama:String = ""
    var harga:String = ""
    var bankRek:String = ""
    var noRek:String = ""
    var noRekUsr:String = ""
    var namaRekUsr:String = ""
    @IBOutlet weak var noRekUserBenarTxt: UILabel!
    @IBOutlet weak var hargaTxt: UILabel!
    @IBOutlet weak var noRekEventTxt: UILabel!
    @IBOutlet weak var bankTxt: UILabel!
    @IBOutlet weak var namaRekEventTxt: UILabel!
    @IBOutlet weak var noRekUser: UILabel!
    @IBOutlet weak var namaTxt: UILabel!
    @IBOutlet weak var namaRekUserTxt: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hargaTxt.text=self.harga
        self.noRekEventTxt.text=self.noRek
        self.namaRekEventTxt.text=self.namaRek
        self.namaTxt.text=self.nama
        self.noRekUserBenarTxt.text=self.namaRekUsr
        self.noRekUser.text=self.noRekUsr
        self.bankTxt.text=self.bankRek
    }
    
    @IBAction func doneBtn(_ sender: Any) {
        performSegue(withIdentifier: "cancelEditDetilVC", sender: self)
    }
    
    @IBAction func editBtn(_ sender: Any) {
        performSegue(withIdentifier: "formEditDetilVC", sender: self )
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "cancelEditDetilVC"){
            let destination = segue.destination as? MainMenuUserController
            destination?.userId = self.userId
        }
        if(segue.identifier == "formEditDetilVC"){
            let destination = segue.destination as? UserEditPembayaranController
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
