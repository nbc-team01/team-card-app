//
//  WonsikTemplateViewController.swift
//  project-team-card-app
//
//  Created by 양원식 on 3/5/25.
//

import UIKit

class WonsikTemplateViewController: UIViewController {
    
    //MARK: - UI 요소 정의
    private let templateView = WonsikTemplateView()
    private var user: User? // Firebase에서 가져온 유저 정보 저장
    
    //MARK: - 라이프사이클 메서드
    override func loadView() {
        self.view = templateView // 커스텀 뷰 적용
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchUserData() // Firestore에서 유저 데이터 가져오기
    }

    //MARK: - Firestore에서 유저 정보 가져오기
    private func fetchUserData() {
        Task {
            do {
                let userId = "UUID" // 실제 유저 ID 설정 필요
                let fetchedUser = try await UserAPIService.fetchUser(userId: userId)
                self.user = fetchedUser
                updateUI(with: fetchedUser) // UI 업데이트
            } catch {
                print("유저 데이터 가져오기 실패:", error.localizedDescription)
            }
        }
    }

    //MARK: - UI 업데이트 메서드
    private func updateUI(with user: User) {
        templateView.updateProfile(
            imageUrl: user.imagePathURL,
            name: "\(user.name ?? "이름 없음") | \(user.nickname ?? "")",
            age: user.age.map { "\($0)세" } ?? "나이 미입력",
            githubURL: user.gitHubPathURL,
            blogURL: user.blogPathURL
        )

        templateView.updateSections(
            aboutMeTitle: "About Me",
            aboutMeContent: user.introduce ?? "",
            mbti: user.mbti ?? "정보 없음",
            styleTitle: "Style",
            styleContent: user.contents?.first(where: { $0.title == "Style" })?.content ?? "정보 없음",
            contents: user.contents
        )
    }
}
