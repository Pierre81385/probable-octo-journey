//
//  OrderModel.swift
//  probable-octo-journey
//
//  Created by m1_air on 7/15/24.
//

import Foundation
import FirebaseFirestore

enum OrderType: Codable {
    case onSite, toGo
}

enum OrderStatus: Codable {
    case notStarted, ordering, fired, inProgress, inTransit, complete
}

struct Order: Codable, Identifiable {
    @DocumentID var id: String?
    var type: OrderType = OrderType.onSite
    var name: String = ""
    var address: String = ""
    var phone: String = ""
    var order: [Product] = []
    var status: OrderStatus = OrderStatus.notStarted
}
