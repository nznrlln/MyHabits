//
//  CheckButton.swift
//  MyHabits
//
//  Created by Нияз Нуруллин on 31.07.2022.
//

import Foundation
import UIKit

//protocol CustomCheckButtonDelegate {
////   func customCheckButtonTapAction()
//}

class CustomCheckButton: UIButton {

    var customCheckButtonTapAction: (() -> Void)?
    
    private let checkedImage = UIImage(
        systemName: "checkmark.circle.fill",
        withConfiguration: UIImage.SymbolConfiguration(
            pointSize: HabitConstants.checkButtonHeight,
            weight: .regular,
            scale: .large
        )
    )
    private let uncheckedImage = UIImage(
        systemName: "circle",
        withConfiguration: UIImage.SymbolConfiguration(
            pointSize: HabitConstants.checkButtonHeight,
            weight: .regular,
            scale: .large
        )
    )
    var isChecked: Bool = false {
        didSet {
            if isChecked == true {
                self.setImage(checkedImage, for: .normal)
            } else {
                self.setImage(uncheckedImage, for: .normal)
            }
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        self.isChecked = false
        self.setImage(uncheckedImage, for: .normal)
        self.addTarget(self, action: #selector(customCheckButtonTap), for: .touchUpInside)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func toogle() {
        isChecked = !isChecked
    }

    @objc private func customCheckButtonTap() {
        toogle()
        print("button checked: \(isChecked)")

//        customCheckButtonTapAction?()

//        if sender == self {
//            isChecked = !isChecked
//        }
    }
}
