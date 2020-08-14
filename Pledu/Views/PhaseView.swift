//
//  PhaseView.swift
//  Pledu
//
//  Created by Muhammad Nashrullah on 09/08/20.
//  Copyright © 2020 Kepiting Bakau. All rights reserved.
//

import SwiftUI

struct PhaseView: View {
    var phaseId: Int
    var dataMyPLant: MyPlant
    @State var dataProgress = [MyProgress]()

    
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
                ForEach(0..<self.dataProgress.count, id:\.self){i in
                    cardSingleProgress(data: self.dataProgress[i])
                }
                
//                Spacer()
//                .sheet(isPresented: $mCamera) {
//                        CameraView()
//
//                }
            }
            
            .padding(.horizontal, 12)
            .navigationBarTitle(Text(Constants.tahapan[phaseId]))
            .navigationBarItems(trailing: cameraBtn)
            
        }.onAppear(){
            self.loadData()
            print("phaseView i ",self.phaseId)
            print("phaseView datamyplant ", self.dataMyPLant)
            print("phaseView dataProgress ",self.dataProgress)



        }
    }
    func loadData(){
        let url = Constants.Api.viewSinglePhase
        let parameters = [
            "idUser": UserDefaults.standard.integer(forKey: Constants.dataUserDefault.idUser),
            "idPlant": self.dataMyPLant.idPlant,
            "phase": self.phaseId
        ]
        print("phaseview parameter ", parameters)

        var urlRequest = URLRequest(url: URL(string: url)!)
        urlRequest.httpMethod = "POST"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpBody = try? JSONEncoder().encode(parameters)

        URLSession.shared.dataTask(with: urlRequest)
        {(data,response,err) in
            if err != nil{
                print((err?.localizedDescription)!)
                return
            }
            let json: [MyProgress] = try! JSONDecoder().decode([MyProgress].self, from: data!)
            DispatchQueue.main.async {
                self.dataProgress = json
                print("phaseview json ",self.dataProgress)
                
            }
            print("Fetch failed: \(err?.localizedDescription ?? "Unknown error")")
        }.resume()
               
       }
}
struct cardSingleProgress: View{
    @Environment(\.imageCache) var cache: ImageCache
    var data: MyProgress
    var body: some View{
        VStack(alignment: .leading,spacing: 5){
            Button(action: {}) {
                Image(data.img).renderingMode(.original).cornerRadius(10)
                AsyncImage(url: URL(string: data.img)!, cache: self.cache, placeholder: Text("Loading ..."), configuration: { $0.resizable() })
                    .frame(width: 120, height: 120)
                    .cornerRadius(10)
            }.buttonStyle(PlainButtonStyle())
            Text("Hari ke - ").fontWeight(.heavy) +
            Text(String(data.dayDifferent)).fontWeight(.heavy)
            HStack(spacing: 5){
                Text(Constants.tahapan[data.phase]).foregroundColor(.gray)
            }
        }
    }
}


