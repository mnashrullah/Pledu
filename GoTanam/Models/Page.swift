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
                 heading: "obTitle1",
                 subSubheading: "obDesc1"),
            Page(id: UUID(),
                 image: "onboarding2",
                 heading: "obTitle2",
                 subSubheading: "obDesc2"),
            Page(id: UUID(),
                 image: "onboarding3",
                 heading: "obTitle3",
                 subSubheading: "obDesc3"),
            Page(id: UUID(),
                 image: "onboarding4",
                 heading: "obTitle4",
                 subSubheading: "obDesc4"),
            
        ]
    }
}
