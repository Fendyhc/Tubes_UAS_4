//
//  DaftarPesertaEOController.swift
//  TubesUas_A_4
//
//  Created by Lab PK 15 on 11/18/19.
//  Copyright © 2019 Fendy Heryanto Chandra, I Putu Ary Sukma Bayu, Otniel Putra Zebua. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
class DaftarPesertaEOController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var eventId:String = ""
    
    let URL_Get_Event = "https://uajytix.xyz/REST-API/userTicket/viewEO.php?id="
    var ticket = [eventTicket]()
    @IBOutlet weak var JumlahPeserta: UILabel!
    @IBOutlet weak var tableView: UITableView!
    private let refresControl = UIRefreshControl()
    override func viewDidLoad() {
        super.viewDidLoad()
        getJson(urlString: URL_Get_Event+eventId)
        tableView.delegate=self
        tableView.dataSource=self
        refresControl.addTarget(self, action: #selector(refreshEventData(_:)), for: .valueChanged)
        self.tableView.addSubview(self.refresControl)
        // Do any additional setup after loading the view.
    }
    @objc private func refreshEventData(_ sender: Any){
        getJson(urlString: self.URL_Get_Event+self.eventId)
        self.refresControl.endRefreshing()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return ticket.count
       }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: "mycell", for: indexPath)
        cell.textLabel?.text = ticket[indexPath.row].nama_user
        cell.detailTextLabel?.text = ticket[indexPath.row].npm + " | " + ticket[indexPath.row].telp + " | " + ticket[indexPath.row].email
           
           return cell
       }
    fileprivate func getJson(urlString : String){
        Alamofire.request(urlString, method: .get).responseJSON{ response in
            print(JSON(response.result.value!))
            print(urlString)
            do{
                let products = try JSONDecoder()
                    .decode([FailableDecodable<eventTicket>].self, from: response.data!)
                .compactMap { $0.base }
                self.ticket = products
                self.tableView.reloadData()
            }catch _ {
                print(Error.self)
            }
            
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
