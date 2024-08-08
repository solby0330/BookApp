//
//  BookData.swift
//  BookApp_240802
//
//  Created by 김솔비 on 8/7/24.
//

import Foundation

struct BookData: Codable {
  let title: String
  let contents: String
  let authors: [String]
  let price: Int
  let thumbnail: String
}

struct BookResponse: Codable {
  let documents: [BookData]
}
