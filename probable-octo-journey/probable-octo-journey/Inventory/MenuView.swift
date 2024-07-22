//
//  MenuView.swift
//  probable-octo-journey
//
//  Created by m1_air on 7/20/24.
//

import SwiftUI

struct MenuView: View {
    @State var categories: [String] = ["Sale", "New", "Women", "Men", "Kids", "Designer", "Shoes", "Accessories", "Home", "Beauty", "Gifts"]
    @State var selectedCategory: String = "none"
    @State var showCreate: Bool = false
    
    var body: some View {
        NavigationStack{
            ZStack{
                VStack{
                    ZStack{
                        Color(.black)
                        VStack{
                            Spacer()
                            ProductCarouselView()
                            Button(action: {
                                showCreate = true
                            }, label: {
                                Text("NORDSTROM").font(.largeTitle)
                                    .fontWeight(.ultraLight).foregroundStyle(.white)
                                }).sheet(isPresented: $showCreate, content: {
                                    CreateProductView(show: $showCreate)
                                }).padding()
                        }
                    }  .clipShape(.rect(topLeadingRadius: 150, bottomLeadingRadius: 0, bottomTrailingRadius: 150, topTrailingRadius: 0))
                        .shadow(color: .gray.opacity(0.6), radius: 15, x: 5, y: 5)
                    CategoryListView(category: $categories, selected: $selectedCategory)
                    ProductListView(filterCategory: $selectedCategory)
                }
            }.ignoresSafeArea()
        }
    }
}

#Preview {
    MenuView()
}
