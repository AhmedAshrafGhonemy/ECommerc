//
//  LoginPage.swift
//  ECommerce
//
//  Created by AhmedAshraf on 08/01/2022.
//

import SwiftUI

struct LoginPage: View {
    
    @StateObject var loginData : LoginPageViewModel = LoginPageViewModel()
    var body: some View {
        VStack{
            
        Text("Welcom\nback")
                .font(.custom(customFont, size: 55).bold())
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, alignment: .leading)
                .frame(height: getRect().height / 3.5)
                .padding()
        
        
        ScrollView(.vertical , showsIndicators: false){
           // login form
            VStack(spacing: 15){
                Text(loginData.registerUser ? "Regiser" : "Login")
                    .font(.custom(customFont, size: 22))
                    .frame(maxWidth : .infinity , alignment: .leading)
                
                // custom texField
                
                customTextField(icon: "envelope", title: "Email", hint: "ahmed@gmail.com", value: $loginData.email, showPassword: .constant(false))
                    .padding(.top,30)
                
                customTextField(icon: "locl", title: "Password", hint: "123456", value: $loginData.password, showPassword: $loginData.showPassword)
                    .padding(.top,10)
                
                // Register reenter password
                if loginData.registerUser{
                    customTextField(icon: "locl", title: "Re-Enter Password", hint: "123456", value: $loginData.re_Enter_Password, showPassword: $loginData.showReEnterPassword)
                        .padding(.top,10)
                }
                
                // Forget password Button
                
                Button {
                    loginData.forgetPassword()
                } label: {
                    Text("Forgot password")
                        .font(.custom(customFont, size: 14))
                        .fontWeight(.semibold)
                        .foregroundColor(Color("purpleColor"))
                }
                .padding(.top,8)
                .frame(maxWidth : .infinity , alignment: .leading)
                
                
                // Login Button...
                
                Button {
                    if loginData.registerUser{
                        loginData.register()
                    }else{
                        loginData.login()
                    }
                } label: {
                    Text("Login")
                        .font(.custom(customFont, size: 17))
                        .padding(.vertical,20)
                        .frame(maxWidth : .infinity)
                        .foregroundColor(.white)
                        .background(Color("purpleColor"))
                        .cornerRadius(15)
                        .shadow(color: .black.opacity(0.07), radius: 5, x: 5, y: 5)
                }
                .padding(.top,8)
                .padding(.horizontal)
                
                //Register user button...
                
                Button {
                    withAnimation {
                        loginData.registerUser.toggle()
                    }
                } label: {
                    Text(loginData.registerUser ? "Back to login" : "Create account")
                        .font(.custom(customFont, size: 14))
                        .fontWeight(.semibold)
                        .foregroundColor(Color("purpleColor"))
                }
                .padding(.top,8)
                .frame(maxWidth : .infinity )
                
                
                
                


            }
            .padding(30)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            Color.white
            // apply custom cornor
                .clipShape(CustomCorners(corners: [.topLeft,.topRight], radios: 25))
                .ignoresSafeArea()
        )
        
        }
        .frame(maxWidth : .infinity , maxHeight: .infinity)
        .background(Color("purpleColor"))
        
        // Clearing data when changes
        .onChange(of: loginData.registerUser) { newValue in
            loginData.email = ""
            loginData.password = ""
            loginData.re_Enter_Password = ""
            loginData.showPassword = false
            loginData.showReEnterPassword = false

        }
    }
    
    // custom texField
    @ViewBuilder
    func customTextField(icon: String, title : String , hint: String, value: Binding<String> , showPassword: Binding<Bool>) -> some View {
        VStack(alignment: .leading, spacing: 12){
            Label{
                Text(title)
                    .font(.custom(customFont, size: 14))
            } icon: {
                Image(systemName: icon)
            }
            .foregroundColor(Color.black.opacity(0.8))
            
            if title.contains("Password") && !showPassword.wrappedValue{
                SecureField(hint, text: value)
            }else{
                TextField(hint , text: value)
                    .padding(.top ,2)
            }
            
            Divider()
                .background(.black.opacity(0.4))
        }
        .overlay(
            Group{
                if title.contains("Password") {
                    Button(action: {
                        showPassword.wrappedValue.toggle()
                    }, label: {
                        Text(showPassword.wrappedValue ? "Hide" : "Show")
                            .font(.custom(customFont, size: 13).bold())
                            .foregroundColor(Color("purpleColor"))
                    })
                        .offset(y : 8)
                }
            }
            , alignment: .trailing
        )
    }
    
}

struct LoginPage_Previews: PreviewProvider {
    static var previews: some View {
        LoginPage()
    }
}
