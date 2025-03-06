//
//  ImagePickerViewController.swift
//  project-team-card-app
//
//  Created by kingj on 3/6/25.
//

import UIKit

class ImagePickerViewController: UIViewController {
    
    private let imagePickerView = ImagePicker()
    
    override func loadView() {
        super.loadView()
        view = imagePickerView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageViewTapGestureRecognize()
    }
    
    func getImageView() -> UIImageView {
        return imagePickerView.imageView
    }
}

extension ImagePickerViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    private func imageViewTapGestureRecognize() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageViewTapped))
        imagePickerView.imageView.isUserInteractionEnabled = true
        imagePickerView.imageView.addGestureRecognizer(tapGesture)
    }
    
    @objc func imageViewTapped() {
        showImagePicker(sourceType: UIImagePickerController.SourceType.photoLibrary, imagePickerController: imagePickerView.imagePickerController)
    }
    
    private func showImagePicker(sourceType: UIImagePickerController.SourceType, imagePickerController: UIImagePickerController) {
        imagePickerController.delegate = self
        imagePickerController.sourceType = sourceType
        imagePickerController.modalPresentationStyle = UIModalPresentationStyle.popover
        imagePickerController.allowsEditing = true
        
        self.present(imagePickerController, animated: true)
    }
    
    // UIImagePickerControllerDelegate implement method 1
    // 이미지 피커 컨트롤러에서 이미지를 선택하거나 카메라 촬영을 완료했을 때 호출되는 메소드
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let info = convertFromUIImagePickerControllerInfoKeyDictionary(info)
        
        guard let image = info[convertFromUIImagePickerControllerInfoKey(UIImagePickerController.InfoKey.editedImage)] as? UIImage else {
            return
        }
        
        dismiss(animated: false) {
            self.imagePickerView.imageView.image = image
        }
    }
    
    // MARK: - Utilities
    private func convertFromUIImagePickerControllerInfoKeyDictionary(_ input: [UIImagePickerController.InfoKey: Any]) -> [String: Any] {
        return Dictionary(uniqueKeysWithValues: input.map { key, value in (key.rawValue, value) })
    }

    private func convertFromUIImagePickerControllerInfoKey(_ input: UIImagePickerController.InfoKey) -> String {
        return input.rawValue
    }
}
