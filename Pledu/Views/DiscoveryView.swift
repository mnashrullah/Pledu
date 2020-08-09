//
//  DiscoveryView.swift
//  Pledu
//
//  Created by Muhammad Nashrullah on 04/08/20.
//  Copyright © 2020 Kepiting Bakau. All rights reserved.
//

import SwiftUI

struct DiscoveryView: View {
    
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
//            VStack(alignment: .leading,spacing: 12){
            VStack {
                //search
                VStack(alignment: .leading, spacing: 5){
                                    Text("Ingin Menanam?").fontWeight(.heavy)
                                    Text("Temukan tanaman yang ingin kamu tanam").foregroundColor(.gray)
                                    
                //
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
                }.padding(.horizontal, 16)
                
                //content
                ScrollView(showsIndicators: false){
                    
                    VStack{
                        HStack{
                            
                            Text("Bunga").fontWeight(.heavy)
                            
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
                                        self.show.toggle()
                                    }) {
                                        
                                        Image("scale").renderingMode(.original).cornerRadius(10)
                                    }
                                    
                                    Text("Mawar").fontWeight(.heavy)
                                    
                                    HStack(spacing: 5){
                                        
                                        Text("Rosella").foregroundColor(.gray)
                                    }
                                }.sheet(isPresented: $show){
                                    Detail()
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
                    }
                    VStack{
                        HStack{
                            
                            Text("Bunga").fontWeight(.heavy)
                            
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
                    }
                    VStack{
                        HStack{
                            
                            Text("Bunga").fontWeight(.heavy)
                            
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
                    }
                    Spacer()

                    
                    
                }.padding()
                    .navigationBarTitle(Text("Names"))
                    .navigationBarTitle(Text("Menjelajah"))
                    .navigationBarItems(trailing: settingButton)
                    .sheet(isPresented: $showingSetting) {
                        SettingView()
                        //                    .environmentObject(self.userData)
                }
            }
        }
    }
}


struct DiscoveryView_Previews: PreviewProvider {
    
    static var previews: some View {
        DiscoveryView()
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
                    Text("Tutorial").fontWeight(.heavy).font(.subheadline)
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
