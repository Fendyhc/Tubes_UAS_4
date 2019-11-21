//
//  Event.swift
//  TubesUas_A_4
//
//  Created by Signal on 11/21/19.
//  Copyright © 2019 Fendy Heryanto Chandra, I Putu Ary Sukma Bayu, Otniel Putra Zebua. All rights reserved.
//

import Foundation
class Event: NSObject {
    var id:String;
    var nama:String;
    var kategori:String;
    var penyelenggara:String;
    var tempat:String;
    var waktu:String;
    var deskripsi:String;
    var harga:String;
    var no_rek:String;
    var nama_rek:String;
    var bank_rek:String;
    
    init(json:[String:Any]){
        self.id=json["id"] as? String ?? ""
        self.nama=json["nama"] as? String ?? ""
        self.kategori=json["kategori"] as? String ?? ""
        self.penyelenggara=json["penyelenggara"] as? String ?? ""
        self.tempat=json["tempat"] as? String ?? ""
        self.waktu=json["waktu"] as? String ?? ""
        self.deskripsi=json["deskripsi"] as? String ?? ""
        self.harga=json["harga"] as? String ?? ""
        self.no_rek=json["no_rek"] as? String ?? ""
        self.nama_rek=json["nama_rek"] as? String ?? ""
        self.bank_rek=json["bank_rek"] as? String ?? ""
    }
}
