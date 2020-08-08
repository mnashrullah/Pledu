//
//  MyPlantView.swift
//  Pledu
//
//  Created by Muhammad Nashrullah on 05/08/20.
//  Copyright © 2020 Kepiting Bakau. All rights reserved.
//

import SwiftUI

struct MyPlantView: View {
    init(){
        UITableView.appearance().tableFooterView = UIView()
        UITableView.appearance().separatorStyle = .none
    }
    var body: some View {
        NavigationView{
            
            List(){
                VStack(alignment: .leading){
                    
                    Text("Tanaman yang kamu tanam akan tampil disini").foregroundColor(.gray)
                    
                }
                
                HStack(){
                    Image("scale").renderingMode(.original).cornerRadius(10)
                    
                    VStack(alignment: .leading, spacing: 10){
                        NavigationLink(destination: MyPlantDetailView()
                            .navigationBarTitle("Mawar")
                            .navigationBarHidden(true)
                            .navigationBarBackButtonHidden(false)                        ){
                            Text("Mawar").fontWeight(.heavy)}
                        Text("Ditambahkan pada: 20/20/2020 ").foregroundColor(.gray)
                    }
                    Spacer()
                }
                HStack(){
                    Image("scale").renderingMode(.original).cornerRadius(10)
                    
                    VStack(alignment: .leading, spacing: 10){
                        NavigationLink(destination: Detail()){
                            Text("Mawar").fontWeight(.heavy)}
                        Text("Ditambahkan pada: 20/20/2020 ").foregroundColor(.gray)
                    }
                    Spacer()
                }
                HStack(){
                    Image("scale").renderingMode(.original).cornerRadius(10)
                    
                    VStack(alignment: .leading, spacing: 10){
                        NavigationLink(destination: Detail()){
                            Text("Mawar").fontWeight(.heavy)}
                        Text("Ditambahkan pada: 20/20/2020 ").foregroundColor(.gray)
                    }
                    Spacer()
                }
                HStack(){
                    Image("scale").renderingMode(.original).cornerRadius(10)
                    
                    VStack(alignment: .leading, spacing: 10){
                        NavigationLink(destination: Detail()){
                            Text("Mawar").fontWeight(.heavy)}
                        Text("Ditambahkan pada: 20/20/2020 ").foregroundColor(.gray)
                    }
                    Spacer()
                }
                HStack(){
                    Image("scale").renderingMode(.original).cornerRadius(10)
                    
                    VStack(alignment: .leading, spacing: 10){
                        NavigationLink(destination: Detail()){
                            Text("Mawar").fontWeight(.heavy)}
                        Text("Ditambahkan pada: 20/20/2020 ").foregroundColor(.gray)
                    }
                    Spacer()
                }
                HStack(){
                    Image("scale").renderingMode(.original).cornerRadius(10)
                    
                    VStack(alignment: .leading, spacing: 10){
                        NavigationLink(destination: Detail()){
                            Text("Mawar").fontWeight(.heavy)}
                        Text("Ditambahkan pada: 20/20/2020 ").foregroundColor(.gray)
                    }
                    Spacer()
                }
                HStack(){
                    
                    Button(action: {
                        
                    }) {
                        
                        Image("scale").renderingMode(.original).cornerRadius(10)
                    }
                    
                    VStack(alignment: .leading, spacing: 10){
                        Text("Mawar").fontWeight(.heavy)
                        Text("Ditambahkan pada: 20/20/2020 ").foregroundColor(.gray)
                    }
                    
                    
                    Spacer()
                    
                    
                    
                }
            }.navigationBarTitle(Text("Tanamanku"))
        }
    }
}

struct MyPlantView_Previews: PreviewProvider {
    static var previews: some View {
        MyPlantView()
    }
}
