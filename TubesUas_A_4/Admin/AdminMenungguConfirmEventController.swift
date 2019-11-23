//
//  AdminMenungguConfirmEventController.swift
//  TubesUas_A_4
//
//  Created by Lab PK 15 on 11/18/19.
//  Copyright © 2019 Fendy Heryanto Chandra, I Putu Ary Sukma Bayu, Otniel Putra Zebua. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
class AdminMenungguConfirmEventController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    let URL_Get_Event = "https://uajytix.xyz/REST-API/event/viewAll.php"
    var event = [Event]()
    var eventTemp:Event? = nil
    var eventId:String = ""
    private let refresControl = UIRefreshControl()
    @IBOutlet weak var tableEvent: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        getJson(urlString: URL_Get_Event)
        tableEvent.delegate=self
        tableEvent.dataSource=self
        refresControl.addTarget(self, action: #selector(refreshEventData(_:)), for: .valueChanged)
        self.tableEvent.addSubview(self.refresControl)
        // Do any additional setup after loading the view.
    }
    @objc private func refreshEventData(_ sender: Any){
        getJson(urlString: self.URL_Get_Event)
        self.refresControl.endRefreshing()
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
     let contextItem = UIContextualAction(style: .normal, title: "event detail") {  (contextualAction, view, boolValue) in
             self.eventTemp = self.event[indexPath.row]
        self.pindah()
         }
         let swipeActions = UISwipeActionsConfiguration(actions: [contextItem])
     contextItem.backgroundColor = UIColor.blue
         
         return swipeActions
     }
     override func didReceiveMemoryWarning() {
         super.didReceiveMemoryWarning()
     }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        event.count
       }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: "mycell", for: indexPath)
           cell.textLabel?.text = event[indexPath.row].nama
           cell.detailTextLabel?.text = event[indexPath.row].kategori + " | " + event[indexPath.row].waktu + " | " + event[indexPath.row].tempat + " | IDR " + event[indexPath.row].harga
           return cell
       }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    fileprivate func getJson(urlString : String){
        Alamofire.request(URL_Get_Event, method: .get).responseJSON{ response in
            print(JSON(response.result.value!))
            do{
                let products = try JSONDecoder()
                    .decode([FailableDecodable<Event>].self, from: response.data!)
                .compactMap { $0.base }
                var eventTemp=[Event]()
                for product in products{
                    if(product.status == "Not Confirm"){
                        eventTemp.append(product)
                    }
                }
                self.event = eventTemp
                self.tableEvent.reloadData()
            }catch _ {
                print(Error.self)
            }
            
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "confirmEventVC"){
            let destination = segue.destination as? AdminConfrimEventController
            destination!.id = self.eventTemp!.id
            destination!.nama = self.eventTemp!.nama
            destination!.namaRek = self.eventTemp!.nama_rek
            destination!.bank = self.eventTemp!.bank_rek
            destination!.noRek = self.eventTemp!.no_rek
            destination!.harga = self.eventTemp!.harga
            destination!.penyelenggara = self.eventTemp!.penyelenggara
            destination!.tempat = self.eventTemp!.tempat
            destination!.waktu = self.eventTemp!.waktu
            destination!.deskripsi = self.eventTemp!.deskripsi
        }
    }
    func pindah(){
        performSegue(withIdentifier: "confirmEventVC", sender: self)
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
