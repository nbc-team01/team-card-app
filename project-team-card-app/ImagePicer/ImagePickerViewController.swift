//
//  ImagePickerViewController.swift
//  project-team-card-app
//
//  Created by kingj on 3/6/25.
//

import UIKit


class ImagePickerViewController: UIViewController{
    
    private let imagePickerView:ImagePickerView
    
    init(imagePickerView: ImagePickerView) {
        self.imagePickerView = imagePickerView
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        imageViewAddTarget()
    }
}

extension ImagePickerViewController: UIImagePickerControllerDelegate,UINavigationControllerDelegate  {
    
    //이미지 뷰 제스쳐 추가
    private func imageViewAddTarget() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageViewTapped))
        imagePickerView.imageView.addGestureRecognizer(tapGesture)
    }
    //이미지 뷰 터치 시 이벤트 실행
    @objc func imageViewTapped() {
        showImagePicker(controller: imagePickerView.imagePickerController)
    }
    //이미지 라이브러리 표시
    private func showImagePicker(controller: UIImagePickerController) {
        controller.sourceType = .photoLibrary
        controller.modalPresentationStyle = .pageSheet
        controller.allowsEditing = true
        controller.delegate = self
        self.present(controller, animated: true)
    }
    // 이미지 피커 컨트롤러에서 이미지를 선택하거나 카메라 촬영을 완료했을 때 호출되는 메소드
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let info = Dictionary(uniqueKeysWithValues: info.map { ($0.key.rawValue, $0.value) })
        let image = UIImagePickerController.InfoKey.editedImage
        
        guard let editedImage = info[image.rawValue] as? UIImage else { return }
        
        dismiss(animated: true) {
            self.imagePickerView.imageView.image = editedImage
            self.imagePickerView.imageView.contentMode = .scaleToFill
            self.loadViewIfNeeded()
        }
    }
}
