//
//  HomeView.swift
//  BookApp_240802
//
//  Created by 김솔비 on 8/5/24.
//

import SnapKit
import UIKit

class HomeView: UIView {
  
  lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: searchCollectionViewLayout())
  
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupCollectionView()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
 
  //MARK: - CollectionView 레이아웃 설정
  func searchCollectionViewLayout() -> UICollectionViewLayout {
    let itemSize = NSCollectionLayoutSize(
      widthDimension: .fractionalWidth(1.0),  //상위 단계인 group의 너비와 같게 설정
      heightDimension: .fractionalHeight(1))  //group의 높이와 같게 설정
    
    let item = NSCollectionLayoutItem(layoutSize: itemSize)
    
    let groupSize = NSCollectionLayoutSize(
      widthDimension: .fractionalWidth(1.0),  //section의 너비와 같게 설정
      heightDimension: .estimated(80))  //높이 60
    
    let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
    
    let section = NSCollectionLayoutSection(group: group)
    section.interGroupSpacing = 10
    section.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20)
    
    let layout = UICollectionViewCompositionalLayout(section: section)
    return layout
  }
  
  func setupCollectionView() {
    collectionView.backgroundColor = .clear
  
    self.addSubview(collectionView)
    
    collectionView.snp.makeConstraints {
      $0.top.equalTo(self.safeAreaLayoutGuide.snp.top)
      $0.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom)
      $0.leading.trailing.equalToSuperview()
    }
  }
}
