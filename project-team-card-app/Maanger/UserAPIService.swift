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
    //유저 정보 조회
    static func fetchUser(userId:String) async throws -> User{
        //경로 설정 users/user_uid
        let ref = db.collection("users").document(userId)
        do {
            //snapshot : user 정보 필드
            let snapshot = try await ref.getDocument()
            guard snapshot.exists else { throw NSError(domain: "FirestoreService", code: 404, userInfo: [NSLocalizedDescriptionKey: "User not found"]) }
            //디코딩
            return try snapshot.data(as: User.self)
        } catch {
            throw error
        }
    }
    //유저정보 저장
    static func setUser(user: User) async throws {
        //경로 설정 users/user_uid
        let ref = db.collection("users").document(user.userID)
        
        do {
            //DB에 데이터 저장
            try ref.setData(from: user)
            print("User 데이터 저장 성공")
        } catch {
            throw NSError(domain: "FirestoreService", code: 500, userInfo: [NSLocalizedDescriptionKey: "Error saving user data to Firestore"])
        }
    }
}
