//
//  ImagePickerDelegate.swift
//  project-team-card-app
//
//  Created by 유영웅 on 3/20/25.
//

import Foundation
import UIKit

protocol ImagePickerDelegate:AnyObject{
    func didSelectedPhoto(image:UIImage)
    func didSelectedView(controller:UIImagePickerController)
}
