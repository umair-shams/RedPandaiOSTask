//
//  FirebaseManager.swift
//  RedPandaiOSTask
//
//  Created by Umair Shams on 02/11/2022.
//

import Firebase
import FirebaseDatabase

class FirebaseManager {
    private let databaseRef = Database.database()
    
    func fetchAllProductNames(for ids: [String]) async throws -> [String] {
        try await withThrowingTaskGroup(of: (String, String).self) { [self] group in
            for id in ids {
                group.addTask { (id, await self.fetchSingleProductName(for: id)) }
            }
            
            let dictionary = try await group.reduce(into: [:]) { $0[$1.0] = $1.1 }
            return ids.compactMap { dictionary[$0] }
        }
    }
    
    func fetchAllProductPrices(for ids: [String]) async throws -> [String] {
        try await withThrowingTaskGroup(of: (String, String).self) { [self] group in
            for id in ids {
                group.addTask { (id, await self.fetchSingleProductPrice(for: id)) }
            }
            
            let dictionary = try await group.reduce(into: [:]) { $0[$1.0] = $1.1 }
            return ids.compactMap { dictionary[$0] }
        }
    }
    
    func fetchAllProductImages(for ids: [String]) async throws -> [String] {
        try await withThrowingTaskGroup(of: (String, String).self) { [self] group in
            for id in ids {
                group.addTask { (id, await self.fetchSingleProductImage(for: id)) }
            }
            
            let dictionary = try await group.reduce(into: [:]) { $0[$1.0] = $1.1 }
            return ids.compactMap { dictionary[$0] }
        }
    }
    
    func fetchAllProductDescription(for ids: [String]) async throws -> [String] {
        try await withThrowingTaskGroup(of: (String, String).self) { [self] group in
            for id in ids {
                group.addTask { (id, await self.fetchSingleProductDescription(for: id)) }
            }
            
            let dictionary = try await group.reduce(into: [:]) { $0[$1.0] = $1.1 }
            return ids.compactMap { dictionary[$0] }
        }
    }
    
    func fetchSingleProductName(for id: String) async -> String {
        let ref = databaseRef.reference(fromURL: AppConstants.FIREBASE_BASE_URL)
        
        return await withCheckedContinuation { continuation in
            ref.child("\(AppConstants.FirebaseNodes.productName)/\(id)").observeSingleEvent(of: .value, with: { snapshot in
                continuation.resume(returning: snapshot.value as? String ?? "No Product title")
            })
        }
    }
    
    func fetchSingleProductPrice(for id: String) async -> String {
        let ref = databaseRef.reference(fromURL: AppConstants.FIREBASE_BASE_URL)
        
        return await withCheckedContinuation { continuation in
            ref.child("\(AppConstants.FirebaseNodes.productPrice)/\(id)").observeSingleEvent(of: .value, with: { snapshot in
                continuation.resume(returning: self.toString(snapshot.value))
            })
        }
    }
    
    func fetchSingleProductImage(for id: String) async -> String {
        let ref = databaseRef.reference(fromURL: AppConstants.FIREBASE_BASE_URL)
        
        return await withCheckedContinuation { continuation in
            ref.child("\(AppConstants.FirebaseNodes.productImage)\(id)").observeSingleEvent(of: .value, with: { snapshot in
                continuation.resume(returning: snapshot.value! as! String)
            })
        }
    }
    
    func fetchSingleProductDescription(for id: String) async -> String {
        let ref = databaseRef.reference(fromURL: AppConstants.FIREBASE_BASE_URL)
        
        return await withCheckedContinuation { continuation in
            ref.child("\(AppConstants.FirebaseNodes.productDescription)\(id)").observeSingleEvent(of: .value, with: { snapshot in
                continuation.resume(returning: snapshot.value as? String ?? "No product description")
            })
        }
    }
}

extension FirebaseManager {
    func toString(_ value: Any?) -> String {
      return String(describing: value ?? "-")
    }
}
