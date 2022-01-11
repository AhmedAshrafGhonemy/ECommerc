//
//  SharedDataModel.swift
//  ECommerce
//
//  Created by AhmedAshraf on 10/01/2022.
//

import SwiftUI

class SharedDataModel : ObservableObject {
    
    // Detail product Data...
    @Published var detailProduct : Product?
    @Published var showDetailProduct : Bool = false
    
    // matched Geometry Effect from search page
    @Published var fromSearchPage : Bool = false
    
    // Liked products
    @Published var likedProduct : [Product] = []
    
    // basket Products
    @Published var cartProduct : [Product] = []
    
    // Calculating Total price..
    func getTotalPrice() -> String {
        var total: Int = 0
        
        cartProduct.forEach { product in
            let price = product.price.replacingOccurrences(of: "$", with: "") as NSString
            
            let quantity = product.quantity
            let priceTotal = quantity * price.integerValue
            
            total += priceTotal
        }
        return"$\(total)"
    }

    



}
