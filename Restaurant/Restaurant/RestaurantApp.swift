//
//  RestaurantApp.swift
//  Restaurant
//
//  Created by User01 on 2021/1/15.
//

import SwiftUI
import SDWebImageSwiftUI
import WebKit

@main
struct RestaurantApp: App {
    
    @StateObject private var purchase = Purchase()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(purchase)
        }
    }
}
