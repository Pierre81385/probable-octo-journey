//
//  MenuView.swift
//  probable-octo-journey
//
//  Created by m1_air on 7/20/24.
//

import SwiftUI

struct MenuView: View {
    @State var productVM: ProductViewModel = ProductViewModel()
    @State var categories: [String] = ["New", "Women", "Men", "Kids", "Designer", "Shoes", "Accessories", "Home", "Beauty", "Gifts"]
    @State var selectedCategory: String = "none"
    @State var showCreate: Bool = false
    @State var gotProducts: Bool = false
    @State var gotFeatured: Bool = false
    
    var body: some View {
        NavigationStack{
            ZStack{
                VStack{
                    ZStack{
                        Color(.black)
                        VStack{
                            Spacer()
                            ProductCarouselView(allProducts: $productVM.featured)
                            Button(action: {
                                showCreate = true
                            }, label: {
                                Text("NORDSTROM").font(.largeTitle)
                                    .fontWeight(.ultraLight).foregroundStyle(.white)
                            }).navigationDestination(isPresented: $showCreate, destination: {
                                CreateProductView(show: $showCreate).navigationBarBackButtonHidden(true)
                            })
                            .padding()
//                            .sheet(isPresented: $showCreate, content: {
//                                    CreateProductView(show: $showCreate)
//                                }).padding()
                        }
                    }  .clipShape(.rect(topLeadingRadius: 150, bottomLeadingRadius: 0, bottomTrailingRadius: 150, topTrailingRadius: 0))
                        .shadow(color: .gray.opacity(0.6), radius: 15, x: 5, y: 5)
                    CategoryListView(category: $categories, selected: $selectedCategory)
                    ProductListView(allProducts: $productVM.products, filterCategory: $selectedCategory)
                }
            }.ignoresSafeArea(.all, edges: .bottom)
                .onAppear{
                    if(productVM.products.isEmpty){
                        Task{
                            gotProducts = await productVM.getProducts()
                            if(productVM.products.isEmpty){
                                gotProducts = false
                            }
                        }
                    }
                    if(productVM.featured.isEmpty){
                        Task{
                            gotFeatured = await productVM.getFeaturedProducts()
                            if(productVM.featured.isEmpty){
                                gotFeatured = false
                            }
                        }
                    }
                }
        }
    }
}

#Preview {
    MenuView()
}
