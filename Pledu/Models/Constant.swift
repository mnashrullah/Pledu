//
//  Constant.swift
//  Pledu
//
//  Created by Muhammad Nashrullah on 05/08/20.
//  Copyright © 2020 Kepiting Bakau. All rights reserved.
//
import UIKit

struct Constants {
    struct TabBarImageName {
        static let tabBar0 = "magnifyingglass"
        static let tabBar1 = "leaf.arrow.circlepath"
    }
    struct TabBarText {
        static let tabBar0 = "Menjelajah"
        static let tabBar1 = "Tanamanku"
    }
    struct Api{
//        static let viewMyPlant = "http://localhost:8081/api/myplant"
//        static let viewProgress = "http://localhost:8081/api/progress"
        static let viewMyPlant = "http://pledu.aplikasibmn.com/api/myplant"
        static let viewProgress = "http://pledu.aplikasibmn.com/api/progress"
    }
    struct Phase{
        static let tahapan1 = "Penyemaian"
        static let tahapan2 = "Penanaman"
        static let tahapan3 = "Perawatan"
        static let tahapan4 = "Lanjutan"
    }
    static let tahapan = ["Penyemaian","Penanaman","Perawatan","Lanjutan"]
}
