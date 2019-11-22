//
//  UserKonfirmasiPembelianController.swift
//  TubesUas_A_4
//
//  Created by Lab PK 15 on 11/18/19.
//  Copyright © 2019 Fendy Heryanto Chandra, I Putu Ary Sukma Bayu, Otniel Putra Zebua. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON


class UserKonfirmasiPembelianController: UIViewController {
    var userId:String = ""
    var eventId:String = ""
    var eventData:eventResponse? = nil
    let URL_Get_Event = "https://uajytix.xyz/REST-API/event/searchById.php?id="
    let URL_Post = "https://uajytix.xyz/REST-API/transaksi/create.php"
    @IBOutlet weak var hargaTxt: UILabel!
    @IBOutlet weak var namaBankTxt: UILabel!
    @IBOutlet weak var namaTxt: UILabel!
    @IBOutlet weak var noRekTxt: UILabel!
    @IBOutlet weak var namaRekText: UILabel!
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
    @IBAction func confirmBtn(_ sender: Any) {
        let params = [
            "id_user":self.userId,
            "id_event":self.eventId
        ]
        var request = URLRequest(url: URL(string: URL_Post)!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try! JSONSerialization.data(withJSONObject: params)
        Alamofire.request(request).responseJSON{
            response in
            if response.result.isSuccess{
                self.pindah()
            }
        }
    }
    func setData(){
        self.namaTxt.text = self.eventData?.nama
        self.namaBankTxt.text = self.eventData?.bank_rek
        self.noRekTxt.text = self.eventData?.no_rek
        self.namaRekText.text = self.eventData?.nama_rek
        self.hargaTxt.text = self.eventData?.harga
    }
    func pindah(){
        performSegue(withIdentifier: "successBuyVC", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "successBuyVC"){
            let destination = segue.destination as? MainMenuUserController
            destination!.userId = self.userId
        }
    }
    @IBAction func cancelBtn(_ sender: Any) {
        self.pindah()
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
