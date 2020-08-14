//
//  Discover.swift
//  Pledu
//
//  Created by Muhammad Nashrullah on 11/08/20.
//  Copyright © 2020 Kepiting Bakau. All rights reserved.
//

import SwiftUI

struct Discover: Decodable {
    var idPlant: Int
    var name, category, type, location: String
    var duration: Int
    var video: String
    var img: String
    var description: String
    var tools: String
}
