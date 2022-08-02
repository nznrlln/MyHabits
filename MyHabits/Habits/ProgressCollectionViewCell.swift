//
//  ProgressCollectionViewCell.swift
//  MyHabits
//
//  Created by Нияз Нуруллин on 30.07.2022.
//

import UIKit

class ProgressCollectionViewCell: UICollectionViewCell {

    private let store = HabitsStore.shared

    private let progressLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.font = UIFont(name: "SFProText-Semibold", size: 13)
        label.textColor = .systemGray
        label.text = "Все получится!"

        return label
    }()

    private lazy var progressStateLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.font = UIFont(name: "SFProText-Semibold", size: 13)
        label.textColor = .systemGray
        label.text = "\(Int(progressBar.progress * 100)) %"

        return label
    }()

    private lazy var progressBar: UIProgressView = {
        let progressBar = UIProgressView(progressViewStyle: .bar)
        progressBar.toAutoLayout()
        progressBar.backgroundColor = .systemGray4
        progressBar.progressTintColor = UIColor(named: "CustomViolet")
        progressBar.layer.cornerRadius = HabitConstants.progressBarHeight / 2
        progressBar.clipsToBounds = true

        return progressBar
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        cellInitialSetting()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func cellInitialSetting() {
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 10
        contentView.clipsToBounds = true

        setupSubviews()
        setupSubviewsLayout()
    }

    private func setupSubviews() {
        contentView.addSubviews(progressLabel, progressStateLabel, progressBar)
    }

    private func setupSubviewsLayout() {
        NSLayoutConstraint.activate([

            progressLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: HabitConstants.spacingInset),
            progressLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: HabitConstants.spacingInset),

            progressStateLabel.topAnchor.constraint(equalTo: progressLabel.topAnchor),
            progressStateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -HabitConstants.spacingInset),

            progressBar.topAnchor.constraint(equalTo: progressLabel.bottomAnchor, constant: HabitConstants.spacingInset + 5),
            progressBar.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: HabitConstants.spacingInset),
            progressBar.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -HabitConstants.spacingInset),
            progressBar.heightAnchor.constraint(equalToConstant: HabitConstants.progressBarHeight)
        ])

    }

    func setupCell(model: HabitsStore) {
        progressBar.setProgress(model.todayProgress, animated: true)
        progressStateLabel.text = "\(Int(progressBar.progress * 100)) %"

    }
    
}
