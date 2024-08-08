//
//  ModalView.swift
//  BookApp_240802
//
//  Created by 김솔비 on 8/8/24.
//

import SnapKit
import UIKit

class ModalView: UIView {
  
  let modalTitle = {
    let label = UILabel()
    label.text = "Title"
    label.textAlignment = .center
    label.textColor = .black
    label.font = .systemFont(ofSize: 20, weight: .bold)
    return label
  }()
  
  let modalAuthors = {
    let label = UILabel()
    label.text = "authors"
    label.textAlignment = .center
    label.textColor = .systemGray3
    label.font = .systemFont(ofSize: 10)
    return label
  }()
  
  let madalThumbnail = {
    let image = UIImageView()
    image.image = UIImage(named: "bookTest")
    image.contentMode = .scaleAspectFit
    image.clipsToBounds = true
    return image
  }()
  
  let modalPrice = {
    let label = UILabel()
    label.text = "10,000원"
    label.textAlignment = .center
    label.textColor = .darkGray
    label.font = .systemFont(ofSize: 15, weight: .bold)
    return label
  }()
  
  let modalContents = {
    let label = UILabel()
    label.text = "contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents"
    label.textAlignment = .left
    label.textColor = .black
    label.font = .systemFont(ofSize: 10)
    label.numberOfLines = 0
    return label
  }()

  let modalClosedButton = {
    let button = UIButton()
    button.setTitle("닫기", for: .normal)
    button.setTitleColor(.black, for: .normal)
    return button
  }()
  
  let modalAddCartButton = {
    let button = UIButton()
    button.setTitle("장바구니 담기", for: .normal)
    button.setTitleColor(.black, for: .normal)
    return button
  }()
  
  let modalButtonStackView = {
    let stackView = UIStackView()
    stackView.axis = .horizontal
    stackView.spacing = 40
    stackView.distribution = .fillEqually
    return stackView
  }()
  
  let modalStackView = {
    let stackView = UIStackView()
    stackView.axis = .vertical
    stackView.spacing = 10
    stackView.distribution = .fillProportionally
    return stackView
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    setupViews()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
 
  
  func setupViews() {
    self.addSubview(modalStackView)
    modalStackView.snp.makeConstraints {
      $0.edges.equalToSuperview().inset(15)
    }
    [modalTitle, modalAuthors, madalThumbnail, modalPrice, modalContents, modalButtonStackView].forEach {
      modalStackView.addArrangedSubview($0)
    }
    [modalClosedButton, modalAddCartButton].forEach {
      modalButtonStackView.addArrangedSubview($0)
    }
    modalButtonStackView.snp.makeConstraints {
      $0.leading.trailing.equalToSuperview().inset(15)
    }
    
    madalThumbnail.snp.makeConstraints {
      $0.width.height.equalTo(150)
    }
  }
}
