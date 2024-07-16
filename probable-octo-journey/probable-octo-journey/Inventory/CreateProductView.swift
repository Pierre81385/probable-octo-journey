//
//  CreateProductView.swift
//  probable-octo-journey
//
//  Created by m1_air on 7/15/24.
//

import SwiftUI

struct CreateProductView: View {
    @State var productVM: ProductViewModel = ProductViewModel()
    
    var body: some View {
        VStack{
            HStack{
                CategoryMenu(category: $productVM.product.category).tint(.black)
                Spacer()
            }
            TextField("Product name", text: $productVM.product.name)
            TextField("Description", text: $productVM.product.description)
            HStack{
                Text("Price")
                TextField("$0.00", value: $productVM.product.price, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                    .keyboardType(.decimalPad)
            }
            HStack{
                Text("Inventory")
                TextField("Amount", value: $productVM.product.inventory, format: .number)
                    .keyboardType(.decimalPad)
            }
            Button(action: {
                productVM.createProduct()
            }, label: {
                Text("Save")
            })
        }.padding()
    }
}

//misc, app, main, side, dessert, beer, wine, spirit, cocktail, na
struct CategoryMenu: View {
    @Binding var category: ProductCategory
    var body: some View {
        Menu {
                    Button {
                        category = .misc
                    } label: {
                        Label("Misc.", systemImage: "rectangle.stack.badge.plus")
                    }
                    Button {
                        category = .app
                    } label: {
                        Label("Appetizer", systemImage: "folder.badge.plus")
                    }
                    Button {
                        category = .main
                    } label: {
                        Label("Main Dish", systemImage: "rectangle.stack.badge.person.crop")
                    }
                    Button {
                        category = .side
                    } label: {
                        Label("Side Dish", systemImage: "rectangle.stack.badge.plus")
                    }
                    Button {
                        category = .dessert
                    } label: {
                        Label("Dessert", systemImage: "folder.badge.plus")
                    }
                    Button {
                        category = .beer
                    } label: {
                        Label("Beer", systemImage: "rectangle.stack.badge.person.crop")
                    }
                    Button {
                        category = .wine
                    } label: {
                        Label("Wine", systemImage: "rectangle.stack.badge.person.crop")
                    }
                    Button {
                        category = .spirit
                    } label: {
                        Label("Spirit", systemImage: "rectangle.stack.badge.plus")
                    }
                    Button {
                        category = .cocktail
                    } label: {
                        Label("Cocktail", systemImage: "folder.badge.plus")
                    }
                    Button {
                        category = .na
                    } label: {
                        Label("Non-Alcoholic", systemImage: "rectangle.stack.badge.person.crop")
                    }
                } label: {
                    if(category == .none) {
                        Label("Category", systemImage: "plus")
                    } else {
                        Text(category.rawValue)
                    }
                }
    }
}

#Preview {
    CreateProductView()
}
