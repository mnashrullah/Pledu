//
//  DiscoveryView.swift
//  Pledu
//
//  Created by Muhammad Nashrullah on 04/08/20.
//  Copyright © 2020 Kepiting Bakau. All rights reserved.
//

import SwiftUI

struct DiscoveryView: View {
//    @ObservedObject var mData = getDataDiscover()
    @State var categories = [String: [Discover]]()
    @State var dataPlant = [Discover]()
    @Binding var tabSelected : Int
    
    
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
                VStack(alignment: .leading, spacing: 5){
                   Text("Ingin Menanam?").fontWeight(.heavy)
                       Text("Temukan tanaman yang ingin kamu tanam").foregroundColor(.gray)
                       // Search view
                       HStack {
                           HStack() {
                               Image(systemName: "magnifyingglass")
                               TextField("search", text: $searchText, onEditingChanged: { isEditing in
                                   self.showCancelButton = true
                               }, onCommit: {
                                   print("onCommit")
                               }).foregroundColor(.primary)

                               Button(action: {
                                   self.searchText = ""
                               }) {
                                   Image(systemName: "xmark.circle.fill").opacity(searchText == "" ? 0 : 1)
                               }
                           }
                           .padding(EdgeInsets(top: 8, leading: 6, bottom: 8, trailing: 6))
                           .foregroundColor(.secondary)
                           .background(Color(.secondarySystemBackground))
                           .cornerRadius(10.0)

                           if showCancelButton  {
                               Button("Cancel") {
                                   UIApplication.shared.endEditing(true)
                                   self.searchText = ""
                                   self.showCancelButton = false
                               }
                               .foregroundColor(Color(.systemBlue))
                           }
                       }
                       .animation(.default) // animation does not work properly
               }//end Vstack Search
               .padding(.horizontal, 16)
//                List{ForEach(self.categories.keys.sorted().filter{$0.lowercased().contains(searchText.lowercased()) || searchText == ""}, id:\.self) {
//                        searchText in
//                           CategoryRow(categoryName: searchText, items: self.categories[searchText]!)
////                        }
//                    }.listRowInsets(EdgeInsets())
//                    .resignKeyboardOnDragGesture()
//                }
                //tidak ada kata pencarian
                
                    List{
                        if self.searchText == ""{
                            ForEach(self.categories.keys.sorted(), id:\.self) {
                                item in
                                CategoryRow(categoryName: item, items: self.categories[item]!, tabSelected: self.$tabSelected)
                            }
//                            .listRowInsets(EdgeInsets())
//                            .resignKeyboardOnDragGesture()
                        
                        }else{
                              ForEach(self.dataPlant.filter{$0.name.lowercased().contains(searchText.lowercased()) || searchText == ""}, id:\.self) {searchText in
                            //                        NavigationLink(destination: ShowcontentView(isNavigationBarHidden: self.$isNavigationBarHidden, landmark: searchText)) {
                                cardPlant(item: searchText, tabSelected: self.$tabSelected)
                            //
                                                    }
                            //                    }
                        }
                    }
               
                
            }
            .navigationBarTitle(Text("Menjelajah"))
                .navigationBarItems(trailing: settingButton)
                .sheet(isPresented: $showingSetting) {
                    SettingView()
//                    .environmentObject(self.userData)
            }.onAppear(){
                self.loadData()
            }
        }
    }
    func loadData(){
        let url = Constants.Api.viewPlant
        let session = URLSession(configuration: .default)
        session.dataTask(with: URL(string: url)!){(data,_,err) in
            if err != nil{
                print((err?.localizedDescription)!)
                return
            }
            let json: [Discover] = try! JSONDecoder().decode([Discover].self, from: data!)
            DispatchQueue.main.async {
                self.dataPlant = json
                self.categories = Dictionary(grouping: json, by: {$0.category})
                print("dataplan",self.dataPlant)
            }
        }.resume()
    }
}

extension UIApplication {
    func endEditing(_ force: Bool) {
        self.windows
            .filter{$0.isKeyWindow}
            .first?
            .endEditing(force)
    }
}
struct ResignKeyboardOnDragGesture: ViewModifier {
    var gesture = DragGesture().onChanged{_ in
        UIApplication.shared.endEditing(true)
    }
    func body(content: Content) -> some View {
        content.gesture(gesture)
    }
}
extension View {
    func resignKeyboardOnDragGesture() -> some View {
        return modifier(ResignKeyboardOnDragGesture())
    }
}



struct CategoryRow: View{
    var categoryName: String
    var items: [Discover]
    @Binding var tabSelected: Int
    
    var body: some View{

        VStack(alignment: .leading){
            HStack{
                Text(categoryName.capitalized).fontWeight(.heavy).padding(.leading, 10)
                Spacer()
                Button(action: {
                }) {
                    Text("View all").foregroundColor(.gray).padding(.trailing, 10)
                }
                
            }.padding([.top], 15)
                    if self.items.count != 0 {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20){
                    ForEach(0..<self.items.count, id: \.self){item in
                        cardPlant(item: self.items[item], tabSelected: self.$tabSelected)
                        }.frame(height: 185)
                }.padding(.leading, 10)
            }
            }
        
        }
    }
}

struct cardPlant: View{
    @State var item : Discover
    @Environment(\.imageCache) var cache: ImageCache
    @State var show = false
    @Binding var tabSelected: Int
    @Environment(\.presentationMode) var presentationMode
    var body: some View{
        
        VStack(alignment: .leading, spacing: 5){
            Button(action: {
                self.show.toggle()
            }) {
               AsyncImage(url: URL(string: item.img)!, cache: self.cache, placeholder: ShimmerView().frame(width: 115, height: 115), configuration: { $0.resizable() })
                .frame(width: 115, height: 115)
                .cornerRadius(10)
            }.buttonStyle(PlainButtonStyle())
            
            Text(item.name).fontWeight(.semibold).font(Font.system(size:14, design: .default))
            
            HStack(spacing: 5){
                Text(item.location).foregroundColor(.gray)
                .font(Font.system(size:14, design: .default))
            }
        }.frame(width: 133, height: 175)
        
        
        .background(Color.white)
        .cornerRadius(9)
        .shadow(color: Color.black.opacity(0.10), radius: 2, x: 2, y: 2)
        .sheet(isPresented: $show){
            VStack{
                            VStack{
            //                    closeModalButton()
                                
                                GeometryReader{ geo in
                                    ScrollView(showsIndicators: false){
                                        AsyncImage(url: URL(string: self.item.img)!, cache: self.cache, placeholder: ShimmerView().frame(width: 120, height: 120), configuration: { $0.resizable() })
                                            .aspectRatio(1, contentMode: .fill)
                                            .frame(width:UIScreen.main.bounds.width, height: 300)
                                        
                                        VStack(alignment: .leading, spacing: 10){
                                            HStack{
                                                VStack(alignment: .leading){
            //                                        NavigationLink(destination:_){
            //
                                                        Text("Tutorial")
                                                            .fontWeight(.semibold)
                                                            .foregroundColor(Color.white)
                                                            .font(.subheadline)
                                                            .padding(.top, 0)
                                                            .padding()
            //                                        }
                                                    HStack{
                                                        Text("Cara menanam " + String(self.item.category.capitalized) + " " + String(self.item.name.capitalized)).fontWeight(.heavy).foregroundColor(Color.white).font(.title)
                                                    }
                                                        .padding(.top, -30)
                                                        .padding()
                                                    
                                                        
                                                }
                                                Spacer()
                                            }
                                            .background(AsyncImage(url: URL(string: self.item.img)!, cache: self.cache, placeholder: ShimmerView().frame(width:UIScreen.main.bounds.width, height: 120), configuration: { $0.resizable() })

                                                .frame(width:UIScreen.main.bounds.width, height: 100.0)
                                                .blur(radius: 40, opaque: true)
                                            )
                                            .padding(.top, -80)
                                            
                                            VStack(){
                                                Text(self.item.name.capitalized).fontWeight(.semibold)
                                                Text("Durasi tumbuh " + String(self.item.duration) + " Hari")
                                            }
                                            .frame(width:UIScreen.main.bounds.width)
                                        }
                                        
                                        VStack(alignment: .leading, spacing: 10){
                                            
                                            Text(self.item.description.capitalized).foregroundColor(.gray).font(Font.system(size:14, design: .default))
                                            
                                            Text("Alat dan Bahan").fontWeight(.semibold)
                                            Text(self.item.tools).foregroundColor(.gray).font(Font.system(size:14, design: .default))
                                            
                                        }.padding()
                                        
                                    }.background(Color("clearColor"))


                                }.background(Color.white)
                                .padding(.top, -75)
                                HStack{
                //                    Button(action: {
                //
                //                    }) {
                //
                //                        Image("Save").renderingMode(.original)
                //                    }
                                    Button(action: {
                                        self.addToMyPlant(item: self.item)
                                        self.show = false
                                        

                                    }) {
                                        HStack(spacing: 6){

                                            Text("Tambah ke Tanamanku")
                                                .fontWeight(.regular)
                                                .foregroundColor(.white)
                                                .padding(.leading, 0)
                                            
                                            Text("Pilih")
                                                .foregroundColor(.blue)
                                                .fontWeight(.semibold)
                                                .background(Color.white
                                                    .cornerRadius(10)
                                                    .frame(width: 50)
                                                )
                                                .offset(x: UIScreen.main.bounds.width/13)

                                        }.foregroundColor(.red)
                                        .padding()
                                    }
                                    .background(Color("offColor")
                                        .opacity(0.3)
                                        .frame(width:UIScreen.main.bounds.width-40, height: 40.0)
                                        .cornerRadius(10)
                                    )
                                }
                            }
                        }.padding()
                            .frame(maxWidth: .infinity, maxHeight: .infinity).background(Color("clearColor"))

            
        }
    }
    func addToMyPlant(item: Discover){
       //        print("addToMyPlant ",item)
               let url = Constants.Api.addMyPlant
               let parameters = [
                   "idUser": UserDefaults.standard.integer(forKey: Constants.dataUserDefault.idUser),
                   "idPlant": self.item.idPlant
               ]
       //        print("addToMyPlant parameter ", parameters)

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
                   self.tabSelected = 1
       //            print("addToMyPlant", response)
       //            print("addToMyPlant", data)
       //            print("addToMyPlant", err)
       //            let json: [MyProgress] = try! JSONDecoder().decode([MyProgress].self, from: data!)
       //            DispatchQueue.main.async {
       //                print(json)
       //                print("berhasil simpan data")
                       
       //                self.dataProgress = json
       //                print("phaseview json ",self.dataProgress)
                       
       //            }
                   print("Fetch failed: \(err?.localizedDescription ?? "Unknown error")")
               }.resume()
           }
   
}

struct closeModalButton: View {
    @Environment(\.presentationMode) private var presentationMode
    
    var body : some View{
      Button(action: {
        
           self.presentationMode.wrappedValue.dismiss()
        }) {
            Image(systemName: "xmark")
                .foregroundColor(Color.black)
                .background(Color.white
                    .frame(width: 30,height: 30)
                    .cornerRadius(20, antialiased: true)
                )
            Text(" ")
        }.offset(x: 330/2, y:8).zIndex(1)
    }
}

//class getDataDiscover: ObservableObject{
//    //    @Published var data: MyPlant!
//    //    @Published var dataDiscover = [Discover]()
//    @Published var categories = [String: [Discover]]()
//    //      @Published var categories
//
//    //    var categories: [String: [Discover]] {
//    //                           Dictionary(
//    //                            grouping: dataDiscover,
//    //                            by: { $0.category }
//    //                           )
//    //   }
//    init (){
//        updateData()
//    }
//    func updateData(){
//        let url = Constants.Api.viewPlant
//        let session = URLSession(configuration: .default)
//        session.dataTask(with: URL(string: url)!){(data,_,err) in
//            if err != nil{
//                print((err?.localizedDescription)!)
//                return
//            }
//            let json: [Discover] = try! JSONDecoder().decode([Discover].self, from: data!)
//            DispatchQueue.main.async {
//                //                self.dataDiscover = json
//                //                print("async",self.dataDiscover)
//                self.categories = Dictionary(grouping: json, by: {$0.category})
//                print(self.categories)
//
//                //                let students = ["Kofi", "Abena", "Efua", "Kweku", "Akosua"]
//                //                let studentsByLetter = Dictionary(grouping: students, by: { $0.first! })
//                //
//
//                //                self.categories = Dictionary(grouping: json, by: { $0.category })
//                //                print(studentsByLetter)
//                //                print(students)
//                //                print(self.categories)
//                //                return json
//                //bisa
//                //                var categories: [String: [Discover]] {
//                //                Dictionary(grouping: json,by: { $0.category })}
//                //                print(categories)
//
//            }
//
//            //
//        }.resume()
//    }
//
//}


struct cardDiscover: View{
    @Environment(\.imageCache) var cache: ImageCache
    var data: Discover
    
    
    var body: some View{
        HStack(){
            AsyncImage(url: URL(string: data.img)!, cache: self.cache, placeholder: ShimmerView().frame(width: 120, height: 120), configuration: { $0.resizable() })
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
