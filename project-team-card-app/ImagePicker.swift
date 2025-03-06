////
////  ImagePicker.swift
////  project-team-card-app
////
////  Created by kingj on 3/4/25.
////
//
//import UIKit
//
///// Image Picker Component
//class ImagePicker: UIView {
//    
//    /// Image Picker Controller instance
//    var imagePickerController = UIImagePickerController()
//    
//    override init(frame: CGRect) {
//        super.init(frame: .zero)
//    }
//        
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//}
//
//
///// ** 해당 주석 아래 코드를 UIViewController에서 사용 후 삭제 **
//// TODO: 1. 본인 UIViewController 이름으로 변경
//// TODO: 2. ImagePicker 객체 생성
////          > ImagePicker 프로퍼티 imagePickerController 사용을 위함
//// TODO: 3. UIImagePickerControllerDelegate & UINavigationControllerDelegate Protocol 을 extension 하여, 아래 메소드 모두 추가
//// TODO: 4. viewDidLoad()에 imagePickerAction() 선언
//
//extension 뷰컨트롤러: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
//    
//    private func imagePickerAction() {
//        
//        // TODO: 본인 UIButton에 맞게 변경
//        ImagePicker버튼.addTarget(뷰컨트롤러.self, action: #selector(showImagePickerForLibrary), for: .touchUpInside)
//        ImagePicker버튼.imagePickerController.delegate = 뷰컨트롤러.self
//    }
//    
//    @objc func showImagePickerForLibrary() {
//        showImagePicker(sourceType: UIImagePickerController.SourceType.photoLibrary, imagePickerController: ImagePicker객체.imagePickerController)
//    }
//    
//    private func showImagePicker(sourceType: UIImagePickerController.SourceType, imagePickerController: UIImagePickerController) {
//        imagePickerController.sourceType = sourceType
//        imagePickerController.modalPresentationStyle = UIModalPresentationStyle.popover
//        imagePickerController.allowsEditing = true
//
//        self.present(imagePickerController, animated: true)
//    }
//    
//    // MARK: UIImagePickerControllerDelegate Method
//    /// 이미지 피커 컨트롤러에서 이미지를 선택하거나 카메라 촬영을 완료했을 때 호출되는 메소드
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//        
//        let info = convertFromUIImagePickerControllerInfoKeyDictionary(info)
//        
//        guard let image = info[convertFromUIImagePickerControllerInfoKey(UIImagePickerController.InfoKey.editedImage)] as? UIImage else {
//            return
//        }
//        
//        dismiss(animated: false) {
//            // TODO: 본인 UIImageView에 맞게 변경
//            // MARK: - 선택된 이미지를 UIImageView에 넣는 코드
//            본인ImageView.image = image
//        }
//    }
//    
//    // MARK: - Utilities
//    private func convertFromUIImagePickerControllerInfoKeyDictionary(_ input: [UIImagePickerController.InfoKey: Any]) -> [String: Any] {
//        return Dictionary(uniqueKeysWithValues: input.map { key, value in (key.rawValue, value) })
//    }
//
//    private func convertFromUIImagePickerControllerInfoKey(_ input: UIImagePickerController.InfoKey) -> String {
//        return input.rawValue
//    }
//
//}
