//
//  CustomTextView.swift
//  ImpactBiosystemsAlgorithm
//
//  Created by KanoaMatton on 1/17/22.
//

import Foundation
import UIKit

class CustomTextView: UITextView {

   
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        setUpUI()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpUI()
    }

    private func setUpUI() {
        backgroundColor = .systemGray6
        font = .systemFont(ofSize: 20)
        textColor = .black
    }


}
