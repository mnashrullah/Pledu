//
//  PageView.swift
//  Pledu
//
//  Created by Muhammad Nashrullah on 04/08/20.
//  Copyright © 2020 Kepiting Bakau. All rights reserved.
//

import SwiftUI

struct PageView: View {
   var page = Page.getAll.first!
    
    var body: some View {
            VStack{
                VStack{
                    Text(page.heading).font(.largeTitle).bold().layoutPriority(1).multilineTextAlignment(.center)
                        .foregroundColor(Color.white)
                    Text(page.subSubheading)
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color.white)
                    
                }.padding(.top, 100)
                Spacer()
                
            }
    }
}

struct PageView_Previews: PreviewProvider {
    static var previews: some View {
        PageView()
    }
}
