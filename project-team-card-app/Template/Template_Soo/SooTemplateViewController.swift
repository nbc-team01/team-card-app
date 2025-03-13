//
//  SooTemplateViewController.swift
//  project-team-card-app
//
//  Created by 이수현 on 3/4/25.
//

import UIKit
import SafariServices

class SooTemplateViewController: UIViewController {
    private lazy var templateView = SooTemplateView()
    private let userId: String
    private var user: User?
    
    init(userId: String) {
        self.userId = userId
        super.init(nibName: nil, bundle: nil)
        
        setTableView()
        fetchUserData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view = templateView
    }
    
    private func setTableView() {
        templateView.tableView.dataSource = self
        templateView.tableView.delegate = self
    }

    @objc private func openURLTapGeusture(_ gesture: CustomTapGesture){
        guard let openURL = gesture.openURL, let url = URL(string: openURL) else {return}
        let safariViewController = SFSafariViewController(url: url)
          present(safariViewController, animated: true, completion: nil)
    }
    
    
    // 유저 정보 불러오기
    public func fetchUserData(){
        Task {
            do {
                let user = try await UserAPIService.fetchUser(userId: userId)
                self.user = user
                DispatchQueue.main.async {[weak self] in
                    self?.templateView.tableView.reloadData()
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}


extension SooTemplateViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2 // 프로필, 커스텀 컨텐츠
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return 1        // 프로필 셀
        case 1: return 1 + (user?.contents?.count ?? 0) // 커스텀 컨텐츠 셀 (자기소개 포함)
        default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0: // 프로필 셀
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SooProfileCell.id) as? SooProfileCell else {
                return UITableViewCell()
            }
            guard let user else { return cell }
            
            // 깃허브 탭 제스처 구현
            let gitButtonTapGesture = CustomTapGesture(target: self, action: #selector(openURLTapGeusture))
            gitButtonTapGesture.openURL = user.gitHubPathURL
            cell.gitButton.addGestureRecognizer(gitButtonTapGesture)
            
            // 블로그 탭 제스처 구현
            let blogButtonTapGesture = CustomTapGesture(target: self, action: #selector(openURLTapGeusture))
            blogButtonTapGesture.openURL = user.blogPathURL
            cell.blogButton.addGestureRecognizer(blogButtonTapGesture)
            
            cell.config(user: user)
            return cell
        case 1: // 커스텀 컨텐츠 셀 (자기소개 포함)
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SooCustomInfoCell.id) as? SooCustomInfoCell else {
                return UITableViewCell()
            }
            let contents = user?.contents ?? []
            let userContent = ([Content(title: "자기소개", content: user?.introduce)] + contents)[indexPath.row]
            guard let title = userContent.title, let content = userContent.content else { return cell }
            cell.config(title: title, content: content)
            return cell
        default:
            return UITableViewCell()
        }
    }
}

extension SooTemplateViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0: return 400
        default: 
            return UITableView.automaticDimension
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 1))
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 30
    }
}
