//
//  DaftarMenungguConfirmEOController.swift
//  TubesUas_A_4
//
//  Created by Lab PK 15 on 11/18/19.
//  Copyright © 2019 Fendy Heryanto Chandra, I Putu Ary Sukma Bayu, Otniel Putra Zebua. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
class DaftarMenungguConfirmEOController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var tableEvent: UITableView!
    

    
    let URL_Get_Event = "https://uajytix.xyz/REST-API/transaksi/searchByEvent.php?id="
    let URL_Confirm = "https://uajytix.xyz/REST-API/transaksi/confirm.php?id="
    var transaksi = [transaksiEvent]()
    var eventId:String = ""
    private let refresControl = UIRefreshControl()
    override func viewDidLoad() {
        super.viewDidLoad()
        print(eventId)
        getJson(urlString: URL_Get_Event+eventId)
        tableEvent.delegate=self
        tableEvent.dataSource=self
        refresControl.addTarget(self, action: #selector(refreshEventData(_:)), for: .valueChanged)
        self.tableEvent.addSubview(self.refresControl)
        // Do any additional setup after loading the view.
    }
    @objc private func refreshEventData(_ sender: Any){
        getJson(urlString: self.URL_Get_Event+self.eventId)
        self.refresControl.endRefreshing()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transaksi.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mycell", for: indexPath)
        cell.textLabel?.text = "ID transaksi : " + transaksi[indexPath.row].id
        cell.detailTextLabel?.text = " Nomor Rekening :  "  + transaksi[indexPath.row].no_rek + " | Nama Rekening" + transaksi[indexPath.row].nama_rek
        return cell
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
    let contextItem = UIContextualAction(style: .destructive, title: "Confirm") {  (contextualAction, view, boolValue) in
        Alamofire.request(self.URL_Confirm+self.transaksi[indexPath.row].id, method: .post).responseJSON{
                    response in
                    print(JSON(response.result.value!))
                    let statusCode = response.response?.statusCode
                    print(statusCode)
                    if(statusCode == 201){
                        print("success!")
                        self.getJson(urlString: self.URL_Get_Event+self.eventId)
                    }else{
                        let alertController = UIAlertController(title: "Gagal Register", message:
                            "Periksa Kembali Inputan Anda", preferredStyle: .alert)
                        alertController.addAction(UIAlertAction(title: "OK", style: .default))

                        self.present(alertController, animated: true, completion: nil)
                    }
                }

        }
        let swipeActions = UISwipeActionsConfiguration(actions: [contextItem])
    contextItem.backgroundColor = UIColor.blue
        
        return swipeActions
    }
    fileprivate func getJson(urlString : String){
        Alamofire.request(urlString, method: .get).responseJSON{ response in
            print(JSON(response.result.value!))
            print(urlString)
            do{
                let products = try JSONDecoder()
                    .decode([FailableDecodable<transaksiEvent>].self, from: response.data!)
                .compactMap { $0.base }
                self.transaksi = products
                self.tableEvent.reloadData()
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
