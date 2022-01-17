//
//  Utility.swift
//  ImpactBiosystemsAlgorithm
//
//  Created by KanoaMatton on 1/17/22.
//

import Foundation
import UIKit


extension String {
    
    // This utility function helps split string including commas and spaces
    func splitString() -> [String]  {
        // Separate string by commas, spaces, and periods
        let array = self.components(separatedBy: CharacterSet(charactersIn: ",. "))
        // The code may produce blank strings, so filter them out
        let filtered = array.filter { $0 != ""}
        return filtered
    }
    
}

// Utility function that overrides textfield bounds to adjust the text padding
class TextFieldWithPadding: UITextField {
    var textPadding = UIEdgeInsets(
        top: 10,
        left: 10,
        bottom: 10,
        right: 20
    )

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.textRect(forBounds: bounds)
        return rect.inset(by: textPadding)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.editingRect(forBounds: bounds)
        return rect.inset(by: textPadding)
    }
}
