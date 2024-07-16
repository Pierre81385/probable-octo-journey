//
//  AppUserViewModel.swift
//  probable-octo-journey
//
//  Created by m1_air on 7/15/24.
//

import Foundation
import Observation
import FirebaseFirestore

@Observable class AppUserViewModel {
    var appUser: AppUser = AppUser()
    var appUsers: [AppUser] = []
    let db = Firestore.firestore()
    
    //CRUD
    
    func createAppUser () -> Bool {
        let ref = db.collection("appUsers")
        do {
            try ref.addDocument(from: self.appUser)
            return true
        } catch {
            print("Error: \(error)")
            return false
        }
    }
    
    func getAppUser() async -> Bool {
        let ref = db.collection("appUsers").document(appUser.id)
        do {
            self.appUser = try await ref.getDocument(as: AppUser.self)
            return true
        } catch {
            print("Error: \(error)")
            return false
        }
    }
    
    func getAppUsers() async -> Bool {
        let ref = db.collection("appUsers")
        do {
            let querySnapshot = try await ref.getDocuments()
              for document in querySnapshot.documents {
                  try self.appUsers.append(document.data(as: AppUser.self))
              }
            return true
        } catch {
          print("Error: \(error)")
            return false
        }
    }
    
    func updateAppUser() -> Bool {
        let ref = db.collection("appUsers").document(appUser.id)
        do {
          try ref.setData(from: appUser)
            return true
        }
        catch {
            print("Error: \(error)")
            return false
        }
    }
    
    func deleteAppUser() {
        let ref = db.collection("appUsers").document(appUser.id)
        
            ref.delete()
            
    }
}
