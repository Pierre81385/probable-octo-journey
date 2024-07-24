//
//  CategoryListView.swift
//  probable-octo-journey
//
//  Created by m1_air on 7/21/24.
//

import SwiftUI

struct CategoryListView: View {
    @Binding var category: [String]
    @Binding var selected: String
    
    var body: some View {
        NavigationStack{
            ScrollView(.horizontal){
                HStack{
                    ForEach(category, id: \.self) {
                        cat in
                        Button(action: {
                            self.selected = cat
                        }, label: {
                            Text(cat).foregroundStyle(selected == cat ? .white : .black).fontWeight(.light)
                        })
                        .padding()
                        .background(cat == selected ? .black : .white).clipShape(.rect(topLeadingRadius: 10, bottomLeadingRadius: 10, bottomTrailingRadius: 10, topTrailingRadius: 10))
                        .foregroundColor(.white)
                        .background(
                            RoundedRectangle(
                                cornerRadius: 10,
                                style: .continuous
                            )
                            .stroke(.gray, lineWidth: 2)
                            
                        )
                        .padding(EdgeInsets(top: 2, leading: 8, bottom: 2, trailing: 8))
                    }
                }
            }
        }
    }
}

//#Preview {
//    CategoryListView()
//}
