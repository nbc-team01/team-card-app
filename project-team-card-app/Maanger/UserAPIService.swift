//
//  UserAPIService.swift
//  project-team-card-app
//
//  Created by 유영웅 on 3/4/25.
//

import Foundation

class UserAPIService{
    
    private static let db = Firestore.firestore()
    
    static func fetchUser(userId:String) async throws -> User{
        let ref = db.collection("users").document(userId)
        
        let snapshot = try await ref.collection("contents").getDocuments()
        do {
            let snapshot = try await ref.getDocument()
            guard snapshot.exists else { throw NSError(domain: "FirestoreService", code: 404, userInfo: [NSLocalizedDescriptionKey: "User not found"]) }
            
            return try snapshot.data(as: User.self)
        } catch {
            throw error
        }
    }
}
