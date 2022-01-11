//
//  Home.swift
//  ECommerce
//
//  Created by AhmedAshraf on 09/01/2022.
//

import SwiftUI

struct Home: View {
    var animation: Namespace.ID
    // Shared Data
    @EnvironmentObject var sharedData: SharedDataModel
    @StateObject var homeData: HomeViewModel = HomeViewModel()
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing : 15){
                // Search Bar
                ZStack{
                    if homeData.searchActivated {
                        searchBar()
                    }else{
                        searchBar()
                            .matchedGeometryEffect(id: "SEARCHBAR", in: animation)
                    }
                }
                .frame(width : getRect().width / 1.6)
                .padding(.horizontal , 25)
                .contentShape(Rectangle())
                .onTapGesture {
                    withAnimation(.easeInOut) {
                        homeData.searchActivated = true
                    }
                }
                
                
                Text("Order online\ncollect in store")
                    .font(.custom(customFont, size: 28).bold())
                    .frame(maxWidth : .infinity , alignment: .leading)
                    .padding(.top)
                    .padding(.horizontal,25)
                
                // products tab...
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing : 18){
                        ForEach(ProductType.allCases,id: \.self){type in
                            // Product Type View
                            productTypeView(type: type)
                        }
                    }
                    .padding(.horizontal,25)
                }
                .padding(.top,28)
                
                // Product Page
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing : 25){
                        ForEach(homeData.filteredProducts){product in
                            
                            // Product Card View
                            ProductCardView(product: product)
                        }
                    }
                    .padding(.horizontal,25)
                }
                .padding(.top,30)
                
                // see more products buttons
                Button {
                    homeData.showMoreProductsOnType.toggle()
                } label: {
                    Label{
                        Image(systemName: "arrow.right")
                    } icon: {
                        Text("see more")
                    }
                    .font(.custom(customFont, size: 15).bold())
                    .foregroundColor(Color("purpleColor"))
                }
                .frame(maxWidth : .infinity ,alignment: .trailing)
                .padding(.trailing)
                .padding(.top,10)

            }
            .padding(.vertical)
        }
        .frame(maxWidth : .infinity ,maxHeight: .infinity)
        .background(Color("HomeBG"))
        // Update data whenever tab changes
        .onChange(of: homeData.productType) { newValue in
            homeData.filterProductByType()
        }
        // more products sheet
        .sheet(isPresented: $homeData.showMoreProductsOnType) {
            
        } content: {
            MoreProductsView()
        }
        // Displaying Search View
        .overlay(
            ZStack{
                if homeData.searchActivated {
                    SearchView(animation: animation)
                        .environmentObject(homeData)
                }
            }
        )

        
    }
    
    @ViewBuilder
    func searchBar() -> some View {
        HStack(spacing : 15){
            Image(systemName: "magnifyingglass")
                .font(.title2)
                .foregroundColor(.gray)
            
            TextField("Search" , text: .constant(""))
                .disabled(true)
        }
        .padding(.vertical,12)
        .padding(.horizontal)
        .background(
            Capsule()
                .strokeBorder(.gray,lineWidth: 0.8))
    }
    
    @ViewBuilder
    func ProductCardView(product : Product) -> some View{
        VStack(spacing : 10){
            
            // adding matched geometry effect
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
                        .matchedGeometryEffect(id: "\(product.id)IMAGE", in: animation)
                }
            }
            .frame(width: getRect().width / 2.5, height: getRect().width / 2.5)
            // Moving image to top to look like its fixed at half top
            .offset(y : -60)
            .padding(.bottom,-80)
                
            
            Text(product.title)
                .font(.custom(customFont, size: 14))
                .fontWeight(.semibold)
                .padding(.top)
            
            Text(product.subtitle)
                .font(.custom(customFont, size: 14))
                .foregroundColor(.gray)
            
            Text(product.price)
                .font(.custom(customFont, size: 16))
                .fontWeight(.bold)
                .foregroundColor(Color("purpleColor"))
                .padding(.top,5)
        }
        .padding(.horizontal,10)
        .padding(.bottom,22)
        .background(
            Color.white
                .cornerRadius(25)
        )
        .padding(.top,80)
        // Showing Product detail when tapped
        .onTapGesture {
            withAnimation {
                sharedData.detailProduct = product
                sharedData.showDetailProduct = true
            }
        }
        
    }
    
    @ViewBuilder
    func productTypeView(type : ProductType) -> some View {
        Button {
            withAnimation {
                homeData.productType = type
            }
        } label: {
            Text(type.rawValue)
                .font(.custom(customFont, size: 15))
                .fontWeight(.semibold)
            // changing color based on current product Type
                .foregroundColor(homeData.productType == type ? Color("purpleColor") : .gray)
                .padding(.bottom,10)
            // Adding Indicator at bottom
                .overlay(
                    // Adding Matched Geometry Effect ...
                    ZStack{
                        if homeData.productType == type {
                            Capsule()
                                .fill(Color("purpleColor"))
                                .matchedGeometryEffect(id: "PRODUCTTAB", in: animation)
                                .frame(height : 2)
                        }else{
                            Capsule()
                                .fill(.clear)
                                .frame(height : 2)
                        }
                    }
                        .padding(.horizontal,-5)
                    , alignment: .bottom
                )
        }

    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        MainPage()
    }
}

