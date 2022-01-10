//
//  HomeViewModel.swift
//  ECommerce
//
//  Created by AhmedAshraf on 09/01/2022.
//

import SwiftUI
import Combine

class HomeViewModel: ObservableObject {
   
    @Published var productType : ProductType = .Wearable
    
    // Sample Products...
    @Published var products : [Product] = [
    Product(type: .Wearable, title: "Apple Watch", subtitle: "Series 6: White", price: "$360", productImage: "series6")
    ,
    Product(type: .Wearable, title: "Samsung Watch", subtitle: "Gear : Black", price: "$200", productImage: "gear")
    ,
    Product(type: .Wearable, title: "Apple Watch", subtitle: "Series 4: Black", price: "$250", productImage: "series4")
    ,
    Product(type: .Phones, title: "iPhone 13", subtitle: "A15 - White", price: "$699", productImage: "iphone13")
    ,
    Product(type: .Phones, title: "iPhone 12", subtitle: "A14 - Red", price: "$599", productImage: "iphone12")
    ,
    Product(type: .Phones, title: "iPhone 11", subtitle: "A13 - Black", price: "$499", productImage: "iphone11")
    ,
    Product(type: .Phones, title: "iPhone SE", subtitle: "A12 - White", price: "$399", productImage: "iphoneSE")
    ,
    Product(type: .Laptops, title: "MacBook air", subtitle: "M1 - Gold", price: "$999", productImage: "MacAir")
    ,
    Product(type: .Laptops, title: "MacBook Pro", subtitle: "M1 - Space Grey", price: "$1299", productImage: "macPro")
    ,
    Product(type: .Tablets, title: "IPad Pro", subtitle: "M1 - SIlver", price: "$999", productImage: "ipadPro")
    ,
    Product(type: .Tablets, title: "iPad Air 4", subtitle: "A14 - Black", price: "$699", productImage: "ipadAir")

  ]
    
    // Filtered Products
    @Published var filteredProducts : [Product] = []
    
    // more products on the type
    @Published var showMoreProductsOnType : Bool = false
    
    // Search Data
    @Published var searchText : String = ""
    @Published var searchActivated : Bool = false
    @Published var searchedProducts : [Product]?
    
    var searchCancellable : AnyCancellable?
    

    init(){
        filterProductByType()
        
        searchCancellable = $searchText.removeDuplicates()
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .sink(receiveValue: { str in
                if str != "" {
                    self.filterProductBySearch()
                }
                else{
                    self.searchedProducts = nil
                }
            })
    }
    
    func filterProductByType() {
        
        DispatchQueue.global(qos: .userInteractive).async {
            let results = self.products
            // use lazy because it requires more memory
                .lazy
                .filter { Product in
                    return Product.type == self.productType
                }
            // Limiting result
                .prefix(4)
            
            DispatchQueue.main.async {
                self.filteredProducts = results.compactMap({ Product in
                    return Product
                })
            }
            
        }
    }
    
    
    func filterProductBySearch() {
        
        DispatchQueue.global(qos: .userInteractive).async {
            let results = self.products
            // use lazy because it requires more memory
                .lazy
                .filter { product in
                    
                    return product.title.lowercased().contains(self.searchText.lowercased())
                }
            
            DispatchQueue.main.async {
                self.searchedProducts = results.compactMap({ product in
                    return product
                })
            }
            
        }
    }
}
