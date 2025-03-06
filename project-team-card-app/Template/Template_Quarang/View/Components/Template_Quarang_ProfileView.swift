//
//  Template_Quarang_ProfileView.swift
//  project-team-card-app
//
//  Created by 유영웅 on 3/6/25.
//

import UIKit
import SnapKit
import Kingfisher

class Template_Quarang_ProfileView:UIView{
    
    var user:User?
    lazy var contentsView = Template_Quarang_ContentsView(contents: user?.contents ?? [])
    
    private let profileImage: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.backgroundColor = .lightGray
        view.layer.cornerRadius = 35
        view.layer.masksToBounds = true
        return view
    }()
    private lazy var profileVStackView:UIStackView = {
        let view = UIStackView(arrangedSubviews: [nameLabel,nickNameLabel])
        view.axis = .vertical
        view.alignment = .leading
        return view
    }()
    private lazy var profileHStackView:UIStackView = {
        let view = UIStackView(arrangedSubviews: [profileImage,profileVStackView])
        view.axis = .horizontal
        view.spacing = 10
        return view
    }()
    private let nameLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    private let nickNameLabel:UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    private let detailsLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.text = "Details"
        return label
    }()
    private lazy var detailsVStackView:UIStackView = {
        let view = UIStackView(arrangedSubviews: [
            Template_Quarang_DetailsView(emoji: "😃", title: "MBTI", value: user?.mbti ?? "", link: nil),
            Template_Quarang_DetailsView(emoji: "🎂", title: "Age", value: "\(user?.age ?? 0)" , link: nil),
            Template_Quarang_DetailsView(emoji: "🌐", title: "GitHub", value: nil , link: "\(user?.gitHubPathURL ?? "")"),
            Template_Quarang_DetailsView(emoji: "📝", title: "Blog", value: nil , link: "\(user?.blogPathURL ?? "")")
        ])
        view.axis = .vertical
        view.spacing = 30
        return view
    }()
    init(user:User){
        super.init(frame: .zero)
        self.user = user
        configureView(user:user)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func configureView(user:User){
        addSubview(profileHStackView)
        addSubview(detailsLabel)
        addSubview(detailsVStackView)
        addSubview(contentsView)
        
        profileImage.kf.setImage(with: URL(string:user.imagePathURL ?? ""))
        nameLabel.text = user.name
        nickNameLabel.text = user.nickname
        
        profileImage.snp.makeConstraints {
            $0.width.height.equalTo(70)
        }
        
        profileHStackView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(20)
            $0.left.right.equalToSuperview().inset(10)
        }
        
        detailsLabel.snp.makeConstraints {
            $0.top.equalTo(profileHStackView.snp.bottom).inset(-30)
            $0.left.right.equalToSuperview().inset(10)
        }
        
        detailsVStackView.snp.makeConstraints {
            $0.top.equalTo(detailsLabel.snp.bottom).inset(-10)
            $0.left.right.equalToSuperview().inset(10)
        }
        contentsView.snp.makeConstraints {
            $0.top.equalTo(detailsVStackView.snp.bottom).inset(-30)
            $0.left.right.equalToSuperview().inset(10)
            $0.bottom.equalToSuperview().inset(100)
        }
    }
}
#Preview{
    Template_Quarang_ViewController(userId:"UUID")
}






