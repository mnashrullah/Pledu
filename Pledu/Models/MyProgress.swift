//
//  MyProgress.swift
//  Pledu
//
//  Created by Muhammad Nashrullah on 10/08/20.
//  Copyright © 2020 Kepiting Bakau. All rights reserved.
//

import SwiftUI

struct MyProgress: Decodable {
    var idProgress: Int
    var idUser: Int
    var idPlant: Int
    var img: String
    var dayDifferent: Int
    var phase: Int
    var dateCreated: String
}
