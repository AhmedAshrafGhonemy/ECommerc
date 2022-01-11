//
//  SearchView.swift
//  ECommerce
//
//  Created by AhmedAshraf on 10/01/2022.
//

import SwiftUI

struct SearchView: View {
    
     var animation : Namespace.ID
    // Shared Data
    @EnvironmentObject var sharedData: SharedDataModel
    
    @EnvironmentObject var homeData : HomeViewModel
    // Activating text field with help of focusState
    @FocusState var startTF: Bool
    var body: some View {
        
        VStack(spacing : 0){
            
            // Search Bar
            HStack(spacing : 20){
                
                // Close Button
                Button {
                    withAnimation {
                        homeData.searchActivated = false
                    }
                    homeData.searchText = ""
                    // resetting
                    sharedData.fromSearchPage = false
                    
                } label: {
                    Image(systemName: "arrow.left")
                        .font(.title2)
                        .foregroundColor(.black.opacity(0.7))
                }
                // Search Bar
                HStack(spacing : 15){
                    Image(systemName: "magnifyingglass")
                        .font(.title2)
                        .foregroundColor(.gray)
                    
                    TextField("Search" , text: $homeData.searchText)
                        .focused($startTF)
                        .textCase(.lowercase)
                        .disableAutocorrection(true)
                }
                .padding(.vertical,12)
                .padding(.horizontal)
                .background(
                    Capsule()
                        .strokeBorder(Color("purpleColor"),lineWidth: 1.5)
                )
                .matchedGeometryEffect(id: "SEARCHBAR", in: animation)
                .padding(.trailing,20)

            }
            .padding([.horizontal])
            .padding(.top)
            .padding(.bottom,10)
            
        // showing progress if searching
        // else showing no results found if empty
            if let products = homeData.searchedProducts{
                
                if products.isEmpty {
                    // no results found
                    
                    VStack(spacing: 10){
                    Image("notFound")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(.top,60)
                    
                    Text("Item Not Found")
                        .font(.custom(customFont, size: 22).bold())
                    
                    Text("Try with another words")
                        .font(.custom(customFont, size: 16))
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal,30)
                    }
                    .padding()
                }
                else{
                    // filter results
                    ScrollView(.vertical,showsIndicators: false){
                        
                        VStack(spacing: 0){
                            // Found Result
                            Text("Found \(products.count) results")
                                .font(.custom(customFont, size: 24).bold())
                                .padding(.vertical)
                         // Staggered Grid
                        StaggeredGrid(columns: 2,spacing: 20, list: products) {product in
                            //Card view
                            ProductCardView(product: product)
                        }
                            
                        }
                        .padding()
                    }
                }
                
            }else{
                ProgressView()
                    .padding(.top,30)
                    .opacity(homeData.searchText == "" ? 0 : 1)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity,alignment: .top)
        .background(Color("HomeBG")
        )
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                startTF = true
            }
        }
    }
    
    @ViewBuilder
    func ProductCardView(product : Product) -> some View{
        VStack(spacing : 10){
            
            ZStack{
                if sharedData.showDetailProduct {
                    Image(product.productImage)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .opacity(0)
                }
                else{
                    Image(product.productImage)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .matchedGeometryEffect(id: "\(product)SEARCH", in: animation)
                }
            }
        
                
            // Moving image to top to look like its fixed at half top
                .offset(y : -50)
                .padding(.bottom,-50)
            
            Text(product.title)
                .font(.custom(customFont, size: 14))
                .fontWeight(.semibold)
                .padding(.top)
            
            Text(product.subtitle)
                .font(.custom(customFont, size: 14))
                .foregroundColor(.gray)
            
            Text(product.price)
                .font(.custom(customFont, size: 14))
                .fontWeight(.bold)
                .foregroundColor(Color("purpleColor"))
                .padding(.top,5)
        }
        .padding(.horizontal,20)
        .padding(.bottom,22)
        .background(
            Color(hue: 0.625, saturation: 0.008, brightness: 0.945)
                .cornerRadius(25)
        )
        .padding(.top,80)
        .onTapGesture {
            withAnimation(.easeInOut){
                sharedData.fromSearchPage = true
                sharedData.detailProduct = product
                sharedData.showDetailProduct = true
            }
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
            MainPage()
        
    }
}
