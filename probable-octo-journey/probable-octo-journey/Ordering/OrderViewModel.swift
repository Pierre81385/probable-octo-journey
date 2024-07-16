//
//  OrderViewModel.swift
//  probable-octo-journey
//
//  Created by m1_air on 7/15/24.
//

import Foundation
import Observation
import FirebaseFirestore

@Observable class OrderViewModel {
    var order: Order = Order()
    var orders: [Order] = []
    let db = Firestore.firestore()
    
    //CRUD
    
    func createOrder () -> Bool {
        let ref = db.collection("orders")
        do {
            try ref.addDocument(from: self.order)
            return true
        } catch {
            print("Error: \(error)")
            return false
        }
    }
    
    func getOrder() async -> Bool {
        let ref = db.collection("orders").document(order.id!)
        do {
            self.order = try await ref.getDocument(as: Order.self)
            return true
        } catch {
            print("Error: \(error)")
            return false
        }
    }
    
    func getOrders() async -> Bool {
        let ref = db.collection("orders")
        do {
            let querySnapshot = try await ref.getDocuments()
              for document in querySnapshot.documents {
                  try self.orders.append(document.data(as: Order.self))
              }
            return true
        } catch {
          print("Error: \(error)")
            return false
        }
    }
    
    func updateOrder() -> Bool {
        let ref = db.collection("orders").document(order.id!)
        do {
          try ref.setData(from: order)
            return true
        }
        catch {
            print("Error: \(error)")
            return false
        }
    }
    
    func deleteOrder() {
        let ref = db.collection("orders").document(order.id!)
        
            ref.delete()
            
    }
}
