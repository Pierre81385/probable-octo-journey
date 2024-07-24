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
    @Binding var show: Bool

    
    var body: some View {
        VStack{
            ZStack{
                Color(.white)
                GroupBox("") {
                    VStack{
                        HStack{
                            Spacer()
                            TextField("", value: $productVM.product.price, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                                .keyboardType(.decimalPad)
                                .fontWeight(.ultraLight)
                                .frame(width: 70, height: 50)
                                .multilineTextAlignment(.trailing)
                                .foregroundStyle(.white)
                        }
                        HStack{
                            Spacer()
                            CategoryMenu(category: $productVM.product.category).tint(.white)
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
                        Toggle(isOn: $productVM.product.sale, label: {
                            Text("Sale Item").foregroundStyle(.white)
                        }).tint(.red)
                        TextField("Product name", text: $productVM.product.name).fontWeight(.bold).foregroundStyle(.white)
                        TextField("Description", text: $productVM.product.description).fontWeight(.ultraLight).foregroundStyle(.white)
                        HStack{
                            Button(action: {
                                show = false
                            }, label: {
                                Image(systemName: "chevron.left").foregroundStyle(.white)
                            }).padding()
                            Button(action: {
                                dismiss = productVM.createProduct()
                            }, label: {
                                Text("Save").foregroundStyle(.white)
                            }).navigationDestination(isPresented: $dismiss, destination: {
                                MenuView().navigationBarBackButtonHidden(true)
                            })
                        }
                    }.padding()
                }.groupBoxStyle(CardGroupBoxStyleTop())
            }.ignoresSafeArea()
        }.onAppear{
            productVM.product = Product()
            imageUploaded = false
        }
    }
}

struct CardGroupBoxStyleTop: GroupBoxStyle {
    func makeBody(configuration: Configuration) -> some View {
        VStack(alignment: .leading) {
            configuration.label
            configuration.content
        }
        .padding()
        .background(Color.black)
        .clipShape(.rect(topLeadingRadius: 175, bottomLeadingRadius: 0, bottomTrailingRadius: 175, topTrailingRadius: 0))
        .shadow(color: .gray.opacity(0.6), radius: 15, x: 5, y: 5)
    }
}

//misc, app, main, side, dessert, beer, wine, spirit, cocktail, na
struct CategoryMenu: View {
    let categories: [String] = ["Sale", "New", "Women", "Men", "Kids", "Designer", "Shoes", "Accessories", "Home", "Beauty", "Gifts"]
    @Binding var category: String
    var body: some View {
        Menu {
            ForEach(categories, id: \.self) {
                cat in
                Button {
                    self.category = cat
                } label: {
                    Label(cat, systemImage: "rectangle.stack.badge.plus")
                }
            }
                   
                } label: {
                    if(category == "none") {
                        Label("Category", systemImage: "plus")
                    } else {
                        Text(category)
                    }
                }
    }
}

//#Preview {
//    CreateProductView()
//}
