//
//  ProductCarouselView.swift
//  probable-octo-journey
//
//  Created by m1_air on 7/18/24.
//

import SwiftUI

struct ProductCarouselView: View {
    @State private var currentIndex = 0
    @Binding var allProducts: [Product]
    private let timer = Timer.publish(every: 5, on: .main, in: .common).autoconnect()

    var body: some View {
        if(allProducts.isEmpty){
            Text("NO PRODUCTS").foregroundStyle(.white)
        } else {
            VStack{
                Text("Featured Sale Items").fontWeight(.ultraLight).foregroundStyle(.white).padding()
                CarouselView(products: allProducts, currentIndex: $currentIndex)
                    .frame(height: 300)
                    .onReceive(timer) { _ in
                        withAnimation {
                            currentIndex = (currentIndex + 1) % allProducts.count
                        }
                    }
                PageIndicator(numberOfPages: allProducts.count, currentIndex: $currentIndex)
            }.onAppear{
                
            }
        }
    }
}

//#Preview {
//    ProductCarouselView()
//}

struct CarouselView: View {
    let products: [Product]
    @Binding var currentIndex: Int

    var body: some View {
        GeometryReader { geometry in
            HStack(spacing: 0) {
                ForEach(products) { prod in
                        AsyncAwaitImageView(imageUrl: URL(string: prod.image)!).frame(width: geometry.size.width, height: geometry.size.height).onAppear{
                    }
                }
            }
            .frame(width: geometry.size.width * CGFloat(products.count), height: geometry.size.height, alignment: .leading)
            .offset(x: -CGFloat(currentIndex) * geometry.size.width)
            .animation(.easeInOut(duration: 1), value: currentIndex)
        }
    }
}

struct PageIndicator: View {
    let numberOfPages: Int
    @Binding var currentIndex: Int

    var body: some View {
        HStack(spacing: 8) {
            ForEach(0..<numberOfPages, id: \.self) { index in
                Circle()
                    .fill(index == (currentIndex % numberOfPages) ? Color.white : Color.gray)
                    .frame(width: 8, height: 8)
            }
        }
        .padding(.top, 16)
    }
}
