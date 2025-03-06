//
//  HakyungTemplateViewController.swift
//  project-team-card-app
//
//  Created by kingj on 3/6/25.
//

import UIKit
import Combine

class HakyungTemplateViewController: UIViewController {
    
    var userId: String
    private var listForShow: [Content] = []
    
    private let templateView = HakyungTemplateView()
    
    init(userId: String) {
        self.userId = userId
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        super.loadView()
        view = templateView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchUserData()
        view.backgroundColor = .white
        templateView.tableView.delegate = self
        templateView.tableView.dataSource = self
        templateView.tableView.register(HakyungCell.self, forCellReuseIdentifier: HakyungCell.identifier)
    }
}

extension HakyungTemplateViewController {
    
    private func makeDataListForShow(user: User) {
        // [["MBTI", ""], ["소개", ""], [Content], [Content] ... ]
        let content: Content = Content(title: "MBTI", content: user.mbti)
        let content2: Content = Content(title: "소개", content: user.introduce)
        listForShow.append(content)
        listForShow.append(content2)
        user.contents!.forEach({
            listForShow.append($0)
        })
        templateView.tableView.reloadData()
    }
    
    func fetchUserData() {
        Task {
            do {
                let user = try await UserAPIService.fetchUser(userId: self.userId)
                
                DispatchQueue.main.async { [weak self] in
                    guard let self else { return }
                    self.templateView.setUserInfo(user: user)
                    self.makeDataListForShow(user: user)
                }
            } catch {
                print("!! User Data Fetch Error: \(error.localizedDescription)")
            }
        }
    }
    
}

extension HakyungTemplateViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listForShow.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.templateView.tableView.dequeueReusableCell(withIdentifier: HakyungCell.identifier, for: indexPath) as? HakyungCell else {
            return UITableViewCell(style: .value1, reuseIdentifier: HakyungCell.identifier)
        }
        
        cell.setContentsData(contents: listForShow[indexPath.item])
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        return cell
    }
}

extension HakyungTemplateViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

#Preview(traits: .defaultLayout, body: {
    HakyungTemplateView()
})
