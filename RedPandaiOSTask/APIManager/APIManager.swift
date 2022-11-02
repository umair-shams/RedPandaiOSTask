//
//  APIManager.swift
//  RedPandaiOSTask
//
//  Created by Umair Shams on 02/11/2022.
//

import Foundation

class APIManager {
    func fetchProductIds() async throws -> [String] {
        var productIds: [String] = []
        let url = URL(string: AppConstants.API_BASE_URL + AppConstants.PRODUCT_IDS)
             
        
        let (data, _) = try await URLSession.shared.data(from: url!)
        guard let value = String(data: data, encoding: String.Encoding.ascii), let jsonData = value.data(using: String.Encoding.utf8) else {return []}
        
        do {
            let jsonArray = try JSONSerialization.jsonObject(with: jsonData, options: []) as! NSArray
            productIds = jsonArray.map({$0 as! String})
        } catch {
            NSLog("ERROR \(error.localizedDescription)")
        }
       
        return productIds
    }
}
