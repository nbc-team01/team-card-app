//
//  SooProfileCell.swift
//  project-team-card-app
//
//  Created by 이수현 on 3/13/25.
//

import UIKit
import Kingfisher

class SooProfileCell: UITableViewCell {
    static let id = "SooProfileCell"
    
    // 링크 버튼 크기 (깃, 블로그)
    private let linkButtonWidthHeight: CGFloat = 40
    
    // 프로필 이미지 뷰
    private let profileImageView: UIImageView = {
        let imgView = UIImageView()
//        imgView.image = .githubMark
        imgView.backgroundColor = .placeholderText
        imgView.contentMode = .scaleToFill
        imgView.translatesAutoresizingMaskIntoConstraints = false
        return imgView
    }()
    
    // 그라데이션 뷰
    private let gradientView: UIView = {
        let view = UIView()
        let layer = CAGradientLayer()
        layer.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 120)
        layer.colors = [
//            UIColor.clear.cgColor,
            UIColor.black.withAlphaComponent(0.8).cgColor,
            UIColor.black.withAlphaComponent(0.5).cgColor,
            UIColor.black.withAlphaComponent(0.3).cgColor,
            UIColor.black.withAlphaComponent(0.1).cgColor,
            UIColor.clear.cgColor
        ]
        view.layer.addSublayer(layer)
        view.backgroundColor = .clear
        view.isUserInteractionEnabled = false
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // 닉네임 / 이름 (나이) 라벨
    private let userInfoLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "닉네임 / 이름 (나이)"
        lbl.textColor = .white
        lbl.font = .systemFont(ofSize: 26, weight: .semibold)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()

//
    // MBTI
    private let mbtiLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "임시 MBTI"
        lbl.textColor = .white
        lbl.font = .systemFont(ofSize: 24, weight: .semibold)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    // 깃허브 버튼
    public lazy var gitButton: UIButton = {
        let btn = UIButton()
        btn.setImage(.githubIcon, for: .normal)
        btn.imageView?.contentMode = .scaleAspectFit
//        btn.backgroundColor = .white
//        btn.layer.cornerRadius = linkButtonWidthHeight / 2
//        btn.clipsToBounds = true
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    // 블로그 버튼
    public lazy var blogButton: UIButton = {
        let btn = UIButton()
        btn.setImage(.blogIconTistory, for: .normal)
        btn.imageView?.contentMode = .scaleAspectFit
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setSubView()
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        profileImageView.image = nil
        userInfoLabel.text = nil
        mbtiLabel.text = nil
        gitButton.gestureRecognizers = nil
        blogButton.gestureRecognizers = nil
    }
    
    
    func setSubView(){
        [
            profileImageView,
            gradientView,
            userInfoLabel,
            mbtiLabel,
            gitButton,
            blogButton,
        ].forEach{self.contentView.addSubview($0)}
    }
    
    func setUI(){
        NSLayoutConstraint.activate([
            // 프로필 이미지 뷰
            profileImageView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            profileImageView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            profileImageView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            profileImageView.heightAnchor.constraint(equalToConstant: 400),
            profileImageView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            
            // 그라이데이션 뷰
            gradientView.topAnchor.constraint(equalTo: userInfoLabel.topAnchor, constant: -20),
            gradientView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            gradientView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),

            // 유저 정보 라벨
            userInfoLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: -75),
            userInfoLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            userInfoLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: 16),
            userInfoLabel.heightAnchor.constraint(equalToConstant: 30),

            // MBTI
            mbtiLabel.topAnchor.constraint(equalTo: userInfoLabel.bottomAnchor, constant: 10),
            mbtiLabel.leadingAnchor.constraint(equalTo: userInfoLabel.leadingAnchor),
            mbtiLabel.heightAnchor.constraint(equalToConstant: 30),

            
            // 깃 버튼
            gitButton.centerYAnchor.constraint(equalTo: mbtiLabel.centerYAnchor),
            gitButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            gitButton.heightAnchor.constraint(equalToConstant: self.linkButtonWidthHeight),
            gitButton.widthAnchor.constraint(equalToConstant: self.linkButtonWidthHeight),
            
            // 블로그 버튼
            blogButton.centerYAnchor.constraint(equalTo: gitButton.centerYAnchor),
            blogButton.trailingAnchor.constraint(equalTo: gitButton.leadingAnchor, constant: -10),
            blogButton.heightAnchor.constraint(equalToConstant: self.linkButtonWidthHeight),
            blogButton.widthAnchor.constraint(equalToConstant: self.linkButtonWidthHeight),
        ])
    }
    
    public func config(user: User) {
        if let imagePathURL = user.imagePathURL {
            profileImageView.kf.setImage(with: URL(string: imagePathURL))
        } else {
            print("이미지 없음")
        }
        
        let age = Int(user.age ?? 0)
        userInfoLabel.text = "\(user.nickname ?? "") / \(user.name ?? "") (\(age)세)"
        mbtiLabel.text = user.mbti
    }
}
