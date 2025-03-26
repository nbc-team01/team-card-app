//
//  ImagePickerDelegate.swift
//  project-team-card-app
//
//  Created by 유영웅 on 3/20/25.
//

import Foundation
import UIKit

//MARK: ImagePickerManager <-> ViewController
protocol ImagePickerDelegate:AnyObject{
    func didSelectedPhoto(image:UIImage)                        //MARK: 사진을 선택했을 때
    func didSelectedView(controller:UIImagePickerController)    //MARK: ImageView를 선택했을 때
}
