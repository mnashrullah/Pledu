//
//  MyPlant.swift
//  Pledu
//
//  Created by Muhammad Nashrullah on 10/08/20.
//  Copyright © 2020 Kepiting Bakau. All rights reserved.
//
import SwiftUI

struct MyPlant: Decodable{
    var idPlant: Int
    var name: String
    var description: String
    var img: String
    var idMyPlant: Int
    var idUser: Int
    var dateCreated: String
}
