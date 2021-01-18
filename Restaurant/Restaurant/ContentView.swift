//
//  ContentView.swift
//  Restaurant
//
//  Created by User01 on 2021/1/15.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        
        TabView {
            Home()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
            Profile()
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Profile")
                }
            Shop()
                .tabItem {
                    Image(systemName: "cart.fill")
                    Text("Shop")
                }
        }
    }
}

    
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
