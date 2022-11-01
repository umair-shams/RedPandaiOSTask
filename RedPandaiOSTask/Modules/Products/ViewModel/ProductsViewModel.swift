//
//  ProductsViewModel.swift
//  RedPandaiOSTask
//
//  Created by Umair Shams on 02/11/2022.
//

import Foundation

class ProductsViewModel {
    var isFethcingCompleted: Observable<Bool?> = Observable(nil)
    private let databaseManager: FirebaseManager
    var productsData = ProductsData()
    
    //Constructor injection using depenacny injection concept.
    init(databaseManager: FirebaseManager) {
        self.databaseManager = databaseManager
    }
    
    func fetch() {
        Task {
            do {
                let productIds = try await databaseManager.fetchProductIds()
                productsData.productIds = productIds
                print("Products ids fethced completed.\(productIds.count)")
                
                async let productNames = databaseManager.fetchAllProductNames(for: productIds)
                async let productPrices = databaseManager.fetchAllProductPrices(for: productIds)
                async let productImages = databaseManager.fetchAllProductImages(for: productIds)
                async let productDescription = databaseManager.fetchAllProductImages(for: productIds)
                
                let (names, prices, images, descriptions) = try await (productNames, productPrices, productImages, productDescription)
                productsData.productNames = names
                productsData.productPrices = prices
                productsData.productImages = images
                productsData.productDescriptions = descriptions
                
                self.isFethcingCompleted.value = true
            } catch {
                print("Request failed with error: \(error)")
            }
        }
    }
}
