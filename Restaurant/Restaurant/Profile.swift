//
//  Profile.swift
//  Restaurant
//
//  Created by User01 on 2021/1/18.
//

import SwiftUI

struct Profile: View {
    
    @State var imgData = Data.init(count: 0)
    @State var shown = false
    
    var body: some View {
        NavigationView {
            VStack{
            
                if imgData.count != 0{
             
                    Image(uiImage: UIImage(data: imgData)!).resizable().frame(height: 300).padding().cornerRadius(20)
                }
                Button(action: {
                
                    self.shown.toggle()
                
                }) {
                
                    Text("Select Your Profile Picture")
                }.sheet(isPresented: $shown) {
                
                    picker(shown: self.$shown, imgData: self.$imgData)
                }
            
            }
            .animation(.spring())
            .navigationTitle("Profile Picture")
        }
    }
}

struct Profile_Previews: PreviewProvider {
    static var previews: some View {
        Profile()
    }
}

struct picker : UIViewControllerRepresentable {
    
    @Binding var shown : Bool
    @Binding var imgData : Data
    
    func makeCoordinator() -> Coordinator {
        
        return Coordinator(imgData1: $imgData, shown1: $shown)
    }
    
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<picker>) -> UIImagePickerController {
        
        let controller = UIImagePickerController()
        controller.sourceType = .photoLibrary
        controller.delegate = context.coordinator
        return controller
        
    }
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<picker>) {
        
    }
    
    class Coordinator : NSObject, UIImagePickerControllerDelegate,UINavigationControllerDelegate{
        
        @Binding var imgData : Data
        @Binding var shown : Bool
        
        init(imgData1 : Binding<Data>,shown1 : Binding<Bool>) {
            
            _imgData = imgData1
            _shown = shown1
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            
            shown.toggle()
            
        }
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            
            let image = info[.originalImage] as! UIImage
            imgData = image.jpegData(compressionQuality: 80)!
            shown.toggle()
        }
    }
}
