//
//  ProductListView.swift
//  probable-octo-journey
//
//  Created by m1_air on 7/18/24.
//

import SwiftUI

struct ProductListView: View {
    @State var productVM: ProductViewModel = ProductViewModel()
    @State private var gotProducts: Bool = false
    @Binding var filterCategory: String
    
    var body: some View {
        NavigationStack{
            ScrollView{
                
                ForEach(productVM.products) {
                    prod in
                    ZStack{
                        RoundedRectangle(cornerSize: CGSize(width: 2, height: 2)).NeumorphicStyleBlk()
                        NavigationLink(destination: {}, label: {
                            VStack{
                                HStack{
                                    Text(prod.name).fontWeight(.bold).foregroundStyle(.white).padding(EdgeInsets(top: 10, leading: 10, bottom: 2, trailing: 10))
                                    Spacer()
                                }
                                HStack{
                                    Text(prod.description).fontWeight(.ultraLight).lineLimit(1).foregroundStyle(.white).padding(EdgeInsets(top: 0, leading: 10, bottom: 5, trailing: 10))
                                    Spacer()
                                }
                            }
                        })
                    }.padding(EdgeInsets(top: 2, leading: 10, bottom: 2, trailing: 10))
                }
                
                }.onAppear{
                    if(productVM.products.isEmpty) {
                        Task{
                            gotProducts = await productVM.getProducts()
                        }
                    }
                }
            }
        }
    }


//#Preview {
//    ProductListView()
//}
