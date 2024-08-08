//
//  ModalController.swift
//  BookApp_240802
//
//  Created by 김솔비 on 8/8/24.
//

import UIKit

class ModalController: UIViewController {
  
  var callback:(() -> BookData)!
  var bookData: BookData?
  var modalView = ModalView()
  
  override func loadView() {
    modalView = ModalView(frame: UIScreen.main.bounds)
    self.view = modalView
    
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    
    //    let homeController = HomeController()
    //    homeController.delegate = self
    
    bookData = callback()
    configure(with: bookData!)
    //    print(bookData)
  }
  
  func configure(with book: BookData) {
    modalView.modalTitle.text = book.title
    modalView.modalPrice.text = "\(book.price)원"
    modalView.modalAuthors.text = book.authors.joined(separator: ", ")
    modalView.modalContents.text = book.contents
    if let url = URL(string: book.thumbnail) {
      DispatchQueue.global().async {
        if let data = try? Data(contentsOf: url) {
          DispatchQueue.main.async {
            self.modalView.madalThumbnail.image = UIImage(data: data)
          }
        }
      }
    }
  }
}

//모달 컨트
//extension ModalController: SendDataDelegate {
//  func sendData(bookData: BookData) -> BookData {
//    return bookData
//  }
//}
