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
                HStack{
                    Spacer()
                    Button(action: {}, label: {
                        Image(systemName: "minus.circle").tint(.black)
                    }).padding()
                    Spacer()
                    Button(action: {}, label: {
                        Image(systemName: "plus.circle").tint(.black)
                    }).padding()
                    Spacer()
                }.padding(/*@START_MENU_TOKEN@*/EdgeInsets()/*@END_MENU_TOKEN@*/)
                GroupBox(label: Text(""), content: {
                    VStack{
                        HStack{
                            VStack{
                                Text("subtotal").fontWeight(.light)
                                Text("with tax").fontWeight(.light)
                                Text("GRAND TOTAL").fontWeight(.bold)
                            }
                            Spacer()
                            VStack{
                                Text("$0.00").fontWeight(.light)
                                Text("$0.00").fontWeight(.light)
                                Text("$0.00").fontWeight(.bold)
                            }
                        }
                    }
                })
            }
        }.onAppear{
            
        }
    }
}

//#Preview {
//    ProductView()
//}

