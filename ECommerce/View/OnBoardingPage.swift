//
//  OnBoardingPage.swift
//  ECommerce
//
//  Created by AhmedAshraf on 08/01/2022.
//

import SwiftUI
let customFont = "Raleway-Regular"

struct OnBoardingPage: View {
    @State var showLoginPage : Bool = false
    var body: some View {
        VStack(alignment: .leading){
            Text("Find Your Gadget")
                .font(.custom(customFont, size: 55))
                .fontWeight(.bold)
                .foregroundColor(.white)
            
            Image("onBoard")
                .resizable()
                .aspectRatio(contentMode: .fit)
            
            Button {
                withAnimation {
                    showLoginPage = true
                }
                
            } label: {
                Text("Get Started")
                    .font(.custom(customFont, size: 18))
                    .fontWeight(.semibold)
                    .padding(.vertical, 18)
                    .frame(maxWidth : .infinity)
                    .foregroundColor(Color("purpleColor"))
                    .background(.white)
                    .cornerRadius(15)
                    .shadow(color: Color.black.opacity(0.1), radius: 5, x: 5, y: 5)
            }
            .padding(.horizontal , 30)
            .offset(y : getRect().height < 750 ?  20 : 40)
            
            
            Spacer()

            
        }
        .padding()
        .padding(.top, getRect().height < 750 ? 0 : 20)
        .frame(maxWidth: .infinity,maxHeight: .infinity)
        .background(Color("purpleColor"))
        .overlay(
            Group{
                if showLoginPage{
                    LoginPage()
                        .transition(.move(edge: .bottom))
                }
            }
        )
    }
}

struct OnBoardingPage_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardingPage()
            .previewDevice("iPhone 12")
        
        OnBoardingPage()
            .previewDevice("iPhone 8")
    }
}

//extending view to get Screen bound

extension View {
    func getRect() -> CGRect {
        return UIScreen.main.bounds
    }
}
