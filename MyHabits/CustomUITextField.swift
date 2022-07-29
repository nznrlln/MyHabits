//
//  CustomUITextField.swift
//  MyHabits
//
//  Created by Нияз Нуруллин on 28.07.2022.
//

import Foundation
import UIKit

class CustomUITextField: UITextField {

    private var insetX: CGFloat = 8
    private var insetY: CGFloat = 0

    // placeholder position
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: insetX, dy: insetY)
    }

    // text position
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: insetX, dy: insetY)
    }
}
