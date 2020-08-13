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
    
    @State var showingSetting = false
    
    @State var show = false
    
    @State var showContent = false
//    @State var selectedPlant: Int = 0
    
    @Environment(\.presentationMode) var presentationMode
    
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
            VStack {
                //search
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
                                    self.searchText = ""
                                    self.showCancelButton = false
                                }
                                .foregroundColor(Color(.systemBlue))
                            }
                        }
                        .navigationBarHidden(showCancelButton) // .animation(.default) // animation does not work properly
                }//end Vstack Search
                .padding(.horizontal, 16)
                
                //content
//                ScrollView(showsIndicators: false){
                    List{
                        
                        VStack{
                            
                            HStack(){
                                Text("Sayur")
                                    .fontWeight(.bold)
                                Spacer()
                                
                                Text("View all")
                                    .foregroundColor(.gray)
                                    .padding(.leading, 200)
                                
                            }.padding([.top], 15)
                        }
                        ScrollView(.horizontal, showsIndicators: false) {
                        //content here
                            HStack(){

                                VStack(alignment: .leading,spacing: 5){
                                        Button(action: {
                                            self.show.toggle()
                                        }) {
    
                                            Image("mawar")
                                                .resizable()
                                                .renderingMode(.original)
                                                .cornerRadius(10)
                                            
                                        }
                                            
                                        .frame(width: 115, height: 115)
                                            .cornerRadius(10)
                                            
                                        Text("Touge")
                                            .fontWeight(.regular)
                                            .font(Font.system(size:14, design: .default))

                                        HStack(spacing: 5){
                                            Text("Indoor").foregroundColor(.gray)
                                            .font(Font.system(size:14, design: .default))
                                        }
                                    }.frame(width: 133, height: 175)
                                    .background(Color.white)
                                    .cornerRadius(9)
                                    .shadow(color: Color.black.opacity(0.10), radius: 2, x: 2, y: 2)
                                    .sheet(isPresented: $show){
                                        Detail()
                                    }
                                }
                            }.frame(height: 185)
                            .padding([.leading], 3)
                            
                        }
                    Spacer()
                    }
                    .navigationBarTitle(Text("Menjelajah"))
                    .navigationBarItems(trailing: settingButton)
                    .sheet(isPresented: $showingSetting) {
                        SettingView()
//                       .environmentObject(self.userData)
                    }
                
//                List{
//                    ForEach(categories.keys.sorted(), id: \.self){ key in
//                        Text(key)
//                    }
//                }
//                }
            }
        }
    }


struct Detail: View {
    @Environment(\.presentationMode) private var presentationMode
    
    var body : some View{

        VStack{
            VStack{
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
                
                GeometryReader{ geo in
                    ScrollView(showsIndicators: false){
                        Image("onboarding2")
                            .resizable()
                            .aspectRatio(1, contentMode: .fill)
                            .frame(width:UIScreen.main.bounds.width, height: 300)
                        
                        detailTop()
                        detailBottom()
                        
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
struct detailTop : View {
    var body : some View{
        VStack(alignment: .leading, spacing: 10){

            HStack{
                VStack(alignment: .leading){
                    NavigationLink(destination: CameraView()){
                        
                        Text("Tutorial")
                            .fontWeight(.semibold)
                            .foregroundColor(Color.white)
                            .font(.subheadline)
                            .padding(.top, 0)
                            .padding()
                    }
                    Text("Cara menanam bunga Mawar")
                        .fontWeight(.heavy)
                        .foregroundColor(Color.white)
                        .font(.title)
                        .padding(.top, -30)
                        .padding()
                    
                        
                }
                Spacer()
            }
            .background(Image("onboarding2")
                .resizable()
                .frame(width:UIScreen.main.bounds.width, height: 100.0)
                .blur(radius: 40, opaque: true)
            )
            .padding(.top, -80)
            
            VStack(){
                Text("Mawar")
                Text("Rosa")
            }.padding(.top, 10)
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
            }.padding(40)
                .padding(.top, -40)
                .padding(.bottom, -40)
        }
    }
}
struct detailBottom : View {

    var body : some View{

        VStack(alignment: .center, spacing: 10){

            Text("         Bunga mawar merupakan tanaman tertua di dunia. Fosil bunga mawar ditemukan sekitar 35 juta tahun yang lalu di Florissant, Colorado, AS. Mawar liar terdiri dari 100 spesies lebih, kebanyakan tumbuh di belahan bumi utara yang berudara sejuk.").foregroundColor(.gray)
            Text("         Manfaat bunga mawar pun cukup beragam, mulai dari produk kecantikan hingga dikonsumsi sebagai minuman atau makanan.").foregroundColor(.gray)

        }.padding()
    }
}

//struct Rounded : Shape {
//
//    func path(in rect: CGRect) -> Path {
//
//        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: [.topLeft,.topRight], cornerRadii: CGSize(width: 40, height: 40))
//        return Path(path.cgPath)
//    }
//}

struct ShelterDetailedView: View {
    var image: String

    var body: some View {
        ZStack {
            VStack {
                Image(image)
                    .resizable()
                    .frame(width: UIScreen.main.bounds.width, height: 300)
                Spacer()
            }
        }
    }
}


class getDataDiscover: ObservableObject{
    //    @Published var data: MyPlant!
    @Published var dataDiscover = [Discover]()
    
    init (){
        updateData()
    }
    func updateData(){
        let url = Constants.Api.discoverPlant
        let session = URLSession(configuration: .default)
        session.dataTask(with: URL(string: url)!){(data,_,err) in
            if err != nil{
                print((err?.localizedDescription)!)
                return
            }
            //            https://www.avanderlee.com/swift/json-parsing-decoding/
            let json: [Discover] = try! JSONDecoder().decode([Discover].self, from: data!)
            DispatchQueue.main.async {self.dataDiscover = json}
            DispatchQueue.main.sync {self.dataDiscover = json}
                print(self.dataDiscover)
        }.resume()
    }
    
}


struct cardDiscover: View{
    @Environment(\.imageCache) var cache: ImageCache
    
    var data: Discover
    @State var show = false
    
    var body: some View{
        VStack(alignment: .leading,spacing: 5){
            AsyncImage(url: URL(string: data.img)!, cache: self.cache, placeholder: Text("Loading ..."), configuration: { $0.resizable()})
                
            .frame(width: 115, height: 115)
                .cornerRadius(10)
                
            Text(data.nama)
                .fontWeight(.regular)
                .font(Font.system(size:14, design: .default))

            HStack(spacing: 5){
                Text(data.tempat).foregroundColor(.gray)
                .font(Font.system(size:14, design: .default))
            }
        }.frame(width: 133, height: 175)
        .background(Color.white)
        .cornerRadius(9)
            .shadow(color: Color.black.opacity(0.10), radius: 2, x: 2, y: 2)
//        .sheet(isPresented: $show){
//            Detail()
//        }
    }
    
}
