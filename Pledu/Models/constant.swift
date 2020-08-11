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
    
    struct Api{
    //        static let viewMyPlant = "http://localhost:8081/api/myplant"
    //        static let viewProgress = "http://localhost:8081/api/progress"
        static let viewMyPlant = "http://pledu.aplikasibmn.com/api/myplant"
        static let viewProgress = "http://pledu.aplikasibmn.com/api/progress"
        static let viewPlant = "http://inventariscdn.xyz/api/api/pledu/read"
    }
    
    struct TabBarText {
        static let tabBar0 = "Menjelajah"
        static let tabBar1 = "Tanamanku"
    }
    
    static let tahapan = ["Penyemaian","Penanaman","Perawatan","Lanjutan"]
}
