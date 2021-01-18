//
//  Shop.swift
//  Restaurant
//
//  Created by User01 on 2021/1/18.
//

import SwiftUI

struct ShopRow: View {
    let package: Package
    let action: () -> Void
    
    var body: some View {
        HStack{
            VStack{
                Image(package.imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 80, height: 80)
                    .cornerRadius(9)
                    .opacity(package.isLocked ? 0.8 : 1)
                    .blur(radius: package.isLocked ? 3.0 : 0)
                    .padding()
                Image(systemName: "lock.fill")
                    .font(.largeTitle)
                    .opacity(package.isLocked ? 1 :0)
            }
            VStack(alignment: .leading) {
                Text(package.title)
                    .font(.title)
                Text(package.description)
                    .font(.caption)
            }
            Spacer()
            if let price = package.price, package.isLocked {
                Button(action: action, label: {
                    Text(price)
                        .foregroundColor(.white)
                        .padding([.leading, .trailing])
                        .padding([.top, .bottom], 5)
                        .background(Color.black)
                        .cornerRadius(25)
                })
            }
        }
    }
}

struct Shop: View {
    @EnvironmentObject private var purchase: Purchase
    
    var body: some View {
        NavigationView {
            List(purchase.allPackages, id: \.self) { package in
                Group {
                    if !package.isLocked {
                        NavigationLink(destination: Text("You Already Purchase This Package")){
                            ShopRow(package: package) { }
                        }
                    } else {
                        ShopRow(package: package) {
                            if let product = purchase.product(for: package.id) {
                                purchase.purchaseProduct(product)
                            }
                        }
                    }
                }
            }.navigationTitle("Premium Packages")
        }
    }
}

struct Shop_Previews: PreviewProvider {
    static var previews: some View {
        Shop()
    }
}
