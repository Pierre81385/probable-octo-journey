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
    var category: String = "none"
    var image: String = ""
    var name: String = ""
    var description: String = ""
    var size: [String] = ["xs", "s", "m", "l", "xl", "xxl",]
    var sale: Bool = false
    var price: Double = 0.0
}

