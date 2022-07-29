//
//  HabitView.swift
//  MyHabits
//
//  Created by Нияз Нуруллин on 28.07.2022.
//

import UIKit

class HabitView: UIView {

    private let habitNameLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.text = "НАЗВАНИЕ"

        return label
    }()

    private let habitDiscriptionField: CustomUITextField = {
        let textField = CustomUITextField()
        textField.toAutoLayout()
        textField.placeholder = "Бегать по утрам, спать 8 часови т.п."

        return textField
    }()

    private let colorLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.text = "ЦВЕТ"

        return label
    }()

    init() {
        super.init(frame: .zero)
        backgroundColor = .white
        setupSubviews()
        setupSubviewsLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupSubviews() {
        self.addSubviews(habitNameLabel, habitDiscriptionField, colorLabel)
    }

    private func setupSubviewsLayout() {
        NSLayoutConstraint.activate([
            habitNameLabel.topAnchor.constraint(equalTo: self.topAnchor),
            habitNameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),

            habitDiscriptionField.topAnchor.constraint(equalTo: habitNameLabel.bottomAnchor),
            habitDiscriptionField.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            habitDiscriptionField.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            habitDiscriptionField.heightAnchor.constraint(equalToConstant: 20),

            colorLabel.topAnchor.constraint(equalTo: habitDiscriptionField.bottomAnchor),
            colorLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor)

        ])
    }
}
