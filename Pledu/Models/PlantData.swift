//
//  PlantData.swift
//  Pledu
//
//  Created by Muhammad Nashrullah on 13/08/20.
//  Copyright © 2020 Kepiting Bakau. All rights reserved.
//

import Combine
import SwiftUI

final class UserData: ObservableObject {
//    @Published var plantData : [MyPlant] = getDataDiscover()
     @Published var landmarks = getDataDiscover()
    //    @ObservedObject var mData = getDataDiscover()
}

//contoh
//final class UserData: ObservableObject {
//    @Published var showFavoritesOnly = false
//    @Published var landmarks = landmarkData
//}
