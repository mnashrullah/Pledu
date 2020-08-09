//
//  MyPlantDetailView.swift
//  Pledu
//
//  Created by Muhammad Nashrullah on 07/08/20.
//  Copyright © 2020 Kepiting Bakau. All rights reserved.
//

import SwiftUI

struct MyPlantDetailView: View {
    @State var showCamera = false
    var data: MyPlant
    
    var cameraButton: some View {
        Button(action: { self.showCamera.toggle() }) {
            Image(systemName: "info.circle")
                .imageScale(.large)
                .accessibility(label: Text("Camera"))
                .padding()
        }
    }
    var body: some View {
        List(){
            
            
            VStack(alignment: .leading, spacing: 0){
                Text("Tahapan").fontWeight(.heavy)
                Text("Temukan tanaman yang ingin kamu tanam").foregroundColor(.gray)
                
            }
            
            ScrollView(.horizontal, showsIndicators: false) {
                
                
                HStack(spacing: 20){
                    
                    ForEach(0..<4){i in
                        cardPhase(i: i)
                    }
                    
               
//                    VStack(alignment: .leading,spacing: 5){
//                        Image("onboarding2").resizable().cornerRadius(10).overlay(
//                            VStack(alignment: .center, spacing: 5){
//                                HStack{
//                                    Image(systemName: "lock.fill").foregroundColor(.white)
//                                    Text(Constants.Phase.tahapan2)
//                                        .font(.subheadline)
//                                        .foregroundColor(.white)
//                                        .fontWeight(.heavy)
//
//                                }
//
//                            }
//
//
//                        )
//                            .frame(width: 200, height: 150)
//                    }
//
//                    VStack(alignment: .leading,spacing: 5){
//                        Image("onboarding2").resizable().cornerRadius(10).overlay(
//                            VStack(alignment: .center, spacing: 5){
//                                HStack{
//                                    Image(systemName: "lock.fill").foregroundColor(.white)
//                                    Text(Constants.Phase.tahapan3)
//                                        .font(.subheadline)
//                                        .foregroundColor(.white)
//                                        .fontWeight(.heavy)
//
//                                }
//
//                            }
//
//
//                        )
//                            .frame(width: 200, height: 150)
//                    }
//
//                    VStack(alignment: .leading,spacing: 5){
//                        Image("onboarding2").resizable().cornerRadius(10).overlay(
//                            VStack(alignment: .center, spacing: 5){
//                                HStack{
//                                    Image(systemName: "lock.fill").foregroundColor(.white)
//                                    Text(Constants.Phase.tahapan4)
//                                        .font(.subheadline)
//                                        .foregroundColor(.white)
//                                        .fontWeight(.heavy)
//                                }
//
//                            }
//
//
//                        )
//                            .frame(width: 200, height: 150)
//                    }
//
                }//end hstack
            }//end scrollview
            
            HStack{
                
                Text("Progress").fontWeight(.heavy)
                
                Spacer()
                
                Button(action: {
                    
                    
                }) {
                    
                    Text("View all").foregroundColor(.gray)
                }
                
            }.padding([.top], 15)
            //end hstack bunga
            
            ScrollView(.horizontal, showsIndicators: false) {
                
                
                HStack(spacing: 20){
                    
                    VStack(alignment: .leading,spacing: 5){
                        
                        Button(action: {
                            
                        }) {
                            
                            Image("scale").renderingMode(.original).cornerRadius(10)
                        }
                        
                        Text(data.name).fontWeight(.heavy)
                        
                        HStack(spacing: 5){
                            
                            Text("Rosella").foregroundColor(.gray)
                        }
                    }
                    
                    
                    VStack(alignment: .leading,spacing: 5){
                        
                        Button(action: {
                            
                        }) {
                            
                            Image("scale").renderingMode(.original).cornerRadius(10)
                        }
                        
                        Text("Mawar").fontWeight(.heavy)
                        
                        HStack(spacing: 5){
                            
                            Text("Rosella").foregroundColor(.gray)
                        }
                    }
                    VStack(alignment: .leading,spacing: 5){
                        
                        Button(action: {
                            
                        }) {
                            
                            Image("scale").renderingMode(.original).cornerRadius(10)
                        }
                        
                        Text("Mawar").fontWeight(.heavy)
                        
                        HStack(spacing: 5){
                            
                            Text("Rosella").foregroundColor(.gray)
                        }
                    }//end vstack
                }//end hstack
            }//end scrollview
                
                
                
                .navigationBarTitle(Text(data.name))
                .navigationBarItems(trailing: cameraButton)
                .sheet(isPresented: $showCamera) {
                    Detail()
            }
        }
    }
}




struct cardPhase: View{
    var i: Int
    var body: some View{
        NavigationLink(destination:PhaseView(i: i)){
           Image("onboarding2").resizable().cornerRadius(10)
               .overlay(
                   VStack(alignment: .center, spacing: 5){
                       HStack{
                           Image(systemName: "lock.open.fill").foregroundColor(.white)
                        Text(Constants.tahapan[i])
                               .font(.subheadline)
                               .foregroundColor(.white)
                               .fontWeight(.heavy)
                       }
                   }
                   
           )
               .frame(width: 200, height: 150)
       }.buttonStyle(PlainButtonStyle())  /*Here, is what you need*/
    }
}
