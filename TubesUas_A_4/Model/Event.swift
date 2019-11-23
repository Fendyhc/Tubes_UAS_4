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
struct FailableDecodable<Base : Decodable> : Decodable {

    let base: Base?

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        self.base = try? container.decode(Base.self)
    }
}
class userTransaksi: Decodable {
    var id:String;
    var id_event:String;
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
    var status:String;
}
class detilTransaksi: Decodable {
    var id_transaksi:String;
    var nama_event:String;
    var no_rek_user:String;
    var harga_ticket:String;
    var no_rek_event:String;
    var nama_rek_event:String;
    var bank_rek_event:String;
    var nama_rek_user:String;
    var status:String;
}
class userTicket: Decodable {
    var nama_event:String;
    var kategori:String;
    var penyelenggara:String;
    var tempat:String;
    var waktu:String;
}
class user: Decodable{
    var id:String;
    var nama:String;
    var npm:String;
    var fakultas:String;
    var prodi:String;
    var telp:String;
    var email:String;
    var username:String;
    var password:String;
}
