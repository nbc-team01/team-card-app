//
//  CustomTeamRulesListView.swift
//  project-team-card-app
//
//  Created by 양원식 on 3/6/25.
//

import UIKit
import SnapKit

class CustomTeamRulesListView: UIView, UITableViewDelegate, UITableViewDataSource {
    
    //MARK: - UI 요소 정의
    private let tableView = UITableView()
    
    var rules: [(image: UIImage?, title: String, description: String)] = [] {
        didSet {
            tableView.reloadData()
            updateTableViewHeight() // 데이터가 변경될 때 높이 업데이트
        }
    }
    
    //MARK: - 초기화 메서드
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - UI 구성 메서드
    private func setupUI() {
        addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CustomTeamRulesListCell.self, forCellReuseIdentifier: CustomTeamRulesListCell.identifier)
        tableView.separatorStyle = .none
        
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalTo(1.5) // 기본 높이 설정 (데이터에 따라 조정됨)
        }
    }
    
    //MARK: - UITableView 데이터 소스 & 델리게이트
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rules.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomTeamRulesListCell.identifier, for: indexPath) as? CustomTeamRulesListCell else {
            return UITableViewCell()
        }
        let rule = rules[indexPath.row]
        cell.configure(with: rule.image, title: rule.title, description: rule.description)
        return cell
    }
    
    // 테이블 뷰 높이를 데이터 개수에 맞게 업데이트
    private func updateTableViewHeight() {
        tableView.layoutIfNeeded()
        tableView.snp.updateConstraints { make in
            make.height.equalTo(tableView.contentSize.height) // 데이터 크기에 맞춰 동적 조절
        }
    }
}
