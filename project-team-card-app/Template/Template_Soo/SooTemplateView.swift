//
//  SooTemplateView.swift
//  project-team-card-app
//
//  Created by 이수현 on 3/13/25.
//

import UIKit

class SooTemplateView: UIView {
    public let tableView: UITableView = {
        let view = UITableView()
        view.register(SooProfileCell.self, forCellReuseIdentifier: SooProfileCell.id)
        view.register(SooCustomInfoCell.self, forCellReuseIdentifier: SooCustomInfoCell.id)
        view.separatorStyle = .none
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
    
        setSubView()
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setSubView(){
        [
            tableView,
        ].forEach{self.addSubview($0)}
    }
    
    private func setUI() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}
