//
//  AsyncImage.swift
//  probable-octo-journey
//
//  Created by m1_air on 7/16/24.
//

import Foundation
import SwiftUI

class ImageLoader: ObservableObject {
    @Published var image: UIImage?

    func loadImage(from url: URL) async {
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            image = UIImage(data: data)
        } catch {
            print("Error loading image: \(error.localizedDescription)")
        }
    }
}

struct AsyncAwaitImageView: View {
    @StateObject private var imageLoader = ImageLoader()
    let imageUrl: URL

    var body: some View {
        Group {
            if let image = imageLoader.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 325, height: 325)
                    .clipShape(RoundedRectangle(cornerSize: CGSize(width: 10, height: 10)))
                    .shadow(color: .gray.opacity(0.6), radius: 15, x: 5, y: 5)
            } else {
                ProgressView()
            }
        }
        .onAppear {
            Task {
                await imageLoader.loadImage(from: imageUrl)
            }
        }
    }
}

struct AsyncAwaitMenuImageView: View {
    @StateObject private var imageLoader = ImageLoader()
    let imageUrl: URL

    var body: some View {
        Group {
            if let image = imageLoader.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 100)
                    //.clipShape(RoundedRectangle(cornerSize: CGSize(width: 10, height: 10)))
                    //.shadow(color: .gray.opacity(0.6), radius: 5, x: 2, y: 2)
            } else {
                ProgressView()
            }
        }
        .onAppear {
            Task {
                await imageLoader.loadImage(from: imageUrl)
            }
        }
    }
}
