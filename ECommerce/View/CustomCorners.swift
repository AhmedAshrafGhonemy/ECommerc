//
//  CustomCorners.swift
//  ECommerce
//
//  Created by AhmedAshraf on 08/01/2022.
//

import SwiftUI

struct CustomCorners: Shape {
    
    var corners : UIRectCorner
    var radios : CGFloat
    
    func path(in rect : CGRect) -> Path{
        
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners,
                                cornerRadii: CGSize(width: radios, height: radios))
        return Path(path.cgPath)
    }
}

