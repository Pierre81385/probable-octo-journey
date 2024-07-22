//
//  ProductModel.swift
//  probable-octo-journey
//
//  Created by m1_air on 7/15/24.
//

import Foundation
import FirebaseFirestore

struct Product: Codable, Identifiable {
    @DocumentID var id: String?
    var name: String = ""
    var description: String = ""
    var price: Double = 0.0
    var quantity: Int = 0
    var inventory: Int = 0
    var sold: Int = 0
    var image: String = ""
    var notes: String = ""
    var category: String = "none"
}

