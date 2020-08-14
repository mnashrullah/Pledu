//
//  DiscoveryView.swift
//  Pledu
//
//  Created by Muhammad Nashrullah on 04/08/20.
//  Copyright © 2020 Kepiting Bakau. All rights reserved.
//

import SwiftUI

struct DiscoveryView: View {
    @ObservedObject var mData = getDataDiscover()
    //    var mData = landmark
    //    @ObservedObject var mData = getDataDiscover()
    //    var categories: [String: [Landmark]] {
    //        Dictionary(
    //            grouping: landmarkData,
    //            by: { $0.category.rawValue }
    //        )
    //    }
    
    @State var showingSetting = false
    
    @State var show = false
    
    //search
    @State private var searchText = ""
    @State private var showCancelButton: Bool = false
    
    var settingButton: some View {
        Button(action: { self.showingSetting.toggle() }) {
            Image(systemName: "gear")
                .imageScale(.large)
                .accessibility(label: Text("Setting"))
                .padding()
        }
    }
    var body: some View {
        NavigationView{
            VStack{
                List{
                    
                    ForEach(self.mData.categories.keys.sorted(), id: \.self) {key in
                        CategoryRow(categoryName: key, items: self.mData.categories[key]!)
                    }
                    .listRowInsets(EdgeInsets())
                    
                }
            }.onAppear(){
                
            }
        }
    }
}
struct CategoryRow: View{
    var categoryName: String
    var items: [Discover]
    
    var body: some View{
        VStack(alignment: .leading){
            HStack{
                
                Text(categoryName).fontWeight(.heavy).autocapitalization(.allCharacters)
                
                Spacer()
                
                Button(action: {
                    
                    
                }) {
                    
                    Text("View all").foregroundColor(.gray)
                }
                
            }.padding([.top], 15)
            
            ScrollView(.horizontal, showsIndicators: false) {
                
                
                HStack(spacing: 20){
//                    Text("love")
//                    ForEach(self.items){item in
//                        cardPlant(item: item)
//                    }
                    ForEach(0..<self.items.count){item in
                        cardPlant(item: self.items[item])
                    }
                }//end hstack
            }//end scrollview
        
    }
    }
}

struct cardPlant: View{
    @State var item : Discover
    @Environment(\.imageCache) var cache: ImageCache
    
    var body: some View{
        VStack(alignment: .leading,spacing: 5){
                                
            Button(action: {
    //                            self.show.toggle()
            }) {
               AsyncImage(url: URL(string: item.img)!, cache: self.cache, placeholder: Text("Loading ..."), configuration: { $0.resizable() })
                .frame(width: 120, height: 120)
                .cornerRadius(10)
            }.buttonStyle(PlainButtonStyle())
            Text(item.name).fontWeight(.heavy)
//            HStack(spacing: 5){
//                Text(item.category).foregroundColor(.gray)
//            }
        }
    }
}

struct Detail: View {
    var body : some View{
        
        VStack{
            VStack{
                
                Image("onboarding2").resizable().aspectRatio(1.35, contentMode: .fill).frame(width:UIScreen.main.bounds.width,height: 500).offset(y: -200).padding(.bottom, -200)
                
                GeometryReader{geo in
                    
                    ScrollView(showsIndicators: false){
                        detailTop()
                        detailBottom()
                        
                    }
                    
                }.background(Color.white)
                    .clipShape(Rounded())
                    .padding(.top, -75)
                
                
            }
        }.padding()
    }
    
}


struct detailTop : View {
    
    var body : some View{
        
        VStack(alignment: .leading, spacing: 10){
            
            HStack{
                
                VStack(alignment: .leading){
                    NavigationLink(destination: CameraView()){
                        Text("Tutorial").fontWeight(.heavy).font(.subheadline)
                    }
                    Text("Cara menanam bunga Mawar").fontWeight(.heavy).font(.title)
                }
                Spacer()
            }.padding(.top, 20).padding()
            
            VStack(){
                Text("Mawar")
                Text("Rosa")
            }
            .frame(width:UIScreen.main.bounds.width)
            HStack{
                VStack{
                    Text("Jenis")
                    Text("Bunga")
                }
                Spacer()
                VStack{
                    Text("Jenis")
                    Text("Bunga")
                }
                
            }
        }
    }
}

struct detailBottom : View {
    
    var body : some View{
        
        VStack(alignment: .leading, spacing: 10){
            
            Text("Description").fontWeight(.heavy)
            Text("loremloremloremloremloremloremloremloremloremloremloremloremloremloremloremloremloremloremloremloremloremloremloremloremloremloremloremloremloremloremloremloremloremloremloremloremloremloremloremloremloremloremloremloremloremloremloremloremloremloremloremloremloremloremloremloremloremloremloremlorem").foregroundColor(.gray)
            
            HStack(spacing: 8){
                
                Button(action: {
                    
                }) {
                    
                    Image("Save").renderingMode(.original)
                }
                
                Button(action: {
                    
                }) {
                    
                    HStack(spacing: 6){
                        
                        Text("Book Your Experience")
                        Image("arrow").renderingMode(.original)
                        
                    }.foregroundColor(.white)
                        .padding()
                    
                }.background(Color("bg"))
                    .cornerRadius(8)
                
            }.padding(.top, 6)
            
        }.padding()
    }
}



struct Rounded : Shape {
    
    func path(in rect: CGRect) -> Path {
        
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: [.topLeft,.topRight], cornerRadii: CGSize(width: 40, height: 40))
        return Path(path.cgPath)
    }
}


class getDataDiscover: ObservableObject{
    //    @Published var data: MyPlant!
    //    @Published var dataDiscover = [Discover]()
    @Published var categories = [String: [Discover]]()
    //      @Published var categories
    
    //    var categories: [String: [Discover]] {
    //                           Dictionary(
    //                            grouping: dataDiscover,
    //                            by: { $0.category }
    //                           )
    //   }
    init (){
        updateData()
    }
    func updateData(){
        let url = Constants.Api.viewPlant
        let session = URLSession(configuration: .default)
        session.dataTask(with: URL(string: url)!){(data,_,err) in
            if err != nil{
                print((err?.localizedDescription)!)
                return
            }
            let json: [Discover] = try! JSONDecoder().decode([Discover].self, from: data!)
            DispatchQueue.main.async {
                //                self.dataDiscover = json
                //                print("async",self.dataDiscover)
                self.categories = Dictionary(grouping: json, by: {$0.category})
                print(self.categories)
                
                //                let students = ["Kofi", "Abena", "Efua", "Kweku", "Akosua"]
                //                let studentsByLetter = Dictionary(grouping: students, by: { $0.first! })
                //
                
                //                self.categories = Dictionary(grouping: json, by: { $0.category })
                //                print(studentsByLetter)
                //                print(students)
                //                print(self.categories)
                //                return json
                //bisa
                //                var categories: [String: [Discover]] {
                //                Dictionary(grouping: json,by: { $0.category })}
                //                print(categories)
                
            }
            
            //
        }.resume()
    }
    
}


struct cardDiscover: View{
    @Environment(\.imageCache) var cache: ImageCache
    var data: Discover
    
    
    var body: some View{
        HStack(){
            AsyncImage(url: URL(string: data.img)!, cache: self.cache, placeholder: Text("Loading ..."), configuration: { $0.resizable() })
                .frame(width: 120, height: 120)
                .cornerRadius(10)
            VStack(alignment: .leading, spacing: 10){
                Text(data.name).fontWeight(.heavy)
                Text(data.category).foregroundColor(.gray)
            }
            Spacer()
        }
        
    }
    
}
