//
//  HabitDetailsHeaderView.swift
//  MyHabits
//
//  Created by Нияз Нуруллин on 01.08.2022.
//

import UIKit

class HabitDetailsHeaderView: UIView {

    private let headerLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.font = UIFont(name: "SFProText-Regular", size: 13)
        label.textColor = .systemGray2
        label.text = "АКТИВНОСТЬ"

        return label
    }()

    init() {
        super.init(frame: .zero)

        setupSubviews()
        setupSubviewsLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupSubviews() {
        addSubview(headerLabel)
    }

    private func setupSubviewsLayout() {
        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: HabitConstants.topInset),
            headerLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: HabitConstants.leadingInset),
            headerLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            headerLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: HabitConstants.spacingInset)
        ])
    }

}
