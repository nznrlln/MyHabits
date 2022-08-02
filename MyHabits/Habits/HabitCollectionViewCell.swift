//
//  HabitCollectionViewCell.swift
//  MyHabits
//
//  Created by Нияз Нуруллин on 30.07.2022.
//

import UIKit

class HabitCollectionViewCell: UICollectionViewCell {

    var checkButtonTapAction: (() -> Void)?

    private let habitDescriptionLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.text = "Описание привычки"
        label.font = UIFont(name: "SFProText-Semibold", size: 17)
        label.numberOfLines = 0
        label.textColor = .systemGreen // передать из habit

        return label
    }()

    private let habitTimeLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.text = "Каждый день в *время"
        label.font = UIFont(name: "SFProText-Regular", size: 12)
        label.textColor = .systemGray4

        return label
    }()

    private let dayCountLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.text = "Счетчик: *кол-во дней"
        label.font = UIFont(name: "SFProText-Regular", size: 13)
        label.textColor = .systemGray2

        return label
    }()

    private lazy var checkButton: CustomCheckButton = {
        let button = CustomCheckButton()
        button.toAutoLayout()
        button.tintColor = .red
        button.addTarget(self, action: #selector(checkButtonTap), for: .touchUpInside)

        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        cellInitialSettings()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupCell(model: Habit) {
        habitDescriptionLabel.text = model.name
        habitDescriptionLabel.textColor = model.color
        habitTimeLabel.text = model.dateString
        dayCountLabel.text = "Счетчик: \(model.trackDates.count)"
        checkButton.isChecked = model.isAlreadyTakenToday
        checkButton.tintColor = model.color
    }

    override func prepareForReuse() {
        habitDescriptionLabel.text = ""
        habitTimeLabel.text = ""
        dayCountLabel.text = ""
        checkButton.isChecked = false
    }

    private func cellInitialSettings() {
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 10
        contentView.clipsToBounds = true

        setupSubviews()
        setupSubviewsLayout()
    }

    private func setupSubviews() {
        contentView.addSubviews(habitDescriptionLabel, habitTimeLabel, dayCountLabel, checkButton)
    }

    private func setupSubviewsLayout() {
        NSLayoutConstraint.activate([
            habitDescriptionLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: HabitConstants.collectionCellInset),
            habitDescriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: HabitConstants.collectionCellInset),

            habitTimeLabel.topAnchor.constraint(equalTo: habitDescriptionLabel.bottomAnchor, constant: HabitConstants.collectionCellSpacingInset),
            habitTimeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: HabitConstants.collectionCellInset),

            dayCountLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: HabitConstants.collectionCellInset),
            dayCountLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -HabitConstants.collectionCellInset),

            checkButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            checkButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -HabitConstants.collectionCellInset),
            checkButton.heightAnchor.constraint(equalToConstant: HabitConstants.checkButtonHeight),
            checkButton.widthAnchor.constraint(equalTo: checkButton.heightAnchor),
        ])
    }

    @objc private func checkButtonTap() {
        checkButtonTapAction?()
    }
}
