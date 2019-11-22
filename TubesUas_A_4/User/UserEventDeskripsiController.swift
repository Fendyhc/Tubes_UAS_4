//
//  UserEventDeskripsiController.swift
//  TubesUas_A_4
//
//  Created by Lab PK 15 on 11/18/19.
//  Copyright © 2019 Fendy Heryanto Chandra, I Putu Ary Sukma Bayu, Otniel Putra Zebua. All rights reserved.
//

import UIKit
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
    @IBOutlet weak var penyelenggaraTxt: UILabel!

    @IBOutlet weak var deskripsiTxt: UILabel!
    @IBOutlet weak var hargaTxt: UILabel!
    @IBOutlet weak var lokasiTxt: UILabel!
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
                    
                }catch{
                    print(Error.self)
                }
            }
        }
    }

}
