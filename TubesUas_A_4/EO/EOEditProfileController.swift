//
//  EOEditProfileController.swift
//  TubesUas_A_4
//
//  Created by Lab PK 15 on 11/18/19.
//  Copyright © 2019 Fendy Heryanto Chandra, I Putu Ary Sukma Bayu, Otniel Putra Zebua. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
class EOEditProfileController: UIViewController {
    var eventData:eventResponse? = nil
     let URL_Get_Event = "https://uajytix.xyz/REST-API/event/searchById.php?id="
    var URL_REGISTER:String = "https://uajytix.xyz/REST-API/event/edit.php"
    var eventId:String = ""
    @IBOutlet weak var namaRekTxt: UITextField!
    @IBOutlet weak var bankRekTxt: UITextField!
    @IBOutlet weak var noRekTxt: UITextField!
    @IBOutlet weak var hargaTxt: UITextField!
    @IBOutlet weak var deskripsiTxt: UITextField!
    @IBOutlet weak var waktuTxt: UITextField!
    @IBOutlet weak var tempatTxt: UITextField!
    @IBOutlet weak var penyelenggaraTxt: UITextField!
    @IBOutlet weak var kategoriTxt: UITextField!
    @IBOutlet weak var namaTxt: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getData()
        // Do any additional setup after loading the view.
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
           self.tempatTxt.text = self.eventData?.tempat
            self.waktuTxt.text = self.eventData?.waktu
            self.noRekTxt.text = self.eventData?.no_rek
            self.namaRekTxt.text = self.eventData?.nama_rek
            self.kategoriTxt.text = self.eventData?.kategori
            self.hargaTxt.text = self.eventData?.harga
        self.bankRekTxt.text = self.eventData?.bank_rek
       }
    @IBAction func ConfirmBtn(_ sender: Any) {
        self.eventData?.nama=namaTxt.text ?? ""
        self.eventData?.deskripsi=deskripsiTxt.text ?? ""
        self.eventData?.penyelenggara=penyelenggaraTxt.text ?? ""
        self.eventData?.tempat=tempatTxt.text ?? ""
        self.eventData?.waktu=waktuTxt.text ?? ""
        self.eventData?.no_rek=noRekTxt.text ?? ""
        self.eventData?.kategori=kategoriTxt.text ?? ""
        self.eventData?.harga=hargaTxt.text ?? ""
        self.eventData?.bank_rek=bankRekTxt.text ?? ""
        self.eventData?.nama_rek=namaRekTxt.text ?? ""
                  let params = [
                    "id":self.eventId,
                    "nama":self.eventData?.nama,
                    "kategori":self.eventData?.kategori,
                    "penyelenggara":self.eventData?.penyelenggara,
                    "waktu":self.eventData?.waktu,
                    "tempat":self.eventData?.tempat,
                    "deskripsi":self.eventData?.deskripsi,
                    "harga":self.eventData?.harga,
                    "no_rek":self.eventData?.no_rek,
                    "nama_rek":self.eventData?.nama_rek,
                    "bank_rek":self.eventData?.bank_rek,
                    "username":self.eventData?.username,
                    "password":self.eventData?.password
                  ]
                
              var request = URLRequest(url: URL(string: URL_REGISTER)!)
                  request.httpMethod = "POST"
                  request.setValue("application/json", forHTTPHeaderField: "Content-Type")

                  request.httpBody = try! JSONSerialization.data(withJSONObject: params)
                  Alamofire.request(request).responseJSON{
                      response in
                      print(JSON(response.result.value!))
                      let statusCode = response.response?.statusCode
                      if(statusCode == 201){
                          print("success!")
                        self.pindah()
                      }
                  }
    }
    @IBAction func CancelBtn(_ sender: Any) {
        performSegue(withIdentifier: "EOEventConfirmProfileVC", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "EOEventConfirmProfileVC"){
            let destination = segue.destination as? MainMenuEO
            destination?.eventId = self.eventId
        }
    }
    func pindah(){
        performSegue(withIdentifier: "EOEventConfirmProfileVC", sender: self)
    }
}
