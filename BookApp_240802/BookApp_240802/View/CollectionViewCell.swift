//
//  CollectionViewCell.swift
//  BookApp_240802
//
//  Created by 김솔비 on 8/6/24.
//

import SnapKit
import UIKit

class CollectionViewCell: UICollectionViewCell {
  
  let bookImage = {
    let image = UIImageView()
    image.image = UIImage(named: "bookTest")
    image.contentMode = .scaleAspectFill
    image.clipsToBounds = true //이미지가 뷰의 경계를 벗어나지 않도록 설정
    return image
  }()
  
  let bookNameLabel = {
    let label = UILabel()
    label.text = " "
    label.textAlignment = .right
    label.textColor = .black
    label.font = UIFont.systemFont(ofSize: 15)
    return label
  }()
  
  let bookPriceLabel = {
    let label = UILabel()
    label.text = "책 가격"
    label.textAlignment = .right
    label.textColor = .darkGray
    label.font = UIFont.systemFont(ofSize: 15)
    return label
  }()
  
  let bookDataStackView = {
    let stackView = UIStackView()
    stackView.axis = .vertical
    stackView.distribution = .fillEqually
    return stackView
  }()
  
  let bookCellStackView = {
    let stackView = UIStackView()
    stackView.axis = .horizontal
    stackView.distribution = .fillEqually
    stackView.layer.borderWidth = 1.0
    stackView.layer.borderColor = UIColor.lightGray.cgColor
    return stackView
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    configureUI()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    configureUI()
  }
  
  func configureUI() {
    [bookImage, bookDataStackView].forEach {
      bookCellStackView.addArrangedSubview($0)
    }
    [bookNameLabel, bookPriceLabel].forEach {
      bookDataStackView.addArrangedSubview($0)
    }
    
    self.addSubview(bookCellStackView)
    
    bookCellStackView.snp.makeConstraints {
      $0.leading.top.bottom.equalToSuperview()
      $0.trailing.equalToSuperview().offset(-20)
    }
  }

}
//컬렉션뷰는 홈컨트롤러에서 홈뷰로 옮겨와야함
//컬렉션뷰셀을 상속하는 셀클레스뷰를 분리

