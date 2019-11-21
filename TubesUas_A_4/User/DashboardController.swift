//
//  DashboardController.swift
//  TubesUas_A_4
//
//  Created by Lab PK 13 on 15/11/19.
//  Copyright © 2019 Fendy Heryanto Chandra, I Putu Ary Sukma Bayu, Otniel Putra Zebua. All rights reserved.
//

import UIKit

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
        // Do any additional setup after loading the view.
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
        let url = URL(string: urlString)
        URLSession.shared.dataTask(with: url!) {
            (data, responds, err) in
            if err != nil{
                print("error",err ?? "")
            }else{
                if let useable = data{
                    do{
                        let jsonObject = try JSONSerialization.jsonObject(with: useable, options: .mutableContainers) as AnyObject
                        print(jsonObject)
                        let events = jsonObject as? [AnyObject]
                        for event in events! {
                            let e = Event(json: event as! [String:Any])
                            self.event.append(e)
                        }
                        print(self.event[0].nama)
                        
                        DispatchQueue.main.async(execute: {
                            self.tableEvent.reloadData()
                        })
                    }
                    catch{
                        print("catch error")
                    }
                }
            }
        }.resume()
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

