//
//  Purchasing.swift
//  Restaurant
//
//  Created by User01 on 2021/1/18.
//

import StoreKit

class Purchasing: UIViewController, UITableViewDelegate,UITableViewDataSource, SKProductsRequestDelegate, SKPaymentTransactionObserver, ObservableObject {

    private var models = [SKProduct]()
    
    private let tableView: UITableView = {
       let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SKPaymentQueue.default().add(self)
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = view.bounds
        fetchProducts()
    }
    
    //Table

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let product = models[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.text = "\(product.localizedTitle): \(product.localizedDescription)-\(product.priceLocale.currencySymbol ?? "$")\(product.price)"
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        //Show Purchase
        let payment = SKPayment(product: models[indexPath.row])
        SKPaymentQueue.default().add(payment)
    }
    
    //Products
    
    enum Products: String, CaseIterable {
        case removeAds = "com.myapp.removeAds"
        case unlockEverything = "com.myapp.everything"
        case getGEms = "com.myapp.gems"
    }
    
    private func fetchProducts(){
        let request = SKProductsRequest(productIdentifiers: Set(Products.allCases.compactMap({ $0.rawValue})))
        request.delegate = self
        request.start()
    }
    
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        DispatchQueue.main.async {
            self.models = response.products
            self.tableView.reloadData()
        }
    }
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        transactions.forEach({
            switch $0.transactionState{
            
            case .purchasing:
                print("Purchasing")
            case .purchased:
                print("Purchased")
                SKPaymentQueue.default().finishTransaction($0)
            case .failed:
                print("Did not purchase")
                SKPaymentQueue.default().finishTransaction($0)
            case .restored:
                break
            case .deferred:
                break
            @unknown default:
                break
            }
        })
    }
}
