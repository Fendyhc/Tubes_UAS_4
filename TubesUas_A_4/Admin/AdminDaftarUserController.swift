//
//  AdminDaftarUserController.swift
//  TubesUas_A_4
//
//  Created by Lab PK 15 on 11/18/19.
//  Copyright © 2019 Fendy Heryanto Chandra, I Putu Ary Sukma Bayu, Otniel Putra Zebua. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
class AdminDaftarUserController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    private let refresControl = UIRefreshControl()
     var userList = [userGet]()
    var eventId:String = ""
    let URL_Get_Event = "https://uajytix.xyz/REST-API/user/viewAll.php"
    let URL_Delete_Event = "https://uajytix.xyz/REST-API/user/delete.php"
    @IBOutlet weak var tableUser: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableUser.delegate=self
        tableUser.dataSource=self
         getJson(urlString: URL_Get_Event)
        refresControl.addTarget(self, action: #selector(refreshEventData(_:)), for: .valueChanged)
        self.tableUser.addSubview(self.refresControl)
        // Do any additional setup after loading the view.
    }
    @objc private func refreshEventData(_ sender: Any){
           getJson(urlString: self.URL_Get_Event)
           self.refresControl.endRefreshing()
       }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mycell", for: indexPath)
        cell.textLabel?.text = userList[indexPath.row].nama
        cell.detailTextLabel?.text = userList[indexPath.row].npm + " | " + userList[indexPath.row].fakultas + " | " + userList[indexPath.row].prodi + " | " + userList[indexPath.row].email
        return cell
    }
    fileprivate func getJson(urlString : String){
        Alamofire.request(URL_Get_Event, method: .get).responseJSON{ response in
            do{
                let products = try JSONDecoder()
                    .decode([FailableDecodable<userGet>].self, from: response.data!)
                .compactMap { $0.base }
                self.userList = products
                self.tableUser.reloadData()
            }catch _ {
                print(Error.self)
            }
            
        }
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
    let contextItem = UIContextualAction(style: .destructive, title: " Delete Event") {  (contextualAction, view, boolValue) in
            self.eventId = self.userList[indexPath.row].id
            let params = [
                "id":self.eventId
            ]
            print(params)
        var request = URLRequest(url: URL(string: self.URL_Delete_Event)!)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = try! JSONSerialization.data(withJSONObject: params)
            Alamofire.request(request).responseJSON{
                response in
                print(JSON(response.result.value!))
                let statusCode = response.response?.statusCode
                if(statusCode == 201){
                    print("success!")
                    self.getJson(urlString: self.URL_Get_Event)
                }else{
                    let alertController = UIAlertController(title: "Gagal Register", message:
                        "Periksa Kembali Inputan Anda", preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "OK", style: .default))

                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
        let swipeActions = UISwipeActionsConfiguration(actions: [contextItem])
        
        return swipeActions
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
