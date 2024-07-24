//
//  ProductView.swift
//  probable-octo-journey
//
//  Created by m1_air on 7/15/24.
//

import Foundation
import SwiftUI

struct ProductView: View {
    var prod: Product?
    
    var body: some View {
        ZStack{
            VStack{
                GeometryReader { geometry in
                    HStack(spacing: 0) {
                        AsyncAwaitImageView(imageUrl: URL(string: prod!.image)!).frame(width: geometry.size.width, height: geometry.size.height)
                    }
                    .frame(width: geometry.size.width, height: geometry.size.height, alignment: .leading)
                }
            }
        }.onAppear{
            
        }
    }
}

//#Preview {
//    ProductView()
//}

