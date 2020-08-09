//
//  PhaseView.swift
//  Pledu
//
//  Created by Muhammad Nashrullah on 09/08/20.
//  Copyright © 2020 Kepiting Bakau. All rights reserved.
//

import SwiftUI

struct PhaseView: View {
    var i: Int
//    @State var showCamera = false
//    var cameraButton: some View {
//        Button(action: { self.showCamera.toggle() }) {
//            Image(systemName: "camera")
//                .imageScale(.large)
//                .accessibility(label: Text("Camera"))
//                .padding()
//        }
//    }
    @State var mCamera = false
    var cameraBtn: some View {
        Button(action: { self.mCamera.toggle() }) {
            Image(systemName: "camera")
                .imageScale(.large)
                .accessibility(label: Text("Camera"))
                .padding()
        }
    }
    var body: some View {
        VStack{
            NavigationLink(destination: CameraView()){
                Text("love")
                
                Spacer()
                .sheet(isPresented: $mCamera) {
                        CameraView()                }
            }
            
            .padding(.horizontal, 12)
            .navigationBarTitle("Tahapan")
            
            
            .navigationBarItems(trailing: cameraBtn)
            
        }
    
    }
}

struct PhaseView_Previews: PreviewProvider {
    static var previews: some View {
        PhaseView(i: 1)
    }
}

