//
//  Package.swift
//  Restaurant
//
//  Created by User01 on 2021/1/18.
//

import Foundation
import StoreKit

struct Package: Hashable {
    let id: String
    let title: String
    let description: String
    var isLocked: Bool
    var price: String?
    let locale: Locale
    let imageName: String
    
    lazy var formatter: NumberFormatter = {
       let nf = NumberFormatter()
        nf.numberStyle = .currency
        nf.locale = locale
        return nf
    }()
    
    init(product: SKProduct, isLocked: Bool = true) {
        self.id = product.productIdentifier
        self.title = product.localizedTitle
        self.description = product.localizedDescription
        self.isLocked = isLocked
        self.locale = product.priceLocale
        self.imageName = product.productIdentifier
        
        if isLocked {
            self.price = formatter.string(from: product.price)
        }
    }
}
