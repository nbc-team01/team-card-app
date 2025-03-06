//
//  DetailMemberView.swift
//  project-team-card-app
//
//  Created by 이수현 on 3/6/25.
//

import UIKit

class DetailMemberView: UIView {
    
    // 뒤로가기 버튼
    private let popButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        btn.tintColor = .black
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    // 타이틀
    private let titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Main"
        lbl.font = .systemFont(ofSize: 20, weight: .medium)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    // 피커
    public let pickerView: UIPickerView = {
        let view = UIPickerView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // 수정 
}
