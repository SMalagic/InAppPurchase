//
//  ViewController.swift
//  InAppTutorial
//
//  Created by futurino on 16.02.2021.
//

import UIKit
import SwiftyStoreKit
import StoreKit

class ViewController: UIViewController , SKPaymentTransactionObserver{

    @IBOutlet weak var tableView: UITableView!
    
    var products = [Product]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView()
        
        SKPaymentQueue.default().add(self)

        setProducts()
        getProductsSwifty()
        //getProductsStoreKit()
        
        
    }
    
    
    // Ürün Bilgilerini içeren model
    func setProducts(){
        
        products.append(Product(id: "com.derspektif.DPD.00001", title: "8. Sınıf Öğrenme Ekosistemi", description: "Derspektif Dijital", price: "20.99$", img: "derspektif-logo"))
        products.append(Product(id: "com.derspektif.DPD.00002", title: "9. Sınıf Öğrenme Ekosistemi", description: "Derspektif Dijital", price: "20.99$", img: "derspektif-logo"))
        products.append(Product(id: "com.derspektif.DPD.00003", title: "10. Sınıf Öğrenme Ekosistemi", description: "Derspektif Dijital", price: "20.99$", img: "derspektif-logo"))
        products.append(Product(id: "com.derspektif.DPD.00004", title: "11. Sınıf Öğrenme Ekosistemi", description: "Derspektif Dijital", price: "20.99$", img: "derspektif-logo"))
        products.append(Product(id: "com.derspektif.DPD.00006", title: "AYT EA Öğrenme Ekosistemi", description: "Derspektif Dijital", price: "20.99$", img: "derspektif-logo"))
        products.append(Product(id: "com.derspektif.DPD.00007", title: "AYT Sayısal Öğrenme Ekosistemi", description: "Derspektif Dijital", price: "20.99$", img: "derspektif-logo"))
        products.append(Product(id: "com.derspektif.DPD.00008", title: "TYT Öğrenme Ekosistemi", description: "Derspektif Dijital", price: "20.99$", img: "derspektif-logo"))
        
    }
    

    func getProductsSwifty(){
        
        SwiftyStoreKit.retrieveProductsInfo( [
            products[0].id, products[1].id, products[2].id, products[3].id, products[4].id, products[5].id, products[6].id
        ] ) { result in
            
            
            for item in result.retrievedProducts {
                print("Ürün Adı : \(item.localizedTitle)")
                let a = "Para Birimi : \(item.priceLocale) Fiyat: \(item.price)"
                print("Ürün Fiyatı : \(a) \n" )
            }
            
            if let product = result.retrievedProducts.first {
                let priceString = product.localizedPrice!
                print("Product: \(product.localizedDescription), price: \(priceString)")
            }
            else if let invalidProductId = result.invalidProductIDs.first {
                print("Invalid product identifier: \(invalidProductId)")
            }
            else {
                print("Error: \(result.error)")
            }
        }
        
    }
    
    
    func buyProduct(id : String){
        
        SwiftyStoreKit.purchaseProduct(products[0].id, quantity: 1, atomically: true) { result in
            switch result {
            case .success(let purchase):
                print("Purchase Success: \(purchase.productId)")
            case .error(let error):
                switch error.code {
                case .unknown: print("Unknown error. Please contact support")
                case .clientInvalid: print("Not allowed to make the payment")
                case .paymentCancelled: break
                case .paymentInvalid: print("The purchase identifier was invalid")
                case .paymentNotAllowed: print("The device is not allowed to make the payment")
                case .storeProductNotAvailable: print("The product is not available in the current storefront")
                case .cloudServicePermissionDenied: print("Access to cloud service information is not allowed")
                case .cloudServiceNetworkConnectionFailed: print("Could not connect to the network")
                case .cloudServiceRevoked: print("User has revoked permission to use this cloud service")
                default: print((error as NSError).localizedDescription)
                }
            }
        }
        
    }

}


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
        
        cell.textLabel?.text = products[indexPath.row].title
        cell.detailTextLabel?.text = products[indexPath.row].description
        cell.imageView?.image = UIImage(named: products[indexPath.row].img)
        cell.imageView?.layer.cornerRadius = 10
        cell.textLabel?.font = UIFont(name: "Avenir Next Demi Bold", size: 17)
        cell.detailTextLabel?.font = UIFont(name: "Avenir Next Demi Bold", size: 12)
        cell.textLabel?.textColor = .darkGray
        cell.detailTextLabel?.textColor = .lightGray
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        buyProduct(id: products[indexPath.row].id)
    }
    
}



extension ViewController {
    
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            if transaction.transactionState == .purchased {
                //if item has been purchased
                print("Transaction Successful")
                
            } else if transaction.transactionState == .failed {
                print("Transaction Failed")
            } else if transaction.transactionState == .restored {
                print("restored")
            }
        }
    }
    
    @IBAction func restorePressed(_ sender: Any) {
        SKPaymentQueue.default().restoreCompletedTransactions()
    }
    
    
    func getProductsStoreKit(){
        
        if SKPaymentQueue.canMakePayments() {
            let paymentRequest = SKMutablePayment()
            paymentRequest.productIdentifier = products[0].id
            SKPaymentQueue.default().add(paymentRequest)
        } else {
            print("User unable to make payments")
        }
        
    }
    
}
