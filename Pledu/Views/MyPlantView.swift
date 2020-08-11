//
//  MyPlantView.swift
//  Pledu
//
//  Created by Muhammad Nashrullah on 05/08/20.
//  Copyright © 2020 Kepiting Bakau. All rights reserved.
//
import SwiftUI

struct MyPlantView: View {
    @ObservedObject var data = getData()
    
    init(){
        UITableView.appearance().tableFooterView = UIView()
        UITableView.appearance().separatorStyle = .none
    }

    
    var body: some View {
        NavigationView{
            VStack{
                if self.data.dataMyPlant.count != 0{
                    List(){
                        VStack(alignment: .leading){
                            Text("Tanaman yang kamu tanam akan tampil disini").foregroundColor(.gray)
                        }
                        
                        ForEach(0..<self.data.dataMyPlant.count){i in
                            cardMyPlant(data: self.data.dataMyPlant[i])
                        }
                    }
                }else{
                    VStack{
                        Text("No plants yet?")
                        Text("Go to discovery tab to discover plants you want to plant, or plant you need to plant.")
                       
                    }
                }
            }

            .onAppear(){
                print(self.data)
                
            }
    
            
            .navigationBarTitle(Text("Tanamanku"))
        }
    }
}

//struct MyPlantView_Previews: PreviewProvider {
//    static var previews: some View {
//        MyPlantView()
//    }
//}
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


class getData: ObservableObject{
    //    @Published var data: MyPlant!
    @Published var dataMyPlant = [MyPlant]()
    init (){
        updateData()
    }
    func updateData(){
        let url = Constants.Api.viewMyPlant
        let session = URLSession(configuration: .default)
        session.dataTask(with: URL(string: url)!){(data,_,err) in
            if err != nil{
                print((err?.localizedDescription)!)
                return
            }
            //            https://www.avanderlee.com/swift/json-parsing-decoding/
            let json: [MyPlant] = try! JSONDecoder().decode([MyPlant].self, from: data!)
            DispatchQueue.main.async {self.dataMyPlant = json}
            DispatchQueue.main.sync {self.dataMyPlant = json}
            //            print(self.dataMyPlant)
        }.resume()
    }
    
}
struct cardMyPlant: View{
    @Environment(\.imageCache) var cache: ImageCache
    var data: MyPlant
    var body: some View{
        HStack(){
            AsyncImage(url: URL(string: data.img)!, cache: self.cache, placeholder: Text("Loading ..."), configuration: { $0.resizable() })
                .frame(width: 120, height: 120)
                .cornerRadius(10)
            
            NavigationLink(destination: MyPlantDetailView(data:data)
                .navigationBarHidden(true)
                .navigationBarBackButtonHidden(false)
            ){
                VStack(alignment: .leading, spacing: 10){
                    Text(data.name).fontWeight(.heavy)
                    Text("Ditambahkan pada").foregroundColor(.gray)
                    Text(getDate(time: data.dateCreated)).foregroundColor(.gray)
                }
            }
            Spacer()
        }
        
    }
    
}
