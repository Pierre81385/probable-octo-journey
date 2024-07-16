//
//  AppUserViewModel.swift
//  probable-octo-journey
//
//  Created by m1_air on 7/15/24.
//

import Foundation
import Observation
import FirebaseAuth
import FirebaseFirestore

@Observable class AppUserViewModel {
    var appUser: AppUser = AppUser()
    var appUsers: [AppUser] = []
    let db = Firestore.firestore()
    private var handle: AuthStateDidChangeListenerHandle?
    
    //authentication
    
    func createAuthorizedUser(password: String) {
        Auth.auth().createUser(withEmail: appUser.email, password: password) { (result, error) in
                      if error != nil {
                          print(error?.localizedDescription ?? "")
                      } else {
                          print("Success!")
                      }
                  }
    }
    
    func ListenForUserState() {
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            switch user {
            case .none:
                print("USER NOT FOUND IN CHECK AUTH STATE")
                self.appUser.loggedIn = false
            case .some(let user):
                print("FOUND: \(user.uid)!")
                self.appUser.loggedIn = true
            }
        }
    }
    
    func StopListenerForUserState() {
        if(handle != nil){
            Auth.auth().removeStateDidChangeListener(handle!)
        }
    }
    
    func DeleteCurrentUser() {
            let user = Auth.auth().currentUser

            user?.delete { error in
                if error != nil {
                    print(error?.localizedDescription ?? "")
                } else {
                    print("Deleted!")
                }
            }
        }
        
        func SignOut(){
            let firebaseAuth = Auth.auth()
            do {
              try firebaseAuth.signOut()
               print("Signed out!")
                self.appUser.loggedIn = true
            } catch let signOutError as NSError {
                self.appUser.loggedIn = false
                print("Error signing out!")
            }
        }
    
    
    //CRUD
    
    func createAppUser() -> Bool {
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
