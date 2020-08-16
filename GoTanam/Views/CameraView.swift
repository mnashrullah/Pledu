//
//  CameraView.swift
//  Pledu
//
//  Created by Muhammad Nashrullah on 10/08/20.
//  Copyright © 2020 Kepiting Bakau. All rights reserved.
//

import SwiftUI

class ProgressUpload: ObservableObject, Codable{
    enum CodingKeys: CodingKey {
        case phase, description, idUser, idPlant, img, dayDifferent, dateCreated
    }
    
    static let types = [
        NSLocalizedString(Constants.tahapan[0], comment: ""),
        NSLocalizedString(Constants.tahapan[1], comment: ""),
        NSLocalizedString(Constants.tahapan[2], comment: ""),
        NSLocalizedString(Constants.tahapan[3], comment: ""),
        NSLocalizedString(Constants.tahapan[4], comment: "")
    ]
    
    @Published var phase: Int = 0
    @Published var description = ""
    @Published var idUser: Int = 1
    @Published var idPlant: Int = 1
    @Published var img: String = "new image.jpg"
    @Published var dayDifferent: Int = 1
    @Published var dateCreated: String = "2020-08-12"
    
    
    func getTodayDate()->String{
        return "2020-08-08"
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(phase, forKey: .phase)
        try container.encode(description, forKey: .description)
        try container.encode(idUser, forKey: .idUser)
        try container.encode(idPlant, forKey: .idPlant)
        try container.encode(img, forKey: .img)
        try container.encode(dayDifferent, forKey: .dayDifferent)
        try container.encode(dateCreated, forKey: .dateCreated)
        
    }
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        phase = try container.decode(Int.self, forKey: .phase)
        description = try container.decode(String.self, forKey: .description)
        idUser = try container.decode(Int.self, forKey: .idUser)
        idPlant = try container.decode(Int.self, forKey: .idPlant)
        img = try container.decode(String.self, forKey: .img)
        dayDifferent = try container.decode(Int.self, forKey: .dayDifferent)
        dateCreated = try container.decode(String.self, forKey: .dateCreated)

    }
    init() { }
}


struct CameraView: View {
    var idPLant: Int
    var dateCreated: String
    @State var image: Image? = nil
    @State var rawimage: UIImage? = nil
    @State var showCaptureImageView: Bool = true
    @ObservedObject var dataprogress = ProgressUpload()
    @Environment(\.presentationMode) var presentationMode
    @State private var showingAlert = false

    
    var body: some View {
        ZStack {
            NavigationView {
                VStack(alignment: .leading, spacing: 12){
                    HStack(){
                        Text("Upload Progress")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        Spacer()
                        Button(action: {
//                            saveProgress(data: self.dataprogress, pic: self.rawimage!)
                            saveProgress2(data: self.dataprogress, pic:  resizeImage(image: self.rawimage!), idPlant: self.idPLant, dateCreated: self.dateCreated)
                            self.showingAlert = true
                        }){
                            Text("Save")
                        }.disabled(
                                !(image != nil))
                        .alert(isPresented: $showingAlert) {
                            Alert(title: Text("Success!"), message: Text("Progress succesfully saved"),
                                  dismissButton: .default(Text("Back to My Plant"), action: {
                                    self.presentationMode.wrappedValue.dismiss()
                                  }))
                        }
                    }.padding()
                    VStack(alignment: .center) {
                        image?.resizable()
                            .frame(width: 250, height: 200)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.white, lineWidth: 4))
                            .shadow(radius: 10)
                            .padding(.top, 20)
                        Button(action: {
                            self.showCaptureImageView.toggle()
                        }) {
                            Text("Choose photos")
                        }
                        Form{
                            TextField("Description", text: $dataprogress.description)
                            Picker("Select a phase", selection: $dataprogress.phase) {
                                ForEach(0..<ProgressUpload.types.count) {
                                    Text(ProgressUpload.types[$0])
                                }
                            }
                        }
                        
                        
                    }
                    Spacer()
                }
            }
            if (showCaptureImageView) {
                CaptureImageView(isShown: $showCaptureImageView, image: $image, rawimage: $rawimage )
            }
            
        }
    }
    
}
func resizeImage(image: UIImage) -> UIImage {
    var actualHeight: Float = Float(image.size.height)
    var actualWidth: Float = Float(image.size.width)
    let maxHeight: Float = 300.0
    let maxWidth: Float = 400.0
    var imgRatio: Float = actualWidth / actualHeight
    let maxRatio: Float = maxWidth / maxHeight
    let compressionQuality: Float = 0.5
    //50 percent compression

    if actualHeight > maxHeight || actualWidth > maxWidth {
        if imgRatio < maxRatio {
            //adjust width according to maxHeight
            imgRatio = maxHeight / actualHeight
            actualWidth = imgRatio * actualWidth
            actualHeight = maxHeight
        }
        else if imgRatio > maxRatio {
            //adjust height according to maxWidth
            imgRatio = maxWidth / actualWidth
            actualHeight = imgRatio * actualHeight
            actualWidth = maxWidth
        }
        else {
            actualHeight = maxHeight
            actualWidth = maxWidth
        }
    }

    let rect = CGRect(x: 0.0, y: 0.0, width: CGFloat(actualWidth), height: CGFloat(actualHeight))
    UIGraphicsBeginImageContext(rect.size)
    image.draw(in: rect)
    let img = UIGraphicsGetImageFromCurrentImageContext()
    let imageData = img!.jpegData(compressionQuality: CGFloat(compressionQuality))
    UIGraphicsEndImageContext()
    return UIImage(data: imageData!)!
}

struct CaptureImageView {
    /// TODO 2: Implement other things later
    /// MARK: - Properties
    @Binding var isShown: Bool
    @Binding var image: Image?
    @Binding var rawimage: UIImage?
    
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(isShown: $isShown, image: $image, rawimage: $rawimage)
    }
}
extension CaptureImageView: UIViewControllerRepresentable {
    func makeUIViewController(context: UIViewControllerRepresentableContext<CaptureImageView>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = .camera // use camera
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController,
                                context: UIViewControllerRepresentableContext<CaptureImageView>) {
        
    }
}

class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    @Binding var isCoordinatorShown: Bool
    @Binding var imageInCoordinator: Image?
    @Binding var imageRawInCoordinator: UIImage?
    init(isShown: Binding<Bool>, image: Binding<Image?>, rawimage: Binding<UIImage?>) {
        _isCoordinatorShown = isShown
        _imageInCoordinator = image
        _imageRawInCoordinator = rawimage
    }
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let unwrapImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
        imageInCoordinator = Image(uiImage: unwrapImage)
        imageRawInCoordinator = unwrapImage
        isCoordinatorShown = false
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        isCoordinatorShown = false
    }
    
}


//
//func saveProgress(data: ProgressUpload, pic: UIImage){
//    print(data.dateCreated)
//    print(data.dayDifferent)
//    print(data.description)
//    print(data.idPlant)
//    print(data.idUser)
//    print(data.phase)
//    print(data.img)
//    print(pic)
//    let imageData:NSData = pic.pngData()! as NSData
//       // convert the NSData to base64 encoding
//    let strBase64:String = imageData.base64EncodedString(options: .lineLength64Characters)
//    data.img = strBase64
//
//
//    let url = Constants.Api.addProgress
//    var urlRequest = URLRequest(url: URL(string: url)!)
//    urlRequest.httpMethod = "POST"
//    urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
//    urlRequest.httpBody = try? JSONEncoder().encode(data)
//
//
//
//
//
//    URLSession.shared.dataTask(with: urlRequest)
//    {(data,response,err) in
//        if err != nil{
//            print((err?.localizedDescription)!)
//            return
//        }
//        print("data",data as Any)
//        print("res",response as Any)
//        print("err",err as Any)
////        let json: [ProgressUpload] = try! JSONDecoder().decode([ProgressUpload].self, from: data!)
////        print(json)
//    }.resume()
//
//}


func saveProgress2(data: ProgressUpload, pic: UIImage, idPlant: Int, dateCreated: String){
    print("saveProgress2 ",data, "idplant ")
    
    print("upload imagw with data", UserDefaults.standard.integer(forKey: Constants.dataUserDefault.idUser), "idPlant", data.idPlant, "idplant2", Constants.dataUserDefault.idPlant)

    let filename = "avatar.png"

    // generate boundary string using a unique per-app string
    let boundary = UUID().uuidString

    let fieldName = "idUser"
    let fieldValue = UserDefaults.standard.integer(forKey: Constants.dataUserDefault.idUser)

    let fieldName2 = "idPlant"
    let fieldValue2 = idPlant

    let fieldName3 = "description"
    let fieldValue3 = data.description

    let fieldName4 = "phase"
    let fieldValue4 = data.phase
    
    let fieldName5 = "dateCreated"
    let fieldValue5 = dateCreated

    let config = URLSessionConfiguration.default
    let session = URLSession(configuration: config)

    // Set the URLRequest to POST and to the specified URL
    var urlRequest = URLRequest(url: URL(string: Constants.Api.uploadProgress)!)
    urlRequest.httpMethod = "POST"

    // Set Content-Type Header to multipart/form-data, this is equivalent to submitting form data with file upload in a web browser
    // And the boundary is also set here
    urlRequest.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")

    var data = Data()

//     Add the reqtype field and its value to the raw http request data
    data.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
    data.append("Content-Disposition: form-data; name=\"\(fieldName)\"\r\n\r\n".data(using: .utf8)!)
    data.append("\(fieldValue)".data(using: .utf8)!)

    // Add the userhash field and its value to the raw http reqyest data
    data.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
    data.append("Content-Disposition: form-data; name=\"\(fieldName2)\"\r\n\r\n".data(using: .utf8)!)
    data.append("\(fieldValue2)".data(using: .utf8)!)
    
    // Add the userhash field and its value to the raw http reqyest data
    data.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
    data.append("Content-Disposition: form-data; name=\"\(fieldName3)\"\r\n\r\n".data(using: .utf8)!)
    data.append("\(fieldValue3)".data(using: .utf8)!)
    
    // Add the userhash field and its value to the raw http reqyest data
    data.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
    data.append("Content-Disposition: form-data; name=\"\(fieldName4)\"\r\n\r\n".data(using: .utf8)!)
    data.append("\(fieldValue4)".data(using: .utf8)!)
    
    // Add the userhash field and its value to the raw http reqyest data
    data.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
    data.append("Content-Disposition: form-data; name=\"\(fieldName5)\"\r\n\r\n".data(using: .utf8)!)
    data.append("\(fieldValue5)".data(using: .utf8)!)
  

    // Add the image data to the raw http request data
    data.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
    data.append("Content-Disposition: form-data; name=\"photo\"; filename=\"\(filename)\"\r\n".data(using: .utf8)!)
    data.append("Content-Type: image/png\r\n\r\n".data(using: .utf8)!)
    data.append(pic.pngData()!)

    // End the raw http request data, note that there is 2 extra dash ("-") at the end, this is to indicate the end of the data
    // According to the HTTP 1.1 specification https://tools.ietf.org/html/rfc7230
    data.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)

    // Send a POST request to the URL, with the data we created earlier
    session.uploadTask(with: urlRequest, from: data, completionHandler: { responseData, response, error in
        
        if(error != nil){
            print("\(error!.localizedDescription)")
        }
        
        guard let responseData = responseData else {
            print("no response data")
            return
        }
        
        if let responseString = String(data: responseData, encoding: .utf8) {
            print("uploaded to: \(responseString)")
        }
    }).resume()
    
}



extension UIImage {
    enum JPEGQuality: CGFloat {
        case lowest  = 0
        case low     = 0.25
        case medium  = 0.5
        case high    = 0.75
        case highest = 1
    }

    /// Returns the data for the specified image in JPEG format.
    /// If the image object’s underlying image data has been purged, calling this function forces that data to be reloaded into memory.
    /// - returns: A data object containing the JPEG data, or nil if there was a problem generating the data. This function may return nil if the image has no data or if the underlying CGImageRef contains data in an unsupported bitmap format.
    func jpeg(_ jpegQuality: JPEGQuality) -> Data? {
        return jpegData(compressionQuality: jpegQuality.rawValue)
    }
}

extension UIImage {
    func resized(withPercentage percentage: CGFloat, isOpaque: Bool = true) -> UIImage? {
        let canvas = CGSize(width: size.width * percentage, height: size.height * percentage)
        let format = imageRendererFormat
        format.opaque = isOpaque
        return UIGraphicsImageRenderer(size: canvas, format: format).image {
            _ in draw(in: CGRect(origin: .zero, size: canvas))
        }
    }
    func resized(toWidth width: CGFloat, isOpaque: Bool = true) -> UIImage? {
        let canvas = CGSize(width: width, height: CGFloat(ceil(width/size.width * size.height)))
        let format = imageRendererFormat
        format.opaque = isOpaque
        return UIGraphicsImageRenderer(size: canvas, format: format).image {
            _ in draw(in: CGRect(origin: .zero, size: canvas))
        }
    }
}
