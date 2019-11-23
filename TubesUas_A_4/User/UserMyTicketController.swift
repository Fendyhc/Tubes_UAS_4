//
//  UserMyTicketController.swift
//  TubesUas_A_4
//
//  Created by Lab PK 15 on 11/18/19.
//  Copyright © 2019 Fendy Heryanto Chandra, I Putu Ary Sukma Bayu, Otniel Putra Zebua. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
class UserMyTicketController: UIViewController,UITableViewDelegate,UITableViewDataSource  {
    let URL_Get_Ticket = "https://uajytix.xyz/REST-API/userTicket/view.php?id="
    var tickets = [userTicket]()
    var userId:String = ""
    private let refresControl = UIRefreshControl()
    @IBOutlet weak var tableTicket: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        print(self.userId)
        let barViewControllers = self.tabBarController?.viewControllers
        let dashboard = barViewControllers![0] as? DashboardController
        let transaksi = barViewControllers![1] as? UserDaftarTransaksiController
        let profile = barViewControllers![3] as? UserProfileController
        dashboard!.userId = self.userId
        transaksi!.userId = self.userId
        profile!.userId = self.userId
        getJson(urlString: self.URL_Get_Ticket+self.userId)
           tableTicket.delegate=self
           tableTicket.dataSource=self
           refresControl.addTarget(self, action: #selector(refreshEventData(_:)), for: .valueChanged)
           self.tableTicket.addSubview(self.refresControl)
        // Do any additional setup after loading the view.
    }
    @objc private func refreshEventData(_ sender: Any){
        getJson(urlString: self.URL_Get_Ticket+self.userId)
        self.refresControl.endRefreshing()
    }
    fileprivate func getJson(urlString : String){
        print(urlString)
        Alamofire.request(urlString, method: .get).responseJSON{ response in
        
            do{
                let products = try JSONDecoder()
                    .decode([FailableDecodable<userTicket>].self, from: response.data!)
                .compactMap { $0.base }
                self.tickets = products
                self.tableTicket.reloadData()
            }catch _ {
                print(Error.self)
            }
            
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tickets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mycell", for: indexPath)
        cell.textLabel?.text = tickets[indexPath.row].nama_event
        cell.detailTextLabel?.text = tickets[indexPath.row].kategori + " | " + tickets[indexPath.row].penyelenggara + " | "  + tickets[indexPath.row].tempat + " | " + tickets[indexPath.row].waktu
        return cell
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
