//
//  FeedView.swift
//  DailyMusic
//
//  Created by 왕정빈 on 2024/03/02.
//

import UIKit
import Then
import SnapKit

class HomeView: UIView {
    
    // MARK: - UI componets
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    
    // MARK: - Initialize
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - set UI
    private func setUI() {
        [collectionView]
            .forEach { addSubview($0) }
        
        collectionView.do {
            $0.register(HomeCollectionViewCell.self, forCellWithReuseIdentifier: "HomeCollectionViewCell")
            $0.backgroundColor = .systemBackground
            $0.collectionViewLayout = layout()
            $0.accessibilityIdentifier = "homeCollectionView"
        }
    }
    
    // MARK: - set Layout
    private func layout() -> UICollectionViewCompositionalLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .estimated(500))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .estimated(500))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
    private func setLayout() {
        collectionView.snp.makeConstraints { $0.edges.equalTo(safeAreaLayoutGuide) }
    }
}
