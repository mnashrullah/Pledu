//
//  MyPlantView.swift
//  Pledu
//
//  Created by Muhammad Nashrullah on 05/08/20.
//  Copyright © 2020 Kepiting Bakau. All rights reserved.
//

import SwiftUI

struct MyPlantView: View {
    @State var dataMyPlant = [MyPlant]()
    @Binding var tabSelected: Int
//    @ObservedObject var data = getData()
    
   
    var body: some View {
        NavigationView{
            VStack{
                if self.dataMyPlant.count != 0{
                    List(){
                        VStack(alignment: .leading){
                            Text("mpDesc").foregroundColor(.gray)
                        }
                        
                        ForEach(0..<self.dataMyPlant.count, id: \.self){i in
                            cardMyPlant(data: self.dataMyPlant[i])
                        }.onDelete(perform: deleteData)
                        
                    }
                }else{
                    VStack(alignment: .center, spacing: 10){
                        Text("no plants")
                        Text("no plants desc").foregroundColor(.gray).multilineTextAlignment(.center)
                        Button(action: {
                            self.tabSelected = 0
                        }){
                            Text("no plants btn")
                        }
                    }
                }
            }
            .navigationBarTitle(Text("mpTitle"))
        }.onAppear(){
            self.loadData()
        }
    }
    func loadData(){
        let url = Constants.Api.viewMyPlant
        let parameters = [
            "idUser": UserDefaults.standard.integer(forKey: Constants.dataUserDefault.idUser)]

        var urlRequest = URLRequest(url: URL(string: url)!)
        urlRequest.httpMethod = "POST"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpBody = try? JSONEncoder().encode(parameters)
        URLSession.shared.dataTask(with: urlRequest){(data,response,err) in
            if err != nil{
                print((err?.localizedDescription)!)
                return
            }
            let json: [MyPlant] = try! JSONDecoder().decode([MyPlant].self, from: data!)
            DispatchQueue.main.async {self.dataMyPlant = json}
            DispatchQueue.main.sync {self.dataMyPlant = json}
            //            print(self.dataMyPlant)
        }.resume()
        
    }
    func deleteData(at offsets: IndexSet) {

        for offset in offsets {
           let item = self.dataMyPlant[offset]
           let url = Constants.Api.deleteMyPlant
           let parameters = [
               "idUser": UserDefaults.standard.integer(forKey: Constants.dataUserDefault.idUser),
               "idPlant": item.idPlant]

           var urlRequest = URLRequest(url: URL(string: url)!)
           urlRequest.httpMethod = "DELETE"
           urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
           urlRequest.httpBody = try? JSONEncoder().encode(parameters)
           URLSession.shared.dataTask(with: urlRequest){(data,response,err) in
               if err != nil{
                   print((err?.localizedDescription)!)
                   return
               }
                self.loadData()

           }.resume()
        }
        
    }
}
func getDate(time: String)->String{
    //    let mtime = "2020-08-08T17:00:00.000Z"
    //string to date, then to string again, change format
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "YYYY-MM-DD"
    let oldDate = dateFormatter.date(from: time)
    
    let dateFormatterSimple = DateFormatter()
    dateFormatterSimple.dateFormat = "dd MMM, YYYY"
    let newDate = dateFormatterSimple.string(from: oldDate!)
    return newDate
    
    
}
//class getData: ObservableObject{
//    @Published var dataMyPlant = [MyPlant]()
//    init (){
//        updateData()
//    }
//    func updateData(){
//        let url = Constants.Api.viewMyPlant
//        let parameters = [
//            "idUser": UserDefaults.standard.integer(forKey: Constants.dataUserDefault.idUser)]
//
//        var urlRequest = URLRequest(url: URL(string: url)!)
//        urlRequest.httpMethod = "POST"
//        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
//        urlRequest.httpBody = try? JSONEncoder().encode(parameters)
//        URLSession.shared.dataTask(with: urlRequest){(data,response,err) in
//            if err != nil{
//                print((err?.localizedDescription)!)
//                return
//            }
//            let json: [MyPlant] = try! JSONDecoder().decode([MyPlant].self, from: data!)
//            DispatchQueue.main.async {self.dataMyPlant = json}
//            DispatchQueue.main.sync {self.dataMyPlant = json}
//            //            print(self.dataMyPlant)
//        }.resume()
//    }
//
//}
struct cardMyPlant: View{
    @Environment(\.imageCache) var cache: ImageCache
    var data: MyPlant
    var body: some View{
        HStack(){
            AsyncImage(url: URL(string: data.img)!, cache: self.cache,
                       placeholder: ShimmerView().frame(width: 120, height: 120)
            , configuration: { $0.resizable() })
                .frame(width: 120, height: 120)
                .cornerRadius(10)
            NavigationLink(destination: MyPlantDetailView(data:data)){
            VStack(alignment: .leading, spacing: 10){
                Text(data.name).fontWeight(.heavy)
                Text("Ditambahkan pada").foregroundColor(.gray)
                Text(getDate(time: data.dateCreated)).foregroundColor(.gray)
            }
                .navigationBarHidden(true)
                .navigationBarBackButtonHidden(false)
            
//            NavigationLink(destination:
//                MyPlantDetailView(data:data)
//                .onAppear(){
//                UserDefaults.standard.set(self.data.idPlant, forKey: Constants.dataUserDefault.idPlant)
//                print("93 plantview save default idplant ", UserDefaults.standard.integer(forKey: Constants.dataUserDefault.idPlant))
//            }
//                .navigationBarHidden(true)
//                .navigationBarBackButtonHidden(false)
//            ){
//                VStack(alignment: .leading, spacing: 10){
//                    Text(data.name).fontWeight(.heavy)
//                    Text("Ditambahkan pada").foregroundColor(.gray)
//                    Text(getDate(time: data.dateCreated)).foregroundColor(.gray)
//                }
//            }
            Spacer()
        }
        
    }
        
    
    }}
