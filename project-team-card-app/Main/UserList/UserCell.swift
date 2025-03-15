//
//  UserCell.swift
//  project-team-card-app
//
//  Created by 이수현 on 3/6/25.
//

import UIKit
import Kingfisher
import SnapKit

class StyledPaddingLabel: PaddingLabel {
    
    // 커스텀 초기화 메서드
    override init(topPadding: CGFloat, leftPadding: CGFloat, bottomPadding: CGFloat, rightPadding: CGFloat) {
        super.init(topPadding: topPadding, leftPadding: leftPadding, bottomPadding: bottomPadding, rightPadding: rightPadding)
        configureLabelStyle()  // 스타일링 설정
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // 스타일을 적용하는 메서드
    private func configureLabelStyle() {
        self.font = .systemFont(ofSize: 12, weight: .regular)
        self.layer.cornerRadius = 2
        self.clipsToBounds = true
        self.backgroundColor = .black.withAlphaComponent(0.05)
        self.layer.borderColor = UIColor.black.withAlphaComponent(0.1).cgColor
        self.layer.borderWidth = 0.5
        self.textAlignment = .center
    }
}

class UserCell: UICollectionViewCell {
    static let identifier = "UserCell"
    //닉네임&MBTI
    private let nickNameLabel = StyledPaddingLabel(topPadding: 2, leftPadding: 4, bottomPadding: 2, rightPadding: 4)
    private let mbtiLabel = StyledPaddingLabel(topPadding: 2, leftPadding: 4, bottomPadding: 2, rightPadding: 4)
    // 메인 이미지뷰
    private let mainImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleToFill
        view.backgroundColor = .black.withAlphaComponent(0.05)
        return view
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
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // 자기소개
    private let introduceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
        nameLabel.text = nil
        subImageView.image = nil
        introduceLabel.text = nil
        nickNameLabel.text = nil
        mbtiLabel.text = nil
    }
    
    private func setSubView(){
        [
            mainImageView,
            nickNameLabel,
            mbtiLabel,
            nameLabel,
            subImageView,
            introduceLabel
        ].forEach{self.addSubview($0)}
    }
    
    private func setUI() {
        isUserInteractionEnabled = true
        // 메인 이미지 뷰
        mainImageView.snp.makeConstraints{ make in
            make.edges.equalToSuperview()
            make.height.equalTo(self.snp.width)
        }
        // 닉네임 라벨
        nickNameLabel.snp.makeConstraints { make in
            make.leading.equalTo(self.snp.leading).offset(8)
            make.top.equalTo(mainImageView.snp.bottom).offset(8)
            make.height.equalTo(20)
        }
        // MBTI 라벨 (오른쪽에 위치하도록 수정)
        mbtiLabel.snp.makeConstraints { make in
            make.leading.equalTo(nickNameLabel.snp.trailing).offset(8)
            make.centerY.equalTo(nickNameLabel.snp.centerY)
            make.height.equalTo(20)
        }
        // 서브 이미지
        subImageView.snp.makeConstraints { make in
            make.top.equalTo(nickNameLabel.snp.bottom).offset(8)
            make.leading.equalTo(nickNameLabel.snp.leading)
            make.width.height.equalTo(20)
        }
        // 이름
        nameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(subImageView.snp.centerY)
            make.leading.equalTo(subImageView.snp.trailing).offset(8)
            make.trailing.equalTo(self.snp.trailing).offset(-8)
            make.height.equalTo(16)
        }
        // 자기소개
        introduceLabel.snp.makeConstraints { make in
            make.top.equalTo(subImageView.snp.bottom).offset(8)
            make.leading.equalTo(nickNameLabel.snp.leading)
            make.trailing.equalTo(self.snp.trailing).offset(-8)
            make.bottom.equalTo(self.snp.bottom).offset(-8)
        }
    }
    
    public func configure(user: User) {
        nickNameLabel.text = user.nickname
        mbtiLabel.text = user.mbti
        nameLabel.text = user.name
        introduceLabel.text = user.introduce
        
        guard let imagePathURL = user.imagePathURL else { return }
        mainImageView.kf.setImage(with: URL(string: imagePathURL))
        subImageView.kf.setImage(with: URL(string: imagePathURL))
        
    }
}

#Preview{
    UserListViewController()
}
