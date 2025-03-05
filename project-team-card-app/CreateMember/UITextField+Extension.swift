//
//  UITextField+Extension.swift
//  project-team-card-app
//
//  Created by 이수현 on 3/5/25.
//

import UIKit

class CustomTextView: UITextView {
    /*
     1. UITextView는 placeholder를 제공하지 않기 때문에, text에 placeholder 텍스트를 넣고, textColor를 UIColor.placeholderText로 바꿔줌
     2. Delegate를 통해 로직을 구현
     3. textView에 입력할 때(textViewDidBeginEditing), 텍스트 컬러가 placeholderText 컬러이면 텍스트를 모두 지우고 textColor를 .black 으로 변경
     4. textView에 입력을 종료했을 때(textViewDidEndEditing), textColor를 UIColor.placeholderText로 바꿔주고, 기존 텍스트뷰의 placeholder로 사용했던 text를 다시 넣어줘야 하는데 TextView는 여러 개가 있기 때문에 지정 불가능함
     -> CustomTextView에 placeholder를 지정할 수 있는 변수를 넣고 Delegate에서 타입 캐스팅을 통해 placeholder를 다시 설정해줌. 이때, CustomTextView 선언 시 placeholderText를 넣어줘야 함
     */
    
    var placeHolderText = ""
}
