//
//  ContentView.swift
//  Pledu
//
//  Created by Muhammad Nashrullah on 04/08/20.
//  Copyright © 2020 Kepiting Bakau. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State var show = false
    private let initialLaunchKey = "isInitialLaunch"
    @State var selected = 0
    
    var body: some View {
        VStack {
            if show || UserDefaults.standard.bool(forKey: initialLaunchKey){
    
                TabView (selection: $selected) {
                        DiscoveryView().tabItem({
                            Image(systemName: Constants.TabBarImageName.tabBar0)
                                .font(.body)
                            Text("\(Constants.TabBarText.tabBar0)")
                        }).tag(0)
                        
                    MyPlantView().tabItem({
                            Image(systemName: Constants.TabBarImageName.tabBar1)
                                .font(.body)
                            Text("\(Constants.TabBarText.tabBar1)")
                        }).tag(1)
                        
                        
                }.accentColor(Color.black)
                
                
            } else {
                PageViewContainer( viewControllers: Page.getAll.map({  UIHostingController(rootView: PageView(page: $0) ) }), presentSignupView: {
                    withAnimation {
                        self.show = true
                    }
                    UserDefaults.standard.set(true, forKey: self.initialLaunchKey)
                }).transition(.scale)
            }
        }.onAppear(){
            
            if UserDefaults.standard.integer(forKey: Constants.dataUserDefault.idUser) == 0{
                print("no user id")
                //nash emulator user id 1954624632
                let randomUserId = generateUserID(length: 6)
                UserDefaults.standard.set(randomUserId, forKey: Constants.dataUserDefault.idUser)
                
            } else{
                print("has user id ", UserDefaults.standard.integer(forKey: Constants.dataUserDefault.idUser))
            }
        }
//        .frame(maxHeight: .infinity)
//            .background(Color.backgroundColor)
//            .edgesIgnoringSafeArea(.all)
//            .onTapGesture {
//                UIApplication.shared.endEditing()
//        }
    }
}
func generateUserID(length: Int) -> Int {
  let letters = "123456789"
  let value = String((0..<length).map{ _ in letters.randomElement()! })
    print("userID",value)
    return Int(value)!
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
