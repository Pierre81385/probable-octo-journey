//
//  ImagePicker.swift
//  probable-octo-journey
//
//  Created by m1_air on 7/16/24.
//
import Foundation
import SwiftUI
import PhotosUI

struct ImagePickerView: View {
    @State private var selectToggle: Bool = true
    @State private var selectedImage: PhotosPickerItem? = nil
    @State private var selectedImageData: Data? = nil
    @Binding var uploader: StoredImageViewModel

    
    var body: some View {
        ZStack {
            VStack{
                if let selectedImageData,
                   let uiImage = UIImage(data: selectedImageData) {
                    VStack {
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 325, height: 325)
                            .clipShape(RoundedRectangle(cornerSize: CGSize(width: 10, height: 10)))
                            .shadow(color: .gray.opacity(0.6), radius: 15, x: 5, y: 5)
                    }
                }
                
                if (selectToggle) {
                    
                    PhotosPicker(
                        selection: $selectedImage,
                        matching: .images,
                        photoLibrary: .shared()
                    ) {
                        Image(systemName: "camera.circle")
                            .resizable()
                            .foregroundStyle(.white)
                            .frame(width: 50, height: 50)
                    }.onChange(of: selectedImage ?? PhotosPickerItem(itemIdentifier: ""), { oldValue, newValue in
                        Task {
                            // Retrieve selected asset in the form of Data
                            if let data = try? await newValue.loadTransferable(type: Data.self) {
                                selectedImageData = data
                                selectToggle = false
                            }
                        }
                    })
                    
                } else {
                    VStack {
                                            HStack {
                                                Button(action: {
                                                    selectToggle = true
                                                }, label: { Text("Cancel")}).tint(.black)
                                                Button(action: {
                                                    let uiImage = UIImage(data: selectedImageData!)
                                                    uploader.uploadImage(uiImage: uiImage!)
                                                }, label: {
                                                    Text("Save").tint(.black)
                                                })
                                            }
                                        }
                }
            }
            
        }.onAppear {
        }
    }
}
