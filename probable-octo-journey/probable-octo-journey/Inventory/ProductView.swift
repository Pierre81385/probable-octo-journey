//
//  ProductView.swift
//  probable-octo-journey
//
//  Created by m1_air on 7/15/24.
//

import Foundation
import SwiftUI

struct ProductView: View {
    @State var productVM: ProductViewModel = ProductViewModel()
    let rows = [
        GridItem(.flexible()),
       ]
    
    var body: some View {
        ZStack{
            Color(.pink.opacity(0.1))
                if(productVM.products.isEmpty) {
                    Text("loading.")
                } else {
                    VStack{
                        Spacer()
                        Text("All Products")
                        ScrollView(.horizontal) {
                            HStack{
                                ForEach(productVM.products) {
                                    prod in
                                    
                                    AsyncAwaitMenuImageView(imageUrl: URL(string: prod.image)!)
                                    
                                }
                            }
                        }
                        Spacer()
                    }.padding()
                }
        }.ignoresSafeArea()
            .onAppear{
                Task{
                    await productVM.getProducts()
                }
            }
    }
}

#Preview {
    ProductView()
}

