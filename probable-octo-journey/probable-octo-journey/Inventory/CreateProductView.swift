//
//  CreateProductView.swift
//  probable-octo-journey
//
//  Created by m1_air on 7/15/24.
//

import SwiftUI

struct CreateProductView: View {
    @State var productVM: ProductViewModel = ProductViewModel()
    @State var imageVM: StoredImageViewModel = StoredImageViewModel()
    @State var imageUploaded: Bool = false
    @State var dismiss: Bool = false
    
    var body: some View {
        ZStack{
            Color(.pink.opacity(0.1))
            GroupBox("") {
                VStack{
                    HStack{
                        Spacer()
                        TextField("", value: $productVM.product.price, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                            .keyboardType(.decimalPad)
                            .fontWeight(.ultraLight)
                            .frame(width: 70, height: 50)
                            .multilineTextAlignment(.trailing)
                    }
                    HStack{
                        Spacer()
                        CategoryMenu(category: $productVM.product.category).tint(.black)
                            .fontWeight(.bold)
                    }
                    if(imageUploaded){
                        AsyncAwaitImageView(imageUrl: URL(string: imageVM.imageStore.url)!)
                    } else {
                        ImagePickerView(uploader: $imageVM).frame(width: 350, height: 350).onChange(of: imageVM.imageStore.url) {
                            productVM.product.image = imageVM.imageStore.url
                            imageUploaded = true
                        }
                    }
                    TextField("Product name", text: $productVM.product.name).fontWeight(.bold)
                    TextField("Description", text: $productVM.product.description).fontWeight(.ultraLight)
                    Button(action: {
                        dismiss = productVM.createProduct()
                    }, label: {
                        Text("Save").tint(.black)
                    })
                }.padding()
            }.groupBoxStyle(CardGroupBoxStyleTop())
        }.ignoresSafeArea()
            
    }
}

struct CardGroupBoxStyleTop: GroupBoxStyle {
    func makeBody(configuration: Configuration) -> some View {
        VStack(alignment: .leading) {
            configuration.label
            configuration.content
        }
        .padding()
        .background(Color.white)
        .clipShape(.rect(topLeadingRadius: 175, bottomLeadingRadius: 0, bottomTrailingRadius: 175, topTrailingRadius: 0))
        .shadow(color: .gray.opacity(0.6), radius: 15, x: 5, y: 5)
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
