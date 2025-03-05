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
        let ref = db.collection("users").document(user.userID ?? "")
        
        do {
            //DB에 데이터 저장
            try ref.setData(from: user)
            print("User 데이터 저장 성공")
        } catch {
            throw NSError(domain: "FirestoreService", code: 500, userInfo: [NSLocalizedDescriptionKey: "Error saving user data to Firestore"])
        }
    }
    //유저정보 업데이트
    static func updateUser(user:User) async throws{
        //경로 설정 users/user_uid
        let ref = db.collection("users").document(user.userID ?? "")
        
        do {
            //업데이트 시에는 [String:Any]형태로 존재해야함
            let data = try Firestore.Encoder().encode(user)
            //DB에 데이터 업데이트
            try await ref.updateData(data)
            print("User 데이터 수정 성공")
        } catch {
            throw NSError(domain: "FirestoreService", code: 500, userInfo: [NSLocalizedDescriptionKey: "Error saving user data to Firestore"])
        }
    }
    //유저정보 삭제
    static func deleteUser(userId:String) async throws{
        let ref = db.collection("users").document(userId)
        try await ref.delete()
    }
    //유저 리스트 조회
    static func fetchUsers() async throws -> [User]{
        //컬렉션의 모든 문서 fetching
        let snapshot = try await db.collection("users").getDocuments()
        //문서 디코딩
        return try snapshot.documents.compactMap { try $0.data(as: User.self) }
    }
}
