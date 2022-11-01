//
//  AppConstants.swift
//  RedPandaiOSTask
//
//  Created by Umair Shams on 02/11/2022.
//

import Foundation

public struct AppConstants {
    static let API_BASE_URL = "http://35.154.26.203/"
    static let FIREBASE_BASE_URL = "https://qstest-123.firebaseio.com"
    static let PRODUCT_IDS = "product-ids"
    
    struct FirebaseNodes {
        static let productName = "product-name/"
        static let productPrice = "product-price/"
        static let productImage = "product-image/"
        static let productDescription = "product-desc/"
    }
}
