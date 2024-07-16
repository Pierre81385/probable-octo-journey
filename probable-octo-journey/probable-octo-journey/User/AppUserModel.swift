//
//  AppUserModel.swift
//  probable-octo-journey
//
//  Created by m1_air on 7/15/24.
//

import Foundation

enum UserPosition: Codable {
    case support, server, bartender, cook, chef, assistantManager, manager, training
}

struct AppUser: Codable, Identifiable {
    var id: String = ""
    var name: String = ""
    var email: String = ""
    var position: UserPosition = UserPosition.training
    var avatar: String = ""
    var loggedIn: Bool = false
}
