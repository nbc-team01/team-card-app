////
////  ImagePicker.swift
////  project-team-card-app
////
////  Created by kingj on 3/4/25.
////


import UIKit
import SnapKit

//MARK: ImagePickerView
class ImagePickerView: UIView {
    
    //MARK: 이미지
    private let image:UIImage? = {
        let config = UIImage.SymbolConfiguration(pointSize: 50, weight: .regular)
        return UIImage(systemName: "photo.badge.plus", withConfiguration: config)?.withTintColor(.lightGray, renderingMode: .alwaysOriginal)
    }()
    //MARK: 이미지 뷰
    lazy var imageView: UIImageView = {
        var imageView = UIImageView(image: image)
        imageView.isUserInteractionEnabled = true
        imageView.contentMode = .center
        imageView.backgroundColor = .lightGray.withAlphaComponent(0.2)
        return imageView
    }()
    //
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
