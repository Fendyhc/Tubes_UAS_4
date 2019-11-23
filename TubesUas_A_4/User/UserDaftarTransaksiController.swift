//
//  UserDaftarTransaksiController.swift
//  TubesUas_A_4
//
//  Created by Lab PK 15 on 11/18/19.
//  Copyright © 2019 Fendy Heryanto Chandra, I Putu Ary Sukma Bayu, Otniel Putra Zebua. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class UserDaftarTransaksiController: UIViewController,UITableViewDelegate,UITableViewDataSource  {
    
    let URL_Get_Transaksi = "https://uajytix.xyz/REST-API/transaksi/searchByUser.php?id="
    let URL_Get_Detil = "https://uajytix.xyz/REST-API/detilTransaksi/view.php?id="
    var userId:String = ""
    var transaksi = [userTransaksi]()
    var transaksiId:String = ""
    var nama:String = ""
    var namaRek:String = ""
    var bankRek:String = ""
    var hargaRek:String = ""
    var noRek:String = ""
    var harga:String = ""
    var detilTransaksiTemp:detilTransaksi? = nil
    
    @IBOutlet weak var tableTransaksi: UITableView!
    private let refresControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(self.userId)
        let barViewControllers = self.tabBarController?.viewControllers
        let dashboard = barViewControllers![0] as? DashboardController
        let tiket = barViewControllers![2] as? UserMyTicketController
        let profile = barViewControllers![3] as? UserProfileController
        dashboard!.userId = self.userId
        tiket!.userId = self.userId
        profile!.userId = self.userId
        // Do any additional setup after loading the view.
        getJson(urlString: self.URL_Get_Transaksi+self.userId)
        tableTransaksi.delegate=self
        tableTransaksi.dataSource=self
        refresControl.addTarget(self, action: #selector(refreshEventData(_:)), for: .valueChanged)
        self.tableTransaksi.addSubview(self.refresControl)
    }
    
    
    @objc private func refreshEventData(_ sender: Any){
        getJson(urlString: self.URL_Get_Transaksi+self.userId)
        self.refresControl.endRefreshing()
    }
    
    fileprivate func getJson(urlString : String){
        print(urlString)
        Alamofire.request(urlString, method: .get).responseJSON{ response in
            
            do{
                let products = try JSONDecoder()
                    .decode([FailableDecodable<userTransaksi>].self, from: response.data!)
                .compactMap { $0.base }
                self.transaksi = products
                self.tableTransaksi.reloadData()
            }catch _ {
                print(Error.self)
            }
            
        }
    }
    fileprivate func getJsonDetil(urlString : String){
        print(urlString)
        Alamofire.request(urlString, method: .get).responseJSON{ response in
            do{
                let decoder = try JSONDecoder().decode(detilTransaksi.self, from: response.data!)
                print(decoder.nama_rek_user)
                self.detilTransaksiTemp = decoder
                print(self.detilTransaksiTemp!.nama_rek_user)
                self.pindah(identitasSegue: "editDetilVC")
            }catch _ {
                print(Error.self)
            }
            
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transaksi.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mycell", for: indexPath)
        cell.textLabel?.text = transaksi[indexPath.row].nama
        cell.detailTextLabel?.text = "No Rekening: " + transaksi[indexPath.row].no_rek + " | Atas Nama : " + transaksi[indexPath.row].nama_rek + " | Harga : " + transaksi[indexPath.row].harga + " | Status : " + transaksi[indexPath.row].status
        return cell
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
     let contextItem = UIContextualAction(style: .normal, title: "event detail") {  (contextualAction, view, boolValue) in
        if(self.transaksi[indexPath.row].status == "Waiting Payment"){
            self.transaksiId = self.transaksi[indexPath.row].id
            self.nama = self.transaksi[indexPath.row].nama
            self.namaRek = self.transaksi[indexPath.row].nama_rek
            self.harga = self.transaksi[indexPath.row].harga
            self.bankRek = self.transaksi[indexPath.row].bank_rek
            self.noRek = self.transaksi[indexPath.row].no_rek
            self.pindah(identitasSegue: "addPaymentTransaksiVC")
        }else if(self.transaksi[indexPath.row].status == "Waiting Confirmation"){
            self.transaksiId = self.transaksi[indexPath.row].id
            self.nama = self.transaksi[indexPath.row].nama
            self.namaRek = self.transaksi[indexPath.row].nama_rek
            self.harga = self.transaksi[indexPath.row].harga
            self.bankRek = self.transaksi[indexPath.row].bank_rek
            self.noRek = self.transaksi[indexPath.row].no_rek
             self.transaksiId = self.transaksi[indexPath.row].id
           self.edit(identitasSegue: "editDetilVC")
        }
     }
        if(transaksi[indexPath.row].status == "Waiting Payment"){
            contextItem.backgroundColor = UIColor.blue
            contextItem.title = "Add Payment Detail"
        }else if(self.transaksi[indexPath.row].status == "Waiting Confirmation"){
            contextItem.backgroundColor = UIColor.green
            contextItem.title = "Show Payment Detail"
        }
         let swipeActions = UISwipeActionsConfiguration(actions: [contextItem])
         return swipeActions
     }
    
    func edit(identitasSegue:String){
        getJsonDetil(urlString: self.URL_Get_Detil + self.transaksiId)
    }
    func pindah(identitasSegue:String){
        performSegue(withIdentifier: identitasSegue, sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "addPaymentTransaksiVC"){
            let destination = segue.destination as? UserConfirmPembayaran1Controller
            destination?.userId = self.userId
            destination?.transaksiId = self.transaksiId
            destination?.namaRek = self.namaRek
            destination?.nama = self.nama
            destination?.bankRek = self.bankRek
            destination?.noRek = self.noRek
            destination?.harga = self.harga
        }
        if(segue.identifier == "editDetilVC")
        {
            print(self.detilTransaksiTemp?.nama_rek_user ?? "sing ade not")
            let destination = segue.destination as? UserDetailPembayaranController
            destination?.userId = self.userId
            destination?.transaksiId = self.transaksiId
            destination?.namaRek = self.namaRek
            destination?.nama = self.nama
            destination?.bankRek = self.bankRek
            destination?.noRek = self.noRek
            destination?.harga = self.harga
            destination?.namaRekUsr = self.detilTransaksiTemp!.nama_rek_user
            destination?.noRekUsr = self.detilTransaksiTemp!.no_rek_user
            
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
