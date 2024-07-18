//
//  ImageViewModel.swift
//  probable-octo-journey
//
//  Created by m1_air on 7/16/24.
//

import Foundation
import PhotosUI

struct ImageStore: Codable, Equatable, Identifiable {
    var id = UUID().uuidString
    var data: Data
    var url: String
}
