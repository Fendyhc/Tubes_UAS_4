//
//  EOProfileController.swift
//  TubesUas_A_4
//
//  Created by Lab PK 15 on 11/18/19.
//  Copyright © 2019 Fendy Heryanto Chandra, I Putu Ary Sukma Bayu, Otniel Putra Zebua. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
class EOProfileController: UIViewController {
    var eventId:String = ""
    var eventData:eventResponse? = nil
    @IBOutlet weak var namaTxt: UILabel!
    @IBOutlet weak var penyelenggaraTxt: UILabel!
    @IBOutlet weak var lokasiTxt: UILabel!
    @IBOutlet weak var waktuTxt: UILabel!
    @IBOutlet weak var deskripsiTxt: UILabel!
    @IBOutlet weak var hargaTxt: UILabel!
    @IBOutlet weak var noRekTxt: UILabel!
    @IBOutlet weak var bankTxt: UILabel!
    @IBOutlet weak var telpTxt: UILabel!
      let URL_Get_Event = "https://uajytix.xyz/REST-API/event/searchById.php?id="
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getData()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func EditBtn(_ sender: Any) {
        performSegue(withIdentifier: "EOEditEventVC", sender: self)
    }
    
    @IBAction func LogoutEOBtn(_ sender: Any) {
        performSegue(withIdentifier: "EOLogout", sender: self)
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
            self.waktuTxt.text = self.eventData?.nama
            self.noRekTxt.text = self.eventData?.deskripsi
            self.bankTxt.text = self.eventData?.penyelenggara
            self.telpTxt.text = self.eventData?.tempat
            self.hargaTxt.text = self.eventData?.harga
       }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "EOEditEventVC"){
            let destination = segue.destination as? EOEditProfileController
            destination?.eventId = self.eventId
        }
    }
}
