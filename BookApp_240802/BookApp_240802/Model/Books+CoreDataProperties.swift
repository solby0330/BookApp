//
//  Books+CoreDataProperties.swift
//  BookApp_240802
//
//  Created by 김솔비 on 8/8/24.
//
//

import Foundation
import CoreData


extension Books {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Books> {
        return NSFetchRequest<Books>(entityName: "Books")
    }

    @NSManaged public var title: String?
    @NSManaged public var contents: String?
    @NSManaged public var authors: String?
    @NSManaged public var price: Int64
    @NSManaged public var thumbnail: String?

}

extension Books : Identifiable {

}
