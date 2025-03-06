//
//  ImagePicker.swift
//  project-team-card-app
//
//  Created by kingj on 3/4/25.
//

import UIKit
import SnapKit

/// Image Picker Component
class ImagePicker: UIView {
    
    /// Image Picker Controller instance
    var imagePickerController = UIImagePickerController()
    
    var imageView: UIImageView = {
        var imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.backgroundColor = .red
        imageView.image = UIImage(systemName: "plus")?.withTintColor(.white, renderingMode: .alwaysOriginal)
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        configureUI()
        configureAutoLayout()
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ImagePicker {

    private func configureUI() {
        backgroundColor = .systemBackground
        addSubview(imageView)
    }
    
    private func configureAutoLayout() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.snp.makeConstraints { make in
            make.width.height.equalTo(UIScreen.main.bounds.size.width * 0.7)
            make.center.equalToSuperview()
        }
    }
}
