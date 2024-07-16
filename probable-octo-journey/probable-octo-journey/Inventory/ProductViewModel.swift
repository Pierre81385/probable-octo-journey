//
//  ProductViewModel.swift
//  probable-octo-journey
//
//  Created by m1_air on 7/15/24.
//

import Foundation
import Observation
import FirebaseFirestore

@Observable class ProductViewModel {
    var product: Product = Product()
    var products: [Product] = []
    let db = Firestore.firestore()
    
    //CRUD
    
    func createProduct () -> Bool {
        let ref = db.collection("products")
        do {
            try ref.addDocument(from: self.product)
            return true
        } catch {
            print("Error: \(error)")
            return false
        }
    }
    
    func getProduct() async -> Bool {
        let ref = db.collection("products").document(product.id!)
        do {
            self.product = try await ref.getDocument(as: Product.self)
            return true
        } catch {
            print("Error: \(error)")
            return false
        }
    }
    
    func getProducts() async -> Bool {
        let ref = db.collection("products")
        do {
            let querySnapshot = try await ref.getDocuments()
              for document in querySnapshot.documents {
                  try self.products.append(document.data(as: Product.self))
              }
            return true
        } catch {
          print("Error: \(error)")
            return false
        }
    }
    
    func updateProduct() -> Bool {
        let ref = db.collection("products").document(product.id!)
        do {
          try ref.setData(from: product)
            return true
        }
        catch {
            print("Error: \(error)")
            return false
        }
    }
    
    func deleteProduct() {
        let ref = db.collection("products").document(product.id!)
        
            ref.delete()
            
    }
}
