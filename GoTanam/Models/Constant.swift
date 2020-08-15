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
        static let mainLink = "http://pledu.aplikasibmn.com/"

        static let viewPlant = Constants.Api.mainLink + "api/plant"
        
        static let viewMyPlant =  Constants.Api.mainLink + "api/myplant"
        static let addMyPlant = Constants.Api.mainLink + "api/myplant/add"
        static let deleteMyPlant = Constants.Api.mainLink + "api/myplant"
        
        static let viewProgress = Constants.Api.mainLink + "api/progress"
        static let uploadProgress = Constants.Api.mainLink + "api/progress/upload"
        static let viewSinglePhase = Constants.Api.mainLink + "api/progress/single"
        
//        static let discoverPlant = "http://inventariscdn.xyz/api/api/pledu/read"
        
    }
    struct dataUserDefault{
        static let idUser = "idUser"
        static let idPlant = "idPlant"
    }
    struct Phase{
        static let tahapan1 = "Penyemaian"
        static let tahapan2 = "Penanaman"
        static let tahapan3 = "Perawatan"
        static let tahapan4 = "Lanjutan"
    }
    static let tahapan = [
        "Pemilihan Biji",
        "Penyemaian",
        "Penanaman",
        "Perawatan",
        "Panen"]
}
