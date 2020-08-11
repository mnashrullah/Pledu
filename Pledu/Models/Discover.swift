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
    var nama, jenis, tipe, tempat: String
    var durasi: Int
    var video: String
    var img: String
    var deskripsi, tools: String
    
}
