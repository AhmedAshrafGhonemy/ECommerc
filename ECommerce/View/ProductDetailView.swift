//
//  ProductDetailView.swift
//  ECommerce
//
//  Created by AhmedAshraf on 10/01/2022.
//

import SwiftUI

struct ProductDetailView: View {
    
    var product : Product
    
    // For Matched Geometry Effect
    var animation: Namespace.ID
    
    @EnvironmentObject var sharedData : SharedDataModel
    @EnvironmentObject var homeData : HomeViewModel

    
    var body: some View {
        VStack{
            // Title Bar and Product Image
            VStack{
                
                // Title Bar
                HStack{
                    Button {
                        // closing view
                        withAnimation {
                            sharedData.showDetailProduct = false
                        }
                    } label: {
                        Image(systemName: "arrow.left")
                            .font(.title2)
                            .foregroundColor(.black.opacity(0.7))
                    }
                    
                    Spacer()
                    
                    Button {
                        addToLiked()
                    } label: {
                        Image("liked")
                            .renderingMode(.template)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 22 , height: 22)
                            .foregroundColor(isLiked() ? .red : .black.opacity(0.7))

                    }


                }
                .padding()
                
                // product Image
                // Adding matched geometry effect
                Image(product.productImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .matchedGeometryEffect(id: "\(product.id)\(sharedData.fromSearchPage ? "SEARCH" : "IMAGE")", in: animation)
                    .padding(.horizontal)
                    .offset(y: -12)
                    .frame(maxHeight : .infinity)
                
            }
            .frame(width: getRect().height / 2.7)
            .zIndex(1)
            
            // product Details
            ScrollView(.vertical, showsIndicators: false) {
                // product data
                VStack(alignment: .leading, spacing: 15){
                    
                    Text(product.title)
                        .font(.custom(customFont, size: 20).bold())
                        
                    Text(product.subtitle)
                        .font(.custom(customFont, size: 18))
                        .foregroundColor(.gray)
                        
                    Text("Get Apple TV+ free for a year")
                        .font(.custom(customFont, size: 16).bold())
                        .padding(.top)
                        
                    Text("Available when you purchase any new Apple products")
                        .font(.custom(customFont, size: 15))
                        .foregroundColor(.gray)
                    
                    Button {
                        
                    } label: {
                        Label{
                            Image(systemName: "arrow.right")
                        } icon: {
                            Text("Full description")
                        }
                        .font(.custom(customFont, size: 15).bold())
                        .background(Color("purpleColor"))
                        
                    }
                    
                    HStack{
                        Text("Total")
                            .font(.custom(customFont, size: 17))
                        
                        Spacer()
                        
                        Text("\(product.price)")
                            .font(.custom(customFont, size: 20).bold())
                            .foregroundColor(Color("purpleColor"))
                    }
                    .padding(.vertical,20)
                    
                    // add to cart
                    Button {
                        addToCart()
                    } label: {
                        Text("\(isAddedToCart() ? "added" : "add") to basket")
                            .font(.custom(customFont, size: 20).bold())
                            .foregroundColor(.white)
                            .padding(.vertical,20)
                            .frame(maxWidth: .infinity)
                            .background(
                                Color("purpleColor")
                                    .cornerRadius(15)
                                    .shadow(color: .black.opacity(0.06), radius: 5, x: 5, y: 5)
                            )
                    }


                }
                .padding([.horizontal,.bottom],20)
                .padding(.top,25)
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .frame(maxWidth : .infinity, maxHeight : .infinity)
            .background(
                Color.white
                    .clipShape(CustomCorners(corners: [.topLeft,.topRight], radios: 25))
                    .ignoresSafeArea()
            )
            .zIndex(0)
        }
        .animation(.easeInOut, value: sharedData.likedProduct)
        .animation(.easeInOut, value: sharedData.cartProduct)
        .background(Color("HomeBG").ignoresSafeArea())
    }
    
    func isLiked() -> Bool {
        return sharedData.likedProduct.contains { product in
            return self.product.id == product.id
        }
    }
    func isAddedToCart() -> Bool {
        return sharedData.cartProduct.contains { product in
            return self.product.id == product.id
        }
    }
    
    func addToLiked() {
        if let index = sharedData.likedProduct.firstIndex(where: { Product in
            return self.product.id == Product.id
        }){
            // remove from liked
            sharedData.likedProduct.remove(at: index)
    }
        else{
            // add to liked
            sharedData.likedProduct.append(product)
        }
    }
    func addToCart(){
        if let index = sharedData.cartProduct.firstIndex(where: { Product in
            return self.product.id == Product.id
        }){
            // remove from liked
            sharedData.cartProduct.remove(at: index)
    }
        else{
            // add to liked
            sharedData.cartProduct.append(product)
        }
    }

}

struct ProductDetailView_Previews: PreviewProvider {
    static var previews: some View {
//        ProductDetailView(product: HomeViewModel().products[0])
//            .environmentObject(SharedDataModel())
        MainPage()
    }
}
