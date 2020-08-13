//
//  Discover.swift
//  Pledu
//
//  Created by Muhammad Nashrullah on 11/08/20.
//  Copyright © 2020 Kepiting Bakau. All rights reserved.
//

import SwiftUI

struct Discover: Decodable {
    var idTanaman: Int
    var nama: String
    var jenis: String
    var tipe, tempat: String
    var durasi: Int
    var video: String
    var img: String
    var deskripsi, tools: String
    
//    enum Category: String, CaseIterable, Codable, Hashable {
//        case sayur = "sayur"
//        case buah = "buah"
//        case bunga = "bunga"
//    }
}
