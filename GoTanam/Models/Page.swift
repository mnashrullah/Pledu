//
//  Page.swift
//  Pledu
//
//  Created by Muhammad Nashrullah on 04/08/20.
//  Copyright © 2020 Kepiting Bakau. All rights reserved.
//

import Foundation

struct Page: Identifiable {
    
    let id: UUID
    let image: String
    let heading: String
    let subSubheading: String
    
    static var getAll: [Page] {
        [
            Page(id: UUID(),
                 image: "onboarding1",
                 heading: "Selamat Datang",
                 subSubheading: "Pledu memungkinkan anda belajar cara menanam secara bertahap"),
            Page(id: UUID(),
                 image: "onboarding2",
                 heading: "Tahapan",
                 subSubheading: "Belajar menanam secara bertahap agar lebih terarah"),
            Page(id: UUID(),
                 image: "onboarding3",
                 heading: "Ambil Gambar",
                 subSubheading: "Abadikan proses perkembangan tanamanmu"),
            Page(id: UUID(),
                 image: "onboarding4",
                 heading: "Bagikan",
                 subSubheading: "Tunjukkan kebanggaan atas proses dan hasil kerja keras, keindahan tanaman kamu, layak untuk diketahui dunia"),
            
        ]
    }
}
