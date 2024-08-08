//
//  ViewController.swift
//  BookApp_240802
//
//  Created by 김솔비 on 8/2/24.
//

import UIKit

class HomeController: UIViewController {
  
//  weak var delegate: SendDataDelegate?
  var homeView: HomeView!
  //book api를 담아줄 북 데이터 빈배열 생성
  var bookList: [BookData] = []
  
  override func loadView() {
    homeView = HomeView(frame: UIScreen.main.bounds)
    self.view = homeView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = .white
    self.title = "책 검색"
    
    homeView.collectionView.delegate = self
    homeView.collectionView.dataSource = self
    homeView.collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: "CollectionViewCell")
    
    setupNavigationBar()
  }
  
  func setupNavigationBar() {
    let searchBar = UISearchController(searchResultsController: nil)
    //서치바에 텍스트가 입력될 때마다 불리는 메서드
    searchBar.searchBar.delegate = self
    self.navigationItem.searchController = searchBar
    self.definesPresentationContext = true
  }
}

extension HomeController: UISearchBarDelegate {
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    guard let searchText = searchBar.text, !searchText.isEmpty else {
      return
    }
    fetchData(searchText: searchText)
  }
}

extension HomeController: UICollectionViewDelegate, UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return bookList.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
    let book = bookList[indexPath.item]
    configure(with: book, cell: cell)
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let modalController = ModalController()
    modalController.callback = { return self.bookList[indexPath.row] }
//    modalController.modalView.modalClosedButton.addTarget(self, action: #selector(setupAlert), for: .touchUpInside)
//    modalController.addAction(UIAction, for: setupAlert())
    print(indexPath)
//    modalController.configure(with: bookList[indexPath.row])
    present(modalController, animated: true, completion: nil)
  }
  
  
  // MARK: - URLSession
  
  private func fetchData(searchText: String) {
    //나를 인증하는 열쇠같은 느낌
    let apiKey = "bc53d3c91550b51fce551eda68373eec"
    
    //URL을 생성하고 올바른 URL인지 확인한다
    guard let url = URL(string: "https://dapi.kakao.com/v3/search/book?query=\(searchText)") else {
      print("URL is not correct")
      return
    }
    
    //URLRequest객체를 생성 / HTTP Method를 통해 GET(자원을 조회)
    var request: URLRequest = URLRequest(url: url)
    request.httpMethod = "GET"
    
    // json 데이터 형식임을 나타냄
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    request.addValue("KakaoAK \(apiKey)", forHTTPHeaderField: "Authorization")
    
    //디폴트 URL 세션을 생성
    //    let session: URLSession = URLSession(configuration: .default)
    
    //데이터 테스크를 생성하여 요청을 보냄
    URLSession.shared.dataTask(with: request) { (data, response, error) in
      // HTTP 응답 코드가 200번대인지 확인
      let successRange: Range = (200..<300)
      
      // 데이터가 존재하고 에러가 없는지 확인
      guard let data = data, error == nil else { return }
      
      // 응답을 HTTPURLResponse로 캐스팅하여 상태 코드 확인
      if let response = response as? HTTPURLResponse {
        print("status code: \(response.statusCode)")
        
        // 상태 코드가 성공 범위에 있는지 확인
        if successRange.contains(response.statusCode) {
          do {
            // JSON 데이터를 디코딩하여 APIResponse 객체로 변환
            let apiResponse = try JSONDecoder().decode(BookResponse.self, from: data)
            // bookList를 응답받은 데이터로 업데이트
            self.bookList = apiResponse.documents
            
            // UI 업데이트를 메인 스레드에서 수행
            DispatchQueue.main.async {
              self.homeView.collectionView.reloadData()
            }
          } catch {
            print("Decoding error: \(error.localizedDescription)")
          }
        } else {
          print("요청 실패")
        }
      }
    }.resume() // 태스크 시작
  }
  
  func configure(with book: BookData, cell: CollectionViewCell) {
    cell.bookNameLabel.text = book.title
    cell.bookPriceLabel.text = "\(book.price) 원"
    if let url = URL(string: book.thumbnail) {
      DispatchQueue.global().async {
        if let data = try? Data(contentsOf: url) {
          DispatchQueue.main.async {
            cell.bookImage.image = UIImage(data: data)
          }
        }
      }
    }
  }
  @objc
  func setupAlert() {
    let alert = UIAlertController(
      title: "알림",
      message: "책 담기 완료!",
      preferredStyle: .alert
    )
    
    let ok = UIAlertAction(title: "확인", style: .default, handler: nil)
    //    let cancel = UIAlertAction(title: "취소", style: .destructive, handler: nil)
    
    alert.addAction(ok)
    //    alert.addAction(cancel)
    
    // 알럿이 모달 위로 뜨도록 설정
    if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
       let topController = windowScene.windows.first?.rootViewController?.presentedViewController
        ?? windowScene.windows.first?.rootViewController {
      topController.present(alert, animated: true, completion: nil)
    } else {
      self.present(alert, animated: true, completion: nil)
    }
  }
  
  // 모달 닫는 버튼에 들어갈 메서드 설정
  func closeModal() {
    dismiss(animated: true, completion: nil)
  }
}

