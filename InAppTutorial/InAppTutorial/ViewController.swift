//
//  ViewController.swift
//  InAppTutorial
//
//  Created by futurino on 16.02.2021.
//

import UIKit
import SwiftyStoreKit


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        getProducts()
    }

    func getProducts(){
        
        SwiftyStoreKit.retrieveProductsInfo( [
            "com.derspektif.DPD.00001","com.derspektif.DPD.00002","com.derspektif.DPD.00003","com.derspektif.DPD.00004","com.derspektif.DPD.00006","com.derspektif.DPD.00007","com.derspektif.DPD.00008"
        ] ) { result in
            
            
            for item in result.retrievedProducts {
//                print("Ürün Adı : \(item.localizedTitle)")
//                print("Ürün Fiyatı : \(item.price)")
                print(item.localizedTitle)
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

}

