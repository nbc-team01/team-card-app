//
//  UserCell.swift
//  project-team-card-app
//
//  Created by 이수현 on 3/6/25.
//

import UIKit
import Kingfisher

class UserCell: UICollectionViewCell {
    static let id = "UserCell"
    
    // 메인 이미지뷰
    private let mainImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.backgroundColor = .black.withAlphaComponent(0.05)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // 닉네임 라벨
    private let nicknameLabel: PaddingLabel = {
        let lbl = PaddingLabel(topPadding: 2, leftPadding: 4, bottomPadding: 2, rightPadding: 4)
        lbl.font = .systemFont(ofSize: 12, weight: .regular)
        lbl.layer.cornerRadius = 2
        lbl.clipsToBounds = true
        lbl.backgroundColor = .black.withAlphaComponent(0.05)
        lbl.layer.borderColor = UIColor.black.withAlphaComponent(0.1).cgColor
        lbl.layer.borderWidth = 0.5
        lbl.textAlignment = .center
        lbl.translatesAutoresizingMaskIntoConstraints = false
        
        return lbl
    }()
    
    // mbti 라벨
    private let mbtiLabel: PaddingLabel = {
        let lbl = PaddingLabel(topPadding: 2, leftPadding: 4, bottomPadding: 2, rightPadding: 4)
        lbl.font = .systemFont(ofSize: 12, weight: .regular)
        lbl.layer.cornerRadius = 2
        lbl.clipsToBounds = true
        lbl.backgroundColor = .black.withAlphaComponent(0.05)
        lbl.layer.borderColor = UIColor.black.withAlphaComponent(0.1).cgColor
        lbl.layer.borderWidth = 0.5
        lbl.textAlignment = .center
        lbl.translatesAutoresizingMaskIntoConstraints = false
        
        return lbl
    }()
    
    // subImageView
    private let subImageView: UIImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 20 / 2
        view.clipsToBounds = true
        view.contentMode = .scaleToFill
        view.backgroundColor = .black.withAlphaComponent(0.05)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // 이름
    private let nameLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 12, weight: .regular)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    // 자기소개
    private let introduceLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 12, weight: .regular)
        lbl.numberOfLines = 0
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = 6
        self.clipsToBounds = true
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.black.withAlphaComponent(0.1).cgColor
        
        setSubView()
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        mainImageView.image = nil
        nicknameLabel.text = nil
        mbtiLabel.text = nil
        nameLabel.text = nil
        subImageView.image = nil
        introduceLabel.text = nil
    }
    
    private func setSubView(){
        [
            mainImageView,
            nicknameLabel,
            mbtiLabel,
            nameLabel,
            subImageView,
            introduceLabel
        ].forEach{self.addSubview($0)}
    }
    
    private func setUI() {
        NSLayoutConstraint.activate([
            
            // 메인 이미지 뷰
            mainImageView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            mainImageView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            mainImageView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            mainImageView.heightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.widthAnchor),
            
            // 닉네임 라벨
            nicknameLabel.topAnchor.constraint(equalTo: mainImageView.bottomAnchor, constant: 8),
            nicknameLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            nicknameLabel.heightAnchor.constraint(equalToConstant: 20),
            
            // mbti 라벨 (오른쪽을 줘야 하긴 하는데 리팩토링 필요)
            mbtiLabel.centerYAnchor.constraint(equalTo: nicknameLabel.centerYAnchor),
            mbtiLabel.leadingAnchor.constraint(equalTo: nicknameLabel.trailingAnchor, constant: 6),
            mbtiLabel.heightAnchor.constraint(equalToConstant: 20),
            
            // 서브 이미지
            subImageView.topAnchor.constraint(equalTo: nicknameLabel.bottomAnchor, constant: 8),
            subImageView.leadingAnchor.constraint(equalTo: nicknameLabel.leadingAnchor),
            subImageView.heightAnchor.constraint(equalToConstant: 20),
            subImageView.widthAnchor.constraint(equalToConstant: 20),
            
            // 이름
            nameLabel.centerYAnchor.constraint(equalTo: subImageView.centerYAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: subImageView.trailingAnchor, constant: 8),
            nameLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -8),
            nameLabel.heightAnchor.constraint(equalToConstant: 16),
            
            // 자기소개
            introduceLabel.topAnchor.constraint(equalTo: subImageView.bottomAnchor, constant: 8),
            introduceLabel.leadingAnchor.constraint(equalTo: nicknameLabel.leadingAnchor, constant: 8),
            introduceLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -8),
            introduceLabel.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -8)
        ])
    }
    
    public func config(user: User) {
        
        // 이미지 설정
        if let imagePathURL = user.imagePathURL {
            mainImageView.kf.setImage(with: URL(string: imagePathURL))
            subImageView.kf.setImage(with: URL(string: imagePathURL))
        } else {
        }
        
        nicknameLabel.text = user.nickname
        mbtiLabel.text = user.mbti
        nameLabel.text = user.name
        introduceLabel.text = user.introduce
    }
}
