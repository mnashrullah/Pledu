//
//  MyPlantDetailView.swift
//  Pledu
//
//  Created by Muhammad Nashrullah on 07/08/20.
//  Copyright © 2020 Kepiting Bakau. All rights reserved.
//

import SwiftUI

struct MyPlantDetailView: View {
    @State var data: MyPlant
    @State var dataProgress = [MyProgress]()
    @State var showCamera = false
    var cameraButton: some View {
        Button(action: { self.showCamera.toggle() }) {
            Image(systemName: "camera")
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
                    ForEach(0..<Constants.tahapan.count){i in
                        cardPhase(i: i, dataMyPlant: self.data)
                    }
                }
            }
            VStack{
                HStack{
                    Text("Progress").fontWeight(.heavy)
                    Spacer()
                    Button(action: {
                    }) {
                        Text("View all").foregroundColor(.gray)
                    }
                }.padding([.top], 15)
                
                if self.dataProgress.count != 0{
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 20){
                            ForEach(0..<self.dataProgress.count){i in
                                cardProgress(dataProgress: self.dataProgress[i], dataMyPlant: self.data)
                            }
                        }
                    }

                }else{
                    Text("Kamu belum berikan progress")
                        .padding(.top, 20)
                }
            }
            .navigationBarTitle(Text(data.name))
            .navigationBarItems(trailing: cameraButton)
            .sheet(isPresented: $showCamera) {
                CameraView()
            }
            
        }
        .onAppear(){
            //self.data sudah mengandung nilai tanaman yang di klik
            self.loadData()
        }
       
    }
    func loadData(){
            let url = Constants.Api.viewProgress
            let parameters = [
                "idUser": UserDefaults.standard.integer(forKey: Constants.dataUserDefault.idUser),
                "idPlant": data.idPlant]
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
                }
                print("Fetch failed: \(err?.localizedDescription ?? "Unknown error")")
            }.resume()
               
       }
}

struct cardPhase: View{
    var i: Int
    var dataMyPlant: MyPlant
    
    var body: some View{
        NavigationLink(destination:PhaseView(phaseId: i, dataMyPLant: dataMyPlant)){
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
        }.buttonStyle(PlainButtonStyle())
    }
}
struct cardProgress: View{
    @Environment(\.imageCache) var cache: ImageCache
    var dataProgress: MyProgress
    var dataMyPlant: MyPlant
    
    var body: some View{
        VStack(alignment: .leading,spacing: 5){
            Button(action: {}) {
                Image(dataProgress.img).renderingMode(.original).cornerRadius(10)
                AsyncImage(url: URL(string: dataProgress.img)!, cache: self.cache, placeholder: Text("Loading ..."), configuration: { $0.resizable() })
                    .frame(width: 120, height: 120)
                    .cornerRadius(10)
            }.buttonStyle(PlainButtonStyle())
            Text("Hari ke - ").fontWeight(.heavy) +
            Text(String(dataProgress.dayDifferent)).fontWeight(.heavy)
            HStack(spacing: 5){
                Text(Constants.tahapan[dataProgress.phase]).foregroundColor(.gray)
            }
        }
    }
}

class getProgress: ObservableObject {
    @Published var dataProgress = [MyProgress]()

    init (){
        updateData()
    }
    func updateData(){
        print("115 idPlant: ",UserDefaults.standard.integer(forKey: "idPlant"))
        print("116 idUser: ",UserDefaults.standard.integer(forKey: "idUser"))

        let url = Constants.Api.viewProgress
        let parameters = [
            "idUser": UserDefaults.standard.integer(forKey: "userId"),
            "idPlant": UserDefaults.standard.integer(forKey: "idPlant")]

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
            DispatchQueue.main.async {self.dataProgress = json}
//            print("json ",self.dataProgress)
        }.resume()
    }
}
