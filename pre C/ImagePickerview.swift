//
//  ImagePickerview.swift
//  pre C
//
//  Created by 千葉勇斗 on 2023/09/27.
//

import SwiftUI

struct ImagePickerview: UIViewControllerRepresentable {
    @Binding var isShowSheet:Bool //UIImagecontoroller(写真撮影)が表示されているかを管理
    @Binding var captureImage:UIImage? //撮影した写真を格納する変数
    
    
    //coordinaterでコントローラーのdelegateを確認
    class Coordinater:NSObject, UINavigationControllerDelegate,UIImagePickerControllerDelegate {
        let parent : ImagePickerview
        
        init(_ parent: ImagePickerview) {
            self.parent = parent
        }
        
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let originalImage = info[UIImagePickerController.InfoKey.originalImage]as? UIImage{
                parent.captureImage = originalImage
            }
            parent.isShowSheet.toggle()
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.isShowSheet.toggle()
        }
        //coordinetorを生成、swiftUIによって自動的に呼び出し
        func makeCoordinator() -> Coordinator {
            Coordinater(self)
        }
        
        func makeUIViewController(context: Context) -> UIViewController {
            let myImagePicakerController = UIImagePickerController()
            myImagePicakerController.sourceType = .camera
            
            myImagePicakerController.delegate = context.coordinator
            return myImagePicakerController
        }
        
        func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
            
        }
    }
}

 
