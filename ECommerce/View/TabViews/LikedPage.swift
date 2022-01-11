//
//  LikedPage.swift
//  ECommerce
//
//  Created by AhmedAshraf on 11/01/2022.
//

import SwiftUI

struct LikedPage: View {
    
    @EnvironmentObject var sharedData : SharedDataModel

    // Delete Option
    @State var showDeleteeOption: Bool = false

    var body: some View {
        NavigationView{
            ScrollView(.vertical, showsIndicators: false) {
                VStack{
                    HStack{
                        Text("Favorites")
                            .font(.custom(customFont, size: 28).bold())
                        
                        Spacer()
                        
                        Button {
                            withAnimation {
                                showDeleteeOption.toggle()
                            }
                        } label: {
                            Image("Delete")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 25, height: 25)
                        }
                        .opacity(sharedData.likedProduct.isEmpty ? 0 : 1)

                    }
                    // cahecking if liked products are empty
                    if sharedData.likedProduct.isEmpty {
                        Group{
                            Image("notLiked")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .padding()
                                .padding(.top,35)
                            
                            Text("No favorites yet")
                                .font(.custom(customFont, size: 25))
                                .fontWeight(.semibold)
                            Text("Click like button on a product to save favorites")
                                .font(.custom(customFont, size: 18))
                                .foregroundColor(.gray)
                                .padding(.top,10)
                                .padding(.horizontal)
                                .multilineTextAlignment(.center)
                        }
                    }
                    else{
                        VStack(spacing: 15){
                            ForEach(sharedData.likedProduct){product in
                                HStack(spacing: 0){
                                    if showDeleteeOption {
                                        Button {
                                            deleteProduct(product: product)
                                        } label: {
                                            Image(systemName: "minus.circle.fill")
                                                .font(.title2)
                                                .foregroundColor(.red)
                                        }
                                        .padding(.trailing)

                                    }
                                    CardView(product: product)
                                }
                                
                            }
                        }
                        .padding(.top,25)
                        .padding(.horizontal)
                    }
                    
                }
                .padding()
                
            }
            .navigationBarHidden(true)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color("HomeeBG").ignoresSafeArea())
        }
    }
    
    @ViewBuilder
    func CardView(product: Product) -> some View {
        HStack(spacing: 15){
            Image(product.productImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100)
            
            VStack(alignment: .leading, spacing: 8) {
                Text(product.title)
                    .font(.custom(customFont, size: 18).bold())
                    .lineLimit(1)
                
                Text(product.subtitle)
                    .font(.custom(customFont, size: 17))
                    .fontWeight(.semibold)
                    .foregroundColor(Color("purpleColor"))
                
                Text("Type: \(product.type.rawValue)")
                    .font(.custom(customFont, size: 13))
                    .foregroundColor(.gray)
            }
        }
        .padding(.horizontal,10)
        .padding(.vertical,10)
        .frame(maxWidth: .infinity , alignment: .leading)
        .background(
            Color.white
                .cornerRadius(10)
        )
    }
    
    func deleteProduct(product: Product)  {
        if let index = sharedData.likedProduct.firstIndex(where: { currentProduct in
            return product.id == currentProduct.id
        }){
            let _ = withAnimation {
                // removing
                sharedData.likedProduct.remove(at: index)
            }
        }
    }
}

struct LikedPage_Previews: PreviewProvider {
    static var previews: some View {
        LikedPage()
            .environmentObject(SharedDataModel())
    }
}
