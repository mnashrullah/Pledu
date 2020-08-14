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
//            NavigationLink(destination: CameraView()){
             
                if self.dataProgress.count != 0 {
                    List{
                        ForEach(0..<self.dataProgress.count, id:\.self){i in
                        cardSingleProgress(data: self.dataProgress[i])
                        }
                        
                    }
                    Spacer()
                }else{
                    Text("Kamu belum mempunyai progress")
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
            
        .onAppear(){
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
    
    @State private var rect: CGRect = .zero
    @State private var uiImage: UIImage? = nil
    @State private var showShareSheet = false

    var data: MyProgress
    var body: some View{

            VStack(alignment: .leading,spacing: 5){
                HStack{
                       Text("Hari ke - " + String(data.dayDifferent)).fontWeight(.heavy)
                       Spacer()
                    Button(action: {
                        self.uiImage = UIApplication.shared.windows[0].rootViewController?.view!.getImage(rect: self.rect)
                        self.showShareSheet.toggle()
                    }){
                        Image(systemName: "square.and.arrow.up").renderingMode(.original)
                    }
                   }.padding([.top], 15)
                    .sheet(isPresented: self.$showShareSheet) {
                    ShareSheet(photo: self.uiImage!)
                    }
                .background(RectangleGetter(rect: $rect))
                
                Button(action: {}) {
                    Image(data.img).renderingMode(.original).cornerRadius(10)
                    AsyncImage(url: URL(string: data.img)!, cache: self.cache, placeholder: ShimmerView().aspectRatio(3/2, contentMode: .fit)
                        .cornerRadius(10),
                        configuration: { $0.resizable() })
                        .aspectRatio(3/2, contentMode: .fit)
                        .cornerRadius(10)
                }.buttonStyle(PlainButtonStyle())
                Text(data.description).font(.body)
                
            }

        }
        
        
        
//        VStack {
//                  HStack {
//                      Image(systemName: "sun.haze")
//                          .font(.title)
//                          .foregroundColor(.white)
//                      Text("Hello, World!")
//                          .font(.title)
//                          .foregroundColor(.white)
//                  }
//                  .padding()
//                  .background(Color.blue)
//                  .cornerRadius(8)
//                  .background(RectangleGetter(rect: $rect))
//                  .onAppear() {
//
//                  }
//                  Button(action: {
//                      self.uiImage = UIApplication.shared.windows[0].rootViewController?.view!.getImage(rect: self.rect)
//                      self.showShareSheet.toggle()
//                  }) {
//                      Image(systemName: "square.and.arrow.up")
//                          .resizable()
//                          .aspectRatio(contentMode: .fit)
//                          .frame(width: 50, height: 50)
//                          .padding()
//                          .background(Color.pink)
//                          .foregroundColor(Color.white)
//                          .mask(Circle())
//                  }
//                  .sheet(isPresented: self.$showShareSheet) {
//                      ShareSheet(photo: self.uiImage!)
//                  }.padding()
//              }
//           }
        
        
        
//        VStack(alignment: .leading,spacing: 5){
//            HStack{
//                   Text("Hari ke - " + String(data.dayDifferent)).fontWeight(.heavy)
//                   Spacer()
//                Button(action: {
////                    ShareSheet
//                }){
//                    Image(systemName: "square.and.arrow.up").renderingMode(.original)
//                }
//               }.padding([.top], 15)
//            Button(action: {}) {
//                Image(data.img).renderingMode(.original).cornerRadius(10)
//                AsyncImage(url: URL(string: data.img)!, cache: self.cache, placeholder: Text("Loading ..."), configuration: { $0.resizable() })
//                    .frame(width: UIScreen.main.bounds.width, height: 120)
//                    .cornerRadius(10)
//            }.buttonStyle(PlainButtonStyle())
//            Text(data.description).font(.body)
//        }
//    }
}

import LinkPresentation

struct RectangleGetter: View {
    @Binding var rect: CGRect
    
    var body: some View {
        GeometryReader { geometry in
            self.createView(proxy: geometry)
        }
    }
    
    func createView(proxy: GeometryProxy) -> some View {
        DispatchQueue.main.async {
            self.rect = proxy.frame(in: .global)
        }
        return Rectangle().fill(Color.clear)
    }
}

extension UIView {
    func getImage(rect: CGRect) -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: rect)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
}


struct ShareSheet: UIViewControllerRepresentable {
    let photo: UIImage
          
    func makeUIViewController(context: Context) -> UIActivityViewController {
        let text = "🐥"
        let itemSource = ShareActivityItemSource(shareText: text, shareImage: photo)
        
        let activityItems: [Any] = [photo, text, itemSource]
        
        let controller = UIActivityViewController(
            activityItems: activityItems,
            applicationActivities: nil)
        
        return controller
    }
      
    func updateUIViewController(_ vc: UIActivityViewController, context: Context) {
    }
}

class ShareActivityItemSource: NSObject, UIActivityItemSource {
    
    var shareText: String
    var shareImage: UIImage
    var linkMetaData = LPLinkMetadata()
    
    init(shareText: String, shareImage: UIImage) {
        self.shareText = shareText
        self.shareImage = shareImage
        linkMetaData.title = shareText
        super.init()
    }
    
    func activityViewControllerPlaceholderItem(_ activityViewController: UIActivityViewController) -> Any {
        return UIImage(named: "AppIcon ") as Any
    }
    
    func activityViewController(_ activityViewController: UIActivityViewController, itemForActivityType activityType: UIActivity.ActivityType?) -> Any? {
        return nil
    }
    
    func activityViewControllerLinkMetadata(_ activityViewController: UIActivityViewController) -> LPLinkMetadata? {
        return linkMetaData
    }
}
