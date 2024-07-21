//
//  ProductCarouselView.swift
//  probable-octo-journey
//
//  Created by m1_air on 7/18/24.
//

import SwiftUI

struct ProductCarouselView: View {
    @State var productVM: ProductViewModel = ProductViewModel()
    @State private var currentIndex = 0
    @State private var gotProducts: Bool = false
    private let timer = Timer.publish(every: 5, on: .main, in: .common).autoconnect()

    var body: some View {
        VStack{
            if(gotProducts) {
                Text("Featured Specials").fontWeight(.ultraLight).padding()
                CarouselView(products: productVM.products, currentIndex: $currentIndex)
                    .frame(height: 300)
                                    .onReceive(timer) { _ in
                                        withAnimation {
                                            currentIndex = (currentIndex + 1) % productVM.products.count
                                        }
                                    }
                PageIndicator(numberOfPages: productVM.products.count, currentIndex: $currentIndex)
            } else {
                ProgressView()
            }
        }.onAppear{
            Task{
                gotProducts = await productVM.getProducts()
            }
        }
    }
}

#Preview {
    ProductCarouselView()
}

struct CarouselView: View {
    let products: [Product]
    @Binding var currentIndex: Int

    var body: some View {
        GeometryReader { geometry in
            HStack(spacing: 0) {
                ForEach(products) { prod in
                    AsyncAwaitImageView(imageUrl: URL(string: prod.image)!).frame(width: geometry.size.width, height: geometry.size.height)
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
                    .fill(index == (currentIndex % numberOfPages) ? Color.black : Color.gray)
                    .frame(width: 8, height: 8)
            }
        }
        .padding(.top, 16)
    }
}
