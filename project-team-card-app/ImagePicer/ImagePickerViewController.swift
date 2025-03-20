//
//  ImagePickerViewController.swift
//  project-team-card-app
//
//  Created by kingj on 3/6/25.
//

import UIKit


class ImagePickerManager: NSObject, UIImagePickerControllerDelegate,UINavigationControllerDelegate  {
    weak var delegate:ImagePickerDelegate?
    private var controller = UIImagePickerController()
   
    //이미지 뷰 제스쳐 추가
    public var imageViewAddTarget:UITapGestureRecognizer{
        return UITapGestureRecognizer(target: self, action: #selector(imageViewTapped))
    }
    //이미지 뷰 터치 시 이벤트 실행
    @objc func imageViewTapped() {
        showImagePicker()
    }
    //이미지 라이브러리 표시
    private func showImagePicker() {
        controller.delegate = self
        controller.sourceType = .photoLibrary
        controller.modalPresentationStyle = .pageSheet
        controller.allowsEditing = true
        delegate?.didSelectedView(controller: controller)
    }
    // 이미지 피커 컨트롤러에서 이미지를 선택하거나 카메라 촬영을 완료했을 때 호출되는 메소드
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let info = Dictionary(uniqueKeysWithValues: info.map { ($0.key.rawValue, $0.value) })
        let image = UIImagePickerController.InfoKey.editedImage
        
        guard let editedImage = info[image.rawValue] as? UIImage else { return }
        delegate?.didSelectedPhoto(image:editedImage)
    }
}
