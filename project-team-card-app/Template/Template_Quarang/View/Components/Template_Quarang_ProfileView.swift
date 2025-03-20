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
    
    var user:User
    lazy var contentsView = Template_Quarang_ContentsView(contents: user.contents ?? [])
    
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
        view.alignment = .center
        view.isLayoutMarginsRelativeArrangement = true
        view.layoutMargins = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
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
            Template_Quarang_DetailsView(emoji: "😃", title: "MBTI", value: user.mbti ?? "", link: nil),
            Template_Quarang_DetailsView(emoji: "🎂", title: "Age", value: "\(user.age ?? 0)" , link: nil),
            Template_Quarang_DetailsView(emoji: "🌐", title: "GitHub", value: nil , link: "\(user.gitHubPathURL ?? "")"),
            Template_Quarang_DetailsView(emoji: "📝", title: "Blog", value: nil , link: "\(user.blogPathURL ?? "")")
        ])
        view.axis = .vertical
        view.spacing = 30
        return view
    }()
    private let introduceLabel:UILabel = {
        let label = UILabel()
        label.text = "Introduce"
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = .systemFont(ofSize: 25,weight: .bold)
        label.textAlignment = .left
        return label
    }()
    private lazy var introduceContentsView:PaddingLabel = {
        let label = PaddingLabel(topPadding: 5, leftPadding: 5, bottomPadding: 5, rightPadding: 5)
        label.text = user.introduce
        label.backgroundColor = .lightGray.withAlphaComponent(0.1)
        label.layer.cornerRadius = 5
        return label
    }()
    init(user:User){
        self.user = user
        super.init(frame: .zero)
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
        addSubview(introduceLabel)
        addSubview(introduceContentsView)
        
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
        introduceLabel.snp.makeConstraints { make in
            make.top.equalTo(detailsVStackView.snp.bottom).inset(-30)
            make.left.right.equalToSuperview().inset(10)
        }
        introduceContentsView.snp.makeConstraints { make in
            make.top.equalTo(introduceLabel.snp.bottom).inset(-10)
            make.left.right.equalToSuperview().inset(10)
        }
        contentsView.snp.makeConstraints {
            $0.top.equalTo(introduceContentsView.snp.bottom).inset(-10)
            $0.left.right.equalToSuperview().inset(10)
            $0.bottom.equalToSuperview().inset(100)
        }
        if let githubView = detailsVStackView.arrangedSubviews[2] as? Template_Quarang_DetailsView,
           let blogView = detailsVStackView.arrangedSubviews[3] as? Template_Quarang_DetailsView{
            githubView.emojiButton.addTarget(self, action: #selector(openGitHub), for: .touchUpInside)
            blogView.emojiButton.addTarget(self, action: #selector(openBlog), for: .touchUpInside)
        }
    }
    @objc func openGitHub() {
        guard let url = URL(string: user.gitHubPathURL ?? "") else {return}
        UIApplication.shared.open(url)
    }
    
    @objc func openBlog() {
        guard let url = URL(string: user.blogPathURL ?? "") else {return}
        UIApplication.shared.open(url)
    }
}
#Preview{
    Template_Quarang_ViewController(userId:"00978D33-1DD6-42F4-9C11-4B421A86AEF9")
}






