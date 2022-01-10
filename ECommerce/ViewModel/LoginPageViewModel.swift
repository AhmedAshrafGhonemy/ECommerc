//
//  LoginPageViewModel.swift
//  ECommerce
//
//  Created by AhmedAshraf on 08/01/2022.
//

import Foundation
import SwiftUI

class LoginPageViewModel : ObservableObject {
    
    // login properties
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var showPassword: Bool = false
    
    // register properties
    @Published var registerUser: Bool = false
    @Published var re_Enter_Password: String = ""
    @Published var showReEnterPassword: Bool = false
    
    //Log Status
    @AppStorage("log_Status") var log_Status : Bool = false

    // login call ...
    func login(){
        withAnimation {
            log_Status = true
        }
    }
    
    // register call ...
    func register(){
        withAnimation {
            log_Status = true
        }
    }
    
    func forgetPassword(){
        
    }
    
    
}
