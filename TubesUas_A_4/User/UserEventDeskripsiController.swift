//
//  UserEventDeskripsiController.swift
//  TubesUas_A_4
//
//  Created by Lab PK 15 on 11/18/19.
//  Copyright © 2019 Fendy Heryanto Chandra, I Putu Ary Sukma Bayu, Otniel Putra Zebua. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

struct eventResponse: Decodable {
    var id: String!
    var nama: String!
    var kategori: String!
    var penyelenggara: String!
    var tempat: String!
    var waktu: String!
    var deskripsi: String!
    var no_rek: String!
    var nama_rek: String!
    var bank_rek: String!
    var username: String!
    var password: String!
    var harga: String!
}
class UserEventDeskripsiController: UIViewController {
    
   
    
    @IBOutlet weak var namaTxt: UILabel!
    @IBOutlet weak var waktuTxt: UILabel!
    @IBOutlet weak var hargaTxt: UILabel!
    @IBOutlet weak var deskripsiTxt: UILabel!
    @IBOutlet weak var lokasiTxt: UILabel!
    @IBOutlet weak var penyelenggaraTxt: UILabel!
   
    let URL_Get_Event = "https://uajytix.xyz/REST-API/event/searchById.php?id="
    var userId:String = ""
    var eventId:String = ""
    var eventData:eventResponse? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        print(self.eventId)
        self.getData()
    }
    
    func getData(){
        Alamofire.request(URL_Get_Event + eventId, method: .get).responseJSON{
            response in
            print(JSON(response.result.value!))
            let statusCode = response.response?.statusCode
            if(statusCode == 200){
                do{
                    let decoder = try JSONDecoder().decode(eventResponse.self, from: response.data!)
                    self.eventData = decoder
                    print(self.eventData!)
                    self.setData()
                }catch{
                    print(Error.self)
                }
            }
        }
    }
    func setData(){
        self.namaTxt.text = self.eventData?.nama
        self.deskripsiTxt.text = self.eventData?.deskripsi
        self.penyelenggaraTxt.text = self.eventData?.penyelenggara
        self.lokasiTxt.text = self.eventData?.tempat
        self.hargaTxt.text = self.eventData?.harga
    }



    @IBAction func cancelBtn(_ sender: Any) {
        performSegue(withIdentifier: "cancelBuyEventDetailVC", sender: self)
    }
    
    @IBAction func buyBtn(_ sender: Any) {
        performSegue(withIdentifier: "confirmBuyVC", sender: self)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "confirmBuyVC"){
            let destination = segue.destination as? UserKonfirmasiPembelianController
            destination!.userId = self.userId
            destination!.eventId = self.eventId
        }
        if(segue.identifier == "cancelBuyEventDetailVC"){
            let destination = segue.destination as? MainMenuUserController
            destination!.userId = self.userId
        }
    }
}
