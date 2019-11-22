//
//  DashboardController.swift
//  TubesUas_A_4
//
//  Created by Lab PK 13 on 15/11/19.
//  Copyright © 2019 Fendy Heryanto Chandra, I Putu Ary Sukma Bayu, Otniel Putra Zebua. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON


struct FailableDecodable<Base : Decodable> : Decodable {

    let base: Base?

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        self.base = try? container.decode(Base.self)
    }
}
class DashboardController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    let URL_Get_Event = "https://uajytix.xyz/REST-API/event/viewAll.php"
    @IBOutlet weak var tableEvent: UITableView!
    var userId:String = ""
    var event = [Event]()
    override func viewDidLoad() {
        super.viewDidLoad()
        print(self.userId)
        let barViewControllers = self.tabBarController?.viewControllers
        let transaksi = barViewControllers![1] as? UserDaftarTransaksiController
        let tiket = barViewControllers![2] as? UserMyTicketController
        let profile = barViewControllers![3] as? UserProfileController
        transaksi!.userId = self.userId
        tiket!.userId = self.userId
        profile!.userId = self.userId
        getJson(urlString: URL_Get_Event)
        tableEvent.delegate=self
        tableEvent.dataSource=self
    }
    
    @IBAction func RegisterBtn(_ sender: Any) {
        performSegue(withIdentifier: "UserRegisterEventVC", sender: self)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return event.count
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
            do{
                let products = try JSONDecoder()
                    .decode([FailableDecodable<Event>].self, from: response.data!)
                .compactMap { $0.base }
                self.event = products
                self.tableEvent.reloadData()
            }catch _ {
                print(Error.self)
            }
            
        }
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         if(segue.identifier == "UserRegisterEventVC"){
            let destination = segue.destination as? RegisterEventController
            destination!.userId = self.userId
        }
    }
}

