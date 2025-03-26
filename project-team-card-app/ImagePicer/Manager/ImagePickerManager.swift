//
//  ImagePickerViewController.swift
//  project-team-card-app
//
//  Created by kingj on 3/6/25.
//

import UIKit

//MARK: 이미지 피커의 기능을 커스텀화한 매니저
class ImagePickerManager: NSObject, UIImagePickerControllerDelegate,UINavigationControllerDelegate  {
    
    //MARK: delegate - 이벤트 수행 후 VC에 위임
    weak var delegate:ImagePickerDelegate?
    //MARK: controller - 컨트롤러
    private var controller = UIImagePickerController()
   
    //MARK: 이미지 뷰 제스쳐 추가
    public var imageViewAddTarget:UITapGestureRecognizer{
        return UITapGestureRecognizer(target: self, action: #selector(imageViewTapped))
    }
    //MARK: 이미지 뷰 터치 시 이벤트 실행
    @objc func imageViewTapped() {
        showImagePicker()
    }
    //MARK: 컨트롤러 속성 설정 후 이미지 라이브러리 표시
    private func showImagePicker() {
        controller.delegate = self
        controller.sourceType = .photoLibrary
        controller.modalPresentationStyle = .pageSheet
        controller.allowsEditing = true
        delegate?.didSelectedView(controller: controller)
    }
    //MARK: 이미지 피커 컨트롤러에서 이미지를 선택하거나 카메라 촬영을 완료했을 때 호출되는 메소드
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let info = Dictionary(uniqueKeysWithValues: info.map { ($0.key.rawValue, $0.value) })
        let image = UIImagePickerController.InfoKey.editedImage
        
        guard let editedImage = info[image.rawValue] as? UIImage else { return }
        delegate?.didSelectedPhoto(image:editedImage)
    }
}
