////
////  ImagePicker.swift
////  project-team-card-app
////
////  Created by kingj on 3/4/25.
////


import UIKit
import SnapKit

/// Image Picker Component
class ImagePickerView: UIView {
    
    let imagePickerController = UIImagePickerController()
    
    private let image:UIImage? = {
        let config = UIImage.SymbolConfiguration(pointSize: 50, weight: .regular)
        return UIImage(systemName: "photo.badge.plus", withConfiguration: config)?.withTintColor(.lightGray, renderingMode: .alwaysOriginal)
    }()
    lazy var imageView: UIImageView = {
        var imageView = UIImageView(image: image)
        imageView.isUserInteractionEnabled = true
        imageView.contentMode = .center
        imageView.backgroundColor = .lightGray.withAlphaComponent(0.2)
        return imageView
    }()
}
