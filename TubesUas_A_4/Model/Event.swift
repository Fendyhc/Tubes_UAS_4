//
//  Event.swift
//  TubesUas_A_4
//
//  Created by Signal on 11/21/19.
//  Copyright © 2019 Fendy Heryanto Chandra, I Putu Ary Sukma Bayu, Otniel Putra Zebua. All rights reserved.
//

import Foundation
import Alamofire
class Event: Decodable {
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
}
