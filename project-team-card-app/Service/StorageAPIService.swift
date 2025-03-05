//
//  StorageAPIService.swift
//  project-team-card-app
//
//  Created by 유영웅 on 3/5/25.
//

import Foundation
import FirebaseStorage
import UIKit

class StorageAPIService{
    private static let storage = Storage.storage()
    
    //이미지를 Storage에 업로드하고 경로 반환
    static func setImage(_ image: UIImage,userId:String) async throws -> String {
        //이미지 형식 밑 퀄리티 설정
        guard let imageData = image.jpegData(compressionQuality: 1.0) else {
            throw NSError(domain: "FirebaseStorageService", code: -1, userInfo: [NSLocalizedDescriptionKey: "이미지 변환 실패"])
        }
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"                                     //데이터 타입 이미지로 설정
        
        let ref = storage.reference().child("users/\(userId).jpg")              //저장 포맷설정(users/uuid)
        let _ = try await ref.putDataAsync(imageData, metadata: metadata)       //메타데이터는 사용X
        
        return try await ref.downloadURL().absoluteString                       //해당 스토리지 경로
    }
    //이미지 삭제
    static func deleteImage(userId: String) async throws {
        let ref = storage.reference().child("users/\(userId).jpg")
        try await ref.delete()
    }
}
