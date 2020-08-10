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
                VStack(alignment: .leading, spacing: 5){
                    Text("Ingin Menanam?").fontWeight(.heavy)
                        .background(Color("white"))
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
                                UIApplication.shared.endEditing(true)
                                self.searchText = ""
                                self.showCancelButton = false
                            }
                            .foregroundColor(Color(.systemBlue))
                        }
                    }.animation(.default)
                }
                .padding(.horizontal, 16)
                .resignKeyboardOnDragGesture()
            
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
                                        
                                        Image("mawar").renderingMode(.original).cornerRadius(10)
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
                                        
                                        Image("mawar").renderingMode(.original).cornerRadius(10)
                                    }
                                    
                                    Text("Mawar").fontWeight(.heavy)
                                    
                                    HStack(spacing: 5){
                                        
                                        Text("Rosella").foregroundColor(.gray)
                                    }
                                }
                                VStack(alignment: .leading,spacing: 5){
                                    
                                    Button(action: {
                                        
                                    }) {
                                        
                                        Image("mawar").renderingMode(.original).cornerRadius(10)
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
                                        
                                        Image("mawar").renderingMode(.original).cornerRadius(10)
                                    }
                                    
                                    Text("Mawar").fontWeight(.heavy)
                                    
                                    HStack(spacing: 5){
                                        
                                        Text("Rosella").foregroundColor(.gray)
                                    }
                                }
                                
                                VStack(alignment: .leading,spacing: 5){
                                    
                                    Button(action: {
                                        
                                    }) {
                                        
                                        Image("mawar").renderingMode(.original).cornerRadius(10)
                                    }
                                    
                                    Text("Mawar").fontWeight(.heavy)
                                    
                                    HStack(spacing: 5){
                                        
                                        Text("Rosella").foregroundColor(.gray)
                                    }
                                }
                                VStack(alignment: .leading,spacing: 5){
                                    
                                    Button(action: {
                                        
                                    }) {
                                        
                                        Image("mawar").renderingMode(.original).cornerRadius(10)
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
                                        
                                        Image("mawar").renderingMode(.original).cornerRadius(10)
                                    }
                                    
                                    Text("Mawar").fontWeight(.heavy)
                                    
                                    HStack(spacing: 5){
                                        
                                        Text("Rosella").foregroundColor(.gray)
                                    }
                                }
                                
                                VStack(alignment: .leading,spacing: 5){
                                    
                                    Button(action: {
                                        
                                    }) {
                                        
                                        Image("mawar").renderingMode(.original).cornerRadius(10)
                                    }
                                    
                                    Text("Mawar").fontWeight(.heavy)
                                    
                                    HStack(spacing: 5){
                                        
                                        Text("Rosella").foregroundColor(.gray)
                                    }
                                }
                                VStack(alignment: .leading,spacing: 5){
                                    
                                    Button(action: {
                                        
                                    }) {
                                        
                                        Image("mawar").renderingMode(.original).cornerRadius(10)
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

struct Detail: View {
    
    var body : some View{
        VStack{
            VStack{
                Image("mawar")
                    .resizable()
                    .aspectRatio(1, contentMode: .fill)
                    .frame(width:UIScreen.main.bounds.width, height: 500)
                    .offset(y: -200).padding(.bottom, -200)
                
                
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
                    Text("Tutorial").fontWeight(.regular).font(.subheadline)
                    Text("Cara menanam bunga Mawar").fontWeight(.heavy).font(.title)
                }
                Spacer()
                }.padding(.top, 5).padding()

            VStack(){
                Text("Mawar").fontWeight(.semibold)
                Text("Rosa").fontWeight(.light)
            }
            .frame(width:UIScreen.main.bounds.width)
            HStack{
                VStack{
                    Text("Jenis").fontWeight(.semibold)
                    Text("Bunga").fontWeight(.light)
                }
                Spacer()
                VStack{
                    Text("Jenis").fontWeight(.semibold)
                    Text("Bunga").fontWeight(.light)
                }
            }.padding()
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
                    
                }.background(Color("accentColor"))
                .cornerRadius(8)
                
            }.padding(.top, 6)
            
        }.padding()
    }
}



struct Rounded : Shape {
    
    func path(in rect: CGRect) -> Path {
        
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: [.topLeft,.topRight], cornerRadii: CGSize(width: 5, height: 5))
        return Path(path.cgPath)
    }
}
