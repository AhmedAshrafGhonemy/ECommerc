//
//  MainPage.swift
//  ECommerce
//
//  Created by AhmedAshraf on 09/01/2022.
//

import SwiftUI

struct MainPage: View {
    
// current Tab
    @State var currentTab : Tab = .Home
    
// hiding tab bar
    init(){
        UITabBar.appearance().isHidden = true
    }
    var body: some View {
     
        VStack(spacing : 0){
            // Tab view
            TabView(selection: $currentTab) {
                Home()
                Text("Liked")
                    .tag(Tab.Liked)
                ProfilePage() 
                    .tag(Tab.Profile)
                Text("Cart")
                    .tag(Tab.Cart)
            }
            
            // Custom Tab Bar
            HStack(spacing : 0){
                ForEach(Tab.allCases, id: \.self) {tab in
                    Button {
                        // Updating tab
                        currentTab = tab
                    } label: {
                        Image(tab.rawValue)
                            .resizable()
                            .renderingMode(.template)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 22, height: 22)
                            .background(
                                Color("purpleColor")
                                    .opacity(0.1)
                                    .cornerRadius(5)
                                    .blur(radius: 5)
                                    .padding(-7)
                                    .opacity(currentTab == tab ? 1 : 0)
                            )
                            .frame(maxWidth : .infinity)
                            .foregroundColor(currentTab == tab ?
                                             Color("purpleColor") :
                                                Color.black.opacity(0.3))
                    }

                }
            }
            .padding([.horizontal,.top])
            .padding(.bottom,10)
        }
        .background(Color("HomeBG").ignoresSafeArea())
    }
}

struct MainPage_Previews: PreviewProvider {
    static var previews: some View {
        MainPage()
    }
}

// Tab Cases   and Iteration case "CaseIterable"
enum Tab : String , CaseIterable{
    
    case Home = "home"
    case Liked = "liked"
    case Profile = "profile"
    case Cart = "cart"
}
