//
//  ImageModel.swift
//  probable-octo-journey
//
//  Created by m1_air on 7/16/24.
//

import Foundation
import Foundation
import SwiftUI
import PhotosUI
import FirebaseStorage
import Observation

@Observable class StoredImageViewModel {
    var imageStore: ImageStore = ImageStore(data: Data(), url: "")
    let storage = Storage.storage()
    
    func uploadImage(uiImage: UIImage) -> Bool {
        let storageRef = storage.reference().child("images/\(uiImage.hash)")
        let data = uiImage.jpegData(compressionQuality: 0.3)
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpg"
        if let data = data {
            storageRef.putData(data, metadata: metadata) {
                (metadata, error) in
                    if let error = error {
                        print(error.localizedDescription)
                        return
                    }
                
                    if let metadata = metadata {
                        print(metadata)
                    }
                
                    storageRef.downloadURL { (url, error) in
                        guard let downloadURL = url else {
                          // Uh-oh, an error occurred!
                          return
                        }
                        
                    self.imageStore.url = downloadURL.absoluteString
                  }
            }
        }
        return true
    }
    
}
