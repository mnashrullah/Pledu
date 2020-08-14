//
//  PageViewContainer.swift
//  Pledu
//
//  Created by Muhammad Nashrullah on 04/08/20.
//  Copyright © 2020 Kepiting Bakau. All rights reserved.
//
import SwiftUI

struct PageViewContainer<Page: View>  : View {
    
    var viewControllers: [UIHostingController<Page>]
    @State var currentPage = 0
    @State var buttonText = "Next"
    var presentSignupView: (()->()) = {}
    
    
    
    var body: some View {
        
        return VStack {
            PageViewController(controllers: viewControllers, currentPage: self.$currentPage)
            
            PageIndicator(currentIndex: self.currentPage)
            
            VStack {
                
                Button(action: {
                    if self.currentPage < self.viewControllers.count - 1{
                        self.currentPage += 1
                    } else {
                        self.presentSignupView()
                    }
                }) {
                    HStack {
                        Text(currentPage == viewControllers.count - 1 ? "Get started" : "Next" )
                            .bold()
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .padding()
                            .accentColor(Color.white)
                            .background(Color("accentColor"))
                            .cornerRadius(5)
                    }.padding()
                }
            }.padding(.vertical)
        }
        .background(Color("clearColor"))
        .edgesIgnoringSafeArea(.all)
    }
}

struct PageViewContainer_Previews: PreviewProvider {
    static var previews: some View {
        PageViewContainer( viewControllers: Page.getAll.map({  UIHostingController(rootView: PageView(page: $0) )  }))
    }
}
