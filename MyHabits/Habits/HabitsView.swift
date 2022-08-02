//
//  HabitsView.swift
//  MyHabits
//
//  Created by Нияз Нуруллин on 24.07.2022.
//

import UIKit

class HabitsView: UIView {

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.toAutoLayout()
        collectionView.backgroundColor = UIColor(named: "CustomGray")
        collectionView.register(ProgressCollectionViewCell.self, forCellWithReuseIdentifier: ProgressCollectionViewCell.identifier)
        collectionView.register(HabitCollectionViewCell.self, forCellWithReuseIdentifier: HabitCollectionViewCell.identifier)

        return collectionView
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
        // Чтобы large label не скролился - неообходимо, чтобы collectionView была не первой в иерархии. Это также решает проблему неправильного отображения large label при использовании edgeInset у tableView (решается через sizeToFit() и DispatchQueue.main.async во viewWillAppear)
        addSubviews(UIView(frame: .zero),collectionView)
    }

    private func setupSubviewsLayout() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }

    func setupCollectionView(dataSource: UICollectionViewDataSource, delegate: UICollectionViewDelegateFlowLayout) {
        collectionView.dataSource = dataSource
        collectionView.delegate = delegate
    }

    func updateHabitsList() {
        collectionView.reloadData()
    }

}
