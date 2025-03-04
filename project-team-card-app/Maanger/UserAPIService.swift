//
//  UserAPIService.swift
//  project-team-card-app
//
//  Created by 유영웅 on 3/4/25.
//

import Foundation
import FirebaseFirestore


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
    static func saveUser(user: User) async throws {
            let ref = db.collection("users").document(user.userID)

            do {
                try ref.setData(from: user)
                print("User 데이터 저장 성공")
            } catch {
                throw NSError(domain: "FirestoreService", code: 500, userInfo: [NSLocalizedDescriptionKey: "Error saving user data to Firestore"])
            }
        }
}
